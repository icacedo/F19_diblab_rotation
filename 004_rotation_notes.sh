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
## run hmmbuild and hmmpress in same script: scripts/hmm_scripts/build_press.sh
  #!/bin/bash
  path=~/F19_diblab_rotation/hmm
  for file in $path/alignments/*sto
  do
          base=$(basename $file .sto)
          hmmbuild $path/build_press/$base.hmm $file
          hmmpress $path/build_press/$base.hmm
  done
## script for hmmscan: scripts/hmm_scripts/scan.sh
  #!/bin/bash
  path=~/F19_diblab_rotation/hmm
  for i in $path/build_press/*.hmm
  do
          for j in $path/clean_fas_files/*.fa
          do
                  base1=$(basename $i .hmm)
                  base2=$(basename $j .plass.nostop.cdhit.uniq_headers.fa)
                  hmmscan -T 100 -o $path/scanned/"$base1"_"$base2".out --tblout $path/scanned/"$base1"_"$base2".tbl --domtblout $path/scanned/"$base1"_"$base2".dom $i $j        done
  done
## the pfam accesion numbers did not get anything with the million read subsetted files: PF00583.19, PF00144.19, PF00893.14
## try new families for tetracycline ribosomal protection proteins, rRNA methyltransferases
  for i in PF00583 PF00144 PF00893 PF00679 PF14492 PF03764 PF00009 PF07091 PF00398; do curl -o $i.sto https://pfam.xfam.org/family/$i/alignment/full; done
