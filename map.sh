#!/bin/bash
# Print help message if no parameter given
if [ "$#" == 0 ];then
echo "Usage: ./run.sh input_file output_dir  RATIO output_file
input_file is the transcript.gtf file
output_dir would save all the results we generate
RATIO is the ratio mapped to a 50nt bin, should be [0.02,1.00];
"
exit;
fi
########################	input_parameters
input_file=$1
output_dir=$2
RATIO=$3
output_file=$4

########################	pre-defined parameters
 file=${input_file##*/};

  if [ `expr "$RATIO" ">" "1.00"` -eq "1"	]; then echo "too big ratio, resetting ratio to 1;"; 		RATIO=1;
elif [ `expr "$RATIO" "<" "0.02"` -eq "1"	]; then echo "too small ratio, resetting ratio to 0.02;"; 	RATIO=0.02;
fi

########################	step1: overlap with bins
[[ -d $output_dir/$file ]] || mkdir -p $output_dir/$file;
awk -F '[;\t]' '{print $1"\t"$4"\t"$5"\t"$7"\t"$10}'	$input_file	>	$output_dir/$file/$file.foo1;
####	assign index: like intersectBed -f 0.9
rm -f $output_dir/$file/$file.foo1.* 
C1=`echo ""|awk -v RATIO="$RATIO" '{print int(50*RATIO)}'`;
C2=`echo ""|awk -v RATIO="$RATIO" '{print 51-int(50*RATIO)}'`;
C3=`echo ""|awk -v RATIO="$RATIO" '{print int(50*RATIO)-1}'`;
awk -F '\t' -v C1="$C1" -v C2="$C2" -v C3="$C3" -v my_prefix1="$output_dir/$file/$file.foo1" '{	
if($3-$2+1 >= C1){
	N1=int($2/50)+1;	n1=$2%50;	if(n1	>	C2	){N1=N1+1;}
	N2=int($3/50)+1;	n2=$3%50;	if(n2	<	C3	){N2=N2-1;}
	foo2=N1;	for(i=N1+1;i<=N2;i++){foo2=foo2","i};
	if(N2>=N1){
		print	$5"\t"foo2	>>	my_prefix1"."$1"."$4;
	}
}
}'	$output_dir/$file/$file.foo1
ls	$output_dir/$file/$file.foo1.*.+	$output_dir/$file/$file.foo1.*.-	>	$output_dir/$file/$file.filelist;
for i in `cat $output_dir/$file/$file.filelist`; do j=${i##$output_dir/$file/$file.foo1.}; 
awk -F '\t' '{if(NR==1){foo=$1;foo1=$2;}else{if($1==foo){foo1=(foo1","$2);}else{print foo"\t"foo1;foo=$1;foo1=$2;}}
}END{print foo"\t"foo1}'	$i	>	$output_dir/$file/$file.foo2.$j;
done
ls 	$output_dir/$file/$file.foo2.*.+	$output_dir/$file/$file.foo2.*.-	>	$output_file;



