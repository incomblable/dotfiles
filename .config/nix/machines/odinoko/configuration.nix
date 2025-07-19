{
  pkgs,
  self,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    colima
    docker
    ffmpeg
    git
    go
    jq
    lima
    mas
    neovim
    nix-prefetch-github
    qemu
    ripgrep
    stow
    vim
    yt-dlp
  ];

  homebrew = {
    enable = true;

    brews = [
      "bandcamp-dl"
      "typewritten"
    ];

    casks = [
      "affinity-designer"
      "affinity-photo"
      "alfred"
      "altserver"
      "discord"
      "font-iosevka-ss15"
      "hammerspoon"
      "monitorcontrol"
      "mos"
      "sketch"
      "swift-shift"
      "telegram"
      "transmission"
      "vlc"
      "visual-studio-code"
      "vscodium"
    ];

    caskArgs = {
      appdir = "~/Applications";
    };

    masApps = {
      "AdGuard for Safari" = 1440147259;
      Keynote = 409183694;
      Numbers = 409203825;
      "System Color Picker" = 1545870783;
    };

    onActivation = {
      cleanup = "zap";
    };
  };

  nix.settings.experimental-features = "nix-command flakes";

  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    direnvrcExtra = "";
    nix-direnv = {
      enable = true;
    };
  };

  programs.zsh = {
    enableGlobalCompInit = false;
    promptInit = "";
  };

  users = {
    knownUsers = [ "pml" ];

    users.pml = {
      home = "/Users/pml";
      uid = 501;
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.primaryUser = "pml";

  system.defaults.finder = {
    FXDefaultSearchScope = "SCcf";
  };

  system.defaults.NSGlobalDomain = {
    InitialKeyRepeat = 15; # Fatest
    KeyRepeat = 2; # Fatest
    NSDocumentSaveNewDocumentsToCloud = false;
    NSWindowShouldDragOnGesture = false; # Switched for swift-shift
  };

  system.stateVersion = 5;
}
