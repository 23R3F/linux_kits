#!/usr/bin/expect 

set path [lindex $argv 0 ]
set respository [lindex $argv 1 ]
set username [lindex $argv 2 ]
set timeout 3 

spawn ssh -T git@github.com
expect{
	"*successfully*"{

	}
	timeout {
		
	}
}