" after/plugin/sexp.vim - Sexp mappings for regular people
" Maintainer:   Tim Pope <code@tpope.net>

if exists("g:loaded_sexp_mappings_for_regular_people") || &cp
  finish
endif
let g:loaded_sexp_mappings_for_regular_people = 1

function! s:map_sexp_wrap(type, target, left, right, pos)
  execute (a:type ==# 'v' ? 'x' : 'n').'noremap'
        \ '<buffer><silent>' a:target ':<C-U>let b:sexp_count = v:count<Bar>exe "normal! m`"<Bar>'
        \ . 'call sexp#wrap("'.a:type.'", "'.a:left.'", "'.a:right.'", '.a:pos.', 0)'
        \ . '<Bar>silent! call repeat#set("'.a:target.'", v:count)<CR>'
endfunction

function! s:sexp_mappings() abort
  if !exists('g:sexp_loaded')
    return
  endif
  call s:map_sexp_wrap('e', 'cseb', '(', ')', 0)
  call s:map_sexp_wrap('e', 'cse(', '(', ')', 0)
  call s:map_sexp_wrap('e', 'cse)', '(', ')', 1)
  call s:map_sexp_wrap('e', 'cse[', '[', ']', 0)
  call s:map_sexp_wrap('e', 'cse]', '[', ']', 1)
  call s:map_sexp_wrap('e', 'cse{', '{', '}', 0)
  call s:map_sexp_wrap('e', 'cse}', '{', '}', 1)

  nmap <buffer> dsf <Plug>(sexp_splice_list)

  nmap <buffer> B   <Plug>(sexp_move_to_prev_element_head)
  nmap <buffer> W   <Plug>(sexp_move_to_next_element_head)
  nmap <buffer> gE  <Plug>(sexp_move_to_prev_element_tail)
  nmap <buffer> E   <Plug>(sexp_move_to_next_element_tail)
  xmap <buffer> B   <Plug>(sexp_move_to_prev_element_head)
  xmap <buffer> W   <Plug>(sexp_move_to_next_element_head)
  xmap <buffer> gE  <Plug>(sexp_move_to_prev_element_tail)
  xmap <buffer> E   <Plug>(sexp_move_to_next_element_tail)
  omap <buffer> B   <Plug>(sexp_move_to_prev_element_head)
  omap <buffer> W   <Plug>(sexp_move_to_next_element_head)
  omap <buffer> gE  <Plug>(sexp_move_to_prev_element_tail)
  omap <buffer> E   <Plug>(sexp_move_to_next_element_tail)

  nmap <buffer> <I  <Plug>(sexp_insert_at_list_head)
  nmap <buffer> >I  <Plug>(sexp_insert_at_list_tail)
  nmap <buffer> <f  <Plug>(sexp_swap_list_backward)
  nmap <buffer> >f  <Plug>(sexp_swap_list_forward)
  nmap <buffer> <e  <Plug>(sexp_swap_element_backward)
  nmap <buffer> >e  <Plug>(sexp_swap_element_forward)
  nmap <buffer> >(  <Plug>(sexp_emit_head_element)
  nmap <buffer> <)  <Plug>(sexp_emit_tail_element)
  nmap <buffer> <(  <Plug>(sexp_capture_prev_element)
  nmap <buffer> >)  <Plug>(sexp_capture_next_element)

  " DMK: My mappings
  nmap <buffer> <up>      <Plug>(sexp_move_to_prev_element_head)
  nmap <buffer> <down>    <Plug>(sexp_move_to_next_element_head)
  nmap <buffer> <s-up>    <Plug>(sexp_move_to_prev_element_tail)
  nmap <buffer> <s-down>  <Plug>(sexp_move_to_next_element_tail)

  " Exchange elements
  " x = exchange, l = right, h = left (like vim)
  nmap <buffer> <localleader>xh  <Plug>(sexp_swap_element_backward)
  nmap <buffer> <localleader>xl  <Plug>(sexp_swap_element_forward)
  nmap <buffer> <c-up>           <Plug>(sexp_swap_element_backward)
  nmap <buffer> <c-down>         <Plug>(sexp_swap_element_forward)

  " Barf and slurp
  " b = barf, s = slurp
  " h = left, l = right
  nmap <buffer> <localleader>bh  <Plug>(sexp_emit_head_element)
  nmap <buffer> <localleader>bl  <Plug>(sexp_emit_tail_element)
  nmap <buffer> <localleader>sh  <Plug>(sexp_capture_prev_element)
  nmap <buffer> <localleader>sl  <Plug>(sexp_capture_next_element)

  " Lift
  nmap <buffer> <localleader>le  <Plug>(sexp_raise_element)
  nmap <buffer> <localleader>lf  <Plug>(sexp_raise_list)

  " Splice
  nmap <buffer> <localleader>S  <Plug>(sexp_splice_list)

  " Split and join
  " j = join, s = split, ss = split string
  " join works on adjacent forms separated by one space
  nmap <buffer> <localleader>j hxlx
  nmap <buffer> <localleader>s ma("byl)"cyl`a"cPl"bp
  nnoremap <localleader>ss i" "<esc>

  " Indent
  " Seem to work, but not sure how it plays with default
  " binding of =
  nmap <buffer> =  <Plug>(sexp_indent)
  nmap <buffer> == <Plug>(sexp_indent_top)

  " Select prev, next element
  " v = visual select
  " h = previous (left), l = next (right)
  nmap <buffer> <localleader>vh  <Plug>(sexp_select_prev_element)
  nmap <buffer> <localleader>vl  <Plug>(sexp_select_next_element)

  " Wrap elements or forms
  nmap <buffer> <localleader>W   <Plug>(sexp_round_tail_wrap_list)
  nmap <buffer> <localleader>w   <Plug>(sexp_round_head_wrap_list)
  nmap <buffer> <localleader>w(  <Plug>(sexp_round_head_wrap_element)
  nmap <buffer> <localleader>w)  <Plug>(sexp_round_tail_wrap_element)
  nmap <buffer> <localleader>w[  <Plug>(sexp_square_head_wrap_element)
  nmap <buffer> <localleader>w]  <Plug>(sexp_square_tail_wrap_element)
  nmap <buffer> <localleader>w{  <Plug>(sexp_curly_head_wrap_element)
  nmap <buffer> <localleader>w}  <Plug>(sexp_curly_tail_wrap_element)

  " Insert stuff
  " - at beginning of form: (a
  " - at end of form: )i
  "
  " Kill stuff
  " - to end of containing form: d)
  " - to beginning of containing form: d(
  " kill left and splice
  nmap <buffer> <localleader>kh d(\S
  " kill right and splice
  nmap <buffer> <localleader>kl d)\S

  " lift left or right without killing
  " you can think of this as barfing from the interior of a form
  " but instead of asking the containing form to barf its head
  " or tail, we ask the current element to barf itself
  " b = barf, > = to right, < = to left
  " <localleader>b>
  " <localleader>b<
  "
  " current function clj formatting of delimiters trailing
  " formatting format of the file delimiters beginning
  " of containing formatting
  "
  " write a function to prep for formatting with =
  " - delete blank lines within a form
  " - join lines that only have closing delimiters on them
  " - join lines that start with closing delimiters
  "   Example:
  "   ((this is
  "      )) (my form)
  "   ==>
  "   ((this is))
  "   (my form)
  "
  " - remove leading and trailing space inside parens
  "   (but not in a string or comment)

endfunction

function! s:setup() abort
  augroup sexp_mappings_for_regular_people
    autocmd!
    execute 'autocmd FileType' get(g:, 'sexp_filetypes', 'lisp,scheme,clojure') 'call s:sexp_mappings()'
  augroup END
endfunction

if has('vim_starting') && !exists('g:sexp_loaded')
  au VimEnter * call s:setup()
else
  call s:setup()
endif
