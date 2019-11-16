###### Using the Farm cluster ######
## use history to view everything you previously input
  history
## always activate the appropriate conda environment
## log in and provide your private key
  ssh -i ~/path_to_keyfile icacedo@farm.cse.ucdavis.edu
## installed miniconda on farm
  curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
  md5sum Miniconda3-latest-Linux-x86_64.sh
  bash Miniconda3-latest-MacOSX-x86_64.sh
  source .bashrc
  conda create -n F19_diblab_rotation
  conda activate F19_diblab_rotation
  conda config --add channels defaults
  conda config --add channels bioconda
  conda config --add channels conda-forge
## set up file system and move into raw/
  mkdir F19_diblab_rotation/
  cd F19_diblab_rotation/
  mkdir inputs/
  cd inputs/
  mkdir raw/
  cd raw/
## download raw data to raw/
## exit out of head node
  exit
## log into transfer node
## use this node to download files
  ssh -p 2022 -i ~/path_to_keyfile icacedo@farm.cse.ucdavis.edu
## cd into raw/
  cd F19_diblab_rotation/inputs/raw/
## dowload raw data (in a screen)
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM6XRQB.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM6XRQI.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM6XRQK.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM6XRQM.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM6XRQO.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM67VF9.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM67VFD.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM67VFJ.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM7CYY7.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM7CYYD.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM7CYY9.tar
  wget https://ibdmdb.org/tunnel/static/HMP2/WGS/1818/HSM7CYYB.tar

###### Notes on using Farm ######
## When you log in with ssh, you log in to the head node
## The head node is connected to a scheduler, which is connected to more computers (nodes)
## To get from the head node to other nodes, run:
## 1. screen
## 2. srun
## srun can be run with:
## 1. node priority 
## .bmh ('high' do not use this node, you will boot people off, use if 72 hr, 16 gb, 4 cpu, anymore than this and you can't use this node)
## .bmm ('mid')
## specify node priority with -p
## specify cpu usage -c
## specify time -t
## format for time: 72:00:00 (72 hours)
## specify memory usage --mem
## specify the language --pty
## name the session -J
## show jobs that are running
  squeue -u username
## example 
## once in the node, they run your stuff
  srun -p bmh -J tmp -t 1:00:00 --mem=2000 --pty bash
