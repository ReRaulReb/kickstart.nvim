-- terraclay.lua
-- A warm, earthy dark colorscheme built from a terracotta / olive / sage palette.
-- Drop this file at: ~/.config/nvim/colors/terraclay.lua
-- Then run: :colorscheme terraclay

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end
vim.o.termguicolors = true
vim.g.colors_name = 'terraclay'

-- ===== Palette (sampled from the reference image) =====
local p = {
  tan      = '#FFE8B8', -- warm sand
  terra    = '#FFAD7A', -- terracotta
  rust     = '#FF8C52', -- burnt rust
  wine     = '#FF8FA3', -- dark maroon
  charcoal = '#453D45', -- dark plum-charcoal
  ochre    = '#FFD98A', -- golden ochre
  bronze   = '#F0C670', -- olive bronze
  umber    = '#4A4239', -- dark warm brown-black

  olive    = '#9db85e', -- olive green
  mustard  = '#FFEB94', -- mustard yellow-green
  cream    = '#FFFDF5', -- pale khaki
  sage     = '#00c6c9', -- sage teal-green
  teal     = '#673ae0', -- true blue (types, blue terminal color)
  mauve    = '#A488A0', -- dark plum-mauve
  taupe    = '#C7B6A3', -- warm gray-brown
  dustrose = '#F0D6C5', -- dusty rose-taupe

  -- Derived UI tones (extrapolated to keep the same warm-dark family)
  bg        = '#171310',
  bg_dim    = '#0D0B09',
  bg_float  = '#1E1814',
  bg_hl     = '#2A2119',
  bg_visual = '#453D45',
  border    = '#4A4239',
  fg        = '#FFFDF5',
  fg_dim    = '#F0D6C5',
  red       = '#FF8C52',
  green     = '#D1D673',
  yellow    = '#FFD98A',
  blue      = '#673ae0',
  magenta   = '#FF8FA3',
  cyan      = '#00c6c9',
}

local hl = vim.api.nvim_set_hl

---@param groups table<string, table>
local function set(groups)
  for name, opts in pairs(groups) do
    hl(0, name, opts)
  end
end

-- ===== Editor UI =====
set {
  Normal        = { fg = p.fg, bg = p.bg },
  NormalFloat   = { fg = p.fg, bg = p.bg_float },
  NormalNC      = { fg = p.fg, bg = p.bg },
  FloatBorder   = { fg = p.border, bg = p.bg_float },
  FloatTitle    = { fg = p.ochre, bg = p.bg_float, bold = true },

  Cursor        = { fg = p.bg, bg = p.tan },
  CursorLine    = { bg = p.bg_hl },
  CursorLineNr  = { fg = p.tan, bold = true },
  LineNr        = { fg = p.taupe },
  SignColumn    = { bg = p.bg },
  ColorColumn   = { bg = p.bg_hl },

  Visual        = { bg = p.bg_visual },
  VisualNOS     = { bg = p.bg_visual },
  Search        = { fg = p.bg, bg = p.ochre },
  IncSearch     = { fg = p.bg, bg = p.terra },
  CurSearch     = { fg = p.bg, bg = p.terra },

  Pmenu         = { fg = p.fg, bg = p.bg_float },
  PmenuSel      = { fg = p.bg, bg = p.ochre },
  PmenuSbar     = { bg = p.bg_hl },
  PmenuThumb    = { bg = p.taupe },
  PmenuBorder   = { fg = p.border, bg = p.bg_float },

  StatusLine    = { fg = p.fg, bg = p.bg_dim },
  StatusLineNC  = { fg = p.taupe, bg = p.bg_dim },
  WinBar        = { fg = p.fg_dim, bg = p.bg },
  WinBarNC      = { fg = p.taupe, bg = p.bg },
  WinSeparator  = { fg = p.border, bg = p.bg },
  VertSplit     = { fg = p.border, bg = p.bg },
  TabLine       = { fg = p.taupe, bg = p.bg_dim },
  TabLineSel    = { fg = p.tan, bg = p.bg, bold = true },
  TabLineFill   = { bg = p.bg_dim },

  Folded        = { fg = p.fg_dim, bg = p.bg_hl, italic = true },
  FoldColumn    = { fg = p.taupe, bg = p.bg },

  MatchParen    = { fg = p.terra, bold = true, underline = true },
  NonText       = { fg = p.umber },
  Whitespace    = { fg = p.umber },
  SpecialKey    = { fg = p.umber },
  Directory     = { fg = p.sage, bold = true },
  Title         = { fg = p.ochre, bold = true },

  ModeMsg       = { fg = p.tan },
  MoreMsg       = { fg = p.sage },
  Question      = { fg = p.sage },
  WarningMsg    = { fg = p.ochre },
  ErrorMsg      = { fg = p.rust, bold = true },

  DiffAdd       = { fg = p.olive, bg = p.bg_hl },
  DiffChange    = { fg = p.ochre, bg = p.bg_hl },
  DiffDelete    = { fg = p.rust, bg = p.bg_hl },
  DiffText      = { fg = p.mustard, bg = p.bg_hl, bold = true },
}

