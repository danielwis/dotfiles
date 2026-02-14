require 'nvim-treesitter.configs'.setup {
  indent = { enable = true },

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- Don't run Vim's built-in syntax highlighting.
    additional_vim_regex_highlighting = false,
  },

  -- Almost verbatim copied from this link:
  -- https://ofirgall.github.io/learn-nvim/chapters/05-text-objects.html
  -- TODO: Enable/change stuff that I (want to) use
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]b"] = "@block.outer",
        ["]a"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]B"] = "@block.outer",
        ["]A"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[b"] = "@block.outer",
        ["[a"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[B"] = "@block.outer",
        ["[A"] = "@parameter.inner",
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["a/"] = "@comment.outer",
        ["i/"] = "@comment.outer",   -- no inner for comment
        ["aa"] = "@parameter.outer", -- parameter -> argument
        ["ia"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>sa'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>sA'] = '@parameter.inner',
      },
    }
  },
}
