#!/bin/zsh

backup_main_folder=${1}
backup_name=$(date +%Y%m%d-%H%M)
backup_folder="${backup_main_folder}/${backup_name}"
echo ${backup_folder}

mkdir -p ${backup_folder}

rsync --archive --verbose --itemize-changes \
    --link-dest=${backup_main_folder}/current \
    /home/noud/{documents,work,nowork,Dropbox} ${backup_folder}/ \
    | tee ${backup_main_folder}/backup-${backup_name}.log

chown noud:noud ${backup_main_folder}/backup-${backup_name}.log
chown -R noud:noud ${backup_folder}

rm ${backup_main_folder}/current
ln -s ${backup_folder} ${backup_main_folder}/current
chown noud:noud ${backup_main_folder}/current
