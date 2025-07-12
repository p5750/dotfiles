# Language
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# Sheldon
export SHELDON_CONFIG_DIR="$ZDOTDIR"

# Go
export GOPATH="$XDG_DATA_HOME/go"

# Rubygems
# export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export BUNDLE_USER_HOME="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"

# Volta
export VOLTA_HOME="$XDG_DATA_HOME/volta"

# Android
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
alias adb='HOME="$XDG_DATA_HOME"/android adb'

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# Gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

# AWS
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
