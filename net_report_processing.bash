#!/bin/bash

awk '$8 ~ /\/run\/dbus\/system_bus_socket/' net_report
echo -e '\n'

awk '$1 ~ /tcp/' net_report > filter-data

awk '{print $5}' filter-data

sort -t$'\t' -k2 filter-data


line=awk '/Active UNIX domain sockets/{print NR}' net_report
awk 'NR>$line {print$0, $6="*****"}' net_report
