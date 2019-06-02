;; helm 系の設定は他の部分への影響も大きそうなので先に持って来た
(el-get-bundle helm)
(el-get-bundle helm-descbinds)
(el-get-bundle helm-ag)
(require 'helm-config)
(helm-descbinds-mode)
