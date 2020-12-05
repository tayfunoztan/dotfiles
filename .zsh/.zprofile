#
# Editors
#

export EDITOR='nvim'
export TERMINAL='alacritty'
export VISUAL='nvim'
# export PAGER='less'
# export LSCOLORS=cxBxhxDxfxhxhxhxhxcxcx
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

#
# Language
#
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

export PATH="/usr/local/opt/llvm/bin:$PATH"
# export GOPATH="$(go env GOPATH)"
# export GOBIN=$GOPATH/bin
# export PATH="$GOBIN:$PATH"
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools

# openssl, psycopg2-postgresql
# export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
# export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
# export LDFLAGS="-L/usr/local/opt/krb5/lib"
# export CPPFLAGS="-I/usr/local/opt/krb5/include"


# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

case "$EDITOR" in
    nvim) export MANPAGER="nvim +'set ft=man' -" ;;
    vim)  export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ro nomod nolist' -\"" ;;
    *)    export MANPAGER='less' ;;
esac
