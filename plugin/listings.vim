" list.vim - Listings

if exists("g:loaded_listings") || &cp || v:version < 800
	finish
endif
let g:loaded_listings = 1



nnoremap <leader>nl :call NumberLine('.', -1)<cr>
vnoremap <leader>nl :call NumberLine(visualmode(),-1)<cr>
nnoremap <leader>nnl :call NumberLine('.', 1)<cr>
vnoremap <leader>nnl :call NumberLine(visualmode(),1)<cr>

function! NumberLine(type, first) range
	let l:first = a:first
	for l:lineno in range(a:firstline, a:lastline)
		if a:type ==# 'V' || a:type ==# '.'
			if getline(l:lineno) !~ '\v(\_^[\t\s\ \[\]_xX%]*\d+\..*)'
				if l:first > 0
					let l:i = l:first
					let l:first = -1 
				else
					let l:i = FindPrevNum(l:lineno)
				endif
				call setline(l:lineno, substitute(getline(l:lineno), '\v(\_^[\t\s\ \[\]_xX%]*)', '\1'.l:i.'. ', ""))
			endif
		else
			return 
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
