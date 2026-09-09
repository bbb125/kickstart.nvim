local is_mac = vim.fn.has 'macunix' == 1
local is_linux = vim.fn.has 'linux' == 1

return {
  -- Kanagawa for macOS (with transparency)
  {
    'rebelot/kanagawa.nvim',
    enabled = is_mac,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'kanagawa'
      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

      -- Make vertical column line darker and more transparent than CursorLine
      local function darken_color(hex, factor)
        local r = tonumber(hex:sub(2, 3), 16)
        local g = tonumber(hex:sub(4, 5), 16)
        local b = tonumber(hex:sub(6, 7), 16)
        r = math.floor(r * factor)
        g = math.floor(g * factor)
        b = math.floor(b * factor)
        return string.format('#%02x%02x%02x', r, g, b)
      end

      local cursorline = vim.api.nvim_get_hl(0, { name = 'CursorLine', link = false })
      if cursorline and cursorline.bg then
        local hex_bg = string.format('#%06x', cursorline.bg)
        local darkened_bg = darken_color(hex_bg, 0.5)
        vim.api.nvim_set_hl(0, 'ColorColumn', { bg = darkened_bg, blend = 70 })
      else
        vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#1b1b1b', blend = 70 })
      end
    end,
  },

  -- TokyoNight for Linux (solid background, good for basic terminals)
  {
    'folke/tokyonight.nvim',
    enabled = is_linux,
    priority = 1000,
    opts = {
      style = 'night', -- night, storm, day, moon
      terminal_colors = true,
      styles = {
        comments = { italic = false }, -- disable italics (some terminals struggle)
        keywords = { italic = false },
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
}
