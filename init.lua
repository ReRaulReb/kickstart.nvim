--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options
-- ============================================================
do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()
  vim.env.CC = 'gcc'

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  vim.g.have_nerd_font = false

  -- [[ Setting options ]]
  --  See `:help vim.o`
  -- NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

  -- Make line numbers default
  vim.o.number = true
  -- You can also add relative line numbers, to help with jumping.
  --  Experiment for yourself to see if you like it!
  -- vim.o.relativenumber = true

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.o.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  vim.o.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  vim.o.breakindent = true

  -- Enable undo/redo changes even after closing and reopening a file
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.o.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  --
  --  Notice listchars is set using `vim.opt` instead of `vim.o`.
  --  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
  --   See `:help lua-options`
  --   and `:help lua-guide-options`
  vim.o.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.o.inccommand = 'split'

  -- Show which line your cursor is on
  vim.o.cursorline = true

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.scrolloff = 10

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  vim.o.confirm = true
end

-- ============================================================
-- SECTION 2: KEYMAPS & AUTOCMDS
-- basic keymaps, basic autocmds
-- ============================================================
do
  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  vim.keymap.set('i', 'jj', '<Esc>', { noremap = false } )
  vim.keymap.set('i', 'jk', '<Esc>', { noremap = false } )

  -- [[ Basic Autocommands ]]
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
  })
end

-- ============================================================
-- SECTION 3: PLUGIN MANAGER INTRO
-- vim.pack intro, build hooks
-- ============================================================
do
  -- [[ Intro to `vim.pack` ]]
  -- `vim.pack` is a new plugin manager built into Neovim,
  --  which provides a Lua interface for installing and managing plugins.
  --
  --  See `:help vim.pack`, `:help vim.pack-examples` or the
  --  excellent blog post from the creator of vim.pack and mini.nvim:
  --  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
  --
  --  To inspect plugin state and pending updates, run
  --    :lua vim.pack.update(nil, { offline = true })
  --
  --  To update plugins, run
  --    :lua vim.pack.update()
  --
  --
  --  Throughout the rest of the config there will be examples
  --  of how to install and configure plugins using `vim.pack`.
  --
  --  In this section we set up some autocommands to run build
  --  steps for certain plugins after they are installed or updated.

  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
  -- [[ Installing and Configuring Plugins ]]
  --
  -- To install a plugin simply call `vim.pack.add` with its git url.
  -- This will download the default branch of the plugin, which will usually be `main` or `master`
  -- You can also have more advanced specs, which we will talk about later.
  --
  -- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
  --
  -- For example, lets say we want to install `guess-indent.nvim` - a plugin for
  -- automatically detecting and setting the indentation.
  --
  -- We first install it from https://github.com/NMAC427/guess-indent.nvim
  -- and then call its `setup()` function to start it with default settings.
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  -- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
  --
  -- See `:help gitsigns` to understand what each configuration key does.
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
  }

  -- Useful plugin to show you pending keybinds.
  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  }

  -- [[ Colorscheme ]]
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command under that to load whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  vim.pack.add { gh 'folke/tokyonight.nvim' }
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    styles = {
      comments = { italic = false }, -- Disable italics in comments
    },
  }

  -- Load the colorscheme here.
  -- Like many other themes, this one has different styles, and you could load
  -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  vim.cmd.colorscheme 'terraclay'
  vim.api.nvim_set_hl(0, 'SnacksDashboardHeader', { fg = '#FF8C52', bold = true })
  vim.api.nvim_set_hl(0, 'SnacksTermHeaderText', { fg = '#FF8C52', bg = 'NONE', blend = 0 })

  -- Highlight todo, notes, etc in comments
  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  -- [[ mini.nvim ]]
  --  A collection of various small independent plugins/modules
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- If a nerd font is available, load the icons module for pretty icons in various plugins.
  if vim.g.have_nerd_font then
    require('mini.icons').setup()
    -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
    MiniIcons.mock_nvim_web_devicons()
  end

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  -- Simple and easy statusline.
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'
  -- Set `use_icons` to true if you have a Nerd Font
  statusline.setup { use_icons = vim.g.have_nerd_font }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end

  -- ... and there is more!
  --  Check out: https://github.com/nvim-mini/mini.nvim
