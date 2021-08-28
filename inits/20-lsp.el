(el-get-bundle lsp-mode)
(el-get-bundle lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(setq lsp-ui-doc-alignment 'window)
