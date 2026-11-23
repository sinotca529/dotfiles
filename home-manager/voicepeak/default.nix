{ pkgs, ... }:

# VOICEPEAK (音声合成ソフト) を CLI から使うためのコマンド。
# VOICEPEAK 本体はライセンス付きの配布物なので Nix では管理しない。
# 既定の場所 (~/Documents/VoicepeakDownloads/Voicepeak/voicepeak) は $VOICEPEAK で変更できる。
# 本体がない環境では、実行時にその旨を表示して終了する。
let
  vpsay = pkgs.writers.writePython3Bin "vpsay" {
    # E501: 行の長さ。E203: スライスの ":" 前の空白 (black の書式と衝突する)。
    flakeIgnore = [ "E501" "E203" ];
  } (builtins.readFile ./vpsay.py);
in
{
  home.packages = [
    vpsay
    (pkgs.writeShellApplication {
      name = "mocasay";
      runtimeInputs = [ vpsay ];
      text = ''exec vpsay -n "Miyamai Moca" "$@"'';
    })
  ];
}
