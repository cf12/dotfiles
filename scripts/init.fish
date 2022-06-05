#!/usr/bin/fish

if not type -q fisher
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end

fisher update