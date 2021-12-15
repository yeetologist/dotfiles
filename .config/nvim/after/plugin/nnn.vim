" nnn.vim
	map <leader>n :NnnPicker %:p:h<CR>
    let g:nnn#layout = { 'window': { 'width': 0.3, 'height': 0.6, 'highlight': 'Comment' } }
    let g:nnn#action = {
         \ '<c-t>': 'tab split',
         \ '<c-x>': 'split',
         \ '<c-v>': 'vsplit'}
    let g:nnn#command = 'nnn -H'
