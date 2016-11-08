"使vim可以正常打开各种中文编码的文件
set encoding=utf-8
let &termencoding=&encoding
set fileencodings=utf-8,gb18030,gbk,gb2312
set ignorecase smartcase

"不显示行号
set nonu
"set number
"设置不显示行号的快捷键
map <silent> <F4> :set nonumber<cr>
"开启语法高亮
syntax on
"在状态栏显示正在输入的命令
set showcmd
"默认缩进设置为4个字符大小
set shiftwidth=4
"python tab->4spaces 
filetype indent on
autocmd FileType python setlocal et sta sw=4 sts=4
"设置命令行的高度
set cmdheight=3
"设置进入粘贴模式的快捷键，可以避免window下复制的内容在vim里粘贴自动换行的问题
set pastetoggle=<F3>
"设置自动缩进
set autoindent
set cindent
"设置制表符宽度
set tabstop=2
set expandtab

"设置代码可折叠,za为{}折叠和展开的切换键
set foldmethod=syntax
set foldlevelstart=99

" Indent Python in the Google way.

setlocal indentexpr=GetGooglePythonIndent(v:lnum)
set mouse=a

