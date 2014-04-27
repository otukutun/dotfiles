if exists("did_load_filetypes")
        finish
endif

augroup filetypedetect
        "au BufRead,BufNewFile *.py set filetype python
        au BufRead,BufNewFile *.rb set filetype=ruby
        au BufRead,BufNewFile *.php :set filetype=php
        au BufRead,BufNewFile *.ctp :set filetype=ctp
        au BufRead,BufNewFile *.less set filetype=css
        au BufRead,BufNewFile *.html set filetype=html
augroup END