return {
  {
    "yetone/avante.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "ColinKennedy/mega.logging",
      "ColinKennedy/mega.cmdparse",
    },
    opts = {
      provider = "ollama",
      vendors = {
        ollama = {
          __inherited_from = "openai",
          api_base_url = "http://localhost:11434/v1",
          model = "qwen2.5-coder:7b",
        },
      },
    },
  },
}
