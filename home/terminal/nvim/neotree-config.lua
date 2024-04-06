require("neo-tree").setup({
  sources = {
    "filesystem", "buffers", "git_status", "document_symbols" 
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
        require("neo-tree.command").execute({ action = "close" })
      end
    },
  },
  default_component_configs = {
    document_symbols = {
      follow_cursor = true
    },
  },
})

