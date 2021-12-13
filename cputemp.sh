#!/bin/bash

z0=$(cat /sys/class/thermal/thermal_zone0/temp)
z1=$(cat /sys/class/thermal/thermal_zone1/temp)
z2=$(cat /sys/class/thermal/thermal_zone2/temp)
z3=$(cat /sys/class/thermal/thermal_zone3/temp)
z4=$(cat /sys/class/thermal/thermal_zone4/temp)

z0=`expr $z0 / 1000`
z1=`expr $z1 / 1000` #Always 20°C on my machine
z2=`expr $z2 / 1000`
z3=`expr $z3 / 1000`
z4=`expr $z4 / 1000`
av=`expr $z0 + $z1 + $z3 + $z4`
av=`expr $av / 4 `

echo "Thermal zone 0: $z0°C"
echo "Thermal zone 1: $z1°C"
echo "Thermal zone 2: $z2°C"
echo "Thermal zone 3: $z3°C"
echo "Thermal zone 4: $z4°C"
echo "Average: $av°C"
