" autoload/helloworld/greetings.vim
function helloworld#greetings#good_morning() abort
    echo 'Good morning'
endfunction

" plug in plugin/helloworld.vim
command Greet call helloworld#greetings#good_morning()
