" list.vim - Listings

" if exists("g:loaded_listings") || &cp || v:version < 800
" 	finish
" endif
" let g:loaded_listings = 1



nnoremap <leader>nl :call NumberLine('.')<cr>
vnoremap <leader>nl :call NumberLine(visualmode())<cr>

function! NumberLine(type)

	if a:type ==# 'v'
		execute "normal! `<v`>y"
	elseif a:type ==# '.'
		let l:lineno = line('.')
		if l:lineno == 1
			let l:i = 1
		else
			let saved_unnamed_register = @"
			" find the number on the line above, if there is one
			execute 'normal! mq/\%' . ( l:lineno - 1 ) . 'l\v\_^[\t\s\ \[\]_xX]*[\ %]*\zs(\d)*\ze\.' . "\<CR>yw`q"
			if @" > 0
				let l:i = @" + 1
			else 
				let l:i = 1
			endif
			let @" = saved_unnamed_register
		endif
		call setline(l:lineno, substitute(getline(l:lineno), '\v(\_^[\t\s\ \[\]_xX%]*)', '\1'.l:i.'. ', ""))
	else
		return 
	endif

endfunction
