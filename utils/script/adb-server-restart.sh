#!/bin/bash

sudo adb kill-server
sudo adb start-server
adb devices
