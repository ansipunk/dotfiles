-- Keybindings

local vimp = require("vimp")
local nnoremap = vimp.nnoremap
local inoremap = vimp.inoremap
local vnoremap = vimp.vnoremap

-- Leader key
vim.g.mapleader = "<Space>"
vimp.map("<Space>", "<Leader>")

-- Buffers
nnoremap("<Leader>bd", ":bw<CR>")                  -- Kill buffer
nnoremap("<Leader>br", ":e<CR>")                   -- Reload buffer
nnoremap("<Leader>bn", ":enew<CR>")                -- New buffer
nnoremap("<S-j>", ":bprevious<CR>")                -- Previous buffer
nnoremap("<S-k>", ":bnext<CR>")                    -- Next buffer
nnoremap("<S-x>", ":bw<CR>")                       -- Kill buffer

-- Windows
nnoremap("<Leader>w/", "<C-w>v")                   -- Vertical split
nnoremap("<Leader>w-", "<C-w>s")                   -- Horizontal split
nnoremap("<Leader>wd", "<C-w>q")                   -- Kill window
nnoremap("<Leader>1", ":1wincmd w<CR>")            -- Go to window 1
nnoremap("<Leader>2", ":2wincmd w<CR>")            -- Go to window 2
nnoremap("<Leader>3", ":3wincmd w<CR>")            -- Go to window 3
nnoremap("<Leader>4", ":4wincmd w<CR>")            -- Go to window 4
nnoremap("<Leader>5", ":5wincmd w<CR>")            -- Go to window 5
nnoremap("<Leader>6", ":6wincmd w<CR>")            -- Go to window 6
nnoremap("<Leader>7", ":7wincmd w<CR>")            -- Go to window 7
nnoremap("<Leader>8", ":8wincmd w<CR>")            -- Go to window 8
nnoremap("<Leader>9", ":9wincmd w<CR>")            -- Go to window 9

-- Completion
nnoremap("<Leader>h",  ":lua vim.lsp.buf.hover()<CR>")
nnoremap("<Leader>dn", ":lua vim.diagnostic.goto_next()<CR>")
nnoremap("<Leader>dp", ":lua vim.diagnostic.goto_prev()<CR>")
nnoremap("<Leader>jD", ":lua vim.lsp.buf.declaration()<CR>")
nnoremap("<Leader>jd", ":lua vim.lsp.buf.definition()<CR>")
nnoremap("<Leader>ji", ":lua vim.lsp.buf.implementation()<CR>")
nnoremap("<Leader>jr", ":lua vim.lsp.buf.references()<CR>")
nnoremap("<Leader>jt", ":lua vim.lsp.buf.type_definition()<CR>")
nnoremap("<Leader>rn", ":lua vim.lsp.buf.rename()<CR>")
nnoremap("<Leader>ca", ":lua vim.lsp.buf.code_action()<CR>")

-- Tabs
nnoremap("<Leader>td", ":tabclose<CR>")            -- Kill tab
nnoremap("<Leader>tj", ":tabn<CR>")                -- Go to the next tab
nnoremap("<Leader>tk", ":tabp<CR>")                -- Go to the previous tab

-- Text navigation
nnoremap("E", "$")                                 -- Go to end of the line
nnoremap("W", "$b")                                -- Go to the last word
vnoremap(">", ">gv")
vnoremap("<", "<gv")
inoremap("<C-a>", "<Home>")
inoremap("<C-e>", "<End>")

-- Code folding
nnoremap("<Leader>a", "za")                        -- Fold code

-- File tree
nnoremap("<Leader>ft", ":NvimTreeRefresh<CR>:NvimTreeToggle<CR>")