end

-- ============================================================
-- SECTION 11: SNACKS.NVIM
-- File explorer sidebar, terminal, dashboard, notifications, and other QoL modules
-- ============================================================
local art = {
'                               ▀▀                     ',
'▒░▀▒░▀░▒ ▒░▀▀██ ▒░▀▀██ ▒░▀█▀██ ██ ▒░▀▀██ ▒░▀▀██ █░    ',
'   ░█    ░█▄▄   ░█▄▄█▀ ░    ██ ░█ ░█  ░█ ░█  ██ ░▒  ██',
'   ██    ██▄▄▄▄ ██  ██ ██   ██ ▒░ ██  ██ ██▀▀██ █░▄▄██',
'   ▀▀           ██  ▀▀ ▀▀                ▀▀  ▀▀       ',
}

local function attach_header(self)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'wipe'
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, art)

  -- Highlight only the non-space glyph runs, leaving blank cells untouched
  -- so they inherit the window's winblend and stay transparent.
  local ns = vim.api.nvim_create_namespace('snacks_term_header')
  for i, line in ipairs(art) do
    local col = 1
    while col <= #line do
      local s, e = line:find('[^ ]+', col)
      if not s then break end
      vim.api.nvim_buf_set_extmark(buf, ns, i - 1, s - 1, { end_col = e, hl_group = 'SnacksTermHeaderText' })
      col = e + 1
    end
  end

  local w = 0
  for _, l in ipairs(art) do w = math.max(w, vim.fn.strdisplaywidth(l)) end

  local function geometry()
    local wincfg = vim.api.nvim_win_get_config(self.win)
    return {
      relative = 'win',
      win = self.win,
      row = -#art - 1,
      col = math.floor((vim.api.nvim_win_get_width(self.win) - w) / 2),
      width = w,
      height = #art,
      style = 'minimal',
      focusable = false,
      zindex = (wincfg.zindex or 50) + 1,
    }
  end

  local hdr = vim.api.nvim_open_win(buf, false, geometry())
  vim.wo[hdr].winblend = 100

  local group = vim.api.nvim_create_augroup('SnacksTermHeader' .. self.win, { clear = true })

  vim.api.nvim_create_autocmd({ 'WinResized', 'VimResized' }, {
    group = group,
    callback = function()
      if not vim.api.nvim_win_is_valid(hdr) or not vim.api.nvim_win_is_valid(self.win) then return end
      vim.api.nvim_win_set_config(hdr, geometry())
    end,
  })

  vim.api.nvim_create_autocmd('WinClosed', {
    group = group,
    pattern = tostring(self.win),
    callback = function()
      pcall(vim.api.nvim_win_close, hdr, true)
      pcall(vim.api.nvim_del_augroup_by_id, group)
    end,
  })
end



