# Welcome to NetChar!

NetChar is a developing package of functions I have used in my network analyses to process and format correlation matrices for subsequent analysis using the SVINet package by Prem Gopalan (https://github.com/premgopalan/svinet). 

## API

### Entropy Analysis

runEntropy: Wrapper that sets up entropy analysis for a given set of regions assigned to a set of communities via the SVInet package

relativeEntropy: Calculates relative entropy of specified regions across communities relative to uniform assignment or other specified distribution using Kullback\_Leibler divergence method. 

### Matrix Processing

binarizeMat: converts a weighted matrix to a binary unweighted matrix in which all nonzero values are converted to 1.

corrMatConcat: wrapper function that extracts the correlation matrices for each of a set of specified subjects and concatenates them into a 3-dimensional matrix, in which the subjects are represented along the 3rd dimension. Also determines which ROIs were lost across all subjects.
* Dependencies: 
	* fillMissingROIs

cutROIs: removes specified ROIs manually

fillMissingROIs: Expects z-scored correlation output from AFNIs 3dNetCorr. Takes in the output .ncc, pulls the z-scored version of the correlation matrix, and determines which ROIs were cut from the correlation. 

getNetDist: Extracts the distribution of network membership for a given ROI based on the output of the SVINet

processMats: function for running a preset pipeline using the other processing functions

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

### Topo Comparison

communityMaps: generates a binarized imaging file of the output of the SVI function

DiceQCall.sh: shell script that runs the Dice coefficient analysis for a single instance

DiceQSub.sh: shell script that pushes Dice coefficient analysis iterations to Sun Grid Engine system

diceRunWrapper: wrapper function that executes an instance of Dice coefficient analysis, with options for map shuffling with a random seed; inline comments indicate values to change for true calculation in this version

diceScript: runs map shuffling and Dice comparison as required; inline comments indicate values to change for true calculation in this version

permFormat: formats results from Dice coefficient analysis across a number of specified iterations for Matlab-based statistical analysis

permP: calculates the values of a Dice coefficient analysis across all network pairs that reach threshold significance

runDice: Uses AFNI function 3ddot with -dodice option to calculate the Dice coefficient across pairs of two sets of specified networks

shuffleMaps: generates a spatially randomized map of the output of a set of networks assigned via SVInet package
