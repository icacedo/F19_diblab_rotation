## December 3, 2019
## HMMER
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







## pfam accesion numbers: PF00583.19, PF00144.19, PF00893.14
