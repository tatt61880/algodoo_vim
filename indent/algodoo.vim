" Vim indent file
" Language:     Algodoo
" Maintainer:   @tatt61880
" Last Modified:2018/02/13 20:53:43.
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

function! s:SubIndent(plnum, pline, lnum, line, opn, cls)
	let plen = strlen(a:pline)
	let res = 0
	for i in range(0, plen - 1)
		if a:pline[i] == a:opn
			let synName = synIDattr(synID(a:plnum, i + 1, 1), 'name')
			if synName == "AlgodooLineComment"
				break
			elseif synName == "AlgodooBlockComment"
			elseif synName == "AlgodooString"
			else
				let res += 1
			endif
		endif
		if res != 0
			if a:pline[i] == a:cls
				let synName = synIDattr(synID(a:plnum, i + 1, 1), 'name')
				if synName == "AlgodooLineComment"
					break
				elseif synName == "AlgodooBlockComment"
				elseif synName == "AlgodooString"
				else
					let res -= 1
				endif
			endif
		endif
	endfor

	let len = strlen(a:line)
	let temp = 0
	for i in range(0, len - 1)
		if a:line[i] == a:opn
			let synName = synIDattr(synID(a:lnum, i + 1, 1), 'name')
			if synName == "AlgodooLineComment"
				break
			elseif synName == "AlgodooBlockComment"
			elseif synName == "AlgodooString"
			else
				let temp += 1
			endif
		endif
		if a:line[i] == a:cls
			let synName = synIDattr(synID(a:lnum, i + 1, 1), 'name')
			if synName == "AlgodooLineComment"
				break
			elseif synName == "AlgodooBlockComment"
			elseif synName == "AlgodooString"
			else
				if temp == 0
					let res -= 1
				else
					let temp -= 1
				endif
			endif
		endif
	endfor

	return res
endfunction

function! GetAlgodooIndent()
	let plnum = prevnonblank(v:lnum - 1)
	if plnum == 0
		return 0
	endif
	let ind = indent(plnum)

	let pline = getline(plnum)
	let line = getline(v:lnum)
	let ind += &l:shiftwidth * s:SubIndent(plnum, pline, v:lnum, line, '{', '}')
	let ind += &l:shiftwidth * s:SubIndent(plnum, pline, v:lnum, line, '[', ']')
	let ind += &l:shiftwidth * s:SubIndent(plnum, pline, v:lnum, line, '(', ')')

	return ind
endfunction

let b:did_indent = 1

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
