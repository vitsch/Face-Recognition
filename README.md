# Face-Recognition

The experiments were run using Matlab 2012. The code includes the following scripts:

im_process – to read jpg images, vectorise, and combine into a data matrix

pw_xn – to prepare the data for training and testing of ANNs

mcnn – to train and test MCNN

pw_nn and pw_test – to train and test PWNN

Instructions:

1. Run the script pw_xn.m in Matlab to generate the data xn.mat.
2. Run the script mcnn.m to train and test the MCNN with the given settings.
When the script finishes running, the mean performance (mp) and standard
deviation (sp) within the 5-fold cross-validation will be output in the Matlab
command window.
3. Similarly, run the script pw_nn5.m to train and test the PWNN.

Additional information about the method:

J. Uglov, L. Jakaite, V. Schetinin and C. Maple "Comparing Robustness of Pairwise and Multiclass Neural-Network Systems for Face Recognition", EURASIP Journal on Advances in Signal Processing 2008, 2008:468693, http://asp.eurasipjournals.com/content/2008/1/468693 

Abstract:

Noise, corruptions, and variations in face images can seriously hurt the performance of face-recognition systems. To make these systems robust to noise and corruptions in image data, multiclass neural networks capable of learning from noisy data have been suggested. However on large face datasets such systems cannot provide the robustness at a high level. In this paper, we explore a pairwise neural-network system as an alternative approach to improve the robustness of face recognition. In our experiments, the pairwise recognition system is shown to outperform the multiclass-recognition system in terms of the predictive accuracy on the test face images.

