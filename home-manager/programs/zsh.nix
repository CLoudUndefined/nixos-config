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
      dotDir = ".config/zsh";

      # История
      history = {
        append = true;
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreDups = true;
        share = true;
        extended = true;
        ignorePatterns = [
          "ssh"
          "curl"
          "wget"

        ];
        ignoreSpace = true;
      };

      # Опции оболочки
      initExtra = ''
        # Базовые опции
        setopt AUTO_CD              # Автоматический cd при вводе пути
        setopt EXTENDED_GLOB        # Расширенный глоббинг
        setopt NOMATCH             # Сообщать об ошибках при отсутствии совпадений
        setopt NOTIFY              # Немедленное уведомление о завершении фоновых задач
        setopt PROMPT_SUBST        # Позволяет подстановку в промпте

        # Опции истории
        setopt HIST_VERIFY

        # Дополнительные привязки клавиш
        bindkey '\eOA' history-search-backward
        bindkey '\e[A' history-search-backward
        bindkey '\eO[B' history-search-forward
        bindkey '\e[B' history-search-forward
        bindkey '^[[H' beginning-of-line
        bindkey '^[[F' end-of-line
        bindkey '^[[3~' delete-char
        bindkey '^[[1;5C' forward-word
        bindkey '^[[1;5D' backward-word

        function mkcd() {
          mkdir -p "$1" && cd "$1"
        }

        function extract() {
          if [ -f $1 ] ; then
            case $1 in
              *.tar.bz2) tar xjf $1 ;;
              *.tar.gz)  tar xzf $1 ;;
              *.bz2)     bunzip2 $1 ;;
              *.rar)     unrar x $1 ;;
              *.gz)      gunzip $1  ;;
              *.tar)     tar xf $1  ;;
              *.tbz2)    tar xjf $1 ;;
              *.tgz)     tar xzf $1 ;;
              *.zip)     unzip $1   ;;
              *.Z)       uncompress $1 ;;
              *.7z)      7z x $1    ;;
              *)         echo "'$1' cannot be extracted via extract()" ;;
            esac
          else
            echo "'$1' is not a valid file"
          fi
        }
      '';

      # Алиасы
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
        home-update = "home-manager --impure switch --flake \"${flakePath}#teiwo\"";
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
      };

      # Настройки
      initExtraFirst = ''
        eval "$(direnv hook zsh)"

        autoload -U colors && colors

        function git_prompt_info() {
          local ref
          ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
          ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
          echo "%F{yellow}(''${ref#refs/heads/})%f"
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

            unset timer_start  # Сбрасываем переменную
          fi
        }

        PROMPT='%F{green}%n@%m%f:%F{blue}%~%f $(git_prompt_info) %# '  # Левый промпт
        RPROMPT='$timer_show'  # Время справа
      '';

      enableCompletion = true;
      completionInit = ''
        autoload -U compinit

        # Настройка стиля дополнений
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

        # Кэширование дополнений
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
    # fzf
    bat
    # exa
    ripgrep
  ];
}
