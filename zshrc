#!/bin/zsh
function tm-env {
	source activate terramagna
	export PS1=$PROMPT
}

function login-node {
  local port=22
  if [ "$4" -ne "" ]; then
    port=$4
  fi
  ssh -p $port -i ~/TerraMagna/chaves/$1.pem $2@$3 -o StrictHostKeyChecking=no
}

function tm-repo {
  local firstfolder=~/TerraMagna/repositories/$1
  local secondfolder=~/TerraMagna/repositories/terramagna_$1
  if [ -d $firstfolder ]; then
	  cd $firstfolder
  elif [ -d $secondfolder ]; then
    cd $secondfolder
  else
    echo "Repository not found!"
  fi
}

function cp-rem-env {
  if [ "$#" -ne 3 ]; then
    printf "Usage [local|remote] origin destiny"
    return 1
  fi

  local src=""
  local rem=""

  if [ "$1" = "local" ]; then
    src="$2"
    rem="root@35.202.214.227:$3"
  elif [ "$1" = "remote" ]; then
    src="root@35.202.214.227:$2"
    rem="$3"
  else
    printf "Bad argument, should be 'local' or 'remote'"
    return 1
  fi

  rsync -azvh -e "ssh -i ~/TerraMagna/keys/dev_key -p 30302" --progress $src $rem
}

function __set_path {
  export GOPATH=$HOME/.gopath

  export PATH=/usr/local/opt/libxml2/bin:$PATH
  export PATH=/usr/local/opt/texinfo/bin:$PATH
  export PATH=/Users/luiscm/.local/bin:$PATH
  export PATH=/Users/luiscm/.miniconda2/bin:$PATH
  export PATH=$HOME/.cargo/bin:$PATH
  export PATH=$GOPATH/bin:$PATH
  
  export LDFLAGS="-L/usr/local/opt/zlib/lib $LDFLAGS"
  export CPPFLAGS="-I/usr/local/opt/zlib/include $CPPFLAGS"
  export LDFLAGS="-L/usr/local/opt/flex/lib $LDFLAGS"
  export CPPFLAGS="-I/usr/local/opt/flex/include $CPPFLAGS" 
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
	zstyle :compinstall filename '/Users/luiscm/.zshrc'

    bindkey -v
    export KEYTIMEOUT=1

	autoload -Uz compinit
	compinit
	setopt appendhistory autocd extendedglob correctall

	source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
	source ~/Sources/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
}

function __set_alias {
  alias zshconfig="vim ~/.zshrc"
  alias grep='grep --color'
  alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
  alias em="emacsclient -c"

  alias t='tail -f'
  alias vim='nvim'
  alias cat='bat'

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
  export PYSPARK_PYTHON=/Users/luiscm/.miniconda2/envs/terramagna/bin/python
}

function __set_java {
  if which java > /dev/null; then
    export JAVA_HOME=$(/usr/libexec/java_home);
  fi
}

function __colorls {
  alias ls="lsd"
	alias ll="lsd -l"
	alias la="lsd -a"
  alias lla="lsd -la"
	alias lt="lsd --tree"
}

function zle-line-init zle-keymap-select {
  PROMPT=`~/Sources/purs/target/release/purs prompt -k "$KEYMAP" -r "$?"`
  zle reset-prompt
}

function _prompt_purs_precmd {
  ~/Sources/purs/target/release/purs precmd
}

function __set_purs_prompt {
  zle -N zle-line-init
  zle -N zle-keymap-select

  add-zsh-hook precmd _prompt_purs_precmd
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
	__set_purs_prompt

  source ~/.zsh_dirhistory

	__zsh_opts
  __set_path
  __set_alias
  __colorls
  __set_java
  __set_nvm
  __set_spark

  if [ -e /Users/luiscm/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/luiscm/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
}

__shell_init

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
eval "$(pyenv init -)"
export PATH="/usr/local/sbin:$PATH"
