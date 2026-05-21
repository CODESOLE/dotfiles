map global insert ş '<esc>'
hook global RegisterModified '"' %{
    nop %sh{
        printf "%s" "$kak_main_reg_dquote" | wl-copy > /dev/null 2>&1 &
    }
}
eval %sh{/home/void/.cargo/bin/kak-lsp --kakoune -s $kak_session}
lsp-enable
lsp-inlay-hints-enable global
lsp-inlay-diagnostics-enable global
lsp-auto-signature-help-enable
set-option global modelinefmt "%opt{lsp_modeline} %opt{modelinefmt}"

map global user l ':enter-user-mode lsp<ret>' -docstring 'LSP mode'

map global goto d <esc>:lsp-definition<ret> -docstring 'LSP definition'
map global goto r <esc>:lsp-references<ret> -docstring 'LSP references'
map global goto y <esc>:lsp-type-definition<ret> -docstring 'LSP type definition'

map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'

map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object f '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object t '<a-semicolon>lsp-object Class Interface Module Namespace Struct<ret>' -docstring 'LSP class or module'
map global object d '<a-semicolon>lsp-diagnostic-object error warning<ret>' -docstring 'LSP errors and warnings'
map global object D '<a-semicolon>lsp-diagnostic-object error<ret>' -docstring 'LSP errors'

hook global WinSetOption filetype=<language> %{
  hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
  hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
  hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
  hook -once -always window WinSetOption filetype=.* %{
    remove-hooks window semantic-tokens
  }
}
