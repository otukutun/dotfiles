if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufRead,BufNewFile *.rb set filetype=ruby
  au BufRead,BufNewFile *.php :set filetype=php
  au BufRead,BufNewFile *.yaml,*.yml set filetype=yaml
augroup END
