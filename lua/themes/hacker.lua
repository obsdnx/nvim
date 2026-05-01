-- Hacker colorscheme: strict black (#000000) + green (#00FF00) palette.
-- Non-green colors are used ONLY for error/warning diagnostics.
local M = {}

M.setup = function()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.background = "dark"
  vim.g.colors_name = "hacker"

  local hl = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- ── Palette ────────────────────────────────────────────────────────────────
  -- Blacks
  local black      = "#000000"
  local black_soft = "#0D0D0D"
  local black_mid  = "#111111"
  local black_hi   = "#1A1A1A"
  local black_sel  = "#0A1A00"   -- very dark green tint for selections

  -- Greens (dark → bright)
  local g0  = "#001100"          -- near-black green (barely visible)
  local g1  = "#003300"          -- dark green  (dim decorations)
  local g2  = "#005500"          -- mid-dark    (line numbers, comments)
  local g3  = "#007700"          -- mid         (operators, delimiters)
  local g4  = "#00AA00"          -- green       (fields, properties)
  local g5  = "#00CC00"          -- bright-ish  (calls, strings)
  local g6  = "#00FF00"          -- BRIGHT      (primary text, keywords)
  local g7  = "#33FF33"          -- pale bright (constants, parameters)
  local g8  = "#66FF66"          -- very pale   (secondary highlights)

  -- Lime (yellow-green) — replaces yellow, stays in green family
  local lime  = "#88FF00"        -- types, storage class
  local lime2 = "#AAFF00"        -- stronger lime for type keywords

  -- Mint (blue-green) — replaces cyan, stays in green family
  local mint  = "#00FF88"        -- preprocessor, includes, macros
  local mint2 = "#00FFAA"        -- namespaces, special strings

  -- Error / warning — red kept ONLY for diagnostics so errors are unmissable
  local err_bg  = "#1A0000"
  local err_mid = "#880000"
  local err_br  = "#FF2200"
  local warn_fg = "#AAAA00"      -- amber, minimal non-green usage
  local warn_bg = "#111100"

  -- ── Editor chrome ──────────────────────────────────────────────────────────
  hl("Normal",         { fg = g6,    bg = black })
  hl("NormalNC",       { fg = g4,    bg = black })
  hl("NormalFloat",    { fg = g6,    bg = black_mid })
  hl("FloatBorder",    { fg = g3,    bg = black_mid })
  hl("Cursor",         { fg = black, bg = g6 })
  hl("CursorLine",     { bg = black_sel })
  hl("CursorColumn",   { bg = black_sel })
  hl("CursorLineNr",   { fg = g6,    bg = black, bold = true })
  hl("LineNr",         { fg = g2,    bg = black })
  hl("SignColumn",     { fg = g2,    bg = black })
  hl("ColorColumn",    { bg = black_mid })

  -- ── Syntax ─────────────────────────────────────────────────────────────────
  hl("Comment",        { fg = g2,    italic = true })
  hl("Constant",       { fg = g7 })
  hl("String",         { fg = g5 })
  hl("Character",      { fg = g5 })
  hl("Number",         { fg = g7 })
  hl("Boolean",        { fg = g7,    bold = true })
  hl("Float",          { fg = g7 })
  hl("Identifier",     { fg = g6 })
  hl("Function",       { fg = g6,    bold = true })
  hl("Statement",      { fg = g6,    bold = true })
  hl("Keyword",        { fg = g6,    bold = true })
  hl("Conditional",    { fg = g6,    bold = true })
  hl("Repeat",         { fg = g6,    bold = true })
  hl("Label",          { fg = lime })
  hl("Operator",       { fg = g3 })
  hl("Exception",      { fg = err_br, bold = true })
  hl("PreProc",        { fg = mint })
  hl("Include",        { fg = mint })
  hl("Define",         { fg = mint })
  hl("Macro",          { fg = mint })
  hl("Type",           { fg = lime2, bold = true })
  hl("StorageClass",   { fg = lime })
  hl("Structure",      { fg = lime })
  hl("Typedef",        { fg = lime })
  hl("Special",        { fg = g7 })
  hl("SpecialChar",    { fg = mint2 })
  hl("Delimiter",      { fg = g3 })
  hl("SpecialComment", { fg = g3,    italic = true })
  hl("Underlined",     { fg = g6,    underline = true })
  hl("Error",          { fg = err_br, bold = true })
  hl("Todo",           { fg = black, bg = g6, bold = true })

  -- ── UI elements ────────────────────────────────────────────────────────────
  hl("Visual",         { bg = black_sel })
  hl("VisualNOS",      { bg = black_sel })
  hl("Search",         { fg = black, bg = g6 })
  hl("IncSearch",      { fg = black, bg = g7 })
  hl("CurSearch",      { fg = black, bg = g6 })
  hl("MatchParen",     { fg = g6,    bg = g1,  bold = true })
  hl("Pmenu",          { fg = g6,    bg = black_mid })
  hl("PmenuSel",       { fg = black, bg = g4 })
  hl("PmenuSbar",      { bg = black_hi })
  hl("PmenuThumb",     { bg = g2 })
  hl("WildMenu",       { fg = black, bg = g6 })
  hl("StatusLine",     { fg = g6,    bg = black_hi,  bold = true })
  hl("StatusLineNC",   { fg = g2,    bg = black_mid })
  hl("TabLine",        { fg = g2,    bg = black_mid })
  hl("TabLineSel",     { fg = g6,    bg = black, bold = true })
  hl("TabLineFill",    { bg = black })
  hl("VertSplit",      { fg = g2,    bg = black })
  hl("WinSeparator",   { fg = g2,    bg = black })
  hl("Folded",         { fg = g2,    bg = black_mid })
  hl("FoldColumn",     { fg = g2,    bg = black })
  hl("NonText",        { fg = g0 })
  hl("SpecialKey",     { fg = g0 })
  hl("Whitespace",     { fg = g0 })
  hl("EndOfBuffer",    { fg = g0 })
  hl("Directory",      { fg = g6,    bold = true })
  hl("Title",          { fg = g6,    bold = true })
  hl("Question",       { fg = g6 })
  hl("MoreMsg",        { fg = g4 })
  hl("ModeMsg",        { fg = g6,    bold = true })
  hl("WarningMsg",     { fg = warn_fg })
  hl("ErrorMsg",       { fg = err_br })

  -- ── Diff ───────────────────────────────────────────────────────────────────
  hl("DiffAdd",        { fg = g6,    bg = g1 })
  hl("DiffChange",     { fg = lime,  bg = black_sel })
  hl("DiffDelete",     { fg = err_mid, bg = err_bg })
  hl("DiffText",       { fg = black, bg = lime })

  -- ── Diagnostics ────────────────────────────────────────────────────────────
  hl("DiagnosticError",            { fg = err_br })
  hl("DiagnosticWarn",             { fg = warn_fg })
  hl("DiagnosticInfo",             { fg = mint })
  hl("DiagnosticHint",             { fg = g4 })
  hl("DiagnosticUnderlineError",   { undercurl = true, sp = err_br })
  hl("DiagnosticUnderlineWarn",    { undercurl = true, sp = warn_fg })
  hl("DiagnosticUnderlineInfo",    { undercurl = true, sp = mint })
  hl("DiagnosticUnderlineHint",    { undercurl = true, sp = g4 })
  hl("DiagnosticVirtualTextError", { fg = err_br,  bg = err_bg })
  hl("DiagnosticVirtualTextWarn",  { fg = warn_fg, bg = warn_bg })
  hl("DiagnosticVirtualTextInfo",  { fg = mint,    bg = black_mid })
  hl("DiagnosticVirtualTextHint",  { fg = g4 })

  -- ── Treesitter tokens ──────────────────────────────────────────────────────
  hl("@comment",               { link = "Comment" })
  hl("@keyword",               { link = "Keyword" })
  hl("@keyword.function",      { fg = g6,    bold = true })
  hl("@keyword.operator",      { fg = g3 })
  hl("@keyword.return",        { fg = g6,    bold = true })
  hl("@function",              { link = "Function" })
  hl("@function.builtin",      { fg = mint,  bold = true })
  hl("@function.call",         { fg = g5 })
  hl("@method",                { fg = g5,    bold = true })
  hl("@method.call",           { fg = g5 })
  hl("@variable",              { fg = g6 })
  hl("@variable.builtin",      { fg = g7,    italic = true })
  hl("@parameter",             { fg = g7 })
  hl("@field",                 { fg = g4 })
  hl("@property",              { fg = g4 })
  hl("@string",                { link = "String" })
  hl("@string.escape",         { fg = mint2 })
  hl("@number",                { link = "Number" })
  hl("@float",                 { link = "Float" })
  hl("@boolean",               { link = "Boolean" })
  hl("@constant",              { link = "Constant" })
  hl("@constant.builtin",      { fg = g7,    bold = true })
  hl("@type",                  { link = "Type" })
  hl("@type.builtin",          { fg = lime2 })
  hl("@namespace",             { fg = mint })
  hl("@include",               { link = "Include" })
  hl("@preproc",               { link = "PreProc" })
  hl("@define",                { link = "Define" })
  hl("@operator",              { link = "Operator" })
  hl("@punctuation.delimiter", { fg = g3 })
  hl("@punctuation.bracket",   { fg = g3 })
  hl("@tag",                   { fg = g6 })
  hl("@tag.attribute",         { fg = g4 })
  hl("@tag.delimiter",         { fg = g2 })

  -- ── Gitsigns ───────────────────────────────────────────────────────────────
  hl("GitSignsAdd",    { fg = g6,     bg = black })
  hl("GitSignsChange", { fg = lime,   bg = black })
  hl("GitSignsDelete", { fg = err_mid, bg = black })

  -- ── NvimTree ───────────────────────────────────────────────────────────────
  hl("NvimTreeNormal",             { fg = g6,   bg = black })
  hl("NvimTreeFolderIcon",         { fg = g4 })
  hl("NvimTreeFolderName",         { fg = g6 })
  hl("NvimTreeOpenedFolderName",   { fg = g7,   bold = true })
  hl("NvimTreeRootFolder",         { fg = mint, bold = true })
  hl("NvimTreeGitDirty",           { fg = lime })
  hl("NvimTreeGitNew",             { fg = g6 })
  hl("NvimTreeGitDeleted",         { fg = err_mid })
  hl("NvimTreeSpecialFile",        { fg = mint })
  hl("NvimTreeIndentMarker",       { fg = g1 })

  -- ── Telescope ──────────────────────────────────────────────────────────────
  hl("TelescopeNormal",         { fg = g6,   bg = black })
  hl("TelescopeBorder",         { fg = g3,   bg = black })
  hl("TelescopePromptBorder",   { fg = g6,   bg = black })
  hl("TelescopeResultsBorder",  { fg = g2,   bg = black })
  hl("TelescopePreviewBorder",  { fg = g2,   bg = black })
  hl("TelescopeSelection",      { fg = black, bg = g4 })
  hl("TelescopeSelectionCaret", { fg = g6,   bg = g4 })
  hl("TelescopeMatching",       { fg = g7,   bold = true, underline = true })
  hl("TelescopePromptPrefix",   { fg = g6 })

  -- ── Which-key ──────────────────────────────────────────────────────────────
  hl("WhichKey",          { fg = g6,   bold = true })
  hl("WhichKeyGroup",     { fg = mint })
  hl("WhichKeyDesc",      { fg = g4 })
  hl("WhichKeySeparator", { fg = g2 })
  hl("WhichKeyFloat",     { bg = black_mid })
  hl("WhichKeyBorder",    { fg = g2 })

  -- ── BufferLine ─────────────────────────────────────────────────────────────
  hl("BufferLineBackground",        { fg = g2,   bg = black_mid })
  hl("BufferLineBufferSelected",    { fg = g6,   bg = black, bold = true })
  hl("BufferLineBufferVisible",     { fg = g4,   bg = black_soft })
  hl("BufferLineSeparator",         { fg = g1,   bg = black_mid })
  hl("BufferLineIndicatorSelected", { fg = g6,   bg = black })
  hl("BufferLineFill",              { bg = black })

  -- ── Indent guides ──────────────────────────────────────────────────────────
  hl("IblIndent", { fg = g1 })
  hl("IblScope",  { fg = g2 })

  -- ── Alpha dashboard ────────────────────────────────────────────────────────
  hl("AlphaHeader",  { fg = g6, bold = true })
  hl("AlphaButtons", { fg = g4 })
  hl("AlphaFooter",  { fg = g2, italic = true })
end

return M
