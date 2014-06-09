~/spy611scripts/script/simple/readme_libsvm_install.txt

I installed libsvm on this virtual machine.

I did it by following the instructions here:

https://github.com/cjlin1/libsvm/blob/master/README#L45

Here is a screendump of the commands I used to install libsvm on this virtual machine:


[madlib@madlib tmp]$ cd
[madlib@madlib ~]$ 
[madlib@madlib ~]$ 
[madlib@madlib ~]$ wget http://www.csie.ntu.edu.tw/~cjlin/libsvm/libsvm-3.18.tar.gz
--2014-06-09 15:26:21--  http://www.csie.ntu.edu.tw/~cjlin/libsvm/libsvm-3.18.tar.gz
Resolving www.csie.ntu.edu.tw... 140.112.30.28
Connecting to www.csie.ntu.edu.tw|140.112.30.28|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 610100 (596K) [application/x-gzip]
Saving to: “libsvm-3.18.tar.gz”

100%[======================================>] 610,100      281K/s   in 2.1s    

2014-06-09 15:26:23 (281 KB/s) - “libsvm-3.18.tar.gz” saved [610100/610100]

[madlib@madlib ~]$ 
[madlib@madlib ~]$ 
[madlib@madlib ~]$ tar zxf libsvm-3.18.tar.gz 
[madlib@madlib ~]$ 
[madlib@madlib ~]$ ln -s libsvm-3.18 libsvm
[madlib@madlib ~]$ 
[madlib@madlib ~]$ cd libsvm
[madlib@madlib libsvm]$ 
[madlib@madlib libsvm]$ ls -la
total 284
drwxr-xr-x.  8 madlib madlib  4096 Mar 31 15:57 .
drwx------. 32 madlib madlib  4096 Jun  9 15:27 ..
-rw-r--r--.  1 madlib madlib  1497 Mar 31 15:57 COPYRIGHT
-rw-r--r--.  1 madlib madlib 78971 Mar 31 15:57 FAQ.html
-rw-r--r--.  1 madlib madlib 27670 Mar 31 15:57 heart_scale
drwxr-xr-x.  3 madlib madlib  4096 Mar 31 15:57 java
-rw-r--r--.  1 madlib madlib   732 Mar 31 15:57 Makefile
-rw-r--r--.  1 madlib madlib  1084 Mar 31 15:57 Makefile.win
drwxr-xr-x.  2 madlib madlib  4096 Mar 31 15:57 matlab
drwxr-xr-x.  2 madlib madlib  4096 Mar 31 15:57 python
-rw-r--r--.  1 madlib madlib 28436 Mar 31 15:57 README
-rw-r--r--.  1 madlib madlib 64702 Mar 31 15:57 svm.cpp
-rw-r--r--.  1 madlib madlib   477 Mar 31 15:57 svm.def
-rw-r--r--.  1 madlib madlib  3382 Mar 31 15:57 svm.h
-rw-r--r--.  1 madlib madlib  5536 Mar 31 15:57 svm-predict.c
-rw-r--r--.  1 madlib madlib  8504 Mar 31 15:57 svm-scale.c
drwxr-xr-x.  5 madlib madlib  4096 Mar 31 15:57 svm-toy
-rw-r--r--.  1 madlib madlib  8978 Mar 31 15:57 svm-train.c
drwxr-xr-x.  2 madlib madlib  4096 Mar 31 15:57 tools
drwxr-xr-x.  2 madlib madlib  4096 Mar 31 15:57 windows
[madlib@madlib libsvm]$ 
[madlib@madlib libsvm]$ 
[madlib@madlib libsvm]$ make
g++ -Wall -Wconversion -O3 -fPIC -c svm.cpp
g++ -Wall -Wconversion -O3 -fPIC svm-train.c svm.o -o svm-train -lm
g++ -Wall -Wconversion -O3 -fPIC svm-predict.c svm.o -o svm-predict -lm
g++ -Wall -Wconversion -O3 -fPIC svm-scale.c -o svm-scale
[madlib@madlib libsvm]$ 
[madlib@madlib libsvm]$ 
[madlib@madlib libsvm]$ ./svm-train
Usage: svm-train [options] training_set_file [model_file]
options:
-s svm_type : set type of SVM (default 0)
	0 -- C-SVC		(multi-class classification)
	1 -- nu-SVC		(multi-class classification)
	2 -- one-class SVM
	3 -- epsilon-SVR	(regression)
	4 -- nu-SVR		(regression)
-t kernel_type : set type of kernel function (default 2)
	0 -- linear: u'*v
	1 -- polynomial: (gamma*u'*v + coef0)^degree
	2 -- radial basis function: exp(-gamma*|u-v|^2)
	3 -- sigmoid: tanh(gamma*u'*v + coef0)
	4 -- precomputed kernel (kernel values in training_set_file)
-d degree : set degree in kernel function (default 3)
-g gamma : set gamma in kernel function (default 1/num_features)
-r coef0 : set coef0 in kernel function (default 0)
-c cost : set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)
-n nu : set the parameter nu of nu-SVC, one-class SVM, and nu-SVR (default 0.5)
-p epsilon : set the epsilon in loss function of epsilon-SVR (default 0.1)
-m cachesize : set cache memory size in MB (default 100)
-e epsilon : set tolerance of termination criterion (default 0.001)
-h shrinking : whether to use the shrinking heuristics, 0 or 1 (default 1)
-b probability_estimates : whether to train a SVC or SVR model for probability estimates, 0 or 1 (default 0)
-wi weight : set the parameter C of class i to weight*C, for C-SVC (default 1)
-v n: n-fold cross validation mode
-q : quiet mode (no outputs)
[madlib@madlib libsvm]$ 
[madlib@madlib libsvm]$ 
[madlib@madlib libsvm]$ 
