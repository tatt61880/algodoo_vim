" Vim indent file
" Language:     Algodoo
" Maintainer:   @tatt61880
" Last Modified:2018/02/11 03:14:46.
"
" Special Thanks:
"   http://labs.timedia.co.jp/2011/04/9-points-to-customize-automatic-indentation-in-vim.html
"
" == Usage ==
" Put this file into "indent" folder.

if exists('b:did_indent')
	finish
endif

setlocal indentexpr=GetAlgodooIndent()
setlocal indentkeys+=!^F,o,O,0=end,0=elif,0=else,0=case,0=default,0=catch,0=finally

function! s:matchcount(lnum, expr, pat, ...)
	let start = get(a:, "1", 0)
	let result = match(a:expr, a:pat, start)
	if result == -1
		return 0
	endif
    if synIDattr(synID(a:lnum, result, 1), 'name') == "AlgodooLineComment"
		return 0
	elseif synIDattr(synID(a:lnum, result, 1), 'name') == "AlgodooBlockComment"
		return s:matchcount(a:lnum, a:expr, a:pat, result+1)
	else
		return s:matchcount(a:lnum, a:expr, a:pat, result+1) + 1
	endif
endfunction

function! GetAlgodooIndent()
	let plnum = prevnonblank(v:lnum - 1)
	if plnum == 0
		return 0
	endif
	let ind = indent(plnum)

	let pline = getline(plnum)
	let ind += &l:shiftwidth * s:matchcount(plnum, pline, "{")
	let line = getline(v:lnum)
	let ind -= &l:shiftwidth * s:matchcount(v:lnum, line, "}")

	return ind
endfunction

let b:did_indent = 1

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