do
  -- Snacks.nvim needs netrw disabled or the built-in explorer can misbehave
  -- alongside it when opening directories.
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  vim.pack.add { gh 'folke/snacks.nvim' }

  require('snacks').setup {
    -- Sidebar file explorer (an alternative to neo-tree/nvim-tree)
    explorer = { enabled = true },

    -- Nicer popup notifications instead of the plain echo-area messages
    notifier = { enabled = true, timeout = 3000 },

    -- Start screen when you open nvim with no file argument.
    -- NOTE: the default preset includes a "startup" section that reads plugin
    -- load stats from lazy.nvim (require('lazy.stats')). Since this config
    -- uses vim.pack instead of lazy.nvim, that module doesn't exist, so we
    -- override `sections` to leave that one out.

    dashboard = {
      enabled = true,
      preset = {
          header = [[
                                                                                      
                                                                                      
                                                                                      
                         ░▄                                                           
                       ▄█░                                                            
▄▄▄ ▄▄▄     ▄▄▄  ▄▄▄▄ ▐▒▓▌ ▄▄▄ ▄▄▄   ▄▄                                               
▐░░░░░░░▄  ▐░▒▒ ▐▒▒▒▓  ▀░  ▐░░░░░░░▄░░░░▄     ▐▀▄       ▄▀▌   ▄▄▄▄▄▄▄                 
▐▒▒▒▀░░▒▒▒ ▐▒▒▒ ▐▒▒▒▓  ▄▄▄ ▐▒▒▒▀░░▒▒▀░░▒▒▒    ▌▒▒▀▄▄▄▄▄▀▒▒▐▄▀▀▒██▒██▒▀▀▄              
▐▓▓▒ ▐▒▒▓▓ ▐▓▓▓ ▐▓▓▓█ ▐▒▒▒ ▐▓▓▒ ▐▒▒▓ ▐▒▒▓▓   ▐▒▒▒▒▀▒▀▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▄            
▐██▓ ▐▓▓██ ▐███ ▐████ ▐▓▓▒ ▐██▓ ▐▓▓█ ▐▓▓██   ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▒▒▒▒▒▒▒▒▒▒▒▒▀▄          
▐███ ▐████ ▐███ ▐████ ▐██▓ ▐███ ▐███ ▐████ ▀█▒▒▒█▌▒▒█▒▒▐█▒▒▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌         
▐▓▓█ ▐█▓▓▓ ▐▓▓▓ ▐▓▓██ ▐███ ▐▓▓█ ▐█▓▓ ▐█▓▓▓ ▀▌▒▒▒▒▒▒▀▒▀▒▒▒▒▒▒▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐   ▄▄    
▐▒▓▓ ▐▓▓▒▒ ▐▒▒▒ ▐▒▓▓▌ ▐███ ▐▒▓▓ ▐▓▓▒ ▐▓▓▒▒ ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌▄███    
▐▒▒▒ ▐▒▒▒░  ▐░░▄█▒▒▌  ▐▓▓▓ ▐▒▒▒      ▐▒▒▒░ ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███▀     
▐░░░ ▐░░░░   ▀▀░░▀▀   ▐▒▒▒ ▐░░░      ▐░░░░ ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▀       
]],
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'recent_files', limit = 5, padding = 1 },
        { section = 'projects', limit = 5, padding = 1 },
      },
    },

    -- Floating/split toggleable terminal
    terminal = { enabled = true,
      win = {
        position = 'float',
        border = 'rounded',
        width = 0.85,
        height = 0.45,
        row = 0.4,
        backdrop = 100,
        title_pos = 'center',
        on_win = attach_header,
      }
    },

    -- Smooth animated cursor scrolling
    scroll = { enabled = true },

    -- Distraction-free single-column mode
    zen = { enabled = true },

    -- Combined line-number/sign/fold gutter, styled to match the rest
    statuscolumn = { enabled = true },

    -- Highlights + lets you jump between other usages of the word under cursor
    -- words = { enabled = true },

    -- Small library other snacks modules depend on internally, safe to leave on
    indent = { enabled = true },
  }

  -- Explorer: toggle the sidebar
  vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = '[E]xplorer' })

  -- Terminal: toggle a floating terminal
  vim.keymap.set('n', '<leader>tt', function() Snacks.terminal() end, { desc = '[T]oggle [T]erminal' })
  vim.keymap.set('t', '<C-\\>', function() Snacks.terminal() end, { desc = 'Toggle terminal (from terminal mode)' })

  -- Zen mode: toggle distraction-free single column
  vim.keymap.set('n', '<leader>tz', function() Snacks.zen() end, { desc = '[T]oggle [Z]en mode' })

  -- LSP reference navigation via words module
  -- vim.keymap.set('n', ']]', function() Snacks.words.jump(1) end, { desc = 'Next reference' })
  -- vim.keymap.set('n', '[[', function() Snacks.words.jump(-1) end, { desc = 'Prev reference' })
end

