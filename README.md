# Optimal-SPCA

Software supplement for the paper
"Certifiably Optimal Principal Component Analysis"
by Lauren Berk and Dimitris Bertsimas

---

1. Introduction

The software in this package is designed to solve the problem

`max x'Qx`
`s.t. ||x||_0 <=k, ||x||_2 <=1`

using a branch-and-bound approach.  The code implements Optimal-SPCA in the paper "Certifiably Optimal Principal Component Analysis"  by Lauren Berk and Dimitris Bertsimas.

---

2. Installation and set up

In order to run this software, you must install a recent version of Julia from http://julialang.org/downloads/.  The most recent version of Julia at the time this code was last tested was Julia 0.6.0.

Two packages must be installed in Julia before the code can be run.  These packages are DataFrames, and StatsBase.  They can be added by running:

`Pkg.add("DataFrames")`
`Pkg.add("StatsBase")`

At this point, the file "test.jl" should run successfully.  To run the script, navigate to the directory containing these .jl files and the pitprops.csv file.

Then run:

include("test.jl")

The script will run the branch and bound algorithm on the Pitprops dataset, and then generate an additional random problem and run the algorithm on that problem.

---

3. Use of the branchAndBound() function

The key method in these packages is branchAndBound().  It takes two required  arguments: prob, and k.  Prob is a custom type that holds the original data as well as the covariance matrix associated with the problem.  (If data is not available, the cholesky factorization of the covariance matrix will suffice,  and not affect the solution.)  The data is presented in an m x n array, with m  data points in n dimensions.  The corresponding covariance matrix is n x n.  The  parameter k is a postiive integer less than n.

There are many optional parameters, some of which are discussed in detail in our paper. Other parameters have to do techincal aspects of the algorithm, like convergence criteria and resizing arrays.  These are commented on in  detail in the branchAndBound.jl file where the function is defined.

The function returns the objective function value, solution vector, and  a few performance metrics, including time elapsed and the number of nodes explored. The function also returns a print-out of the algorithm's progress over time.

---

4. Thank you

Thank you for reading and considering our paper for publication in  Mathematical Programming Computation. Please let us know if you encounter any  issues using this code, or have comments or questions.  Feel free to email us anytime.

Lauren Berk
lberk@mit.edu

Dimitris Bertsimas
dbertsim@mit.edu
