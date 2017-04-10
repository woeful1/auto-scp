# auto-scp
This is a bash script that copy automatically file from local system to remote system with scp

This script just copy modifed file and new created file to remote server and there is a line you can add what to do when a file is deleted.

If you want to add other event you should see 'man inotifywait event section' and add some code to the script. 

In this script we use ' inotifywait ' command

# install inotifywait :

  `https://github.com/rvoicilas/inotify-tools/wiki`

Before you use this shell script you need to setup SSH for auto login without a password.

In shell script edit line number 4 , 5 , 6 for out server login information :

  `
  USERNAME="<YOUR USERNAME>"
  IP="<YOUR SERVER IP>"
  PORT="<PORT NUMBER IF USE DEFAULT PORT NUMBER LEAVE IT EMPTY>"
  `
  
  # USEAGE :
  
    $ ./auto-scp <LOCAL_DIRECTORY> <REMOTE_DIRECTORY>
  
  # Example :
    
    $ ./auto-scp /var/www/public_html/ /var/www/example.com/
