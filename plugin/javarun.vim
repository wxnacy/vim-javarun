python << EOF
import os
import vim
import json
import commands
import sys
def run():
    filename = vim.current.buffer
    filename = str(filename)
    filename = filename.split(' ')[1][0:-1]
    if 'src/' in filename:
        filename = filename[4:]
    if '.java' in filename:
        filename = filename[0:-5]
    project_root = os.getcwd()
    cmd = 'javarun {} {}'.format(project_root, filename)
    s, msg = commands.getstatusoutput(cmd)
    show_list = msg.split('\n')

    def _fmt(o):
        o = o.strip()
        item = dict(text=o)
        return item
    show_list = [_fmt(o) for o in show_list]
 

    vim.command('call setqflist({}, "r")'.format(json.dumps(show_list)))
    vim.command(':copen 35')
EOF

function! JavaRun()
    exec('py run()')
endfunction
nnoremap <leader>rj :call JavaRun()<cr>
