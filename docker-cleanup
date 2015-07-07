#!/bin/sh

>/tmp/run_image_ids.$$

DOCKER_BIN=/usr/bin/docker
LOG=/var/log/docker-cleanup.log

rm /tmp/run_image_ids.$$

echo "$(date) start-----" >>$LOG

$DOCKER_BIN ps --no-trunc -a -q | while read cid
do
  running=$($DOCKER_BIN inspect -f '{{.State.Running}}' $cid )
  if [ "$running"x = "true"x ]
  then
    id=$($DOCKER_BIN inspect -f '{{.Image}}' $cid )
    echo $id >>/tmp/run_image_ids.$$
    continue
  fi 
  fini=$($DOCKER_BIN inspect -f '{{.State.FinishedAt}}' $cid | awk -F. '{print $1}')
  diff=$(expr $(date +"%s") - $(date --date="$fini" +"%s"))    
  #for MacOs 
  #diff=$(expr $(date +"%s") - $(date -j -f %Y-%m-%dT%H:%M:%S "$fini" +"%s"))
  if [ $diff -gt 86400 ]
  then
     $DOCKER_BIN rm -v $cid >>$LOG 2>&1
  fi 
done


$DOCKER_BIN images --no-trunc | grep -v REPOSITORY | while read line
do
  repo_tag=$(echo $line | awk '{print $1":"$2}')
  image_id=$(echo $line | awk '{print $3}')
  grep -q $image_id /tmp/run_image_ids.$$
  if [ $? -eq 0 ]
  then
    continue
  fi
  if [ "$repo_tag"x = "<none>:<none>"x ]
  then
    $DOCKER_BIN rmi $image_id >>$LOG 2>&1
  else
    $DOCKER_BIN rmi $repo_tag >>$LOG 2>&1
  fi
done

rm /tmp/run_image_ids.$$


echo "$(date) end-----" >>$LOG
