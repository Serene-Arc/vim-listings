" list.vim - Listings

" if exists("g:loaded_listings") || &cp || v:version < 800
" 	finish
" endif
" let g:loaded_listings = 1



nnoremap <leader>nl :call NumberLine('.')<cr>
vnoremap <leader>nl :call NumberLine(visualmode())<cr>

function! NumberLine(type)
	let l:lineno = line('.')
	if a:type ==# 'V' || a:type ==# '.'
		let l:i = FindPrevNum(l:lineno)
		call setline(l:lineno, substitute(getline(l:lineno), '\v(\_^[\t\s\ \[\]_xX%]*)', '\1'.l:i.'. ', ""))
	else
		return 
	endif

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
