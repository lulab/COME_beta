#!/bin/bash
# Print help message if no parameter given
if [ "$#" == 0 ];then
echo "Usage: ./COME_all.sh input_file output_dir bin_dir species
/path/to/COME/bin/folder/COME_all.sh    /path/to/your/transcripts.gtf    /path/to/your/output    /path/to/COME/bin/folder    model_species_name
/path/to/your/transcripts.gtf is the transcript.gtf file with absolute path
/path/to/your/output is the folder that all the results generated would be saved
/path/to/COME/bin/folder contains our software
model_species_name should be one of these terms: human mouse fly worm plant;
"
exit;
fi
########################	input_parameters
input_file=$1
output_dir=$2
bin_dir=$3
spe=$4

file=${input_file##*/};

if   [ "$spe"   ==      "human" ];then CUTOFF=0.533;Model=$bin_dir/human.all.models;	CPL=$bin_dir/human.CPL;
elif [ "$spe"   ==      "mouse" ];then CUTOFF=0.575;Model=$bin_dir/mouse.all.models;	CPL=$bin_dir/mouse.CPL;
elif [ "$spe"   ==      "worm"  ];then CUTOFF=0.537;Model=$bin_dir/worm.all.models;	CPL=$bin_dir/worm.CPL;
elif [ "$spe"   ==      "fly"   ];then CUTOFF=0.489;Model=$bin_dir/fly.all.models;	CPL=$bin_dir/fly.CPL;
elif [ "$spe"   ==      "plant" ];then CUTOFF=0.716;Model=$bin_dir/plant.all.models;	CPL=$bin_dir/plant.CPL;
else echo "wrong speices specified, only human mouse fly worm plant are avilable now."; exit;
fi

###	overlapping
bash	$bin_dir/map.sh 	$input_file	$output_dir  	$output_dir/$file/$file.filelist2;
####	predicting
Rscript	$bin_dir/COME_all.R	$CPL		$output_dir/$file/$file.filelist2	$Model	$output_dir/$file/$file.foo3;

########################	predict coding potential and assign prediction labels
echo -e "transcriptID\tcoding_potential\tprediction"												>	$output_dir/$file.output;
awk -F '\t' -v cutoff="$CUTOFF" '{if($2>=cutoff){print $1"\t"$2"\tcoding"}else{print $1"\t"$2"\tnoncoding"}}'	$output_dir/$file/$file.foo3	>>	$output_dir/$file.output;
####	clean
! [[ -d $output_dir/$file ]] || rm -r -f $output_dir/$file;




