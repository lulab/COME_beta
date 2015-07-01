#!/bin/bash
# Print help message if no parameter given
if [ "$#" == 0 ];then
echo "Usage: ./check_gtf.sh input_gtf species
input_file is the transcript.gtf file
species is one of five species: human, mouse, fly, worm and plant
"
exit;
fi
########################	input_parameters
input_file=$1
spe=$2;

awk -F '[;\t]' '{
if($3!="exon"){
print "Error in line "NR"; The gtf file should be delimitated by tab and semicolon; Also, the third column should be \"exon\""
exit;}
if($10!~/ transcript_id/){
print "Error in line "NR"; The gtf file should be delimitated by tab and semicolon; Also, the tenth column should be \" transcript_id XXX\""
exit;}
}'	$input_file

if   [ "$spe"   ==      "human" ];then 
awk -F '[;\t]' '{print $1}'     $input_file     |sort|uniq|awk '{
if($1!="chr1"&&$1!="chr2"&&$1!="chr3"&&$1!="chr4"&&$1!="chr5"&&$1!="chr6"&&$1!="chr7"&&$1!="chr8"&&$1!="chr9"&&$1!="chr10"&&$1!="chr11"&&$1!="chr12"&&$1!="chr13"&&$1!="chr14"&&$1!="chr15"&&$1!="chr16"&&$1!="chr17"&&$1!="chr18"&&$1!="chr19"&&$1!="chr20"&&$1!="chr21"&&$1!="chr22"&&$1!="chrX"&&$1!="chrY"){
print "your file contains chromosome \""$1"\", which is not chr1, chr2, ..., chr22, chrX or chrY";exit}
}'
elif [ "$spe"   ==      "mouse" ];then 
awk -F '[;\t]' '{print $1}'     $input_file     |sort|uniq|awk '{
if($1!="chr1"&&$1!="chr2"&&$1!="chr3"&&$1!="chr4"&&$1!="chr5"&&$1!="chr6"&&$1!="chr7"&&$1!="chr8"&&$1!="chr9"&&$1!="chr10"&&$1!="chr11"&&$1!="chr12"&&$1!="chr13"&&$1!="chr14"&&$1!="chr15"&&$1!="chr16"&&$1!="chr17"&&$1!="chr18"&&$1!="chr19"&&$1!="chrX"&&$1!="chrY"){
print "your file contains chromosome \""$1"\", which is not chr1, chr2, ..., chr19, chrX or chrY";exit}
}'
elif [ "$spe"   ==      "worm"  ];then 
awk -F '[;\t]' '{print $1}'     $input_file     |sort|uniq|awk '{
if($1!="chrI"&&$1!="chrII"&&$1!="chrIII"&&$1!="chrIV"&&$1!="chrV"&&$1!="chrX"){
print "your file contains chromosome \""$1"\", which is not chrI, chrII, chrIII, chrIV, chrV or chrX";exit}
}'
elif [ "$spe"   ==      "fly"   ];then 
awk -F '[;\t]' '{print $1}'     $input_file     |sort|uniq|awk '{
if($1!="chr2L"&&$1!="chr2R"&&$1!="chr3L"&&$1!="chr3R"&&$1!="chr4"&&$1!="chrX"){
print "your file contains chromosome \""$1"\", which is not chr2L, chr2R, chr3L, chr3R, chr4 or chrX";exit}
}'
elif [ "$spe"   ==      "plant" ];then 
awk -F '[;\t]' '{print $1}'     $input_file     |sort|uniq|awk '{
if($1!="chr1"&&$1!="chr2"&&$1!="chr3"&&$1!="chr4"&&$1!="chr5"){
print "your file contains chromosome \""$1"\", which is not chr1, chr2, chr3, chr4 or chr5";exit}
}'
else echo "wrong speices specified, only human mouse fly worm plant are avilable now."; exit;
fi


