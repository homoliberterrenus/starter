return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    opts = {
      provider = "openai_compatible",

      request_timeout = 4,
      auto_suggestion_debounce_delay = 0.4,
      auto_suggestion_throttle_delay = 0.8,

      n_completions = 1,

      provider_options = {
        openai_compatible = {
          api_key = function()
            return vim.env.SILICONFLOW_API_KEY or "sk-your-siliconflow-key"
          end,
          name = "SiliconFlow",
          end_point = "https://api.siliconflow.cn/v1/chat/completions",
          model = "Qwen/Qwen2.5-Coder-32B-Instruct",

          optional = {
            max_tokens = 256,
            temperature = 0.2,
          },
        },
      },
    },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        default = { "minuet", "lsp", "path", "snippets", "buffer" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