-- ===== Syntax (classic groups) =====
set {
  Comment       = { fg = p.taupe, italic = true },

  Constant      = { fg = p.ochre },
  String        = { fg = p.mustard },
  Character     = { fg = p.mustard },
  Number        = { fg = p.olive },
  Boolean       = { fg = p.olive },
  Float         = { fg = p.olive },

  Identifier    = { fg = p.sage },
  Function      = { fg = p.terra, bold = true },

  Statement     = { fg = p.wine, bold = true },
  Conditional   = { fg = p.wine },
  Repeat        = { fg = p.wine },
  Label         = { fg = p.wine },
  Operator      = { fg = p.cream },
  Keyword       = { fg = p.wine, bold = true },
  Exception     = { fg = p.rust },

  PreProc       = { fg = p.teal },
  Include       = { fg = p.teal },
  Define        = { fg = p.teal },
  Macro         = { fg = p.teal },
  PreCondit     = { fg = p.teal },

  Type          = { fg = p.teal, bold = true },
  StorageClass  = { fg = p.bronze },
  Structure     = { fg = p.teal },
  Typedef       = { fg = p.teal },

  Special       = { fg = p.sage },
  SpecialChar   = { fg = p.sage },
  Tag           = { fg = p.terra },
  Delimiter     = { fg = p.dustrose },
  SpecialComment= { fg = p.taupe, italic = true },
  Debug         = { fg = p.rust },

  Underlined    = { underline = true },
  Ignore        = { fg = p.taupe },
  Error         = { fg = p.rust, bold = true },
  Todo          = { fg = p.bg, bg = p.ochre, bold = true },
}

-- ===== Treesitter (@-groups) =====
set {
  ['@variable']            = { fg = p.cream },
  ['@variable.builtin']    = { fg = p.rust, italic = true },
  ['@variable.parameter']  = { fg = p.dustrose },
  ['@variable.member']     = { fg = p.sage },

  ['@constant']             = { fg = p.ochre },
  ['@constant.builtin']     = { fg = p.ochre, bold = true },
  ['@string']               = { fg = p.mustard },
  ['@string.escape']        = { fg = p.terra, bold = true },
  ['@character']            = { fg = p.mustard },
  ['@number']               = { fg = p.olive },
  ['@boolean']              = { fg = p.ochre },

  ['@function']             = { fg = p.terra, bold = true },
  ['@function.builtin']     = { fg = p.terra },
  ['@function.call']        = { fg = p.terra },
  ['@method']                = { fg = p.terra, bold = true },
  ['@method.call']          = { fg = p.terra },
  ['@constructor']          = { fg = p.sage, bold = true },

  ['@keyword']              = { fg = p.wine, bold = true },
  ['@keyword.function']     = { fg = p.wine },
  ['@keyword.return']       = { fg = p.wine, italic = true },
  ['@keyword.operator']     = { fg = p.wine },
  ['@conditional']          = { fg = p.wine },
  ['@repeat']               = { fg = p.wine },

  ['@type']                  = { fg = p.teal, bold = true },
  ['@type.builtin']         = { fg = p.teal },
  ['@attribute']            = { fg = p.bronze },
  ['@namespace']            = { fg = p.teal },

  ['@punctuation.delimiter'] = { fg = p.dustrose },
  ['@punctuation.bracket']   = { fg = p.fg_dim },
  ['@punctuation.special']   = { fg = p.sage },

  ['@comment']               = { fg = p.taupe, italic = true },
  ['@tag']                   = { fg = p.terra },
  ['@tag.attribute']         = { fg = p.sage, italic = true },
  ['@tag.delimiter']         = { fg = p.dustrose },
}

-- ===== LSP / Diagnostics =====
set {
  DiagnosticError = { fg = p.rust },
  DiagnosticWarn  = { fg = p.ochre },
  DiagnosticInfo  = { fg = p.sage },
  DiagnosticHint  = { fg = p.teal },
  DiagnosticUnderlineError = { undercurl = true, sp = p.rust },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = p.ochre },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = p.sage },
  DiagnosticUnderlineHint  = { undercurl = true, sp = p.teal },

  LspReferenceText  = { bg = p.bg_visual },
  LspReferenceRead  = { bg = p.bg_visual },
  LspReferenceWrite = { bg = p.bg_visual, underline = true },
  LspInlayHint      = { fg = p.taupe, bg = p.bg_hl, italic = true },
}

-- ===== Git / gitsigns =====
set {
  GitSignsAdd    = { fg = p.olive },
  GitSignsChange = { fg = p.ochre },
  GitSignsDelete = { fg = p.rust },
}

-- ===== Telescope =====
set {
  TelescopeNormal        = { fg = p.fg, bg = p.bg_float },
  TelescopeBorder        = { fg = p.border, bg = p.bg_float },
  TelescopePromptNormal  = { fg = p.fg, bg = p.bg_hl },
  TelescopePromptBorder  = { fg = p.border, bg = p.bg_hl },
  TelescopeSelection     = { fg = p.tan, bg = p.bg_visual, bold = true },
  TelescopeMatching      = { fg = p.terra, bold = true },
  TelescopeTitle         = { fg = p.ochre, bold = true },
}

-- ===== which-key =====
set {
  WhichKey          = { fg = p.terra, bold = true },
  WhichKeyGroup     = { fg = p.sage },
  WhichKeyDesc      = { fg = p.cream },
  WhichKeySeparator = { fg = p.taupe },
  WhichKeyFloat     = { bg = p.bg_float },
}
