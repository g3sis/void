# Defined in - @ line 1
function whoami --wraps='whoami && curl ident.me' --description 'alias whoami whoami && curl ident.me'
 command whoami && curl ident.me $argv;
end
