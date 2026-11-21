{
  description = "Takumi's Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      mkHome =
        modules:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home-manager/home.nix ] ++ modules;
        };
    in
    {
      # `home-manager switch --flake ~/dotfiles` は "ユーザー名@ホスト名" を探し、
      # 無ければ "ユーザー名" を使う。
      homeConfigurations = {
        # デスクトップ (Arch + Hyprland)
        "takumi@panthalassa" = mkHome [ ./home-manager/desktop.nix ];
        # WSL など、GUI を使わない環境
        "takumi" = mkHome [ ];
      };
    };
}
