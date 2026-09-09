--[[
  Modern Modular Neovim Configuration

  Structure:
    lua/config/     - Core settings (options, keymaps, autocmds, lazy setup)
    lua/plugins/    - Plugin specifications (auto-loaded by lazy.nvim)
    lua/kickstart/  - Kickstart.nvim modules
--]]

-- Load core configuration
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lazy'
