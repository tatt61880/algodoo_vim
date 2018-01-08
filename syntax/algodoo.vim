" Vim syntax file
" Language:     Algodoo
" Maintainer:   @tatt61880
" Last Modified:2018/01/09 01:19:17.
"
" == Usage ==
" Put this file into "syntax" folder.

if exists("b:current_syntax")
    finish
endif

syntax case match

" *Comment {{{1
syn region	AlgodooBlockComment contains=AlgodooLineComment,AlgodooString,AlgodooCharacter
			\ start='/\*'
			\ end='\*/'
			\ fold
syn match	AlgodooLineComment :\v//.*:
" }}}1

" *Constant {{{1
syn region	AlgodooString
			\ start=/"/
			\ end=/"\|$/
			\ skip=/\v%(\\)@1<!%(\\\\)*\\"/
syn region	AlgodooString
			\ start=/@"/
			\ end=/"/
			\ skip=/\v%(\")@1<!%(\"\")+/
syn match	AlgodooCharacter	/'[^\']'/
syn keyword	AlgodooBoolean	true false
" }}}1

" Number {{{2
syn match	AlgodooNumber	/\v<0x\d+>/
syn match	AlgodooNumber	/\v<\d+>/
syn match	AlgodooNumber	/\v<\d+\.\d+%(e[\+\-]\d+)?>/
" }}}2

" def link {{{1
" *Comment
hi def link AlgodooBlockComment	Comment
hi def link AlgodooLineComment	Comment
hi def link AlgodooString		String
hi def link AlgodooCharacter	Character
hi def link AlgodooNumber		Number
hi def link AlgodooBoolean		Boolean
" }}}1

let b:current_syntax = "Algodoo"
syn sync fromstart

" vim:ts=4:sts=4:sw=4:noexpandtab:ft=vim
