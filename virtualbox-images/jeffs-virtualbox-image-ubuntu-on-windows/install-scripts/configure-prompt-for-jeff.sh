#!/bin/sh -e
# configure-prompt-for-jeff.sh

JEFF_HOME=/home/jeff

echo " "
echo "************************************************************************"
echo "********************************* configure-prompt-for-jeff.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

# -----------------------------------------------
# DOWnLOAD git-prompt.sh and git-completion.bash

echo "Downloading git-prompt.sh"
curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh \
    -o "$JEFF_HOME/.git-prompt.sh"
echo " "

echo "Downloading git-completion.bash"
curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
    -o "$JEFF_HOME/.git-completion.bash"
echo " "

echo "chown git-prompt.sh and git-completion.bash to jeff:jeff"
chown jeff:jeff "$JEFF_HOME/.git-prompt.sh" "$JEFF_HOME/.git-completion.bash"

# ------------------------------------------------
# REMOVE DEFAULT PS1 BLOCK FROM .bashrc

echo "Removing default PS1 block from .bashrc..."
sed -i '/^if \[ "$color_prompt" = yes \]; then/,/^unset color_prompt force_color_prompt/d' "$JEFF_HOME/.bashrc"
echo " "

# ------------------------------------------------
# ADD TO .bashrc

echo ">>> Appending prompt config to .bashrc..."
cat >> "$JEFF_HOME/.bashrc" << 'EOF'

# GIT AWARE COLOR PROMPT using git-prompt.sh ----------------------------------

# JEFF ADDED - FUNCTION to check for updated files in the local repository
check_git_dirty() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        # Check for updated files in the working directory
        if [ -n "$(git status --porcelain)" ]; then
            echo "*"
        fi
    fi
}

# JEFF ADDED - FUNCTION to check for updates in the remote repository
check_git_updates() {
    # Check if we are in a Git repository
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        # Fetch updates from the remote repository
        git fetch &>/dev/null
        # Check if the local branch is behind the remote branch
        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse @{u})
        BASE=$(git merge-base @ @{u})

        if [ "$LOCAL" = "$REMOTE" ]; then
            echo ""
        elif [ "$LOCAL" = "$BASE" ]; then
            echo "[update available]"
        elif [ "$REMOTE" = "$BASE" ]; then
            echo "[ahead of remote]"
        else
            echo "[diverged from remote]"
        fi

    fi
}

# JEFF UPDATED - GIT AWARE PROMPT 'PS1' using git-prompt.sh and the functions above
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[00;37m\]@\[\033[38;5;208m\]\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\] $(__git_ps1 "(\[\033[00;36m\]%s)")\[\033[00m\]\[\033[0;31m\]$(check_git_dirty)$(check_git_updates)\[\033[00m\]\$ '
        # PS1='${debian_chroot:+($debian_chroot)}   - Indicates you're in chroot environment
        #     \[\033[01;36m\]                       - \033 Escape and [01;36m is Bold cyan
        #     \u                                    - Username
        #     \[\033[00;37m\]                       - Sets color to White
        #     @                                     - @ symbol
        #     \[\033[38;5;208m\]                    - Sets color to Orange (256-color)
        #     \h                                    - Hostname
        #     \[\033[00m\]                          - Resets color
        #     :                                     - Colon symbol
        #     \[\033[01;34m\]                       - Sets color to Bold blue
        #     \W                                    - Working directory (without full path)
        #     \[\033[00m\]                          - Resets color
        #     $(__git_ps1 "(\[\033[00;36m\]%s)")    - Calls _git_ps1 function - %s Git branch in Cyan
        #     \[\033[00m\]                          - Resets color
        #     \[\033[0;31m\]                        - Sets color to Red
        #     $(check_git_dirty)                    - Calls check_git_dirty() function
        #     $(check_git_updates)                  - Calls check_git_updates() function
        #     \[\033[00m\]                          - Resets color
        #     \$                                    - $ symbol (# if root)
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W $(__git_ps1 "(%s)")$(check_git_dirty)$(check_git_updates)\$ '
    fi
fi

# JEFF ADDED - GIT COMPLETION
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

unset color_prompt force_color_prompt
EOF

echo ">>> Done."

echo "*********************************** configure-prompt-for-jeff.sh (END) *"
echo "************************************************************************"
echo " "
