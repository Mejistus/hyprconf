syntax on
filetype plugin on

set ru
set tw=29
set ts=4
set nowrap
set number
set mouse=a
set tabstop=4
set expandtab
set ignorecase
set backspace=2
set shiftwidth=4
set shortmess+=I
set softtabstop=4
set textwidth=120
set termguicolors
set relativenumber
set encoding=utf-8
set completeopt=longest,menu,preview

call plug#begin()
Plug 'psliwka/vim-smoothie'
Plug 'arzg/vim-colors-xcode'
Plug 'easymotion/vim-easymotion'
Plug 'vim-autoformat/vim-autoformat'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ap/vim-css-color'
Plug 'zhou13/vim-easyescape'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
Plug 'preservim/tagbar'
call plug#end()


colorschem xcodedark
" colorschem xcodelight

" NerdTree
map <C-N> :NERDTreeToggle<CR>
map <C-n> :NERDTreeMirror<CR>
map <C-n> :NERDTreeToggle<CR>
" Change current folder as root
let g:NERDTreeChDirMode = 2
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |cd %:p:h |endif

" UI settings
" Close NERDtree when files was opened
let NERDTreeQuitOnOpen=1
" Start NERDTree in minimal UI mode (No help lines)
let NERDTreeMinimalUI=1
" Display arrows instead of ascii art in NERDTree
let NERDTreeDirArrows=1
" Change current working directory based on root directory in NERDTree
let NERDTreeChDirMode=2
" Don't show hidden files
let g:NERDTreeHidden=1
" Initial NERDTree width
let NERDTreeWinSize=20
" Auto delete buffer deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '__pycache__']   " Hide temp files in NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" easymotion
let g:EasyMotion_smartcase = 1
nmap f <Plug>(easymotion-s)

" minimap
nmap <C-J> :MinimapToggle<CR>

let g:minimap_width = 10
let g:minimap_auto_start = 0
let g:minimap_auto_start_win_enter = 0
autocmd ColorScheme *
            \ highlight minimapCursor ctermbg=59  ctermfg=228 guibg=#5F5F5F guifg=#FFFF87 |
            \ highlight minimapRange ctermbg=242 ctermfg=228 guibg=#4F4F4F guifg=#FFFF87

" tagbar
nmap <C-K> :TagbarToggle<CR>
let g:tagbar_width=35
let g:tagbar_show_tag_linenumbers=1
let g:tagbar_show_linenumbers=1
let g:tagbar_scrolloff =1
let g:tagbar_compact=1
let g:tagbar_expand=1
let g:tagbar_autofocus=1
let g:tagbar_singleclick=1
let g:tagbar_autoclose=1
let g:tagbar_indent=1

" 键位更改
noremap <silent><tab>e :tabnew<cr>
noremap <silent><tab>c :tabclose<cr>
noremap <silent><tab>n :tabn<cr>
noremap <silent><tab>p :tabp<cr>

" 定义 ToggleComment 函数
function! ToggleComment() abort
    let l:comment_prefix = {
                \ 'python': '#',
                \ 'java': '//',
                \ 'c': '//',
                \ 'cpp': '//',
                \ 'go': '//',
                \ 'rust': '//',
                \ }

    let l:filetype = &filetype
    let l:comment = get(l:comment_prefix, l:filetype, '"')
    if empty(l:comment)
        let l:comment = '"'
    endif

    let l:current_line = getline('.')
    if l:current_line =~# '^\s*' . l:comment . '\s*'
        if strlen(l:current_line) >= strlen(l:comment)+1
            let l:current_line = strpart(l:current_line, strlen(l:comment)+1)
            call setline('.', l:current_line)
        endi
    else
        execute 'normal!' 'I' . l:comment . ' '
    endif
endfunction

map <leader><CR>  :call ToggleComment()<CR>

" QuickRun
imap \\ <ESC>
nmap <C-I> :w<CR>:!easy %<CR>

" Coc

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=200

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-s> coc#refresh()
else
    inoremap <silent><expr> <c-s> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s)
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" coc-highlight
autocmd CursorHold * silent call CocActionAsync('highlight')
" coc-pairs
autocmd FileType tex let b:coc_pairs = [["$", "$"]]
autocmd FileType markdown let b:coc_pairs_disabled = ['`']
" Autoformat

