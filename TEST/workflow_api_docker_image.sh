docker service update --image git.clearbi.io:3443/clearbi/wf-api:$1 triniti-test_wf --with-registry-auth
docker ps -a
