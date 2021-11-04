require('vis')

vis:command('map! normal j gj')
vis:command('map! normal k gk')

vis:command('map! normal gh 0')
vis:command('map! normal gl $')

vis:command('map! insert <C-l> <Right>')
vis:command('map! insert <C-h> <Left>')
vis:command('map! insert <C-j> <Down>')
vis:command('map! insert <C-k> <Up>')

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    vis:command('set theme seti')
    vis:command('set autoindent on')
    vis:command('set cursorline')
    vis:command('set expandtab on')
    vis:command('set tabwidth 2')
end)
