#!/usr/bin/expect 

set path [lindex $argv 0 ]
set respository [lindex $argv 1 ]
<<<<<<< HEAD
set username [lindex $argv 2 ]
set timeout 3 

spawn ssh -T git@github.com
expect{
	"*successfully*"{

	}
	timeout {
		
	}
}
=======
set username [lindex $argv 2 ]
>>>>>>> 38a94af5892e04c79d488f1112a4c107cfe41abf
