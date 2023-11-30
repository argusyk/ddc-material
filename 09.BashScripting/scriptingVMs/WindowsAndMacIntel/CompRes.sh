#!/bin/bash

echo "Welcome $USER on $HOSTNAME!"
echo "####################################################"

FREEMEM=$(free -m | grep Mem | awk ' {print $4} ')
LOAD=`uptime | awk '{print $9}'`
ROOTFREE=$(df -h | grep '/dev/sda1' | awk '{print $4}')

echo "####################################################"
echo "Available free RAM is $FREEMEM MB"
echo "####################################################"
echo "Current Load Average is $LOAD"
echo "####################################################"
echo "Free ROOT Partition size is $ROOTFREE"
