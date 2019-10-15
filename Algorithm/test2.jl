using Test, JLD, LinearAlgebra
mutable struct problem
    data::Array{Float64}
    Sigma::Array{Float64}
end
###############################################################################
### This test script aims to verify correctness of our code,
### by verifying that the sparse principal components found here match those
### found by (Berk+Bertsimas, 2017) on the UCI dataset
###
### We have hard-coded the test data here, in order to avoid Julia dependency issues
###############################################################################
include(normpath(joinpath(@__FILE__,"..",".."))*"Algorithm/branchAndBound.jl")
include(normpath(joinpath(@__FILE__,"..",".."))*"Algorithm/utilities.jl")
include(normpath(joinpath(@__FILE__,"..",".."))*"Algorithm/multiComponents.jl")
################################################################################
######## Test pitprops data set for each cardinality level
################################################################################
@testset "Berk and Bertsimas SPCA Table 8" begin

pitprops=[[1,0.954,0.364,0.342,-0.129,0.313,0.496,0.424,0.592,0.545,0.084,-0.019,0.134];
       [0.954,1,0.297,0.284,-0.118,0.291,0.503,0.419,0.648,0.569,0.076,-0.036,0.144];
       [0.364,0.297,1,0.882,-0.148,0.153,-0.029,-0.054,0.125,-0.081,0.162,0.22,0.126];
       [0.342,0.284,0.882,1,0.22,0.381,0.174,-0.059,0.137,-0.014,0.097,0.169,0.015];
       [-0.129,-0.118,-0.148,0.22,1,0.364,0.296,0.004,-0.039,0.037,-0.091,-0.145,-0.208];
       [0.313,0.291,0.153,0.381,0.364,1,0.813,0.09,0.211,0.274,-0.036,0.024,-0.329];
       [0.496,0.503,-0.029,0.174,0.296,0.813,1,0.372,0.465,0.679,-0.113,-0.232,-0.424];
       [0.424,0.419,-0.054,-0.059,0.004,0.09,0.372,1,0.482,0.557,0.061,-0.357,-0.202];
       [0.592,0.648,0.125,0.137,-0.039,0.211,0.465,0.482,1,0.526,0.085,-0.127,-0.076];
       [0.545,0.569,-0.081,-0.014,0.037,0.274,0.679,0.557,0.526,1,-0.319,-0.368,-0.291];
       [0.084,0.076,0.162,0.097,-0.091,-0.036,-0.113,0.061,0.085,-0.319,1,0.029,0.007];
       [-0.019,-0.036,0.22,0.169,-0.145,0.024,-0.232,-0.357,-0.127,-0.368,0.029,1,0.184];
       [0.134,0.144,0.126,0.015,-0.208,-0.329,-0.424,-0.202,-0.076,-0.291,0.007,0.184,1];]
spca_pitrops_value=[1.000, 1.954, 2.475, 2.937, 3.406, 3.771, 3.996, 4.069, 4.139, 4.173, 4.208, 4.218, 4.219]#source: Berk+B paper (unpublished manuscript)
pitprops=reshape(pitprops, (13,13));
B=sqrt(pitprops);
theProb=problem(B, pitprops)
    for k=1:13
           println("Running pitprops data set k= ", k)
           obj, xVal, timetoBound, timetoConverge, timeOut, explored, toPrint=branchAndBound(theProb, k)
           println("Testing pitprops data set k= ", k)
           @show @test(abs(obj-spca_pitrops_value[k])<1e-3)
    end

end;
