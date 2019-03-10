" Runs a command asynchronously.
"
" Functions like the attribute -bar was given however | runs in a synchronous
" context.
command -nargs=1 AsyncRun call asyncrun#AsyncRunCommand(<q-args>, <q-mods>)

" TODO Add :Make command (asynchronous version of :make)

function! s:SlimeOperator(...) abort
	if !a:0
		let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$') " Set opfunc to this function
		return 'g@'
	else
		let type = a:1
	endif
	return ''
endfunction

function! TestSlime() abort
	call s:SlimeOperator()
endfunction

" Operator that sends the text into a thingy
" TODO Maybe rename?
" noremap <silent> <Plug>(asyncrun-slime) :<C-U>call asyncrun#SlimeOperator(visualmode(), 0)<CR>
noremap <expr> <Plug>AsyncRunSlime <SID>SlimeOperator()

nnoremap <Leader>f <Plug>AsyncRunSlime

" TODO Provide named key sequences to customize hotkeys
" (see https://whileimautomaton.net/2008/09/27022735)
nnoremap <Leader>s :set operatorfunc=asyncrun#SlimeOperator<CR>g@
vnoremap <Leader>s :<C-U>call asyncrun#SlimeOperator(visualmode(), 0)<CR>
nmap <Leader>ss <Leader>s_