nmap <C-L> <ESC>:Autoformat<CR>:w<CR>
" YCM
" let g:ycm_auto_trigger = 1
" let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_enable_disagnostic_signs = 1
" let g:ycm_echo_current_diagnostic = 1
" let g:ycm_key_invoke_completion = '<C-S>'
" nmap <C-L> <ESC>:YcmCompleter FixIt<CR><ESC>:Autoformat<CR>:w<CR>
" imap <C-L> <ESC>:YcmCompleter FixIt<CR><ESC>:Autoformat<CR>:w<CR>
" map <C-F> <ESC>:YcmCompleter FixIt<CR>
" map <C-G> <ESC>:tab split\| YcmCompleter GoTo<CR>
" " map <C-G> <ESC>:YcmCompleter GoToDeclaration<CR>
" map <C-C> <ESC>:YcmCompleter GoToCallers<CR>
" nnoremap <F10>  <ESC>:YcmForceCompileAndDiagnostics<CR>
" " set completeopt-=preview
" " 开启 YCM 基于标签引擎
" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_auto_start_csharp_server = 1
" let g:ycm_auto_stop_csharp_server = 1
" let g:ycm_error_symbol = '😅'
" let g:ycm_warning_symbol = '🤔'
"
" " LSP
" let g:ycm_lsp_dir = '~/.vim/lsp-examples'
" let g:ycm_language_server = []
" let s:pip_os_dir = 'bin'
" if has('win32')
"     let s:pip_os_dir = 'Scripts'
" end
" let g:ycm_language_server += [
"             \   { 'name': 'lua',
"             \     'filetypes': [ 'lua' ],
"             \     'cmdline': [ g:ycm_lsp_dir . '/lua/lua-language-server/root/bin/lua-language-server' ],
"             \     'capabilities': { 'textDocument': { 'completion': { 'completionItem': { 'snippetSupport': v:true } } } },
"             \     'triggerCharacters': []
"             \   },
"             \ ]
"
" let g:ycm_language_server += [
"             \   {
"             \     'name': 'cmake',
"             \     'cmdline': [ expand( g:ycm_lsp_dir . '/cmake/venv/' . s:pip_os_dir . '/cmake-language-server' )],
"             \     'filetypes': [ 'cmake' ],
"             \    },
"             \ ]
" let g:ycm_language_server += [
"             \   {
"             \     'name': 'bash',
"             \     'cmdline': [ 'node', expand( g:ycm_lsp_dir . '/bash/node_modules/.bin/bash-language-server' ), 'start' ],
"             \     'filetypes': [ 'sh', 'bash' ],
"             \   },
"             \ ]
" let g:ycm_language_server += [
"             \   { 'name': 'kotlin',
"             \     'filetypes': [ 'kotlin','kt' ],
"             \     'cmdline': [ expand( g:ycm_lsp_dir . '/kotlin/KotlinLanguageServer/server/build/install/server/bin/kotlin-language-server' ) ],
"             \   },
"             \ ]
"
" highlight PMenu ctermfg=lightgrey ctermbg=darkgrey  guifg=#eef7f2 guibg=#207f4c
" highlight PMenuSel ctermfg=lightgrey ctermbg=darkgrey guifg=#207f4c guibg=#eef7f2

" 水平分割vs
" 数值分割sv
" 切换ctrl-w + 上下选择
function! Tabline() abort
    let l:line = ''
    let l:current = tabpagenr()

    for l:i in range(1, tabpagenr('$'))
        if l:i == l:current
            let l:line .= '%#TabLineSel#'
        else
            let l:line .= '%#TabLine#'
        endif

        let l:label = fnamemodify(
                    \ bufname(tabpagebuflist(l:i)[tabpagewinnr(l:i) - 1]),
                    \ ':t'
                    \ )

        let l:line .= '%' . i . 'T' " Starts mouse click target region.
        let l:line .= '  ' . l:label . '  '
    endfor

    let l:line .= '%#TabLineFill#'
    let l:line .= '%T' " Ends mouse click target region(s).

    return l:line
endfunction

set tabline=%!Tabline()
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-k>'
let g:coc_snippet_next = '<tab>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<s-tab>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
