#!/bin/sh
source_directory_path=
bucket=
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=


function unzip_all {
    echo 'unzipping zipped files..'
    while [ "`find . -type f -name '*.zip' | wc -l`" -gt 0 ]; do find -type f -name "*.zip" -exec unzip -- '{}' \; -exec rm -- '{}' \;; done
}

function move_files {
    echo 'extracting files...'
    find . -mindepth 2 -type f -print -exec mv {} . \;
}

function upload_to_bucket {
    echo 'start uploading ..'
    aws s3 cp --recursive $source_directory_path s3://$bucket/initial_load
}

cd $source_directory_path
unzip_all
move_files
upload_to_bucket
