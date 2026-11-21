{ ... }:

{
  # clangd のユーザー設定(ホームディレクトリ外のファイルにも効く)
  xdg.configFile."clangd/config.yaml".source = ./config.yaml;

  # clang-format は親ディレクトリをたどって探すので、ホーム直下に置く
  home.file.".clang-format".source = ./clang-format;
}
