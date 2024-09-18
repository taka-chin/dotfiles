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
set termguicolors
set clipboard=unnamed,autoselect

" colorscheme iceberg
nmap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc> " 文字列検索のハイライトオフ
" nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=30<CR>

" vim関連map
let mapleader = "\<Space>"
" nnoremap <silent> <Leader>vc :new ~/.vim/_config/200-lsp.vim<CR>   
" nnoremap <silent> <Leader>vm :new ~/.vim/_config/map.vim<CR>   
nnoremap <silent> <Leader>vr :new ~/.vimrc<CR>
" nnoremap <silent> <Leader>bk :highlight Normal ctermbg=none<CR>
nnoremap <silent> <Leader>rr :source ~/.vimrc<CR>  

nnoremap <silent> <Leader>term :set autochdir<CR>:vert terminal<CR> 
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
  " Plug 'vim-jp/vimdoc-ja'
  Plug 'vim-utils/vim-man'
  " Plug 'itchyny/lightline.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-hijack.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'yuki-yano/fern-preview.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  " Plug 'lambdalisue/fern-git-status.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  " Plug 'liuchengxu/vim-which-key'
  Plug 'cocopon/pgmnt.vim'
  " Plug 'dracula/vim'
  " Plug 'mattn/vim-yoshi'
  " Plug 'mattn/vim-chatgpt'
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'morhetz/gruvbox'
	Plug 'skanehira/preview-markdown.vim'	
	Plug 'rhysd/vim-clang-format'
	" Plug	'fatih/vim-go'
  " Plug 'puremourning/vimspector'
  " Plug 'vim-utils/vim-debug'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#formatter = 'unique_tail'
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-t> <Plug>AirlineSelectNextTab
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

let g:lsp_diagnostics_enabled = 0                        " Diagnosticsを有効にする
" let g:lsp_diagnostics_echo_cursor = 1                    " カーソル下のエラー、警告、情報、ヒントを画面下部のコマンド ラインに表示
let g:lsp_diagnostics_echo_cursor = 0                    " カーソル下のエラー、警告、情報、ヒントを画面下部のコマンド ラインに表示
let g:lsp_diagnostics_echo_delay = 50                    " Diagnosticsの表示の遅延を50msに設定
let g:lsp_diagnostics_float_cursor = 0                   " カーソル下のエラー、警告、情報、ヒントをフロート表示
let g:lsp_diagnostics_signs_enabled = 0                  " 画面左端のサイン列にエラー、警告、情報、ヒントのアイコンを 表示
let g:lsp_diagnostics_signs_delay = 50                   " Diagnosticsのサイン列の表示の遅延を50msに設定
let g:lsp_diagnostics_signs_insert_mode_enabled = 0      " 挿入モード時、Diagnosticsのサイン列を表示しない
let g:lsp_diagnostics_highlights_delay = 50              " Diagnosticsの指摘箇所自体の文字ハイライト表示の遅延を50msに設定
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0 " 挿入モード時、Diagnosticsの指摘箇所自体の文字ハイライトを表示しない
let g:lsp_document_code_action_signs_enabled = 0         " 画面左端のサイン列にコードアクションのアイコン非表示

let g:asyncomplete_popup_delay = 100 " 補完メニューを開く際の遅延を100msに設定

" fzf
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

"test
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=30<CR>
colorscheme iceberg

let g:preview_markdown_parser = 'glow' 
