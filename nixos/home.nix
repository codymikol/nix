{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "cmikol";
  home.homeDirectory = "/home/cmikol";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
     zsh
     xclip
     neovim
     vim
     firefox
     steam
     tmux
     curl
     git
     kitty
     clang
     zig
     nodejs_22
     unzip
     coolercontrol.coolercontrol-gui
     coolercontrol.coolercontrold
     discord
     virtualbox
     nix-search-cli
     wget
     python3
     lua-language-server
     luarocks
     lua5_1
     lazygit
     ripgrep
     rustc
     xclip
     fd
     tree-sitter
     kotlin
     temurin-bin
     gradle
     home-manager
     google-cloud-sdk
     jq
     terraform-lsp
     opentofu
     docker
     docker-compose
     stylua
     nil
     kotlin-language-server
  ];

  programs.git = {
    enable = true;
    userName = "Cody Mikol";
    userEmail = "hi@codymikol.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    loginShell = true;

    initExtra = ''
    # TODO: do I need this?
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      g = "java -jar ~/dev/src/git-down/build/libs/gitdown-1.0-all.jar";
      nu = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
