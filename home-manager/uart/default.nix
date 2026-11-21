{ ... }:

{
  # 自作の UTF-8 アート作成 TUI (https://github.com/sinotca529/uart) の設定。
  # 本体はいまのところ ~/works/uart から cargo install で入れている。
  xdg.configFile."uart/config.toml".source = ./config.toml;
}
