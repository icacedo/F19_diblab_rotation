## December 3, 2019
## stuff for HMMMER
## scripts adapted from taylor's snakemake code
## convert everything into bash
## remove stops (*) from plass .fas sequences
## https://raw.githubusercontent.com/spacegraphcats/2018-paper-spacegraphcats/f9fe8e8d477173f7e72ca497ed72728af8882a8a/pipeline-base/scripts/remove-stop-plass.py
## created new directories 
  mkdir ~/F19_diblab_rotation/scripts/hmm_scripts/
  mkdir ~/F19_diblab_rotation/hmm/
  mkdir ~/F19_diblab_rotation/hmm/nostop_fas_files/
## put remove-stop-plass.py in a script under ~/F19_diblab_rotation/scripts/hmm_scripts/nostop.sh 
  #!/bin/bash
  path=~/F19_diblab_rotation
  for file in $path/plass_assembly/*.assembly.fas
  do
          $path/scripts/remove-stop-plass.py $file
          mv $path/plass_assembly/*nostop* $path/hmm/nostop_fas_files/
  done
## remove redundant sequences with cd-hit
## ~/F19_diblab_rotation/scripts/hmm_scripts/cdhit.sh
  #!/bin/bash
  path=~/F19_diblab_rotation/hmm
  for file in $path/nostop_fas_files/*
  do
          base="$(basename $file .assembly.fas.nostop.fa)"
          cd-hit -c 1 -i $file -o $path/cdhit_fas_files/$base.plass.cdhit.fa
  done
## rename plass headers to make them all unique in hmmm_scripts/rename_headers.sh
  #!/bin/bash
  for file in ~/F19_diblab_rotation/hmm/cdhit_fas_files/*.fa
  do
          base="$(basename $file .plass.cdhit.fa)"
          # cut out string after first space in header
          cut -d ' ' -f1 $file > tmp.fa
          # add (_1, _2, _n) to duplicate headers
          awk '(/^>/ && s[$0]++){{$0=$0"_"s[$0]}}1;' tmp.fa > ~/F19_diblab_rotation/hmm/clean_fas_files/$base.plass.nostop.cdhit.uniq_headers.fa
          rm tmp.fa
  done
## build HMM profile
## reference page 20: http://eddylab.org/software/hmmer3/3.1b2/Userguide.pdf
## download alignments in Stockholm format to hmm/alignments/
## options for curl: https://curl.haxx.se/docs/manpage.html#-O
  # log out and log into the transfer node
  ssh -p 2022 -i ssh/2019-11-15-farm icacedo@farm.cse.ucdavis.edu
  screen
  curl -o PF00583.sto https://pfam.xfam.org/family/PF00583/alignment/full
  curl -o PF00144.sto https://pfam.xfam.org/family/PF00144/alignment/full
  curl -o PF00893.sto https://pfam.xfam.org/family/PF00893/alignment/full
## hmmbuild.sh
  hmmbuild .hmm .sto
## hmmpress.sh
  hmmpress .hmm
  hmmscan db.hmm input.fa
## using  nested for loop




## pfam accesion numbers: PF00583.19, PF00144.19, PF00893.14
