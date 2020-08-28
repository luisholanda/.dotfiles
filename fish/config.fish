function __set_path
  set -xg GOPATH $HOME/.gopath
  set -xg PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /usr/local/MacGPG2/bin
  set -xgp PATH /usr/local/opt/libxml2/bin
  set -xgp PATH /usr/local/opt/llvm@9/bin
  set -xgp PATH /usr/local/opt/texinfo/bin
  set -xgp PATH $HOME/.local/bin
  set -xgp PATH $HOME/.cargo/bin
  set -xgp PATH $GOPATH/bin
  set -xgp PATH $HOME/.pyenv/bin

  set -xgp LDFLAGS -L/usr/local/opt/zlib/lib
  set -xgp CPPFLAGS -I/usr/local/opt/zlib/include
  set -xgp LDFLAGS -L/usr/local/opt/flex/lib
  set -xgp CPPFLAGS -I/usr/local/opt/flex/include
  set -xgp LDFLAGS -L/usr/local/opt/openssl/lib
  set -xgp CPPFLAGS -I/usr/local/opt/openssl/include
  set -xgp LDFLAGS -L/usr/local/opt/llvm@9/lib
  set -xgp CPPFLAGS -I/usr/local/opt/llvm@9/include
  set -xg LC_ALL en_US.UTF-8
  set -xg LANG en_US.UTF-8
  set -xg LC_CTYPE en_US.UTF-8
  set -xgp PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig /usr/local/lib/pkgconfig /usr/local/opt/libxml2/lib/pkgconfig /opt/X11/lib/pkgconfig

  set -xg HOMEBREW_NO_INSECURE_REDIRECT 1
  set -xg HOMEBREW_CASK_OPTS --require-sha

  set -xg GPG_KEY (tty)
  set -xg TMREPOS ~/TerraMagna/repositories

  set -xg EDITOR kak
end

function __set_alias
  alias -s zshconfig="vim ~/.zshrc"
  alias -s grep='grep --color'
  alias -s sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
  alias -s em="emacsclient -c"

  alias -s t='tail -f'
  alias -s vim='nvim'
  alias -s cat='bat'

  alias -s date="gdate"

  alias -s ..="cd .."
  alias -s ...="cd ../.."
  alias -s ....="cd ../../.."

  alias -s dud='du -d 1 -h'
  alias -s duf='du -sh *'
  alias -s fd='find . -type d -name'
  alias -s ff='find . -type f -name'

  alias -s h='history'
  alias -s hgrep="fc -El 0 | grep"
  alias -s help='man'
  alias -s p='ps -f'
  alias -s sortnr='sort -n -r'
  alias -s unexport='unset'

  alias -s rm='rm -i'
  alias -s cp='cp -i'
  alias -s mv='mv -i'

  alias -s ls="exa"
  alias -s ll="ls -lh"
  alias -s la="ls -a"
  alias -s lla="ls -lha"
  alias -s lt="ls --tree"
end

__set_path
__set_alias

status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)

almel init fish | source
source /Users/luiscm/.dotfiles/fish/rusticated.fish
