set-face global ModelineChip LineNumberCursor
set-face global ModelineFill LineNumbers

set-face global ModelinePos  ModelineChip
set-face global ModelineBuff ModelineChip
set-face global ModelineMode ModelineChip

set-face global ModelinePosToFill  ModelineFill
set-face global ModelineBuffToFill ModelineFill
set-face global ModelineModeToFill ModelineFill

declare-option -hidden -docstring 'The current buffer name' str statusline_buffer
declare-option -hidden -docstring 'The current buffer readonly status' str statusline_readonly

define-command -hidden statusline-update-buffer %{ set-option buffer statusline_buffer %sh{
    printf "%s\n" "${kak_bufname}" | perl -pe 's:(?(?<=/)|(?<=^))([^\p{Letter}\p{Digit}]+.|[^/]).+?/:\1/:g'
} }

define-command -hidden statusline-update-readonly %{ set-option buffer statusline_readonly %sh{
    if [ ! "${kak_opt_readonly}" = "true" ]; then
        if [ -w "${kak_buffile}" ] || [ -z "${kak_buffile##*\**}" ]; then
               printf "%s\n" ''
               exit
        fi
    fi
    printf "%s\n" ' '
} }

hook -group statusline global WinDisplay   .*          %{ statusline-update-buffer; statusline-update-readonly }
hook -group statusline global BufWritePost .*          %{ statusline-update-buffer; statusline-update-readonly }
hook -group statusline global BufSetOption readonly=.+ %{ statusline-update-buffer; statusline-update-readonly }

hook global WinCreate .* %{
    set-option      buffer modelinefmt "{ModelineModeToFill}" 
    set-option -add buffer modelinefmt " {ModelineBuff}%opt{statusline_readonly}%opt{statusline_buffer}{ModelineBuffToFill}"
    set-option -add buffer modelinefmt " {ModelinePos} %{ %val{cursor_line}, %val{cursor_char_column}} {ModelinePosToFill}"
    set-option -add buffer modelinefmt " {ModelineFill}"
}

