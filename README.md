# COME_test2
my test version 2 of COME software

COME is designed to calculate COding potential from Multiple fEatures for transcripts. The ariticle is published in "XXX"

COME accectps a gtf-format file as input, predicts the input transcripts as either coding ones or non-coding ones. In brief, COME builds two models. The level 1 learning model is to integrate multiple features (sequence, structure, expression and histone modification features) into a one score---the coding potential landscape. The leve 2 learning model is to overlap the input transcript with the coding potential landscape and predict it to be a coding transcript or a non-coding transcript. Since the level 1 learning model integrated lots of features, which is a very complicated process, we pre-calculated the coding potential landscape for five model species: human (hg19), mouse (mm10), fly (dm3), worm (ce10) and plant (TAIR10). We also included the level 2 models for these species.

Requriements: Linux based system, R(>=2.15.2) and its package "randomForest" and "rhd5", awk (should be pre-installed for almost all linux systems)

To use COME, users need to download the bin folder into his working directory. Then the user needs to type in these commands:

  /path/to/COME/bin/folder/COME_all.sh /path/to/your/transcripts.gtf  /path/to/your/output  /path/to/COME/bin/folder  model_species_name   overlapping_ratio
  
Here I explain aach item in the command line: 

  1)  /path/to/COME/bin/folder is the folder that you kept downloaded COME's bin.

  2)  /path/to/COME/bin/folder/COME_all.sh is COME's main program.

  3)  /path/to/your/transcripts.gtf is your input gtf file. Better to be given with full-path names.

  4)  /path/to/your/output is a folder that will be created (if the user didn't create it already) to save your output file.

  5)  model_species_name is allowed for now only one of these five names: human, mouse, fly, worm and plant.

  6)  overlapping_ratio is the ratio to overlap your input transcript with precalculated coding potential files. Default is 0.5. should be 0.02<=overlapping_ratio<=1
  
An example:

  if you download COME to /user/woring/directory

  your input transcript file is /user/transcripts/file.gtf, and it's part of human's trancriptome.

  you would like to save your output to this folder: /user/assigned/output/folder

  The command would be: 
  
  /user/woring/directory/COME_all.sh /user/transcripts/file.gtf  /user/assigned/output/folder  /user/woring/directory human 0.5

The input gtf file should be:

  1)  as the description from "http://genome.ucsc.edu/FAQ/FAQformat.html#format4"

  2)  chromosome names should be in lower and abbreviate case, e.g. (chr1, chrX, etc), except for worm genome, which used roman number: chrI, chrII, chrIII, chrIV, chrX, chrY
