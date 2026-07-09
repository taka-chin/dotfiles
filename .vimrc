" ---表示設定---
" 行番号表示
set number
" 相対行番号表示
set relativenumber
" 左にサイン列を表示
set signcolumn=yes
" ステータスラインを表示
set laststatus=2
" コマンド表示欄を2行
set cmdheight=2
" タブラインを表示
set showtabline=2
set foldmethod=syntax
set foldlevelstart=99

" ---入力・編集---
" バックスペースの設定
set backspace=indent,eol,start
" インデントの設定
set autoindent
set smartindent
set nocindent
" タブをスペースに変換、インデント幅2
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set completeopt=menuone,noinsert,noselect,preview
set wildmenu

" ---基本設定---
set encoding=utf-8
set mouse=a
set clipboard=unnamed,autoselect
set splitright

" ---ファイル管理---
set noswapfile
set nobackup
"外部でファイル変更時読み直し
set autoread
" autoreadが実行される条件
augroup auto_reload
	autocmd!
	autocmd FocusGained,BufEnter,CursorHold * checktime
augroup END

" ---検索---
"  検索ハイライトをesc2回で消す
nmap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc>

" ---Leaderキーの設定---
let mapleader = "\<Space>"

" ---keymapの設定---
"　Leader + vrでvimrcを開く 
nnoremap <silent> <Leader>vr :new ~/.vimrc<CR>
"　Leader + rrでvimrcを反映
nnoremap <silent> <Leader>rr :source ~/.vimrc<CR>  
" insertモードをjjで抜ける
inoremap <silent> jj <ESC>
" ctrl + j,kで行swap
nnoremap <C-j> :m +1<CR>
nnoremap <C-k> :m -2<CR>

"---Undoの永続化---
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')
  call mkdir(undo_path, 'p')
  exe 'set undodir=' . undo_path
  set undofile
endif

"man.vim
map <leader>k <Plug>(Man)

" ---プラグイン---
call plug#begin('~/.vim/plugged')
  " ---ファイルツリー fern---
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-hijack.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'yuki-yano/fern-preview.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  " ---Git---
  Plug 'tpope/vim-fugitive'
  " ---コメントアウト---
  Plug 'tpope/vim-commentary'
  " ---fzf---
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " ---LSP---
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  " ---ステータスライン---
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " ---colorscheme---
	Plug 'morhetz/gruvbox'
	Plug 'cocopon/iceberg.vim'
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  " ---formatter---
	Plug 'rhysd/vim-clang-format'
  " ---manの表示---
  Plug 'vim-utils/vim-man'

  " ---トライアル中---
  " Docker環境でのvimコピー
	Plug 'ojroques/vim-oscyank'
  " Markdownファイルの表示
  Plug 'cocopon/pgmnt.vim'
	Plug 'skanehira/preview-markdown.vim'	
call plug#end()

" ---プラグイン設定---
" ---airline---
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#formatter = 'unique_tail'
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-t> <Plug>AirlineSelectNextTab

" ---fern---
" 公式リポジトリを参考にキーマップを追加
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

" アイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

let g:fern#default_hidden=1 " 隠しファイルを表示する
let g:fern#renderer = 'nerdfont'
let g:fern#renderer#nerdfont#indent_markers = 1

" ctrl + nでファイルツリーを開く
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=30<CR>

" ---LSP設定---
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_diagnostics_echo_delay = 50
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_diagnostics_signs_delay = 50
let g:lsp_diagnostics_signs_insert_mode_enabled = 0
let g:lsp_diagnostics_highlights_delay = 50
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0
let g:asyncomplete_popup_delay = 100

" ---fzf設定---
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>G :GFiles?<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>r :Rg<CR>

imap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

set timeoutlen=500 " 100msだと他のキーマッピングが上手く動かないため500msに設定

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  if exists('+tagfunc')
    setlocal tagfunc=lsp#tagfunc
  endif

  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gD <plug>(lsp-declaration)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> K  <plug>(lsp-hover)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
endfunction

augroup lsp_settings
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" ---OSCYank設定---
"  Leader + yでコピー
vnoremap <leader>y y:OSCYankRegister "<CR>

" ---color設定---
syntax enable
set termguicolors
set background=dark
colorscheme catppuccin_mocha

" ---言語設定----
" マークダウンプレビューのデフォルト
let g:preview_markdown_parser = 'glow' 

" C++フォーマッターの設定
let g:clang_format#auto_format = 0

" ---自作関数---
"  Leader + e で呼び出し
"  日本語と対応する英単語をprogramming.tsvから検索する
function! ProgrammingDictionary()

    let key = input('Japanese: ')

    if empty(key)
        return
    endif

    call fzf#run({
        \ 'source': printf("grep '^%s' ~/.vim/dict/programming.tsv | cut -f2", key),
        \ 'sink': { word -> setreg('+', word) },
        \ })

endfunction

nnoremap <Leader>e :call ProgrammingDictionary()<CR>

