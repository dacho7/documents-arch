set number
set numberwidth=1
set mouse=r
set showcmd
set ruler
set encoding=utf-8
set showmatch
set relativenumber
set autoindent
set laststatus=2
set clipboard=unnamed
set tabstop=2
set expandtab							"indica expandir los tabs en espacios
set shiftwidth=2 					"espacios para identacions
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P  "statusline enable git
set scrolloff=8
set shortmess+=c          "evita pasar informacion en statusline(distrae)
set complete+=kspell           "para completeop
"set completeopt=menuone,longest "para completeopt

"	CONFIGURE INSTALL PLUGGINS 
call plug#begin('~/.vim/plugged')
"Theme
Plug 'morhetz/gruvbox'

"ID
Plug 'scrooloose/nerdtree' 		    "mostrar arbol de directorios
Plug 'easymotion/vim-easymotion'	"buscar texto en pantalla y trasladarse
Plug 'mattn/emmet-vim'            "autocompletar codigo html
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/AutoComplPop'    "Autocompletar codigo
Plug 'tpope/vim-fugitive'          "estilo git
"Plug 'vim-airline/vim-airline'    "Themes statusline git
call plug#end()


"Functions"
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  endif
  return "\<Tab>"
endfunction


"Autocompletar parentesis
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [ []<Esc>i
inoremap < <><Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
"navega con flecha arriba en autocomplete
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"


"	CONFIGURE MAP LEADER
let mapleader=" "
let g:user_emmet_leader_key=','
let g:prettier#config#single_quote = 'true'          "comillas simples
nnoremap <leader>nt : NERDTreeFocus<CR>
nmap <leader>s <Plug>(easymotion-s2)
nmap <leader>pr <Plug>(Prettier)
nmap <leader>w :w<CR>
"<Plug>(Prettier)
nmap <leader>q :q<CR>


"	CONFIGURE THEME
let g:gruvbox_constrast_dark = "soft"
let g:gruvbox_termcolors = 256
colorscheme gruvbox
