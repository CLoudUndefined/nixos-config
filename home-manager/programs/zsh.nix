{
  config,
  pkgs,
  flakePath,
  ...
}:
{
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      dotDir = ".config/zsh";

      history = {
        append = true;
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreDups = true;
        share = true;
        extended = true;
        ignoreSpace = true;
      };

      shellAliases = {
        l = "ls -l";
        la = "ls -la";
        ll = "ls -l";
        ls = "ls --color=auto";
        grep = "grep --color=auto";
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        update = "sudo nixos-rebuild --impure switch --flake \"${flakePath}#\"";
        home-update = "home-manager --impure switch --flake \"${flakePath}#${config.home.username}\"";
        g = "git";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gpl = "git pull";
        gst = "git status";
        gd = "git diff";
        gl = "git log --oneline";
        gb = "git branch";
        gco = "git checkout";

        mkdir = "mkdir -p";
        ports = "netstat -tulanp";
        df = "df -h";
        du = "du -h";
        free = "free -h";
        ps = "ps aux";

        helix = "hx";
      };

      initContent = ''
        setopt AUTO_CD
        setopt EXTENDED_GLOB
        setopt NOMATCH
        setopt NOTIFY
        setopt PROMPT_SUBST

        setopt HIST_VERIFY
        setopt HIST_FIND_NO_DUPS
        setopt HIST_IGNORE_ALL_DUPS

        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey '\eOA' history-substring-search-up
        bindkey '\eOB' history-substring-search-down

        bindkey '^[[H' beginning-of-line
        bindkey '^[[F' end-of-line
        bindkey '^[[3~' delete-char
        bindkey '^[[1;5C' forward-word
        bindkey '^[[1;5D' backward-word

        mkcd() {
          mkdir -p "$1" && cd "$1"
        }

        extract() {
          if [ -f $1 ] ; then
            case $1 in
              *.tar.bz2) ${pkgs.gnutar}/bin/tar xjf $1 ;;
              *.tar.gz)  ${pkgs.gnutar}/bin/tar xzf $1 ;;
              *.bz2)     ${pkgs.bzip2}/bin/bunzip2 $1 ;;
              *.rar)     ${pkgs.unrar}/bin/unrar x $1 ;;
              *.gz)      ${pkgs.gzip}/bin/gunzip $1 ;;
              *.tar)     ${pkgs.gnutar}/bin/tar xf $1 ;;
              *.tbz2)    ${pkgs.gnutar}/bin/tar xjf $1 ;;
              *.tgz)     ${pkgs.gnutar}/bin/tar xzf $1 ;;
              *.zip)     ${pkgs.unzip}/bin/unzip $1 ;;
              *.Z)       ${pkgs.ncompress}/bin/uncompress $1 ;;
              *.7z)      ${pkgs.p7zip}/bin/7z x $1 ;;
              *.xz)      ${pkgs.xz}/bin/xz -d $1 ;;
              *)         echo "'$1' cannot be extracted via extract()" ;;
            esac
          else
            echo "'$1' is not a valid file"
          fi
        }

        copy() {
          if [ -n "$1" ] && [ -f "$1" ]; then
            ${pkgs.coreutils}/bin/cat "$1" | ${pkgs.xclip}/bin/xclip -selection clipboard
          else
            ${pkgs.xclip}/bin/xclip -selection clipboard
          fi
        }

        hash_base64() {
          local algo=''${1:-${pkgs.coreutils}/bin/sha256sum}
          local file=$2
          if [[ -z "$file" ]]; then
            # Read from stdin if no file provided
            $algo | awk '{print $1}' | ${pkgs.xxd}/bin/xxd -r -p | base64
          else
            $algo "$file" | ${pkgs.gawk}/bin/awk '{print $1}' | ${pkgs.xxd}/bin/xxd -r -p | ${pkgs.coreutils}/bin/base64
          fi
        }

        eval "$(direnv hook zsh)"

        autoload -U colors && colors

        function shortened_path() {
          local p=''${PWD/#$HOME/\~}
          local short_path=""
          
          if [[ $p == \~* ]]; then
            short_path="~/"
            p=''${p:2}
          elif [[ $p == /* ]]; then
            short_path="/"
            p=''${p:1}
          fi
          
          if [[ $p != "" ]]; then
            local -a segments
            segments=(''${(s:/:)p})
            local num_segments=''${#segments}
            
            if [[ $num_segments -gt 3 ]]; then
              for i in {1..$(($num_segments-1))}; do
                short_path+="''${segments[$i]:0:2}/"
              done
              short_path+="''${segments[-1]}"
            else
              short_path+="$p"
            fi
          fi
          
          echo $short_path
        }

        function git_prompt_info() {
          local ref
          ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
          ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
          local branch="''${ref#refs/heads/}"
          local git_status=$(git status --porcelain 2> /dev/null)
          local symbol=""
          
          if [[ -n $git_status ]]; then
            symbol="%F{red}✗%f"
          else
            symbol="%F{green}✓%f"
          fi
          
          local ahead=$(git rev-list --count @{upstream}..HEAD 2> /dev/null)
          local behind=$(git rev-list --count HEAD..@{upstream} 2> /dev/null)
          local sync_status=""
          
          if [[ $ahead -gt 0 && $behind -gt 0 ]]; then
            sync_status="%F{yellow}↕%f"
          elif [[ $ahead -gt 0 ]]; then
            sync_status="%F{cyan}↑%f"
          elif [[ $behind -gt 0 ]]; then
            sync_status="%F{magenta}↓%f"
          fi
          
          echo "%F{yellow}($branch)%f $symbol $sync_status"
        }

        function preexec() {
          timer_start=$(date +%s%N)
        }

        function precmd() {
          if [ "$timer_start" ]; then
            local timer_end=$(date +%s%N)
            local elapsed_time=$((($timer_end - $timer_start) / 1000000))
            local seconds=$((elapsed_time / 1000))
            local milliseconds=$((elapsed_time % 1000))

            if [ $seconds -gt 0 ]; then
              timer_show=" %F{yellow}[''${seconds}s]%f"
            else
              timer_show=""
            fi

            unset timer_start
          fi
        }

        PROMPT=$'%(?.%F{green}✓.%F{red}✗%?)%f %F{green}%n@%m%f:%F{blue}$(shortened_path)%f $(git_prompt_info)\n%F{cyan}❯%f '
        RPROMPT='$timer_show'
      '';

      enableCompletion = true;
      completionInit = ''
        autoload -U compinit

        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':history-search:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' verbose yes
        zstyle ':completion:*' group-name ""
        zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
        zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
        zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
        zstyle ':completion:*:default' list-prompt '%S%M matches%s'

        zmodload zsh/complist
        compinit

        zstyle ':completion::complete:*' use-cache 1
        zstyle ':completion::complete:*' cache-ph "${config.xdg.dataHome}/zsh/zcompcache"
      '';
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    zoxide
    bat
    ripgrep
  ];
}
