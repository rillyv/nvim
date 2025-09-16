return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",

		dependencies = { "rafamadriz/friendly-snippets" },

		config = function()
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node

			ls.add_snippets("php", {
				s("pubf", {
					t("public function "),
					i(1, "name"),
					t("("),
					i(2),
					t(")"),
					t({ "", "{", "\t" }),
					i(0),
					t({ "", "}" }),
				}),
				s("prif", {
					t("private function "),
					i(1, "name"),
					t("("),
					i(2),
					t(")"),
					t({ "", "{", "\t" }),
					i(0),
					t({ "", "}" }),
				}),
				s("prof", {
					t("protected function "),
					i(1, "name"),
					t("("),
					i(2),
					t(")"),
					t({ "", "{", "\t" }),
					i(0),
					t({ "", "}" }),
				}),
				s("pub", {
					t("public $"),
					i(1, "property"),
					t(";"),
					i(0),
				}),
				s("pri", {
					t("private $"),
					i(1, "property"),
					t(";"),
					i(0),
				}),
				s("pro", {
					t("protected $"),
					i(1, "property"),
					t(";"),
					i(0),
				}),
			})

			vim.keymap.set({ "i" }, "<C-l>", function()
				ls.expand()
			end, { silent = true })
		end,
	},
}
