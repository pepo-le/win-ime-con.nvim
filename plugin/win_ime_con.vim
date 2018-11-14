scriptencoding utf-8

if exists('g:loaded_winimecon')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

if has("win32")
    if has('pythonx')
        let s:py = 'pythonx'
        let s:pyfile = 'pyxfile'
    elseif has('python3')
        let s:py = 'python3'
        let s:pyfile = 'py3file'
    elseif has('python')
        let s:py = 'python'
        let s:pyfile = 'pyfile'
    else
        echo 'ERROR: has("python3") was not successful'
        finish
    endif

    if !exists('g:win_ime_con_mode')
        let g:win_ime_con_mode = 1
    endif

    execute s:pyfile . ' <sfile>:h:h/py/win_ime_con.py'
    execute s:py . ' wic = WinImeCon()'

    augroup win_ime_con
        autocmd!
        autocmd BufWinEnter * let b:win_ime_con_is_insert = 0
        autocmd BufWinEnter * let b:win_ime_con_is_active = 0
        autocmd InsertEnter * call On_insert_enter()
        autocmd InsertLeave * call On_insert_leave()
    augroup END

    function! On_insert_enter()
        if !exists('b:win_ime_con_is_insert')
            return
        endif

        if b:win_ime_con_is_insert == 0
            let b:win_ime_con_is_insert = 1
            if b:win_ime_con_is_active == 1 && g:win_ime_con_mode != 0
                execute s:py . ' wic.activate()'
            endif
        endif
    endfunction

    function! On_insert_leave()
        if !exists('b:win_ime_con_is_insert')
            return
        endif

        if b:win_ime_con_is_insert == 1
            let b:win_ime_con_is_insert = 0
            execute s:py . ' wic.on_leave()'
        endif
    endfunction
endif

let &cpo = s:save_cpo
unlet s:save_cpo

let g:leaded_winimecon = 1
