function __set_path
  set -x GOPATH $HOME/.gopath
  set -x PATH /usr/local/opt/libxml2/bin $PATH
  set -x PATH /usr/local/opt/texinfo/bin $PATH
  set -x PATH $HOME/.local/bin $PATH
  set -x PATH $HOME/.miniconda2/bin $PATH
  set -x PATH $HOME/.cargo/bin $PATH
  set -x PATH $GOPATH/bin $PATH

  set -x LDFLAGS "-L/usr/local/opt/zlib/lib $LDFLAGS"
  set -x CPPFLAGS "-I/usr/local/opt/zlib/include $CPPFLAGS"
  set -x LDFLAGS "-L/usr/local/opt/flex/lib $LDFLAGS"
  set -x CPPFLAGS "-I/usr/local/opt/flex/include $CPPFLAGS"
  set -x LDFLAGS "-L/usr/local/opt/openssl/lib $LDFLAGS"
  set -x CPPFLAGS "-I/usr/local/opt/openssl/include $CPPFLAGS"
  set -x LC_ALL en_US.UTF-8
  set -x LANG en_US.UTF-8
  set -x LC_CTYPE en_US.UTF-8
  set -x PKG_CONFIG_PATH /usr/local/opt/zlib/lib/pkgconfig /usr/local/lib/pkgconfig /usr/local/opt/libxml2/lib/pkgconfig /opt/X11/lib/pkgconfig $PKG_CONFIG_PATH

  set -x HOMEBREW_NO_INSECURE_REDIRECT 1
  set -x HOMEBREW_CASK_OPTS --require-sha

  set -x GPG_KEY (tty)
  set -x TMREPOS ~/TerraMagna/repositories

  set -x EDITOR nvim
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

source ~/.local/share/nvim/dein/repos/github.com/nightsense/snow/shell/snow_dark.fish
