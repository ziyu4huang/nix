{ config, pkgs, ... }:
let 
  qt48 = pkgs.callPackage ./nixlib/qt48 {
    inherit (pkgs.gnome2) libgnomeui GConf gnome_vfs;
    inherit (pkgs.darwin) libobjc;
    inherit (pkgs.darwin.apple_sdk.frameworks) ApplicationServices OpenGL Cocoa AGL;
    cups = if pkgs.stdenv.isLinux then pkgs.cups else null;
    libmysqlclient = if (!pkgs.stdenv.isFreeBSD) then pkgs.libmysqlclient else null;
  };
  stable-packages = with pkgs; [
    patchelf

    #################
    neovim lunarvim
    git git-crypt
    zsh
    #python311
    #(python311.withPackages(ps: with ps; [ pandas requests]))


    #python311.pkgs.requests
    #python311.pkgs.pip
    #python311.pkgs.pandas
    bat
    bottom
    coreutils


    curl
    du-dust
    fd
    findutils
    fx

    htop
    jq
    killall
    mosh
    procs
    ripgrep
    sd
    tmux
    tree
    unzip
    vim
    wget
    zip

    #####
    mkcert
    httpie

    # treesitter
    tree-sitter

    # language servers
    ccls # c / c++

    lua52Packages.luacheck
    shellcheck
    shfmt
    statix # nix
    sqlfluff
    tflint
  ];

in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ziyu4huang";
  #home.username = "${config.username}";
  home.homeDirectory = "/home/ziyu4huang";
  home.enableNixpkgsReleaseCheck = false;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = 
    stable-packages
    ++
    [
      qt48
      pkgs.hello
      #stable-packages
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

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
  #  /etc/profiles/per-user/ziyu4huang/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "lvim";
    SHELL = "/home/ziyu4huang/.nix-profile/bin/zsh";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    starship.enable = true;
    starship.settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;
      git_branch.style = "242";
      directory.style = "blue";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
      python.disabled = true;
      ruby.disabled = true;
      hostname.ssh_only = false;
      hostname.style = "bold green";
    };
    # FIXME: disable whatever you don't want
    fzf.enable = true;
    fzf.enableZshIntegration = true;
    lsd.enable = true;
    lsd.enableAliases = true;
    zoxide.enable = true;
    zoxide.enableZshIntegration = true;
    broot.enable = true;
    broot.enableZshIntegration = true;

    direnv.enable = true;
    direnv.enableZshIntegration = true;
    direnv.nix-direnv.enable = true;

    git = {
      enable = true;
      package = pkgs.git;
      delta.enable = true;
      delta.options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
      };
      userEmail = "ziyu4huang@gmail.com"; # FIXME: set your git email
      userName = "Ziyu Huang"; #FIXME: set your git username
      extraConfig = {
        # FIXME: uncomment the next lines if you want to be able to clone private https repos
        # url = {
        #   "https://oauth2:${secrets.github_token}@github.com" = {
        #     insteadOf = "https://github.com";
        #   };
        #   "https://oauth2:${secrets.gitlab_token}@gitlab.com" = {
        #     insteadOf = "https://gitlab.com";
        #   };
        # };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        merge = {
          conflictstyle = "diff3";
        };
        diff = {
          colorMoved = "default";
        };
      };
    };

    zsh = {
      enable = true;
      autocd = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      defaultKeymap = "emacs";
      history.size = 10000;
      history.save = 10000;
      history.expireDuplicatesFirst = true;
      history.ignoreDups = true;
      history.ignoreSpace = true;
      historySubstringSearch.enable = true;

      plugins = [
        {
          name = "fast-syntax-highlighting";
          src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
        }
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
        }
      ];

      shellAliases = {
        "..." = "./..";
        "...." = "././..";
        cd = "z";
        gc = "nix-collect-garbage --delete-old";
        refresh = "source ${config.home.homeDirectory}/.zshrc";
        show_path = "echo $PATH | tr ':' '\n'";

        # FIXME: add more git aliases here if you want them
        gapa = "git add --patch";
        grpa = "git reset --patch";
        gst = "git status";
        gdh = "git diff HEAD";
        gp = "git push";
        gph = "git push -u origin HEAD";
        gco = "git checkout";
        gcob = "git checkout -b";
        gcm = "git checkout master";
        gcd = "git checkout develop";

        pbcopy = "/mnt/c/Windows/System32/clip.exe";
        pbpaste = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -command 'Get-Clipboard'";
        explorer = "/mnt/c/Windows/explorer.exe";
      };

      envExtra = ''
        export PATH=$PATH:$HOME/.local/bin
      '';

      initExtra = ''
        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward
        bindkey '^e' end-of-line
        bindkey '^w' forward-word
        bindkey "^[[3~" delete-char
        bindkey ";5C" forward-word
        bindkey ";5D" backward-word

        zstyle ':completion:*:*:*:*:*' menu select

        # Complete . and .. special directories
        zstyle ':completion:*' special-dirs true

        zstyle ':completion:*' list-colors ""
        zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

        # disable named-directories autocompletion
        zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

        # Use caching so that commands like apt and dpkg complete are useable
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

        # Don't complete uninteresting users
        zstyle ':completion:*:*:*:users' ignored-patterns \
                adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
                clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
                gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
                ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
                named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
                operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
                rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
                usbmux uucp vcsa wwwrun xfs '_*'
        # ... unless we really want to.
        zstyle '*' single-ignored complete

        # https://thevaluable.dev/zsh-completion-guide-examples/
        zstyle ':completion:*' completer _extensions _complete _approximate
        zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
        zstyle ':completion:*' group-name ""
        zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
        zstyle ':completion:*' squeeze-slashes true
        zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

        # mkcd is equivalent to takedir
        function mkcd takedir() {
          mkdir -p $@ && cd ''${@:$#}
        }

        function takeurl() {
          local data thedir
          data="$(mktemp)"
          curl -L "$1" > "$data"
          tar xf "$data"
          thedir="$(tar tf "$data" | head -n 1)"
          rm "$data"
          cd "$thedir"
        }

        function takegit() {
          git clone "$1"
          cd "$(basename ''${1%%.git})"
        }

        function take() {
          if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]; then
            takeurl "$1"
          elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
            takegit "$1"
          else
            takedir "$@"
          fi
        }

        WORDCHARS='*?[]~=&;!#$%^(){}<>'

        # fixes duplication of commands when using tab-completion
        export LANG=C.UTF-8
      '';
    };
  };
}
