set number 
set relativenumber           " 画面左端に行番号を表示
set signcolumn=yes    " 画面左端にサイン列を常に表示
set laststatus=2      " 画面最下部に常にステータスラインを表示
set cmdheight=2       " 画面最下部(ステータス行より下)のメッセージ表示欄を2行にする
set showtabline=2     " タブ毎に常にタブラインを表示
set backspace=indent,eol,start
set completeopt=menuone,noinsert,noselect,preview

set wildmenu          " コマンドラインでTAB補完時に候補メニューを表示

set tabstop=2         " タブを2文字分にする

set noswapfile        " スワップファイル(.swp)を生成しない
set nobackup          " バックアップファイル(~)を生成しない
set noundofile        " undoファイル(.un~)を生成しない
set encoding=utf-8    " Vim内部で使われる文字エンコーディングにutf-8にする

set mouse=a           " マウス操作を有効にする
set clipboard=unnamed,autoselect
set background=dark
set tags=./tags;,tags;

colorscheme iceberg

"insertモードをjjで抜ける
inoremap <silent> jj <ESC>
"man.vim
map <leader>k <Plug>(Man)
"行入れ替え
nnoremap <C-j> :m +1<CR>
nnoremap <C-k> :m -2<CR>
"Undoの永続化
if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif

call plug#begin('~/.vim/plugged')
  Plug 'lambdalisue/fern.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-hijack.vim'
	Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/gina.vim'
  Plug 'yuki-yano/fern-preview.vim'
	Plug 'lambdalisue/glyph-palette.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
	Plug 'github/copilot.vim'
	Plug 'itchyny/vim-qfedit'
	Plug 'simeji/winresizer'
	" Plug 'prabirshrestha/vim-lsp'
	" Plug 'mattn/vim-lsp-settings'
	" Plug 'prabirshrestha/asyncomplete.vim'
	" Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'angr'
let g:airline#extensions#tabline#formatter = 'unique_tail'
" nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <Tab> <Plug>AirlineSelectPrevTab
nmap <S-Tab> <Plug>AirlineSelectNextTab

function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

" アイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

let g:fern#renderer = 'nerdfont'
let g:fern#renderer#nerdfont#indent_markers = 1

let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>
nnoremap <silent> <Leader>t :set autochdir<CR>:bo terminal++rows=10<CR> 

" fzf
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>G :GFiles?<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>r :Rg<CR>

nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=30<CR>
nnoremap <C-f> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
" let g:lsp_diagnostics_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_diagnostics_echo_delay = 50
" let g:lsp_diagnostics_float_cursor = 1
" let g:lsp_diagnostics_signs_enabled = 1
" let g:lsp_diagnostics_signs_delay = 50
" let g:lsp_diagnostics_signs_insert_mode_enabled = 0
" let g:lsp_diagnostics_highlight_delay = 50
" let g:lsp_diagnostics_highlight_insert_mode_enabled = 0
" let g:lsp_document_code_action_signs_enabled = 0

" let g:asyncomplete_popup_delay = 100
