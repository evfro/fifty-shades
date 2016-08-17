# Fifty Shades of Ratings: How to Benefit from a Negative Feedback in Top-N Recommendations Tasks
This is a *"fixed state"* version of the code from [Polara framework](https://github.com/evfro/polara), that can be used to fully reproduce the work described in our paper. See [**Example_ML1M.ipynb**](Example_ML1M.ipynb) for an exact experiment workflow. You're also welcome to explore other jupyter notebooks for more experimental results or check out our online demo at http://coremodel.azurewebsites.net.

## [NEW] Run code online with binder
A quick way to reproduce results without any installation hassle:

[![Binder](http://mybinder.org/badge.svg)](http://mybinder.org:/repo/evfro/fifty-shades)

## Get your own copy to run offline
No installation is required. Simply get a copy of this code and unpack it somewhere on your PC.

### Prerequisites
The recommended way to setup a working python environment is to use Anaconda distribution https://www.continuum.io/downloads. However, you may create your own environment with the following packages:

* Python 2.7
* Pandas
* Numpy
* Scipy
* Matplotlib
* Numba
* Seaborn
* Requests
* Jupyter Notebook
* MKL [Optional]

## MyMediaLite support
We provide python wrapper for [MyMediaLite](http://www.mymedialite.net) (MML) library with additional functionality for quick online recommendations. Note, that fixed version of MML (v. 3.11) is already included into repository (this ensures reproducibility of the results). If you encounter any problems running MML binaries, ensure that [Mono](http://www.mono-project.com/) is supported by your system. You may find additional help by visiting MML [Google Group](https://groups.google.com/forum/#!forum/mymedialite) or [Github Issues](https://github.com/zenogantner/MyMediaLite/issues/) page.

## OS support
The code was tested on both Windows and Linux. Can possibly run on OSX however this was not tested yet.

## Isolated environment
It may be a good idea to create an isolated conda environment for experimentation.
```
conda create -n shades python=2.7 pandas matplotlib numpy scipy numba mkl jupyter seaborn requests
```
Activate newly created `shades` with eithr `source activate shades` (Linux) or `activate shades` (Windows), navigate to the unpacked folder in your shell and run jupyter notebook:
```
jupyter notebook
```
