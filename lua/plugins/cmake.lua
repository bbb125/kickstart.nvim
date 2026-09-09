-- CMake and general build/task management
return {
  -- CMake Tools - full CMake workflow with preset support
  {
    'Civitasv/cmake-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ft = { 'c', 'cpp', 'objc', 'objcpp', 'cmake' },
    cmd = {
      'CMakeGenerate',
      'CMakeBuild',
      'CMakeRun',
      'CMakeDebug',
      'CMakeSelectBuildType',
      'CMakeSelectBuildTarget',
      'CMakeSelectLaunchTarget',
      'CMakeSelectConfigurePreset',
      'CMakeSelectBuildPreset',
    },
    keys = {
      { '<leader>mg', '<cmd>CMakeGenerate<cr>', desc = 'C[M]ake [G]enerate' },
      { '<leader>mb', '<cmd>CMakeBuild<cr>', desc = 'C[M]ake [B]uild' },
      { '<leader>mr', '<cmd>CMakeRun<cr>', desc = 'C[M]ake [R]un' },
      { '<leader>md', '<cmd>CMakeDebug<cr>', desc = 'C[M]ake [D]ebug' },
      { '<leader>mt', '<cmd>CMakeSelectBuildTarget<cr>', desc = 'C[M]ake Select [T]arget' },
      { '<leader>ml', '<cmd>CMakeSelectLaunchTarget<cr>', desc = 'C[M]ake Select [L]aunch Target' },
      { '<leader>mp', '<cmd>CMakeSelectConfigurePreset<cr>', desc = 'C[M]ake Select [P]reset' },
      { '<leader>mP', '<cmd>CMakeSelectBuildPreset<cr>', desc = 'C[M]ake Select Build [P]reset' },
      { '<leader>mD', '<cmd>CMakeSelectBuildDir<cr>', desc = 'C[M]ake Select Build [D]ir' },
      { '<leader>mT', '<cmd>CMakeSelectBuildType<cr>', desc = 'C[M]ake Select Build [T]ype' },
      { '<leader>ms', '<cmd>CMakeStop<cr>', desc = 'C[M]ake [S]top' },
      { '<leader>mo', '<cmd>CMakeOpen<cr>', desc = 'C[M]ake [O]pen Output' },
      { '<leader>mc', '<cmd>CMakeClose<cr>', desc = 'C[M]ake [C]lose Output' },
    },
    opts = {
      cmake_command = 'cmake',
      ctest_command = 'ctest',
      -- Build directory pattern - works with presets
      cmake_build_directory = function()
        -- cmake-tools will use preset's binaryDir if available
        -- fallback to build/${presetName} or build/${buildType}
        return 'build/${presetName}'
      end,
      -- Automatically create symlink to compile_commands.json in project root
      cmake_soft_link_compile_commands = true,
      -- Don't regenerate compile_commands via LSP (we use the symlink)
      cmake_compile_commands_from_lsp = false,
      -- Generate compile_commands.json during configure, disable colors for quickfix parsing
      cmake_generate_options = {
        '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON',
        '-DCMAKE_COLOR_DIAGNOSTICS=OFF', -- CMake 3.24+
      },
      cmake_regenerate_on_save = false, -- Don't auto-regenerate (Conan might need special handling)
      cmake_build_options = {},
      -- Executor for running cmake commands
      cmake_executor = {
        name = 'quickfix', -- Use quickfix window
        opts = {
          show = 'always', -- Show quickfix on build
          position = 'botright',
          size = 15,
          encoding = 'utf-8',
          auto_close_when_success = false,
        },
      },
      -- Runner for running targets
      cmake_runner = {
        name = 'toggleterm',
        opts = {
          direction = 'horizontal',
          close_on_exit = false,
          auto_scroll = true,
        },
      },
      -- Notifications (disabled - can hang after build completes)
      cmake_notifications = {
        runner = { enabled = false },
        executor = { enabled = false },
      },
    },
    config = function(_, opts)
      -- Disable colored output for proper quickfix error parsing
      vim.env.NO_COLOR = '1'
      vim.env.CLICOLOR = '0'
      vim.env.CLICOLOR_FORCE = '0'
      vim.env.GCC_COLORS = ''
      vim.env.CMAKE_COLOR_DIAGNOSTICS = 'OFF'

      require('cmake-tools').setup(opts)

      -- Auto-refresh clangd when compile_commands.json changes
      vim.api.nvim_create_autocmd('User', {
        pattern = 'CMakeGenerateDone',
        callback = function()
          -- Restart clangd to pick up new compile_commands.json
          local clients = vim.lsp.get_clients { name = 'clangd' }
          for _, client in ipairs(clients) do
            vim.notify('Restarting clangd to pick up new compile_commands.json', vim.log.levels.INFO)
            vim.cmd 'LspRestart clangd'
            break
          end
        end,
      })
    end,
  },

  -- Overseer - general task runner for multiple languages/build systems
  {
    'stevearc/overseer.nvim',
    cmd = {
      'OverseerRun',
      'OverseerToggle',
      'OverseerOpen',
      'OverseerClose',
      'OverseerBuild',
      'OverseerTaskAction',
      'OverseerQuickAction',
    },
    keys = {
      { '<leader>oo', '<cmd>OverseerToggle<cr>', desc = '[O]verseer T[o]ggle' },
      { '<leader>or', '<cmd>OverseerRun<cr>', desc = '[O]verseer [R]un' },
      { '<leader>ob', '<cmd>OverseerBuild<cr>', desc = '[O]verseer [B]uild' },
      { '<leader>oa', '<cmd>OverseerTaskAction<cr>', desc = '[O]verseer Task [A]ction' },
      { '<leader>oq', '<cmd>OverseerQuickAction<cr>', desc = '[O]verseer [Q]uick Action' },
      { '<leader>ol', '<cmd>OverseerRestartLast<cr>', desc = '[O]verseer Restart [L]ast' },
    },
    opts = {
      strategy = 'toggleterm',
      templates = { 'builtin' }, -- Load built-in templates (make, cargo, npm, go, etc.)
      task_list = {
        direction = 'bottom',
        min_height = 15,
        max_height = 25,
        default_detail = 1,
        bindings = {
          ['?'] = 'ShowHelp',
          ['g?'] = 'ShowHelp',
          ['<CR>'] = 'RunAction',
          ['<C-e>'] = 'Edit',
          ['o'] = 'Open',
          ['<C-v>'] = 'OpenVsplit',
          ['<C-s>'] = 'OpenSplit',
          ['<C-f>'] = 'OpenFloat',
          ['<C-q>'] = 'OpenQuickFix',
          ['p'] = 'TogglePreview',
          ['<C-l>'] = 'IncreaseDetail',
          ['<C-h>'] = 'DecreaseDetail',
          ['L'] = 'IncreaseAllDetail',
          ['H'] = 'DecreaseAllDetail',
          ['['] = 'DecreaseWidth',
          [']'] = 'IncreaseWidth',
          ['{'] = 'PrevTask',
          ['}'] = 'NextTask',
          ['<C-k>'] = 'ScrollOutputUp',
          ['<C-j>'] = 'ScrollOutputDown',
          ['q'] = 'Close',
        },
      },
      form = {
        border = 'rounded',
        win_opts = { winblend = 0 },
      },
      task_launcher = {
        bindings = {
          i = {
            ['<C-s>'] = 'Submit',
            ['<C-c>'] = 'Cancel',
          },
          n = {
            ['<CR>'] = 'Submit',
            ['<C-s>'] = 'Submit',
            ['q'] = 'Cancel',
            ['?'] = 'ShowHelp',
          },
        },
      },
    },
    config = function(_, opts)
      local overseer = require 'overseer'
      overseer.setup(opts)

      -- Custom Conan template
      overseer.register_template {
        name = 'conan install',
        builder = function()
          return {
            cmd = { 'conan' },
            args = { 'install', '.', '--build=missing' },
            name = 'Conan Install',
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          callback = function()
            return vim.fn.filereadable 'conanfile.txt' == 1 or vim.fn.filereadable 'conanfile.py' == 1
          end,
        },
      }

      -- Custom template for CMake with Conan preset
      overseer.register_template {
        name = 'cmake conan workflow',
        builder = function()
          return {
            cmd = { 'cmake' },
            args = { '--workflow', '--preset', 'conan-release' },
            name = 'CMake Conan Workflow',
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          callback = function()
            return vim.fn.filereadable 'CMakePresets.json' == 1
          end,
        },
      }

      -- Ninja build template (for custom/manual cmake setups)
      overseer.register_template {
        name = 'ninja',
        builder = function()
          -- Find build directory with build.ninja
          local build_dirs = { 'build', 'build/Debug', 'build/Release', 'cmake-build-debug', 'cmake-build-release', 'out/build' }
          local build_dir = nil
          for _, dir in ipairs(build_dirs) do
            if vim.fn.filereadable(dir .. '/build.ninja') == 1 then
              build_dir = dir
              break
            end
          end
          return {
            cmd = { 'ninja' },
            args = { '-C', build_dir or 'build' },
            name = 'Ninja Build',
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          callback = function()
            -- Check common build directories for build.ninja
            local build_dirs = { 'build', 'build/Debug', 'build/Release', 'cmake-build-debug', 'cmake-build-release', 'out/build' }
            for _, dir in ipairs(build_dirs) do
              if vim.fn.filereadable(dir .. '/build.ninja') == 1 then
                return true
              end
            end
            return false
          end,
        },
      }

      -- Ninja with target selection
      overseer.register_template {
        name = 'ninja (select target)',
        params = {
          target = {
            type = 'string',
            desc = 'Build target',
            default = '',
            optional = true,
          },
          build_dir = {
            type = 'string',
            desc = 'Build directory',
            default = 'build',
          },
        },
        builder = function(params)
          local args = { '-C', params.build_dir }
          if params.target and params.target ~= '' then
            table.insert(args, params.target)
          end
          return {
            cmd = { 'ninja' },
            args = args,
            name = 'Ninja: ' .. (params.target ~= '' and params.target or 'all'),
            cwd = vim.fn.getcwd(),
          }
        end,
        condition = {
          callback = function()
            local build_dirs = { 'build', 'build/Debug', 'build/Release', 'cmake-build-debug', 'cmake-build-release', 'out/build' }
            for _, dir in ipairs(build_dirs) do
              if vim.fn.filereadable(dir .. '/build.ninja') == 1 then
                return true
              end
            end
            return false
          end,
        },
      }

      -- Restart last task command
      vim.api.nvim_create_user_command('OverseerRestartLast', function()
        local tasks = overseer.list_tasks { recent_first = true }
        if vim.tbl_isempty(tasks) then
          vim.notify('No tasks found', vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], 'restart')
        end
      end, {})
    end,
  },

  -- ToggleTerm - terminal management (used by cmake-tools and overseer)
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm', 'TermExec' },
    keys = {
      { '<C-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
      { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = '[T]erminal [F]loat' },
      { '<leader>tH', '<cmd>ToggleTerm direction=horizontal<cr>', desc = '[T]erminal [H]orizontal' },
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<cr>', desc = '[T]erminal [V]ertical' },
    },
    opts = {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = 'horizontal',
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        winblend = 0,
      },
    },
  },
}
