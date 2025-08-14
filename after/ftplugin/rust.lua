require "lspconfig".rust_analyzer.setup = {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
       allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        enable = true,
        locationLinks = false
      },
    },
  },
}
