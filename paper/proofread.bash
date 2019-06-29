#!/bin/bash

#Check for repeated words
egrep "(\b[a-zA-Z]+) \1\b" sections/*.tex -n
