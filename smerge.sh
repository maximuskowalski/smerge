#!/bin/bash
echo -e "initiating merger sequence alpha"
USER=max #user name goes here
GROUP=max #group name goes here
M_DIR1=/mnt/sharedrives #Base dir,can use wildcard eg /mnt/sharedrives/tv_*
M_DIR2=/mnt/sharedrives #secondary merger dir to merge with dir 1
M_DIR3=/mnt/sharedrives #unused thirdary merger dir
MERGER_DIR=/mnt/mergerfs
# Make Work Dirs
sudo mkdir -p $MERGER_DIR
sudo chown -R $USER:$GROUP $MERGER_DIR
sudo chmod -R 775 $MERGER_DIR
# Create and merger service files
export user=$USER group=$GROUP m_dir1=$M_DIR1 m_dir2=$M_DIR2 m_dir3=$M_DIR3 merger_dir=$MERGER_DIR 
envsubst 'm_dir1,m_dir2,$merger_dir' <./input/smerger.service >./output/smerger.service
#copynewfiles
sudo bash -c 'cp ./output/smerger.service /etc/systemd/system/smerger.service'
# daemon reload
sudo systemctl daemon-reload
# enable and start merger
sudo systemctl enable smerger.service
sudo systemctl start smerger.service
echo "merger setup complete, requires reboot if using non empty paths for merger"
