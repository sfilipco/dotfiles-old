local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local util = require('lspconfig/util')

local diagnostic = require('diagnostic')
-- local completion = require('completion')

local set_keymap = function(key, mapping)
  vim.fn.nvim_set_keymap("n", key, mapping, {noremap = true, silent = true})
end

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client, bufnr)
  diagnostic.on_attach(client, bufnr)
  -- completion.on_attach(client, bufnr)

  -- Keybindings for LSPs
  -- Note these are in on_attach so that they don't override bindings in a non-LSP setting
  set_keymap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  set_keymap("gh", "<cmd>lua vim.lsp.buf.hover()<CR>")
  set_keymap("gD", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  set_keymap("<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  set_keymap("1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  set_keymap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  set_keymap("g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
  set_keymap("gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
end

-- buck specific

local root_pattern = util.root_pattern(".buckconfig")

local buck_root = function(fname)
  local filename = util.path.is_absolute(fname) and fname
    or util.path.join(vim.loop.cwd(), fname)
  return root_pattern(filename) or util.path.dirname(filename)
end;

configs.rustls = {
  default_config = {
    cmd = {'nuclide-rls.sh'};
    filetypes = {'rust'};
    root_dir = buck_root;
    settings = {};
    callbacks = {
      ['window/logMessage'] = function(err, method, params, client_id)
        return {}
      end;
      ['window/showMessage'] = function(err, method, params, client_id)
        return {}
      end;
      ['window/showFileStatus'] = function(err, method, params, client_id)
        return {}
      end;
      ['client/registerCapability'] = function(err, method, params, client_id)
        return {}
      end;
      ['workspace/configuration'] = function(err, method, params, client_id)
        return {}
      end;
    }
  }
}


lspconfig.rls.setup({
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
})
