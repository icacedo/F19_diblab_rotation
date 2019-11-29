## November 25, 2019
## install khmer in F19_diblab_rotation (~/)
  conda install -c bioconda khmer
## install jupyter lab on your farm account (F19_diblab_rotation environment)
  conda install -c conda-forge jupyterlab
## could not get jupyterlab to connect through my browser
## installed regular jupyter instead
  conda install -c conda-forge jupyter
## nothing was different, so i removed jupyter
  conda remove -c conda-forge jupyter
## it probably won't work because i'm on farm, and i'm trying to open the notebook on my desktop
###########################################################################################################################
## November 27, 2019
## running khmer in the bmm node
  srun -p bmh -J tmp -t 1:00:00 --mem=2000 --pty bash
## check for running jobs
  squeue -u username
## cancel all jobs
  scancel -u username
## created new script to run khmer
  #!/bin/bash

  for file in ~/F19_diblab_rotation/inputs/HSM*
  do
        base=$(basename "$file" .fastq.gz)
        sample-reads-randomly.py -N 1000000 -o ~/F19_diblab_rotation/test_reads/random/$base.random_1mil.fastq.gz --gzip $file
  done
## run an srun session within a screen
  screen 
  srun -p bmm -J tmp -t 72:00:00 --mem=2000 --pty bash
  ./F19_diblab_rotation/scripts/run_khmer.sh
## run plass
## https://lifebit.gitbook.io/cloudos/pipelines-documentations-and-examples-1/docker-pipelines-and-tools/plass
## made new directory ~/F19_diblab_rotation/plass_assembly/
## made script to run plass ~/F19_diblab_rotation/scripts/run_plass.sh
  #!/bin/bash
  for file in ~/F19_diblab_rotation/test_reads/random/*R1*
  do
          file1=$file
          file2=`echo $file1 | awk -F"R1" '{print $1 "R2" $2}'`
          base=`echo $file1 | sed -e 's/_R1//' | sed -e 's/.fastq.gz//'`
          plass assemble $file1 $file2 ~/F19_diblab_rotation/plass_assembly/$base.assembly.fas tmp
  done
## run plass 
  screen
  srun -p bmm -J tmp -t 72:00:00 --mem=2000 --pty bash
  conda activate F19_diblab_rotation
  chmod 755 ./run_plass.sh
  ./run_plass.sh

  
