-------------------------------------
---         P L U G I N S         ---
-------------------------------------

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'SirVer/ultisnips' -- Snippets
Plug 'lervag/vimtex' -- Lots of LaTeX support
Plug 'tpope/vim-surround' -- Surround text objects with things (parens, quotes etc.)
Plug 'tpope/vim-repeat' -- Extend the . command to things like vim-surround
Plug 'romainl/vim-cool' -- No more lingering hl after search
Plug 'inkarkat/vim-ReplaceWithRegister' -- Replace motion with register without intermediate deletion
-- Plug 'gaoDean/autolist.nvim'          -- Make lists better (autocomplete list items, tab for sublists etc)
-- Add back when ultisnips tab conflict is fixed
-- Plug 'zegervdv/nrpattern.nvim' -- Extend <C-x> and <C-a> functionality to custom patterns etc

Plug 'vim-airline/vim-airline' -- Nice status bar at the bottom of the screen
Plug 'vim-airline/vim-airline-themes' -- Themes for vim-airline
-- Plug 'ludovicchabant/vim-gutentags'

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn[':TSUpdate'] })

-- Fuzzy finder for files
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.0' })

-- Visualise the vim undo tree
Plug 'mbbill/undotree'

-- Git stuff (TODO: learn)
Plug 'tpope/vim-fugitive'

-- Tab line
Plug 'nvim-tree/nvim-web-devicons' -- For coloured icons
Plug ('akinsho/bufferline.nvim', { [ 'tag' ] = 'v3.*' })

-- LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

-- Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

-- Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'

Plug 'sainnhe/everforest' -- Colorscheme
vim.call('plug#end')
