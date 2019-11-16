###### Installing Miniconda 3 ######
## Get download link with right-click and 'Copy link address' from https://docs.conda.io/en/latest/miniconda.html
## copy paste into bash
  curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
## verify hash using checksum
## the outputted hash number should be the same on on the websit
  md5sum Miniconda3-latest-Linux-x86_64.sh
## download Miniconda3
  bash Miniconda3-latest-Linux-x86_64.sh
## activated base
  source .bashrc
## create new environmnet
  conda create -n env_name
## activate environment
  conda activate env_name
## install channels (order matters)
## check channel order by looking at the .condarc 
  conda config --add channels defaults
  conda config --add channels bioconda
  conda config --add channels conda-forge
## Install Jupyter
## activate appropriate conda environment
  conda install jupyter
## run jupyter
  jupyter


