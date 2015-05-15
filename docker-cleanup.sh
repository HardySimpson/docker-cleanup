#!/bin/sh

docker ps --no-trunc -a -q | while read cid
do
  running=$(docker inspect -f '{{.State.Running}}' $cid )
  if [ "$running"=="true" ]
  then
    continue
  fi 
  fini=$(docker inspect -f '{{.State.FinishedAt}}' $cid | awk -F. '{print $1}')
  diff=$(expr $(date +"%s") - $(date --date="$fini" +"%s"))    
  echo $diff
  if [ $diff -gt 86400 ]
  then
     docker rm -v $cid
  fi 
done


docker images --no-trunc | grep -v REPOSITORY | while read line
do
  repo_tag=$(echo $line | awk '{print $1":"$2}')
  image_id=$(echo $line | awk '{print $3}')
  if [ "$repo_tag"=="<none>:<none>" ]
  then
    docker rmi $image_id
  else
    docker rmi $repo_tag
  fi
done
