-- ~/.config/nvim/init.lua

require("config.core")
-- filetype autocommands
require("config.ft")

-- WARNING: Before calling the plugins manager and its corrolary make sure to:
-- 1. grant permessions for all authorized plugins in the regal edict:
--    lua/config/~edict.lua  ¤¤ gitignored ¤¤
-- 2. load from all plugins/ files the: lua/config/grimoire.lua magic grimoire
--    to know who is allowed to bask under the lazy sun of nvim paradise.

-- Load the plugin manager
require("config.lazy")
