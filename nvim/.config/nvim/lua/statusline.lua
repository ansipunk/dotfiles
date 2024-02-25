require("bufferline").setup({
  options = {
    numbers = "none",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = " "

      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
        or (e == "warning" and " " or " " )
        local part = sym .. n
        s = s == " " and part or s .. " " .. part
      end

      return s
    end,
    color_icons = false,
    show_close_icon = false,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    always_show_bufferline = true,
    sort_by = "id",
  },
})

require("lualine").setup({
  options = {
    theme = "powerline",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = { lualine_x = {} },
})
