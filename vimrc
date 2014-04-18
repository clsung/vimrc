execute pathogen#infect()

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc,*~

if has("win32")
    let g:OS = "windows"
elseif has("unix")
    if match(system("uname"),'Darwin') != -1
	let g:OS = "mac"
    else
	let g:OS = "unix"
    endif
endif
set nocompatible

set history=500
source $VIMRUNTIME/vimrc_example.vim

" Turn off sounds
set noerrorbells
set novisualbell
set t_vb=

set lz                      " LazyRedraw

set wildmenu
set ruler                   " show cursor position
set showcmd                 " show partial commands as you type
set cmdheight=1             " :cmd area size
set shortmess=aoOTI         " short messages
set showbreak="+"           " show lines that have been broken
set showmatch               " show matching braces
set nrformats+=alpha        " Increment for alpha'd lists.
set term=xterm-256color
hi MatchParen ctermbg=yellow

set shiftround
set writeany autoread autowrite
" Tabkey: {{{
set tabstop=4               " so tabs look right for us 
set noexpandtab
set softtabstop=4
set backspace=2
set shiftwidth=4            " so ^T and << are smaller 
set report=1                " so we our told whenever we affect more than 1 line 
set autoindent              " so i don't have to tab in 
set smartindent
set cindent
set wrap
" }}}

" Encoding: {{{
set fileencodings=utf-8,big5-hkscs,big5,euc-jp,gb2312,cp936,iso8859-1
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8
set ambiwidth=double
" }}}

" Folding: {{{
    set foldenable
    set foldmethod=marker
    set foldtext=AutFoldText()
    nnoremap <SPACE> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
    set nofoldenable

    function ExpandTo(xlen,xstr)
        let hey = a:xstr
        while strlen(hey) < a:xlen
            let hey = hey . ' '
        endwhile
        return hey
    endfunction

    function AutFoldText()
        let line = getline(v:foldstart)
        let tail = (v:foldend - v:foldstart + 1) . ' lines'
        return ExpandTo((winwidth(0) - strlen(tail)), line) . tail
    endfunction

    set fillchars=stlnc:-,vert:\|,fold:\ ,diff:-
    "if has("win32")
    "    hi Folded ctermbg=blue ctermfg=yellow
    "else
    "    hi Folded cterm=underline ctermfg=Gray
    "endif
    au FileType mason,xml,html,pod,css set foldmethod=syntax formatoptions-=o
    au FileType xml,html,mason,pod syn region FoldMarker start="^\z(\s*\)\S.*{{{\s*$" end="^\z1\S.*}}}\s*$" transparent fold keepend
    au FileType human syn region FoldMarker start="^[1234567890]" end="^[1234567890]"me=e-1 fold keepend
" }}}

" Color: {{{
if &term == "xterm-color" || &term == "xterm-16color"
    set t_Co=16
else
    set t_Co=256
endif
colo ir_black
" colo gardener
" }}}

" Maps: {{{
nmap <Esc>jk :. s/@/_AT_/<CR> :. s/\./ dot /g<CR> :/blah<CR>
"map <buffer> ,w /p5-\([^/]\+\)/<CR> :. /[A-Z][\w-]\+/y k<CR>
map <buffer> ,w /p5-\([^/]\+\)/<CR> "vyaW

nmap <F12> ,w /^Changes:<CR> Ahttp://search.cpan.org/dist/<C-R>v<ESC> :1<CR> :/dist\/[^/]\+\/p5<CR> :. s,dist/[^/]\+/p5-,dist/,<CR> :. s,Makefile,Changes,<CR>
nmap <F11> :% s,^\d\+.* -r..*lib/ruby/gems/1.8/gems/.*/lib/,%%GEM_LIB_DIR%%/lib/,<CR> :% s,^\d\+.* -r..*lib/ruby/gems/1.8/gems/[^/]\+/,%%GEM_LIB_DIR%%/,<CR> :% s,^\d\+.* -r..*lib/ruby/gems/1.8/doc/.*/rdoc/,%%GEM_DOC_DIR%%/rdoc/,<CR>
nmap <F11>4 :% s,^\d\+.* dr..*lib/ruby/gems/1.8/gems/.*/lib/,@dirrm %%GEM_LIB_DIR%%/lib/,<CR> :% s,^\d\+.* dr..*lib/ruby/gems/1.8/gems/[^/]\+/,@dirrm %%GEM_LIB_DIR%%/,<CR> :% s,^\d\+.* dr..*lib/ruby/gems/1.8/doc/.*/rdoc/,@dirrm %%GEM_DOC_DIR%%/rdoc/,<CR>
" nmap <F11> :% s,^\d\+.*lib/ruby/gems/1.8/gems/.*/lib/,%%GEM_LIB_DIR%%/lib/,<CR> :% s,^\d\+.*lib/ruby/gems/1.8/gems/[^/]\+/,%%GEM_LIB_DIR%%/,<CR> :% s,^\d\+.*lib/ruby/gems/1.8/doc/.*/rdoc/,%%GEM_DOC_DIR%%/rdoc/,<CR>
nmap <F11>1 :% s,^\d\+.*lib/ruby/gems/1.8/gems/.*/lib/,%%GEM_LIB_DIR%%/lib/,<CR>
nmap <F11>2 :% s,^\d\+.*lib/ruby/gems/1.8/gems/[^/]\+/,%%GEM_LIB_DIR%%/,<CR>
nmap <F11>3 :% s,^\d\+.*lib/ruby/gems/1.8/doc/.*/rdoc/,%%GEM_DOC_DIR%%/rdoc/,<CR>

