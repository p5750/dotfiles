alias vi='nvim'
alias vim='nvim'

case ${OSTYPE} in
  darwin*)
    alias ls='gls --color=auto'
    alias date='gdate'
    alias mkdir='gmkdir'
    alias cp='gcp'
    alias mv='gmv'
    alias rm='grm'
    alias du='gdu'
    ;;
  linux*)
    alias ls='ls --color=auto'
    ;;
esac
