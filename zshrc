#!/bin/zsh
function __set_path {
  export GOPATH=$HOME/.gopath

  export PATH=/usr/local/opt/libxml2/bin:$PATH
  export PATH=/usr/local/opt/texinfo/bin:$PATH
  export PATH=$HOME/.local/bin:$PATH
  export PATH=$HOME/.miniconda2/bin:$PATH
  export PATH=$HOME/.cargo/bin:$PATH
  export PATH=$GOPATH/bin:$PATH

  export LDFLAGS="-L/usr/local/opt/zlib/lib $LDFLAGS"
  export CPPFLAGS="-I/usr/local/opt/zlib/include $CPPFLAGS"
  export LDFLAGS="-L/usr/local/opt/flex/lib $LDFLAGS"
  export CPPFLAGS="-I/usr/local/opt/flex/include $CPPFLAGS"
  export LDFLAGS="-L/usr/local/opt/openssl/lib $LDFLAGS"
  export CPPFLAGS="-I/usr/local/opt/openssl/include $CPPFLAGS"
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  export LC_CTYPE=en_US.UTF-8
  export PKG_CONFIG_PATH=/usr/local/opt/zlib/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/local/opt/libxml2/lib/pkgconfig:/opt/X11/lib/pkgconfig:$PKG_CONFIG_PATH

  export HOMEBREW_NO_INSECURE_REDIRECT=1
  export HOMEBREW_CASK_OPTS=--require-sha

  export GPG_KEY=$(tty)
  export TMREPOS=~/TerraMagna/repositories

  export EDITOR=nvim
}

function zle-line-init zle-keymap-select {
    zle reset-prompt
}


function __zsh_opts {
	zstyle ':completion:*' completer _list _expand _complete _ignored _correct _approximate
	zstyle ':completion:*' group-name ''
	zstyle ':completion:*' max-errors 2
	zstyle :compinstall filename '$HOME/.zshrc'

  bindkey -v
  export KEYTIMEOUT=1

	autoload -Uz compinit
	compinit
	setopt appendhistory autocd extendedglob correctall

  if [ -d ~/.zsh/zsh-autosuggestions ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  fi

  if [ -d ~/Sources/fast-syntax-highlighting ]; then
    source ~/Sources/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
  fi
}

function __set_alias {
  alias zshconfig="vim ~/.zshrc"
  alias grep='grep --color'
  alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
  alias em="emacsclient -c"

  alias t='tail -f'
  alias vim='nvim'
  alias cat='bat'

  if hash gdate 2>/dev/null; then
    alias date="gdate"
  fi

  alias -- -="cd -"
  alias ..="cd .."
  alias ...="cd ../.."
  alias ....="cd ../../.."

  # Command line head / tail shortcuts
  alias -g H='| head'
  alias -g T='| tail'
  alias -g G='| grep'
  alias -g L="| less"
  alias -g M="| most"
  alias -g LL="2>&1 | less"
  alias -g CA="2>&1 | cat -A"
  alias -g NE="2> /dev/null"
  alias -g NUL="> /dev/null 2>&1"
  alias -g P="2>&1| pygmentize -l pytb"

  alias dud='du -d 1 -h'
  alias duf='du -sh *'
  alias fd='find . -type d -name'
  alias ff='find . -type f -name'

  alias h='history'
  alias hgrep="fc -El 0 | grep"
  alias help='man'
  alias p='ps -f'
  alias sortnr='sort -n -r'
  alias unexport='unset'

  alias rm='rm -i'
  alias cp='cp -i'
  alias mv='mv -i'
}

function __set_spark {
  if which pyspark > /dev/null; then
    export SPARK_HOME="/usr/local/Cellar/apache-spark/2.3.0/libexec/"
    export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/build:$PYTHONPATH
    export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
  fi

  export PYSPARK_DRIVER_PYTHON=jupyter
  export PYSPARK_DRIVER_PYTHON_OPTS=notebook
  export PYSPARK_PYTHON=$HOME/.miniconda2/envs/terramagna/bin/python
}

function __set_java {
  if which java > /dev/null; then
    export JAVA_HOME=$(/usr/libexec/java_home);
  fi
}

function __colorls {
  alias ls="exa"
  alias ll="ls -lh"
  alias la="ls -a"
  alias lla="ls -lha"
  alias lt="ls --tree"
}

function __set_prompt {
  SILVER=(status:black:white dir:blue:black git:green:black)
  export SILVER_SHELL=zsh

  eval "$(~/.local/bin/silver init)"
}

function _check_node {
  if [ -f "$PWD/package.json" ]; then
    if [ -n "$__NVM_LOADED" ]; then
      nvm use --silent "$NVM_AUTO_LOAD_VERSION"
      export __NVM_LOADED="1"
    fi
  fi
}

function __set_nvm {
  export NVM_DIR="$HOME/.nvm"

  if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh" --no-use

    nvm_die_on_prefix () {
      return 0
    }

    nvm_print_npm_version () {
      return 0
    }

    if [ -f "$NVM_DIR/_default_version" ]; then
      NVM_AUTO_LOAD_VERSION=$(cat "$NVM_DIR/_default_version")
    fi
    if [ -z "$NVM_AUTO_LOAD_VERSION" ]; then
      NVM_AUTO_LOAD_VERSION=$(nvm_resolve_local_alias default)
    fi
    if [ -n "$NVM_AUTO_LOAD_VERSION" ]; then
      echo "$NVM_AUTO_LOAD_VERSION" > "$NVM_DIR/_default_version"
    fi

    add-zsh-hook chpwd _check_node
  fi
}

function __shell_init {
  autoload -Uz add-zsh-hook
	__set_prompt

  source ~/.zsh_dirhistory

	__zsh_opts
  __set_path
  __set_alias
  __colorls
  __set_java
  __set_nvm
  __set_spark

  if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
}

__shell_init

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if hash pyenv 2>/dev/null; then
  eval "$(pyenv init -)"
fi

export PATH="/usr/local/sbin:$PATH"
