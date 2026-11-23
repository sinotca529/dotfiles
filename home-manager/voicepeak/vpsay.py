"""vpsay: read text aloud (or save it) with VOICEPEAK's Linux CLI.

- Splits text into chunks within VOICEPEAK's 140-character limit.
- Synthesizes the next chunk while the previous one is playing.
- Serializes all vpsay runs with a lock (VOICEPEAK can't run concurrently).
- Retries failed synthesis; checks the output file, since voicepeak exits 0 on errors.
"""

import argparse
import fcntl
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
import wave
from pathlib import Path

VOICEPEAK = os.environ.get(
    "VOICEPEAK", str(Path.home() / "Documents/VoicepeakDownloads/Voicepeak/voicepeak")
)
LOCK_PATH = Path(os.environ.get("XDG_RUNTIME_DIR", tempfile.gettempdir())) / "vpsay.lock"
MAX_CHARS = 140
RETRIES = 3

# Silence VOICEPEAK puts after punctuation inside one call, minus what is left at a
# seam between two separately synthesized chunks (measured with
# book/tools/measure_pauses.py). Added at chunk seams so splitting sounds natural.
# VOICEPEAK's --speed only affects speech, not pauses, so these don't depend on it.
SEAM_PAUSE = {"。": 0.70, "．": 0.70, "？": 0.61, "?": 0.61, "！": 0.63, "!": 0.63, "、": 0.34, "，": 0.34}


def seam_pause(chunk: str, speed: int | None = None) -> float:
    """Extra silence (sec) to put after `chunk` when the next chunk is synthesized separately."""
    tail = chunk.rstrip().rstrip("」』）)…")
    return SEAM_PAUSE.get(tail[-1:], 0.0) if tail else 0.0


def split_text(text: str, limit: int = MAX_CHARS) -> list[str]:
    """Split at sentence ends, then commas, then hard-cut; pack pieces up to `limit`."""

    def pieces(s: str, seps: list[str]) -> list[str]:
        if len(s) <= limit:
            return [s]
        if not seps:
            return [s[i : i + limit] for i in range(0, len(s), limit)]
        parts = [p for p in re.split(f"(?<=[{seps[0]}])", s) if p]
        return [q for p in parts for q in pieces(p, seps[1:])]

    chunks: list[str] = []
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        cur = ""
        for p in pieces(line, ["。！？!?", "、，,"]):
            if len(cur) + len(p) > limit:
                chunks.append(cur)
                cur = ""
            cur += p
        if cur:
            chunks.append(cur)
    return [c for c in chunks if c.strip()]


def synthesize(text: str, out: Path, args: argparse.Namespace) -> None:
    cmd = [VOICEPEAK, "-s", text, "-n", args.narrator, "-o", str(out)]
    if args.emotion:
        cmd += ["-e", args.emotion]
    if args.speed is not None:
        cmd += ["--speed", str(args.speed)]
    if args.pitch is not None:
        cmd += ["--pitch", str(args.pitch)]

    last_err = ""
    for attempt in range(RETRIES):
        out.unlink(missing_ok=True)
        r = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        if out.exists() and out.stat().st_size > 44:  # larger than a bare WAV header
            return
        last_err = "\n".join(
            ln for ln in r.stdout.splitlines()
            if not ln.startswith("[debug]") and "iconv_open" not in ln
        )
        time.sleep(0.5 * (attempt + 1))
    sys.exit(f"vpsay: synthesis failed for {text!r}\n{last_err}".rstrip())


def concat_wavs(srcs: list[Path], dst: Path, gaps: list[float] | None = None) -> None:
    """Concatenate WAVs; gaps[i] seconds of silence follow srcs[i]."""
    with wave.open(str(srcs[0])) as w:
        params = w.getparams()
    frame = params.sampwidth * params.nchannels
    with wave.open(str(dst), "wb") as out:
        out.setparams(params)
        for i, s in enumerate(srcs):
            with wave.open(str(s)) as w:
                out.writeframes(w.readframes(w.getnframes()))
            if gaps and i < len(gaps) and gaps[i] > 0:
                out.writeframes(b"\0" * frame * int(params.framerate * gaps[i]))


DIC_PATH = Path(VOICEPEAK).parent / "usersettings" / "settings" / "dic.json"
DEFAULT_POS = "Japanese_Futsuu_meishi"  # 普通名詞; na-adjectives (不十分) are nouns in MeCab terms


def _to_katakana(s: str) -> str:
    return "".join(chr(ord(c) + 0x60) if "ぁ" <= c <= "ゖ" else c for c in s)


def _gui_running() -> bool:
    """True if a VOICEPEAK process without CLI arguments (the GUI) is running.

    The GUI keeps its own copy of the dictionary and may overwrite dic.json.
    """
    for p in Path("/proc").glob("[0-9]*/cmdline"):
        try:
            argv = p.read_bytes().split(b"\0")
        except OSError:
            continue
        if argv and Path(argv[0].decode(errors="ignore")).name == "voicepeak" and not any(argv[1:2]):
            return True
    return False


