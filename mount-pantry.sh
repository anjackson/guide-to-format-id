#!/bin/bash
# Experimenting with mounting remote corpora, doesn't seem to work
mkdir ~/ipres-pantry
rclone mount pantry: ~/ipres-pantry 2>&1 > rclone-mount.log &

