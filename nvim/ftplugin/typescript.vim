"let oldomni = omnifunc
"function! typescript#Complete(findstart, base) " {{{
"python << ENDPYTHON

"import vim
"from padawan import client

"findstart = vim.eval('a:findstart')
"column = vim.eval("col('.')")
"if findstart == '1':
    "line = vim.eval("getline('.')")
    "def findColumn(column, line):
        "column = int(column)
        "if not type(column) is int:
            "return 0
        "if not type(line) is str:
            "return 0
        "curColumn = column - 1
        "while curColumn > 0:
            "curChar = line[curColumn-1]
            "if curChar == ' ':
                "return curColumn
            "if curChar == '\\':
                "return curColumn
            "if curChar == '$':
                "return curColumn
            "if curChar == ';':
                "return curColumn
            "if curChar == '=':
                "return curColumn
            "if curChar == '(':
                "return curColumn
            "curChar = line[(curColumn-2):curColumn]
            "if curChar == '->':
                "return curColumn
            "if curChar == '::':
                "return curColumn
            "curColumn -= 1
        "return 0
    "vim.command('return {0}'.format(findColumn(column, line)))
"else:
    "line = vim.eval('line(\'.\')')
    "filepath = vim.eval('expand(\'%:p\')')
    "contents = "\n".join(vim.current.buffer)
    "completions = client.GetCompletion(filepath, line, column, contents)
    "completions = [
        "{
        "'word': completion["name"].encode("ascii") if completion["name"] else '',
        "'abbr': completion["menu"].encode("ascii") if completion["menu"] else '',
        "'info': completion["description"].encode("ascii") if completion["description"] else '',
        "'menu': completion["signature"].encode('ascii') if completion["signature"] else ''
        "}
        "for completion in completions["completion"]
    "]
    "vim.command(("let completions = %s" % completions).replace('\\\\', '\\'))
"ENDPYTHON
    "return completions
"endfunction
