if status is-interactive
    # Commands to run in interactive sessions can go here
end

/opt/homebrew/bin/brew shellenv | source
set -U fish_greeting ""
fish_add_path ~/.cargo/bin
