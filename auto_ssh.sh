#!/usr/bin/expect 


set ip [lindex $argv 0 ]
set username [lindex $argv 1 ]
set mypassword [lindex $argv 2 ]
set timeout 10
 
spawn ssh $username@$ip
expect { 
"*yes/no" { send "yes\r"; exp_continue}
"*password:" { send "$mypassword\r" }
} 
interact