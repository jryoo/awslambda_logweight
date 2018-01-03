#!/bin/bash

### This file installs all required dependencies


while read p; do
  pip install $p -t .
done <requirements.txt