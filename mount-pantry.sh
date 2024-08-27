#!/bin/bash
mkdir ~/ipres-pantry
rclone mount pantry: ~/ipres-pantry 2>&1 > rclone-mount.log &

