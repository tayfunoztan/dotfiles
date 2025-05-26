return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buffer)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "<leader>ghp", gitsigns.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function()
          gitsigns.blame()
        end, "Blame Buffer")
        map("n", "<leader>ghB", function()
          gitsigns.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>ghd", gitsigns.diffthis, "Diff This")
        map("n", "<leader>ghD", function()
          gitsigns.diffthis("~")
        end, "Diff This ~")
      end,
    },
  },
}