do
  ------------------------------------------------------------------
  -- Colors — single flat color for the flame (matches the logo).
  -- Confirm the exact match with `:Inspect` over the header text,
  -- then adjust FLAME_COLOR below if it's off.
  ------------------------------------------------------------------
  local FLAME_COLOR = '#FF8C52'
  local SMOKE_COLOR = '#4A4239' -- terraclay p.umber, faint/dim against bg
  local TAIL_COLOR = FLAME_COLOR

  vim.api.nvim_set_hl(0, 'SnacksFlame', { fg = FLAME_COLOR, bold = true })
  vim.api.nvim_set_hl(0, 'SnacksSmoke', { fg = SMOKE_COLOR })
  vim.api.nvim_set_hl(0, 'SnacksTail', { fg = TAIL_COLOR })

  ------------------------------------------------------------------
  --- cat tail stuffs
  ------------------------------------------------------------------

  local row12_template = "▐▓▓█ ▐█▓▓▓ ▐▓▓▓ ▐▓▓██ ▐███ ▐▓▓█ ▐█▓▓ ▐█▓▓▓ ▀▌▒▒▒▒▒▒▀▒▀▒▒▒▒▒▒▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐   ▄▄    "
  local row13_template = "▐▒▓▓ ▐▓▓▒▒ ▐▒▒▒ ▐▒▓▓▌ ▐███ ▐▒▓▓ ▐▓▓▒ ▐▓▓▒▒ ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌▄███    "
  local row14_template = "▐▒▒▒ ▐▒▒▒░  ▐░░▄█▒▒▌  ▐▓▓▓ ▐▒▒▒      ▐▒▒▒░ ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███▀     "
  local row15_template = "▐░░░ ▐░░░░   ▀▀░░▀▀   ▐▒▒▒ ▐░░░      ▐░░░░ ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▀       "

  local tip_glyph, seg_glyph, mid_glyph, base_glyph = "▄▄", "▄███", "███▀", "█▀"
  local tip_start  = assert(row12_template:find(tip_glyph, 1, true))
  local seg_start  = assert(row13_template:find(seg_glyph, 1, true))
  local mid_start  = assert(row14_template:find(mid_glyph, 1, true))
  local base_start = assert(row15_template:find(base_glyph, 1, true))

  local function build_tail_row(template, zone_start, content)
    local zone_width = #template - zone_start + 1 -- byte width; all glyphs here are 3-byte UTF-8 so this lines up
    local content_w = vim.fn.strdisplaywidth(content)
    local pad = string.rep(" ", math.max(0, zone_width - content_w))
    return template:sub(1, zone_start - 1) .. content .. pad
  end

  local TAIL_TICK_DIV = 1

  -- {head, tail_up, tail_lo} per frame. Repeated rest frames give it
  -- a pause between flicks instead of wagging nonstop.
  --   ▐▀▄       ▄▀▌   ▄▄▄▄▄▄▄             
  --   ▌▒▒▀▄▄▄▄▄▀▒▒▐▄▀▀▒██▒██▒▀▀▄          
  --  ▐▒▒▒▒▀▒▀▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▄        
  --  ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▒▒▒▒▒▒▒▒▒▒▒▒▀▄      
  --▀█▒▒▒█▌▒▒█▒▒▐█▒▒▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌     
  --▀▌▒▒▒▒▒▒▀▒▀▒▒▒▒▒▒▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐   ▄▄
  --▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌▄███
  --▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███▀ 
  --▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▀   
  local tail_frames = {
    { tip_glyph,   seg_glyph, mid_glyph, base_glyph },
    { "▄▄",    "▄███", "███▀", "█▀" },
    { " ▄",    " ▄███", "███▀", "█▀" },
    { " ▄",    " ▄▄██", "███▀▀", "█▀" },
    { "",    " ▄▄██",   "███▀▀", "█▀" },
    { "",    " ▄▄▄▄▄",  "████▀▀", "█▀▀" },
    { "",    "   ▄▄▄", "█▄█████", "██▀▀" },
    { "",    "    ▄▄", "█▄█████", "██▀▀" },
    { "",    "     ▄", "█▄▄████", "██▀▀▀" },
    { "",    "      ", "█▄▄▄███▄", "██▀▀▀▀" },
    { "",    "      ", "█▄▄▄███▄", "██▀▀▀▀" },

    { "",    "      ", "█▄▄▄███▄",  "██▀▀▀▀" },
    { "",    "      ", "█▄▄▄███▄",  "██▀▀▀▀" },

    { "",    "      ", "█▄▄▄███▄", "██▀▀▀▀" },
    { "",    "      ", "█▄▄▄███▄", "██▀▀▀▀" },
    { "",    "     ▄", "█▄▄████", "██▀▀▀" },
    { "",    "    ▄▄", "█▄█████", "██▀▀" },
    { "",    "   ▄▄▄", "█▄█████", "██▀▀" },
    { "",    " ▄▄▄▄▄",  "████▀▀", "█▀▀" },
    { "",    " ▄▄██",   "███▀▀", "█▀" },
    { " ▄",    " ▄▄██", "███▀▀", "█▀" },
    { " ▄",    " ▄███", "███▀", "█▀" },
    { "▄▄",    "▄███", "███▀", "█▀" },
    { tip_glyph,   seg_glyph, mid_glyph, base_glyph },
  }

  ------------------------------------------------------------------
  -- Templates: exact original spacing. The anchor is the 3rd body
  -- row, used to locate everything else regardless of centering.
  ------------------------------------------------------------------
  local line1_template  = "                         ░▄               "
  local line2_template  = "                       ▄█░                "
  local anchor_template = "▄▄▄ ▄▄▄     ▄▄▄  ▄▄▄▄ ▐▒▓▌ ▄▄▄ ▄▄▄   ▄▄   "
  local blank_template  = string.rep(" ", #line1_template)

  local line1_old, line2_old = "░▄", "▄█░"
  local line1_start = assert(line1_template:find(line1_old, 1, true))
  local line2_start = assert(line2_template:find(line2_old, 1, true))
  local flame_col = line1_start -- roughly the flame's horizontal center

  local function build_line(template, start, old, new)
    return template:sub(1, start - 1) .. new .. template:sub(start + #old)
  end

  local function place(col, ch)
    col = math.max(1, math.min(#blank_template, col))
    return blank_template:sub(1, col - 1) .. ch .. blank_template:sub(col + 1)
  end

  local function hl_line(buf, ns, row, group, len)
    vim.api.nvim_buf_set_extmark(buf, ns, row - 1, 0, { end_row = row - 1, end_col = len, hl_group = group })
  end

  ------------------------------------------------------------------
  -- Flame: 20 frames, tiny steps between each, ticking fast (60ms)
  -- for a smooth flicker instead of a jumpy one.
  ------------------------------------------------------------------
  local flame_frames = {
    { "░▄", "▄█░" }, { "░▄", "▄█▒" }, { "▒▄", "▄█▒" }, { "▒▄", "▄█▓" },
    { "▓▄", "▄█▓" }, { "▓▄", "▓█▓" }, { "▓▀", "▓█▓" }, { "▓▀", "▓██" },
    { "█▀", "▓██" }, { "█▀", "▒██" }, { "▓▀", "▒██" }, { "▓▀", "▒█▓" },
    { "▓▄", "▒█▓" }, { "▓▄", "░█▓" }, { "▒▄", "░█▓" }, { "▒▄", "░█▒" },
    { "▒▄", "▄▓▒" }, { "░▄", "▄▓▒" }, { "░▄", "▄▓░" }, { "░▀", "▄▒░" },
  }

  ------------------------------------------------------------------
  -- Smoke: 3 rows above the flame, drifting up + sideways, fading
  -- with distance (denser ▒/▓ near the flame, thin marks higher
  -- up). Advances slower than the flame for a lazy drift feel.
  ------------------------------------------------------------------
  local smoke_frames = {
    { {flame_col + 1, "▒"}, {flame_col,     "·"}, {flame_col - 1, "˙"} },
    { {flame_col,     "▓"}, {flame_col + 1, "‚"}, {flame_col,     "·"} },
    { {flame_col - 1, "▒"}, {flame_col - 1, "˙"}, {flame_col + 1, "‚"} },
    { {flame_col + 1, "▓"}, {flame_col,     "·"}, {flame_col + 2, "˙"} },
    { {flame_col,     "▒"}, {flame_col + 2, "˙"}, {flame_col - 1, " "} },
    { {flame_col - 1, "▓"}, {flame_col - 1, "‚"}, {flame_col,     "˙"} },
  }

  local flame_idx, smoke_idx, tail_idx, tick = 1, 1, 1, 0
  local timer = nil
  local ns = vim.api.nvim_create_namespace("snacks_fire")

  local function start_fire(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local anchor_row
    for i, line in ipairs(lines) do
      if line:find("▐▒▓▌", 1, true) then anchor_row = i; break end
    end
    if not anchor_row or anchor_row < 6 then return end

    local template_pad = anchor_template:match("^(%s*)")
    local actual_pad = lines[anchor_row]:match("^(%s*)")
    local extra_pad = actual_pad:sub(#template_pad + 1)

    local smoke_row3 = anchor_row - 3 -- closest to flame
    local smoke_row2 = anchor_row - 4
    local smoke_row1 = anchor_row - 5 -- highest/faintest
    local flame_row1 = anchor_row - 2
    local flame_row2 = anchor_row - 1
    local tip_row  = anchor_row + 6
    local seg_row  = anchor_row + 7
    local mid_row  = anchor_row + 8
    local base_row = anchor_row + 9
    local has_tail = lines[base_row] ~= nil

    timer = vim.uv.new_timer()
    timer:start(0, 60, vim.schedule_wrap(function()
      if not vim.api.nvim_buf_is_valid(buf) then
        timer:stop(); timer:close(); return
      end
      tick = tick + 1
      flame_idx = (flame_idx % #flame_frames) + 1
      if tick % 3 == 0 then smoke_idx = (smoke_idx % #smoke_frames) + 1 end
      if tick % TAIL_TICK_DIV == 0 then tail_idx = (tail_idx % #tail_frames) + 1 end

      local f  = flame_frames[flame_idx]
      local s  = smoke_frames[smoke_idx]
      local tf  = tail_frames[tail_idx]

      local l_f1 = extra_pad .. build_line(line1_template, line1_start, line1_old, f[1])
      local l_f2 = extra_pad .. build_line(line2_template, line2_start, line2_old, f[2])
      local l_s1 = extra_pad .. place(s[1][1], s[1][2])
      local l_s2 = extra_pad .. place(s[2][1], s[2][2])
      local l_s3 = extra_pad .. place(s[3][1], s[3][2])

      local l_tip, l_seg, l_mid, l_base
      if has_tail then
        l_tip  = extra_pad .. build_tail_row(row12_template, tip_start,  tf[1])
        l_seg  = extra_pad .. build_tail_row(row13_template, seg_start,  tf[2])
        l_mid  = extra_pad .. build_tail_row(row14_template, mid_start,  tf[3])
        l_base = extra_pad .. build_tail_row(row15_template, base_start, tf[4])
      end

      vim.bo[buf].modifiable = true
      vim.api.nvim_buf_set_lines(buf, smoke_row1 - 1, smoke_row1, false, { l_s1 })
      vim.api.nvim_buf_set_lines(buf, smoke_row2 - 1, smoke_row2, false, { l_s2 })
      vim.api.nvim_buf_set_lines(buf, smoke_row3 - 1, smoke_row3, false, { l_s3 })
      vim.api.nvim_buf_set_lines(buf, flame_row1 - 1, flame_row1, false, { l_f1 })
      vim.api.nvim_buf_set_lines(buf, flame_row2 - 1, flame_row2, false, { l_f2 })
      if has_tail then
        vim.api.nvim_buf_set_lines(buf, tip_row - 1, tip_row, false, { l_tip })
        vim.api.nvim_buf_set_lines(buf, seg_row - 1, seg_row, false, { l_seg })
        vim.api.nvim_buf_set_lines(buf, mid_row - 1, mid_row, false, { l_mid })
        vim.api.nvim_buf_set_lines(buf, base_row - 1, base_row, false, { l_base })
      end
      vim.bo[buf].modifiable = false

      vim.api.nvim_buf_clear_namespace(buf, ns, smoke_row1 - 1, flame_row2)
      hl_line(buf, ns, smoke_row1, 'SnacksSmoke', #l_s1)
      hl_line(buf, ns, smoke_row2, 'SnacksSmoke', #l_s2)
      hl_line(buf, ns, smoke_row3, 'SnacksSmoke', #l_s3)
      hl_line(buf, ns, flame_row1, 'SnacksFlame', #l_f1)
      hl_line(buf, ns, flame_row2, 'SnacksFlame', #l_f2)
      if has_tail then
        vim.api.nvim_buf_clear_namespace(buf, ns, tip_row - 1, base_row)
        hl_line(buf, ns, tip_row, 'SnacksTail', #l_tip)
        hl_line(buf, ns, seg_row, 'SnacksTail', #l_seg)
        hl_line(buf, ns, mid_row, 'SnacksTail', #l_mid)
        hl_line(buf, ns, base_row, 'SnacksTail', #l_base)
      end
    end))  end

  local function stop_fire()
    if timer then timer:stop(); timer:close(); timer = nil end
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "SnacksDashboardOpened",
    callback = function(data) start_fire(data.buf) end,
  })

  vim.api.nvim_create_autocmd({ "BufWipeout", "BufDelete" }, {
    pattern = "*",
    callback = function(ev)
      if vim.bo[ev.buf].filetype == "snacks_dashboard" then stop_fire() end
    end,
  })
end

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- Telescope setup, keymaps, LSP picker mappings
-- ============================================================
do
  -- [[ Fuzzy Finder (files, lsp, etc) ]]
  --
  -- Telescope is a fuzzy finder that comes with a lot of different things that
  -- it can fuzzy find! It's more than just a "file finder", it can search
  -- many different aspects of Neovim, your workspace, LSP, and more!
  --
  -- There are lots of other alternative pickers (like snacks.picker, or fzf-lua)
  -- so feel free to experiment and see what you like!
  --
  -- The easiest way to use Telescope, is to start by doing something like:
  --  :Telescope help_tags
  --
  -- After running this command, a window will open up and you're able to
  -- type in the prompt window. You'll see a list of `help_tags` options and
  -- a corresponding preview of the help.
  --
  -- Two important keymaps to use while in Telescope are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Telescope picker. This is really useful to discover what Telescope can
  -- do as well as how to actually do it!

  ---@type (string|vim.pack.Spec)[]
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
  }
  if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

  -- NOTE: You can install multiple plugins at once
  vim.pack.add(telescope_plugins)

  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    -- You can put your default mappings / updates / etc. in here
    --  All the info you're looking for is in `:help telescope.setup()`
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
  -- If you later switch picker plugins, this is where to update these mappings.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf

      -- Find references for the word under your cursor.
      vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

      -- Jump to the implementation of the word under your cursor.
      -- Useful when your language has ways of declaring types without an actual implementation.
      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

      -- Jump to the definition of the word under your cursor.
      -- This is where a variable was first declared, or where a function is defined, etc.
      -- To jump back, press <C-t>.
      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

      -- Fuzzy find all the symbols in your current document.
      -- Symbols are things like variables, functions, types, etc.
      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

      -- Fuzzy find all the symbols in your current workspace.
      -- Similar to document symbols, except searches over your entire project.
      vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

      -- Jump to the type of the word under your cursor.
      -- Useful when you're not sure what type a variable is and you want to see
      -- the definition of its *type*, not where it was *defined*.
      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
    end,
  })

  -- Override default behavior and theme when searching
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set(
    'n',
    '<leader>s/',
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    { desc = '[S]earch [/] in Open Files' }
  )

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = '[S]earch [N]eovim files' })
end

-- ============================================================
-- SECTION 6: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================
do
  -- [[ LSP Configuration ]]
  -- Brief aside: **What is LSP?**
  --
  -- LSP is an initialism you've probably heard, but might not understand what it is.
  --
  -- LSP stands for Language Server Protocol. It's a protocol that helps editors
  -- and language tooling communicate in a standardized fashion.
  --
  -- In general, you have a "server" which is some tool built to understand a particular
  -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  -- processes that communicate with some "client" - in this case, Neovim!
  --
  -- LSP provides Neovim with features like:
  --  - Go to definition
  --  - Find references
  --  - Autocompletion
  --  - Symbol Search
  --  - and more!
  --
  -- Thus, Language Servers are external tools that must be installed separately from
  -- Neovim. This is where `mason` and related plugins come into play.
  --
  -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
  -- and elegantly composed help section, `:help lsp-vs-treesitter`

  -- Useful status updates for LSP.
  vim.pack.add { gh 'j-hui/fidget.nvim',
    gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'mfussenegger/nvim-jdtls',
  }
  require('fidget').setup {}

  --  This function gets run when an LSP attaches to a particular buffer.
  --    That is to say, every time a new file is opened that is associated with
  --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --    function will be executed to configure the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      -- NOTE: Remember that Lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --  See `:help lsp-config` for information about keys and how to configure
  ---@type table<string, vim.lsp.Config>
  local servers = {
    clangd = {
          },
    -- gopls = {},
    pyright = {},
    -- rust_analyzer = {},
    --
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
    --
    -- But for many setups, the LSP (`ts_ls`) will work just fine
    -- ts_ls = {},

    stylua = {}, -- Used to format Lua code

    -- Special Lua Config, as recommended by neovim help docs
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
        client.config.settings.Lua = vim.tbl_deep_extend('force', current_settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.api.nvim_get_runtime_file('', true),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false }, -- Disable formatting (formatting is done by stylua)
        },
      },
    },

    html = {},
    cssls = {},
    jsonls = {},
    tailwindcss = {},
    ts_ls = {},
    eslint = {
      settings = {
        workingDirectories = { mode = 'auto'},
      },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- Automatically install LSPs and related tools to stdpath for Neovim
  require('mason').setup {}

  -- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
  require('mason-lspconfig').setup {
    automatic_enable = false, -- Change this to true if you want to automatically enable servers that are installed manually (e.g. via :Mason / :MasonInstall)
  }

  -- Ensure the servers and tools above are installed
  --
  -- To check the current status of installed tools and/or manually install
  -- other tools, you can run
  --    :Mason
  --
  -- You can press `g?` for help in this menu.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- You can add other tools here that you want Mason to install
    'jdtls',
    'java-debug-adapter',
    'java-test',
    'prettierd',
    'prettier',
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

-- ============================================================
-- SECTION 7: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================
do
  -- [[ Formatting ]]
  vim.pack.add { gh 'windwp/nvim-ts-autotag' }
  require('nvim-ts-autotag').setup()
  --
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- You can specify filetypes to autoformat on save here:
      local enabled_filetypes = {
        -- lua = true,
        -- python = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      -- rust = { 'rustfmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
end

-- ============================================================
-- SECTION 8: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================
do
  -- [[ Snippet Engine ]]

  -- NOTE: You can also specify plugin using a version range for its git tag.
  --  See `:help vim.version.range()` for more info
  vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
  require('luasnip').setup {}

  -- `friendly-snippets` contains a variety of premade snippets.
  --    See the README about individual language/framework/plugin snippets:
  --    https://github.com/rafamadriz/friendly-snippets
  --
  -- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
  -- require('luasnip.loaders.from_vscode').lazy_load()

  -- [[ Autocomplete Engine ]]
  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See `:help blink-cmp-config-keymap` for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See `:help blink-cmp-config-fuzzy` for more information
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  }
end

-- ============================================================
-- SECTION 9: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================
do
  -- [[ Configure Treesitter ]]
  --  Used to highlight, edit, and navigate code
  --
  --  See `:help nvim-treesitter-intro`

  -- NOTE: You can also specify a branch or a specific commit
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  -- Ensure basic parsers are installed
  local parsers = { 'bash', 'java', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
  'javascript', 'typescript', 'tsx', 'css', 'json', 'yaml', 'graphql' }
  require('nvim-treesitter').install(parsers)

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- Check if a parser exists and load it
    if not vim.treesitter.language.add(language) then return end
    -- Enable syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- Enable treesitter based folds
    -- For more info on folds see `:help folds`
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'

    -- Check if treesitter indentation is available for this language, and if so enable it
    -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    -- Enable treesitter based indentation
    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        -- Enable the parser if it is already installed
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- ============================================================
-- SECTION 10: OPTIONAL EXAMPLES / NEXT STEPS
-- kickstart.plugins.* examples
-- ============================================================
do
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug'
  -- require 'kickstart.plugins.indent_line'
  -- require 'kickstart.plugins.lint'
  -- require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree'
  -- require 'kickstart.plugins.gitsigns' -- adds gitsigns recommended keymaps

  -- NOTE: You can add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- require 'custom.plugins'
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
