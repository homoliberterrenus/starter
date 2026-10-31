return {
  {
    "milanglacier/minuet-ai.nvim",
    lazy = false,
    config = function()
      require("minuet").setup({
        virtualtext = {
          auto_trigger_ft = {},
          keymap = {
            -- accept whole completion
            accept = "<A-A>",
            -- accept one line
            accept_line = "<A-a>",
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = "<A-z>",
            -- Cycle to prev completion item, or manually invoke completion
            prev = "<A-[>",
            -- Cycle to next completion item, or manually invoke completion
            next = "<A-]>",
            dismiss = "<A-e>",
          },
        },

        provider = "openai_fim_compatible",
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 512,

        request_timeout = 8,
        -- notify = "debug",
        -- debug = true,

        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM",
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:3b",
            stream = true,
            optional = {
              max_tokens = 256,
              top_p = 0.9,
              stop = { "\n\n", "<|file_sep|>" },
            },
          },

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

  -- {
  --   "saghen/blink.cmp",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.sources = opts.sources or {}
  --     opts.sources.default = opts.sources.default or {}
  --
  --     if not vim.tbl_contains(opts.sources.default, "minuet") then
  --       table.insert(opts.sources.default, 1, "minuet")
  --     end
  --
  --     opts.sources.providers = opts.sources.providers or {}
  --     opts.sources.providers.minuet = {
  --       name = "minuet",
  --       module = "minuet.blink",
  --       score_offset = 100,
  --       async = true,
  --       timeout_ms = 6000,
  --     }
  --   end,
  -- },
}
