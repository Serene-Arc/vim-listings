" list.vim - Listings

if exists("g:loaded_listings") || &cp || v:version < 800
	finish
endif
let g:loaded_listings = 1


" Stuff for creating numbered lists {{{{
nnoremap <silent> <leader>nl :call NumberLine(-1)<cr>
vnoremap <silent> <leader>nl :call NumberLine(-1)<cr>
nnoremap <silent> <leader>nnl :call NumberLine(1)<cr>
vnoremap <silent> <leader>nnl :call NumberLine(1)<cr>

function! NumberLine(first) range
	let l:first = a:first
	for l:lineno in range(a:firstline, a:lastline)
		if getline(l:lineno) !~ '\v(\_^[\t\s\ \[\]_xX%]*\d+\..*)'
			if l:first > 0
				let l:i = l:first
				let l:first = -1 
			else
				silent let l:i = FindPrevNum(l:lineno)
			endif
			call setline(l:lineno, substitute(getline(l:lineno), '\v(\_^[\t\s\ \[\]_xX%]*)', '\1'.l:i.'. ', ""))
		endif
	endfor
endfunction

func! FindPrevNum(lineno)
	if a:lineno == 1
		let l:i = 1
	else
		let saved_unnamed_register = @"
		try
			" find the number on the line above, if there is one
			execute 'normal! mq/\%' . ( a:lineno - 1 ) . 'l\v\_^[\t\s\ \[\]_xX]*[\ %]*\zs(\d)*\ze\.' . "\<CR>yw`q"
		catch
			let @" = 0
		endtry
		if @" > 0
			let l:i = @" + 1
		else 
			let l:i = 1
		endif
		let @" = saved_unnamed_register
	endif
	return l:i
endfunction
" }}}}

" Stuff for generic markdown style lists {{{{

nnoremap <silent> <leader>gl :call DotpointLine()<CR>
vnoremap <silent> <leader>gl :call DotpointLine()<CR>

function! DotpointLine() range
	for l:lineno in range(a:firstline, a:lastline)
		if getline(l:lineno) !~ '\v(\_^[\t\s\[\]_xX%]*\-.*)'
			call setline(l:lineno, substitute(getline(l:lineno), '\v(\_^[\t\s\[\]_xX%]*)', '\1- ', ""))
		endif
	endfor
endfunction

" }}}}
