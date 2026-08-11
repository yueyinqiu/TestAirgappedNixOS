NixFodExporter from-installables output nixpkgs#hello
scp -F /dev/null -r output server@192.168.100.10:/home/server/s
ssh -F /dev/null server@192.168.100.10 "bash /home/server/s/restore.sh"
