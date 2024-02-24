require("nvim-treesitter.configs").setup({
  modules = { },
  ensure_installed = "all",
  ignore_install = { },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

local cmp = require("cmp")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  })
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  })
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

if vim.fn.executable("pylsp") == 1 then
  lspconfig.pylsp.setup({
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          ruff = { enabled = false },
          autopep8 = { enabled = false },
          flake8 = { enabled = false },
          mccabe = { enabled = false },
          pycodestyle = { enabled = false },
          pydocstyle = { enabled = false },
          pyflakes = { enabled = false },
          pylint = { enabled = false },
          yapf = { enabled = false },
        },
      },
    },
  })
end

if vim.fn.executable("ruff-lsp") == 1 then
  lspconfig.ruff_lsp.setup({
    capabilities = capabilities,
  })
end

if vim.fn.executable("gopls") == 1 then
  lspconfig.gopls.setup({
    capabilities = capabilities,
  })
end

if vim.fn.executable("deno") == 1 then
  lspconfig.denols.setup({
    capabilities = capabilities,
    single_file_support = false,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  })
end

if vim.fn.executable("tsserver") == 1 then
  lspconfig.tsserver.setup({
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("package.json"),
  })
end

if vim.fn.executable("ccls") == 1 then
  lspconfig.ccls.setup({
    capabilities = capabilities,
    init_options = { cache = {
        directory = ".ccls-cache";
    } },
  })
end

if vim.fn.executable("lua-language-server") == 1 then
  lspconfig.lua_ls.setup {
    capabilities = capabilities,
    settings = { Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = {"vim"} },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    }},
  }
end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
