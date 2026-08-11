rsync -avzP -e "ssh -F /dev/null" /home/client/fod server@192.168.100.10:/home/server/
ssh -F /dev/null server@192.168.100.10 "cd /home/server/fod && bash ./store.sh"