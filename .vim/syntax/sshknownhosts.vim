setlocal iskeyword=@,48-57,_,192-255,#,-

syntax match sshknownhostspubkey "AAAA[0-9a-zA-Z+/]\+[=]\{0,2}"
highlight def link sshknownhostspubkey Special

syn keyword sshalg ssh-rsa
hi def link sshalg Identifier

syn keyword sshalg ssh-ed25519
hi def link sshalg Identifier

syn match sshknownhostsip "\<\(\d\{1,3}\.\)\{3}\d\{1,3}\>"
hi def link sshknownhostsip Constant
