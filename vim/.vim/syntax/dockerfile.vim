" dockerfile.vim - Syntax highlighting for Dockerfiles
" Maintainer:   Honza Pokorny <https://honza.ca>
" Version:      0.6
" Last Change:  2019 Aug 16
" License:      BSD


if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "dockerfile"

syntax case ignore

syn keyword dockerfileKeyword   ADD ARG AS CMD COPY ENTRYPOINT ENV EXPOSE FROM HEALTHCHECK LABEL
syn keyword dockerfileKeyword   MAINTAINER ONBUILD RUN SHELL STOPSIGNAL USER VOLUME WORKDIR

syn region  dockerfileString    start=/\v"/ skip=/\v\\./ end=/\v"/
syn region  dockerfileVariable  matchgroup=dockerfileEscape start=/\v\$\{/ end=/\v\}/

syn match   dockerfileComment   "\v^\s*#.*$"

hi def link dockerfileComment   Comment
hi def link dockerfileEscape    Special
hi def link dockerfileKeyword   Keyword
hi def link dockerfileString    String
hi def link dockerfileVariable  Identifier
