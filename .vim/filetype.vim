if exists("did_load_filetypes")
        finish
endif

augroup filetypedetect
        "au BufRead,BufNewFile *.py set filetype python
        au BufRead,BufNewFile *.rb set filetype=ruby
        au BufRead,BufNewFile *.php :set filetype=php
        "au BufRead,BufNewFile *.ctp :set filetype=ctp
        "au BufRead,BufNewFile *.ctp :set filetype=php,html,javascript
        au BufRead,BufNewFile *.ctp :set filetype=php
        au BufRead,BufNewFile *.less set filetype=css
        au BufRead,BufNewFile *.yaml,*.yml set filetype=yaml
        au BufRead,BufNewFile *.coffee set filetype=coffee
        "au BufNewFile,BufReadPost *.coffee set| shiftwidth=2 expandtab
augroup END
