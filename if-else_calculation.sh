#!/bin/bash
echo "Enter a number:"
read number

if [ $number -gt 20 ]; then
	echo "Your number is greater then 20"
else
	echo "Your number is smaller then 20"
fi
