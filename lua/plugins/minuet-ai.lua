return {
  {
    "milanglacier/minuet-ai.nvim",
    lazy = false,
    config = function()
      require("minuet").setup({
        provider = "openai_compatible",
        request_timeout = 8,
        notify = "debug",
        debug = true,

        provider_options = {
          openai_compatible = {
            api_key = "OPENROUTER_API_KEY",
            name = "OpenRouter",
            end_point = "https://openrouter.ai/api/v1/chat/completions",

            model = "openrouter/free",
            stream = false,

            headers = {
              ["HTTP-Referer"] = "https://github.com/milanglacier/minuet-ai.nvim",
              ["X-Title"] = "Minuet Neovim",
            },

            optional = {
              -- 512 tokens ensures completion fits alongside reasoning overhead
              max_tokens = 512,
              temperature = 0.2,

              -- Disable reasoning token allocation for OpenAI-compatible APIs
              reasoning_effort = "none",
            },

            system = {
              prompt = "You are an expert code autocomplete engine. Complete the user snippet directly. Do not include markdown code blocks, introductory text, or explanations. Respond with ONLY the missing code required to finish the logic.",
            },
          },
        },
      })
    end,
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}

      if not vim.tbl_contains(opts.sources.default, "minuet") then
        table.insert(opts.sources.default, 1, "minuet")
      end

      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.minuet = {
        name = "minuet",
        module = "minuet.blink",
        score_offset = 100,
        async = true,
        timeout_ms = 6000,
      }
    end,
  },
}
