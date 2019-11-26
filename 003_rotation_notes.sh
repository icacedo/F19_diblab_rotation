## November 25, 2019
## for random subsampling, use khmer: https://anaconda.org/bioconda/khmer
## use this script specifically (view on github): khmer/scripts/sample-reads-randomly.py
## created new directory within test_reads/ called random/
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
