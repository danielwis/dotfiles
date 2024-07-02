-------------------------------------
---         P L U G I N S         ---
-------------------------------------

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'lervag/vimtex'                    -- Lots of LaTeX support
Plug 'tpope/vim-surround'               -- Surround text objects with things (parens, quotes etc.)
Plug 'tpope/vim-repeat'                 -- Extend the . command to things like vim-surround
Plug 'tpope/vim-sleuth'                 -- Automatically set tab width/spaces
Plug 'romainl/vim-cool'                 -- No more lingering hl after search
Plug 'inkarkat/vim-ReplaceWithRegister' -- Replace motion with register without intermediate deletion
Plug 'echasnovski/mini.ai'              -- Extend `i` and `a` text objects

Plug 'zegervdv/nrpattern.nvim'          -- Extend <C-x> and <C-a> functionality to custom patterns etc
Plug 'rcarriga/nvim-notify'             -- Notifications

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons' -- Icons

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn[':TSUpdate'] })
Plug 'nvim-treesitter/nvim-treesitter-textobjects' -- LSP-aware text objects

-- Fuzzy finder for files
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

-- Visualise the vim undo tree
Plug 'mbbill/undotree'

-- Comment/uncomment lines
Plug 'numToStr/Comment.nvim'

-- Tab-/bufferline
Plug('nvim-tree/nvim-web-devicons') -- For coloured icons
Plug 'akinsho/bufferline.nvim'

-- Indent prettifyer
Plug 'lukas-reineke/indent-blankline.nvim'

-- LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-jdtls' -- Temporary, for Java

-- LSP context hints in winbar
Plug 'SmiteshP/nvim-navic'

-- LSP navigation
Plug "SmiteshP/nvim-navbuddy"
Plug "MunifTanjim/nui.nvim" -- UI library dependency for the above

-- Allow external (non-LSP) programs to hook into LSP API
Plug 'jose-elias-alvarez/null-ls.nvim'

-- Autocompletion and its sources
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'f3fora/cmp-spell'

-- Live markdown viewing
Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app && yarn install' })

-- Git integration
Plug('lewis6991/gitsigns.nvim')

-- Snippets
Plug 'saadparwaiz1/cmp_luasnip' -- Link autocomplete to snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'sainnhe/everforest' -- Colorscheme
vim.call('plug#end')
