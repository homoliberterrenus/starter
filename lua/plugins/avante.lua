return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  build = "make",
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = "ollama",
    providers = {
      ollama = {
        endpoint = "http://localhost:11434",
        model = "qwen2.5-coder:7b",
        timeout = 30000, -- Timeout in milliseconds
        disable_tools = true,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
          stream = true,
        },
      },
    },
    behaviour = {
      -- Force Avante to wait for your confirmation (co/ct) instead of applying directly
      auto_apply_diff_after_generation = false,

      -- Automatically set up highlighting and conflict keymaps
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      support_paste_from_clipboard = false,
      minimize_diff = true, -- Shows compact diffs rather than whole file replacements
    },

    -- Ensure native diff integration is enabled
    diff = {
      autojump = true,
      list_opener = "copen",
      override_timeoutlen = 500,
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    { "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
