
# COME --- Calculate COding potential from Multiple Features.

# 0. About COME

COME is a two-level machine-learning method, which uses multiple features of a transcript to predict its coding potential.The first level model is to generate a coding potential landscape, which describes the coding potential fluctuation of bins (100-nt intervals with 50-nt overlap) along the whole genome. The coding potential landscape (CPL) is integrated from multiple features (sequence, structure, expression and histone modification features) of bins. The second level learning model is to predict an input transcript to be a coding transcript or a non-coding transcript based on its overlapped CPL's pattern. 

Since the level 1 learning model integrated lots of features, which is a very complicated process, we pre-calculated the CPL for five model species: human (hg19), mouse (mm10), fly (dm3), worm (ce10) and plant (TAIR10). The known coding and non-coding trasncripts' CPL patterns are also learned and stored in our level 2 models for these species.

# 1. Installation and Requirements

COME requires R(>=2.15.2) and R packages "randomForest" and "rhd5" pre-installed in a linux system.

## COME doesn't need installation.  
First, users need to download the bin folder (which contains source codes and level 2 models) from the github into his working directory.  
Second, users need to download and unzip the CPL files (http://lulab.life.tsinghua.edu.cn/RNAfinder/come/CPL_files.tar.gz). The unzipped files need to be placed in the bin folder under your working directory.

# 2. Usage

    /path/to/COME/bin/folder/COME_all.sh    /path/to/your/transcripts.gtf    /path/to/your/output    /path/to/COME/bin/folder    model_species_name    overlapping_ratio
  

  ### 2.1)  /path/to/COME/bin/folder is the folder where you kept downloaded COME's bin.

  2.2)  /path/to/COME/bin/folder/COME_all.sh is COME's main program script.

  2.3)  /path/to/your/transcripts.gtf is your input gtf file. Should be given with absolute path. The input gtf file should be:
  
  2.3.1)  as the description from "http://genome.ucsc.edu/FAQ/FAQformat.html#format4"
  
  2.3.2)  chromosome names should be in lower and abbreviate case, e.g. (chr1, chrX, etc), except for worm genome, which used roman number: chrI, chrII, chrIII, chrIV, chrX, chrY

  2.4)  /path/to/your/output is a folder that will be created (if the user didn't create it already) to save your output file(s).

  2.5)  model_species_name is one of these five names: human, mouse, fly, worm and plant. It specifies which species' CPL and model files should be used to calculate your input transcripts

  2.6)  overlapping_ratio is the ratio to overlap your input transcript with precalculated coding potential files. Default is 0.5. should be 0.02<=overlapping_ratio<=1
  
  2.7)  An example:

Assuming I download the bin folder in /my/working/directory, and unzipped the downloaded CPL files and moved them into /my/working/directory/bin. I want to predict human transcripts, /my/test/transcript.gtf, the output files should be saved in
/my/output/directory;
  
  The command would be: 
  
    /my/working/directory/bin/COME_all.sh    /my/test/transcript.gtf    /my/output/directory    /my/working/directory/bin    human    0.5



# 3. Citing RNAcode
=================

pubmed DOI...


# 4. Contact
==========

Long Hu <hulongptp@gmail.com>
