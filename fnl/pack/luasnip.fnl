(local {: config} (require :luasnip))
(local {: load} (require :luasnip/loaders/from_snipmate))

(config.set_config {:history true :updateevents "TextChanged,TextChangedI"})

;; Load snippets
(load)
