#!/bin/sh

# Forward docker shutdown signals to process
pid=
trap "echo SIGINT; [[ $pid ]] && kill -INT $pid" SIGINT
trap "echo SIGTERM; [[ $pid ]] && kill -TERM $pid" SIGTERM

# Pipe in password from env variable
echo ${PASSWORD} | openconnect --protocol=${PROTOCOL} --server=${SERVER} --user=${USER} --passwd-on-stdin & pid=$! 

# Wait on process
wait $pid
