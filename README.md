
# COME --- calculate COding potential from Multiple Features.

# 0. About COME

COME is a two-level machine-learning method, which uses multiple features of a transcript to predict its coding potential.The first level model is to generate a coding potential landscape, which describes the coding potential fluctuation of bins (100-nt intervals with 50-nt overlap) along the whole genome. The coding potential landscape (CPL) is integrated from multiple features (sequence, structure, expression and histone modification features) of bins. The second level learning model is to predict an input transcript to be a coding transcript or a non-coding transcript based on its overlapped CPL's pattern. 

Since the level 1 learning model integrated lots of features, which is a very complicated process, we pre-calculated the CPL for five model species: human (hg19), mouse (mm10), fly (dm3), worm (ce10) and plant (TAIR10). The known coding and non-coding trasncripts' CPL patterns are also learned and stored in our level 2 models for these species.

COME also is avaliable as a [webserver](http://RNAfinder.ncrnalab.org/COME)  

# 1. Installation and Requirements

COME requires R(>=2.15.2) and R packages "randomForest" and "rhd5" pre-installed in a linux system.

#### COME doesn't need installation.    
1. users need to download the [scripts and models](https://github.com/rnaseqsucks/COME_test2) (which contains source codes and level 2 models) from the github into his working directory. Make sure all the files are in one folder, hereafter, we name this folder the _bin folder_.    
2. Second, users need to download and unzip the [CPL files](http://lulab.life.tsinghua.edu.cn/RNAfinder/come/CPL_files.tar.gz). The unzipped files need to be placed in the bin folder under your working directory.

# 2. Usage

    /path/to/COME/bin/folder/COME_all.sh    /path/to/your/transcripts.gtf    /path/to/your/output    /path/to/COME/bin/folder    model_species_name    overlapping_ratio
  
_____
* _/path/to/COME/bin/folder_                is the folder where you kept downloaded COME's scripts and models, namely, the _bin folder_.

* _/path/to/COME/bin/folder/COME_all.sh_    is COME's main program script.

* _/path/to/your/transcripts.gtf_           is your input gtf file. Should be given with absolute path. The input gtf file should be:    
  * as the description of ucsc's [gtf format](http://genome.ucsc.edu/FAQ/FAQformat.html#format4)     
  * chromosome names should be in lower and abbreviate case, e.g. (chr1, chrX, etc), except for worm genome, which used roman number: chrI, chrII, chrIII, chrIV, chrX, chrY

* _/path/to/your/output_                    is a folder that will be created (if the user didn't create it already) to save your output file(s).

* _model_species_name_                      is one of these five names: human, mouse, fly, worm and plant. It specifies which species' CPL and model files should be applied to your calculation

* _overlapping_ratio_                       is the ratio to overlap your input transcript with precalculated coding potential files. Default is 0.5. should be 0.02<=overlapping_ratio<=1
______  

#### An example:

Assuming I download the [scripts and models](https://github.com/rnaseqsucks/COME_test2) into _/my/working/directory/bin_, and unzipped the downloaded CPL files and moved them into _/my/working/directory/bin_. I want to predict human transcripts, _/my/test/transcript.gtf_, the output files should be saved in _/my/output/directory_;  
The command would be: 
  
    /my/working/directory/bin/COME_all.sh    /my/test/transcript.gtf    /my/output/directory    /my/working/directory/bin    human    0.5



# 3. Citing RNAcode
=================

pubmed DOI...


# 4. Contact
==========

Long Hu <hulongptp@gmail.com>
