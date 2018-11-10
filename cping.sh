#!/bin/sh

function p() {
  ping -c 1 $1| sed -n 2p |awk -F'=| ' 'BEGIN{begin=systime()} {value=$10} END{end=systime(); if (value=="") {value=(end-begin)*1000}; print value}';
}

function o() {
  echo $1 $2| awk '{print "ping,host="$1 (" value=" $2)}'
}

while true;
do
  val=`p $SOURCE`
  res=`o $SOURCE $val`
  echo $res |curl -i -XPOST "${INFLUX_PROTOCOL}://${INFLUX_HOST}:${INFLUX_PORT}/write?db=${INFLUX_DB}" --data-binary @-
  sleep 5
done