"s,dist/[^/]\+/p5-,,g
"s,dist/[^/]\+/p5-,,g<CR>/dist/
"let g:snip_set_textmate_cp=1
map ,pt :%! perltidy
" }}}

set mouse="" "insert mode instead of visual mode

set complete+=k
set dictionary+=/home/clsung/.vim/dict

" Taglist: {{{
if g:OS == "windows"
    let Tlist_Ctags_Cmd="ctags.exe"
elseif g:OS == "mac"
    let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
else
    let Tlist_Ctags_Cmd="/usr/local/bin/exctags"
endif
let Tlist_Auto_Update = 1
let Tlist_Sort_Type = "name"
let Tlist_WinWidth = 30
let Tlist_Inc_Winwidth = 0
let Tlist_Show_One_File = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_File_Fold_Auto_Close = 1 " Automatically close the folds for the non-active files
let Tlist_Process_File_Always = 1 " Process files even when the taglist window is not open
let Tlist_Enable_Fold_Column = 0 " Enable fold column to display the folding for the tag tree
nnoremap <silent> <f6> :Tlist<cr>
"}}}
"
autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
set nomodeline
fun! DoSC()
    let argv = argv(0)
    let s = substitute(argv, 'p', "\1", "")
    return s
endfun
" devel/p5-Module-ExtractUse/Makefile 
" Tabs
" map <C-t>l <ESC>:tabnext<CR>
" map <C-t>h <ESC>:tabprev<CR>
" map <C-t>n <ESC>:tabnew<CR><ESC>:e
" map <C-t>c <ESC>:tabclose<CR>

" Buffer
set display=lastline 
au BufNewFile,BufRead *.js,*.htc,*.c,*.tmpl,*.css inoremap $c /**<CR>  **/<ESC>O
au BufRead,BufNewFile /usr/local/etc/nginx/* set ft=nginx 
au BufRead,BufNewFile *.psgi set ft=perl
au! BufRead,BufNewFile *.conf set filetype=config

" Tab
"let mapleader=","
nmap <LEADER>tc :tabnew<CR>
nmap <LEADER>te :tabedit<SPACE>
nmap <LEADER>tm :tabmove<SPACE>
nmap <LEADER>tk :tabclose<CR>
nmap <C-H> :tabprev<CR>
nmap <C-L> :tabnext<CR>
set switchbuf=usetab
set showtabline=2

let g:vimwiki_list=[{'path': '~/Dropbox/wiki',
    \ 'path_html': '~/Dropbox/wiki/html',
    \ 'html_header': '~/Dropbox/wiki/template/header.tpl',}]
filetype plugin indent on

" Search
set ignorecase
set incsearch
set hlsearch
set wrapscan

set exrc

if g:OS == "mac"
    set guifont=Monaco:h13
elseif g:OS == "windows"
    set guifont=Consolas:h13
else
    set guifont=Consolas\ 13
endif

augroup cplusplus
    autocmd!
    function! _cplusplus()
        set shiftwidth=4
        set softtabstop=4
        set tabstop=4

        " None of these should be word dividers, so make them not be
        set iskeyword+=_,@,#
    endfunction
    autocmd FileType c,cpp call _cplusplus()
augroup END

augroup go
	autocmd!
	function! _go()
		set shiftwidth=4
		set softtabstop=4
		set tabstop=4
	endfunction
	autocmd FileType go call _go()
    autocmd FileType go map <leader>t :Tmux go test<CR>
augroup END

augroup perl
    autocmd!
    function! _perl()
        set shiftwidth=4
        set softtabstop=4
        set tabstop=4
        set tags+=~/.vim/tags/perl
        set foldmethod=indent
	let perl_fold = 1
        set equalprg=perltidy
	set foldmethod=syntax
	set formatoptions-=o
    endfunction
    "au FileType xml,html,mason,perl,pod syn region FoldMarker start="^\z(\s*\)\S.*{{{\s*$" end="^\z1\S.*}}}\s*$" transparent fold keepend
    autocmd FileType perl call _perl()
augroup END

augroup python
    autocmd!
    function! _python()
        setlocal shiftwidth=4
        setlocal softtabstop=4
        setlocal tabstop=4
	setlocal textwidth=79
	setlocal smartindent
        set tags+=~/.vim/tags/python
        setlocal foldmethod=indent " foldcolumn=4 foldlevel=3 foldnestmax=3
    endfunction
    autocmd FileType python call _python()
augroup END

" scala
au BufRead,BufNewFile *.scala set filetype=scala

let python_highlight_all = 1


set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
" <leader>p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>
