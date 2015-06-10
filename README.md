# COME_test2
COME --- Calculate coding potential for transcripts.

0. About COME
=============

COME is a two-level machine-learning method, which uses multiple features of a transcript to predict its coding potential.The first level model is to generate a coding potential landscape, which describes the coding potential fluctuation of bins (100-nt intervals with 50-nt overlap) along the whole genome. The coding potential landscape (CPL) is integrated from multiple features (sequence, structure, expression and histone modification features) of bins. The second level learning model is to predict an input transcript to be a coding transcript or a non-coding transcript based on its overlapped CPL's pattern. 

Since the level 1 learning model integrated lots of features, which is a very complicated process, we pre-calculated the CPL for five model species: human (hg19), mouse (mm10), fly (dm3), worm (ce10) and plant (TAIR10). The known coding and non-coding trasncripts' CPL patterns are also learned and stored in our level 2 models for these species.

1. Installation and Requirements
===============

COME requires R(>=2.15.2) and its package "randomForest" and "rhd5" pre-installed in a linux system.

COME doesn't need installation. 
  First, users need to download the bin folder (which contains source codes and level 2 models) from the github into his working directory. 
  Second, users need to download and unzip the CPL files (http://lulab.life.tsinghua.edu.cn/RNAfinder/come/CPL_files.tar.gz). The unzipped files need to be placed in the bin folder under your working directory.











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
