" rfc.vim : Download RFC over https
" Credit  : Jan Christoph Ebersbach <jceb@e-jc.de>
" Version : 0.1

if (exists("g:loaded_rfc") && g:loaded_rfc) || &cp
  finish
endif

let g:loaded_rfc = 1

" 'RFC <number>' open the requested RFC number in a new window
function! RFC(number)
  if a:number =~ '^[0-9]'
    if filereadable("/usr/share/doc/rfc/txt/rfc" . a:number . ".txt")
        " if the RFC is downloaded, use the downloaded file
        silent exe ":e /usr/share/doc/rfc/txt/rfc" . a:number . ".txt"
    else
        " else fetch the rfc file
        silent exe ":e https://www.ietf.org/rfc/rfc" . a:number . ".txt"
    endif

    " set syntax on the rfc txt file
    setf rfc

    " redraw screen to avoid ugly artifacts
    redraw!
  else
    echoerr a:number . " is not a number"
  endif
endfunction

" ':RFC <number>' open the requested RFC number in a new window
command! -nargs=1 RFC call RFC(<q-args>)
