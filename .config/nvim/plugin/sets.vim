" Appearance
  colorscheme onedark
  set termguicolors
  highlight Normal guibg=none
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
  set encoding=utf-8

" Enable autocompletion:
	set wildmode=longest,list,full
