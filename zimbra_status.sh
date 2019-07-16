#!/bin/bash

tail=/usr/bin/tail

if [[ -z "$1" ]]; then
  exit 1
fi

zimbra_log_file="/var/log/zimbra-stats.log"
zimbra_discovery="$(su zimbra -c "/opt/zimbra/bin/zmcontrol status" | awk {'print $1'} | grep -v Host)"

case "$1" in
  discovery)
    declare -a services
    n=0
    for i in $zimbra_discovery ; do
      services[$n]="$i"
      let "n= $n + 1"
    done

    length=${#services[@]}
    echo "{"
    echo -e "\"data\":[\n"
    for (( i=0; i<${length}; i++ ))
    do
      if [ $(( $i + 1 )) -lt $length ]; then
        echo -e "\t{ \"{#ZIMBRASERVICE}\":\"${services[$i]}\" },"
      else
        echo -e "\t{ \"{#ZIMBRASERVICE}\":\"${services[$i]}\" }"
      fi
    done
    echo -e "\n\t]\n"
    echo "}"
  exit 0;
  ;;
  *)

  if [ $1 = "" ]; then
    echo "ERROR: argument required"
    exit 1
  fi

  state="$(tail -n 1000 $zimbra_log_file | grep STATUS | grep $1 | tail -1 | awk {'print $12'})"

  if [ "$state" == "Running" ]; then
    echo 1
  else
    echo 0
  fi
  ;;
esac

exit 0;