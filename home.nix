{ pkgs, ... }: {
  home.username = "sul";
  home.homeDirectory = "/home/sul";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.bash = {
    enable = true;
    shellAliases = {
      cat = "bat --paging=never";
      lzg = "lazygit";
      lzd = "lazydocker";
      fzf = "sk";
      vi = "nvim";
    };

    bashrcExtra = ''
      eval "$(starship init bash)"
      eval "$(zoxide init --cmd cd bash)"
    '';
  };

  programs.wezterm = { enable = true; };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      starship init fish | source
      zoxide init --cmd cd fish | source

      alias cat="bat --paging=never"
      alias lzg='lazygit'
      alias lzg='lazydocker'
      alias fzf='sk'
      alias vi='nvim'
    '';
  };
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    pkgs.nixfmt-classic
    pkgs.ripgrep
    pkgs.skim
    pkgs.zoxide
    pkgs.lazydocker
    pkgs.lazygit
    pkgs.starship
    pkgs.bat
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sl/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { EDITOR = "hx"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.nixvim = import ./modules/nixvim.nix;

  programs.git = {
    enable = true;
    userName = "sul";
    userEmail = "su1im69n@gmail.com";
    extraConfig.init.defaultBranch = "main";
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      dialect = "us";
      ignored_commands = [ "cd" "ls" "vi" ];
      search_mode = "skim";
      show_preview = true;
      style = "compact";
    };
  };
}
