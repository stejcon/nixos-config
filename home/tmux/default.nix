{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    prefix = "C-a";
    plugins = with pkgs.tmuxPlugins; [sensible];
    baseIndex = 1;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Use Alt-arrow to switch panes
      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D

      # Use Shift-arrow to switch windows
      bind -n M-Left previous-window
      bind -n M-Right next-window

      # Set easier split window keys
      bind-key v split-window -h
      bind-key h split-window -v
    '';
  };
}
