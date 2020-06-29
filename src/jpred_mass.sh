#!/bin/bash

echo "Run JPred Batch Script on input multisequence fasta file"

cp data/$1 $1

/home/appuser/prepareInputs.csh $1


/home/appuser/massSubmitScheduler.csh $1_dir

cp -r $1_dir_output data/$1_dir_output
cp -r $1_dir_error data/$1_dir_error
