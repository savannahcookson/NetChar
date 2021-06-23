# Welcome to NetChar!

NetChar is a developing package of functions I have used in my network analyses to process and format correlation matrices for subsequent analysis using the SVINet package by Prem Gopalan (https://github.com/premgopalan/svinet). 

## API

binarizeMat: converts a weighted matrix to a binary unweighted matrix in which all nonzero values are converted to 1.

corrMatConcat: wrapper function that extracts the correlation matrices for each of a set of specified subjects and concatenates them into a 3-dimensional matrix, in which the subjects are represented along the 3rd dimension. Also determines which ROIs were lost across all subjects.
* Dependencies: 
	* fillMissingROIs

fillMissingROIs: Expects z-scored correlation output from AFNIs 3dNetCorr. Takes in the output .ncc, pulls the z-scored version of the correlation matrix, and determines which ROIs were cut from the correlation. 

getNetDist: Extracts the distribution of network membership for a given ROI based on the output of the SVINet

subAvg: Averages the 3-dimensional correlation matrix along the subject dimension to provide a weighted average correlation matrix for the group

sviformat: formats a processed matrix into the format required for SVINet

SVIPreproc: runs a preset wrapper function to produce a triangular binarized matrix threshold to a specified level and then formats it for SVINet
* Dependencies:
	* subAvg
	* zeroDiag
	* zeroNegs
	* thresholdMat
	* binarizeMat
	* sviformat

thresholdMat: triangulates a matrix and thresholds the top values according to a given percentage

zeroDiag: zeroes out the diagonal of a matrix

zeroNegs: zeroes out negative values in the matrix
