# vim-list

This is meant to be a simple plugin to enable the easy creation of various types of lists in vim. At the current time, there are two types of supported lists: ordered numbered lists and unordered Markdown style lists. This means that the lines will be prefixed with either a number e.g. `1. ` or a minus sign e.g. `- `.

Where the numbered list is concerned, if there is another numbered listing on the two lines above then the list numbers will increase from that point. 

## Keybindings

There are three keybindings for this plugin, and all three are bound with a leader key as the first tap.

- <leader>nl -> Numbered List
- <leader>gl -> Generic (Unordered) List
- <leader>dl -> Delete List

The deletion option only removes the characters input by the other options, so no other text should be destroyed.

## Checkboxes

This plugin is compatible with both the vim-outliner checkboxes and Markdown-format checkboxes as well. 
