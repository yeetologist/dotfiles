let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
  Plug 'mcchrish/nnn.vim' " n³ as a file picker in vim/neovim
  Plug 'vimwiki/vimwiki' " VimWiki is a personal wiki for Vim
  Plug 'itchyny/lightline.vim' " A light and configurable statusline/tabline plugin for Vim
  Plug 'tpope/vim-commentary' " Comment stuff out using 'gc,gcc,gcap(for paragraph)'
  Plug 'ap/vim-css-color' " Preview colours in source code while editing
  Plug 'joshdick/onedark.vim' " A dark Vim/Neovim color scheme
call plug#end()

" Appearance
  colorscheme onedark
  set termguicolors
  " set bg=light
  silent! set splitbelow nostartofline linespace=0 whichwrap=b,s scrolloff=8 sidescroll=0 splitright noshowmode noshowcmd
  silent! set cursorline nocursorcolumn colorcolumn= concealcursor=nvc conceallevel=0 number norelativenumber

" Editing
	syntax on
 	filetype plugin on
  silent! set iminsert=0 imsearch=0 nopaste pastetoggle= nogdefault comments& commentstring=#\ %s
  silent! set smartindent autoindent shiftround shiftwidth=2 expandtab tabstop=2 smarttab softtabstop=2
  silent! set foldclose=all foldcolumn=0 nofoldenable foldlevel=0 foldmarker& foldmethod=indent
  silent! set textwidth=0 backspace=indent,eol,start nrformats=hex formatoptions=cmMj nojoinspaces
  silent! set nohidden autoread noautowrite noautowriteall nolinebreak mouse= modeline& modelines&
  silent! set noautochdir write nowriteany writedelay=0 verbose=0 verbosefile= notildeop noinsertmode
  silent! set tags=tags,./tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags tagstack

" Search
  silent! set wrapscan ignorecase smartcase incsearch hlsearch magic

" Insert completion
  silent! set complete& completeopt=menu,noinsert,noselect infercase pumheight=10 noshowfulltag shortmess+=c

" Command line
  silent! set wildchar=9 nowildmenu wildmode=list:longest wildoptions= wildignorecase cedit=<C-k>
  silent! set wildignore=*.~,*.?~,*.o,*.sw?,*.bak,*.hi,*.pyc,*.out,*.lock suffixes=*.pdf

" Performance
  silent! set updatetime=300 timeout timeoutlen=500 ttimeout ttimeoutlen=50 ttyfast lazyredraw

" Clipboard
  silent! set clipboard=unnamed,unnamedplus

" Bell
  silent! set noerrorbells visualbell t_vb=

" Data files
  silent! set history=5000
  silent! set noswapfile nobackup nowb

" Some basics:
	nnoremap c "_c
	set encoding=utf-8

" Enable autocompletion:
	set wildmode=longest,list,full

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" nnn.vim
	map <leader>n :NnnPicker %:p:h<CR>
    let g:nnn#layout = { 'window': { 'width': 0.3, 'height': 0.6, 'highlight': 'Comment' } }
    let g:nnn#action = {
         \ '<c-t>': 'tab split',
         \ '<c-x>': 'split',
         \ '<c-v>': 'vsplit'}

" lightline.vim
     let g:lightline = {
       \ 'colorscheme': 'onedark',
       \ 'component': {
       \   'filename': '%F',}
       \ }

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Replace ex mode with gq
	map Q gq

" Open empty buffer in split
	map <leader>s :vsp<space>$BIB<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" :norm for noobs
	vnoremap <leader>m :norm<space>

" Get rid of hlsearch
	nmap <leader><space> :nohlsearch<CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Function for toggling the bottom statusbar:
let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>