def run_dict(args: argparse.Namespace) -> None:
    entries = json.loads(DIC_PATH.read_text()) if DIC_PATH.exists() else []
    if args.dict_list:
        for e in entries:
            print(f"{e['sur']}\t{e['pron']}\taccent={e.get('accentType', 0)}\t{e.get('pos', '')}")
        return
    if _gui_running():
        sys.exit("vpsay: close the VOICEPEAK GUI first (it would overwrite dic.json)")
    if args.dict_add:
        sur, pron = args.dict_add
        entries = [e for e in entries if e["sur"] != sur]
        entries.append({
            "sur": sur,
            "pron": _to_katakana(pron),
            "pos": args.pos,
            "priority": args.priority,
            "accentType": args.accent,
            "lang": "ja",
        })
        print(f"added: {sur} -> {_to_katakana(pron)} (accent {args.accent})")
    else:
        before = len(entries)
        entries = [e for e in entries if e["sur"] != args.dict_remove]
        if len(entries) == before:
            sys.exit(f"vpsay: not in dictionary: {args.dict_remove}")
        print(f"removed: {args.dict_remove}")
    DIC_PATH.parent.mkdir(parents=True, exist_ok=True)
    tmp = DIC_PATH.with_suffix(".json.tmp")
    tmp.write_text(json.dumps(entries, ensure_ascii=False, indent=2))
    tmp.replace(DIC_PATH)


def run_cmd_list(args: argparse.Namespace) -> None:
    flag = ["--list-narrator"] if args.list else ["--list-emotion", args.list_emotion]
    r = subprocess.run([VOICEPEAK, *flag], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True)
    print(r.stdout, end="")


def main() -> None:
    ap = argparse.ArgumentParser(description="Speak text with VOICEPEAK.")
    ap.add_argument("text", nargs="*", help="text to speak (reads stdin if omitted)")
    ap.add_argument("-n", "--narrator", default=os.environ.get("VPSAY_NARRATOR", "Miyamai Moca"))
    ap.add_argument("-e", "--emotion", help="e.g. happy=50,sad=20")
    ap.add_argument("--speed", type=int, help="50-200")
    ap.add_argument("--pitch", type=int, help="-300-300")
    ap.add_argument("-o", "--out", type=Path, help="save to WAV instead of playing")
    ap.add_argument("--list", action="store_true", help="list narrators")
    ap.add_argument("--list-emotion", metavar="NARRATOR", help="list emotions of a narrator")
    dic = ap.add_argument_group("user dictionary (VOICEPEAK dic.json)")
    dic.add_argument("--dict-add", nargs=2, metavar=("WORD", "READING"), help="register a reading (kana)")
    dic.add_argument("--dict-remove", metavar="WORD")
    dic.add_argument("--dict-list", action="store_true")
    dic.add_argument("--accent", type=int, default=0, help="mora after which pitch drops; 0 = flat")
    dic.add_argument("--pos", default=DEFAULT_POS, help=f"part of speech (default {DEFAULT_POS})")
    dic.add_argument("--priority", type=int, default=5, help="0-10")
    args = ap.parse_args()

    # VOICEPEAK is licensed software installed outside Nix; fail clearly where it is absent.
    if not Path(VOICEPEAK).is_file():
        sys.exit(f"vpsay: VOICEPEAK not found at {VOICEPEAK} (set $VOICEPEAK to the voicepeak binary)")
    if args.dict_add or args.dict_remove or args.dict_list:
        run_dict(args)
        return
    if not args.out and not shutil.which("paplay"):
        sys.exit("vpsay: paplay not found (needed for playback; use -o FILE to save instead)")
    if args.list or args.list_emotion:
        run_cmd_list(args)
        return

    text = " ".join(args.text) if args.text else sys.stdin.read()
    chunks = split_text(text)
    if not chunks:
        ap.error("no text given")

    with open(LOCK_PATH, "w") as lock, tempfile.TemporaryDirectory(prefix="vpsay-") as tmp:
        fcntl.flock(lock, fcntl.LOCK_EX)
        wavs = [Path(tmp) / f"{i:04d}.wav" for i in range(len(chunks))]
        gaps = [seam_pause(c, args.speed) for c in chunks[:-1]]
        player: subprocess.Popen | None = None
        for i, (chunk, wav) in enumerate(zip(chunks, wavs)):
            synthesize(chunk, wav, args)
            if args.out:
                continue
            if player:
                player.wait()
                time.sleep(gaps[i - 1])
            player = subprocess.Popen(["paplay", str(wav)])
        if player:
            player.wait()
        if args.out:
            concat_wavs(wavs, args.out, gaps)


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(130)
