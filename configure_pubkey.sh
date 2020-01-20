#!/usr/bin/expect 

set email [lindex $argv 0 ]
set key_path [lindex $argv 1 ]


# spawn rm "${key_path}"
spawn ssh-keygen -t rsa -C $email

expect "*save the key*" 
send "${key_path}\n";
expect "*passphrase)*"
send "\n";
expect "*again:*"
send "\n";
expect eof
exit
