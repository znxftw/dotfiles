source ${HOME}/.aliases

# zlib - required for installing python via asdf
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
. "$HOME/.cargo/env"
