" Vim filetype plugin
" Language:     Algodoo
" Maintainer:   @tatt61880
" Last Modified:2018/01/09 00:36:02.
"
" == Usage ==
" Put this file into "ftplugin" folder.

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

setlocal autoindent
setlocal noexpandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
