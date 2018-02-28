# Haskell stack install path
set -xg PATH $HOME/.local/bin $PATH

# SSL certificate file
set -xg SSL_CERT_FILE $NIX_SSL_CERT_FILE

# emacs alias
function emacs
  eval "$HOME/.nix-profile/Applications/Emacs.app/Contents/MacOS/Emacs $argv &"
end
