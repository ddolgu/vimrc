" 플러그인 관리 시작
call plug#begin('~/.vim/plugged')

" 파일 탐색 및 검색
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'

" 자동 완성과 LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" YAML 및 Python 플러그인 추가
Plug 'stephpy/vim-yaml'                " YAML 지원
Plug 'vim-python/python-syntax'        " Python 구문 강조
Plug 'davidhalter/jedi-vim'            " Python 자동 완성 (선택 사항)
Plug 'psf/black', { 'branch': 'stable' } " Python 코드 포매터 (선택 사항)

" 문법 검사 및 디버깅
Plug 'dense-analysis/ale'
Plug 'puremourning/vimspector'

" 문법 강조 및 생산성
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Git 및 코드 구조 탐색
Plug 'airblade/vim-gitgutter'
Plug 'preservim/tagbar'

" 테마
Plug 'morhetz/gruvbox'
Plug 'dracula/vim',{'as':'dracula'}

call plug#end()


" 기본 설정
syntax on
autocmd BufRead,BufNewFile * if &filetype == ''|| &filetype=='text' | set filetype=messages | endif
autocmd BufRead,BufNewFile *.service set filetype=systemd
let g:ale_linters = {
\   'cpp': ['clang'],
\   'c': ['clang'],
\}

let g:ale_cpp_clang_executable = 'clang++'
let g:ale_cpp_clang_options = '-std=c++17 -Wall -isystem /usr/include/c++/11 -isystem /usr/include/x86_64-linux-gnu/c++/11 -I/usr/include/eigen3 -I/opt/ros/humble/include -I/opt/ros/humble/include/rcl -I/opt/ros/humble/include/rmw -I/opt/ros/humble/include/rcutils -I/opt/ros/humble/include/rosidl_runtime_c -I/opt/ros/humble/include/builtin_interfaces -I/opt/ros/humble/include/rclcpp -I/opt/ros/humble/include/rcl_yaml_param_parser -I/opt/ros/humble/include/rosidl_typesupport_interface -I/opt/ros/humble/include/rcpputils -I/opt/ros/humble/include/rosidl_runtime_cpp -I/opt/ros/humble/include/tracetools'
let g:ale_cpp_cc_options = g:ale_cpp_clang_options
let g:ale_c_clang_options = '-std=c99 -Wall -I/usr/include/eigen3'
set wildmenu
set completeopt=menu,menuone,noselect
set lazyredraw
set ttyfast
set synmaxcol=200
set nu
set hlsearch
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set history=100
set cursorline
set laststatus=2
set clipboard=unnamedplus
set number
set encoding=utf-8
set fileencodings=utf-8,euc-kr
set termencoding=utf-8
set keymap=korean
set iminsert=2
set imsearch=2
colorscheme dracula

nnoremap <C-r> : Commentary<CR>

" Python 파일의 주석을 이탤릭체로 설정
augroup PythonItalicComments
  autocmd!
  autocmd FileType python highlight Comment cterm=italic gui=italic
augroup END

" YAML 파일을 위한 들여쓰기 설정
augroup yaml_indent
  autocmd!
  autocmd FileType yaml setlocal expandtab
  autocmd FileType yaml setlocal shiftwidth=4
  autocmd FileType yaml setlocal softtabstop=4
  autocmd FileType yaml setlocal tabstop=4
augroup END

" Python 파일을 위한 들여쓰기 설정
augroup python_indent
  autocmd!
  autocmd FileType python setlocal expandtab
  autocmd FileType python setlocal shiftwidth=4
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal tabstop=4
augroup END

" 자동 저장 시 트레일링 스페이스 제거
autocmd BufWritePre * :%s/\s\+$//e
" color delek
