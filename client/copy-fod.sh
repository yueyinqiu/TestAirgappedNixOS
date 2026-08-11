scp -F /dev/null -r fod server@192.168.100.10:/home/server/fod
ssh -F /dev/null server@192.168.100.10 "bash /home/server/fod/store.sh"