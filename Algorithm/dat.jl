using DataFrames

type problem
    data::Array{Float64}
    Sigma::Array{Float64}
end


################ Pitprops
Dir = "../Data/"
Sigma = readcsv(string(Dir,"pitprops.csv"),header=false);
pitprops = problem(chol(Sigma),  Sigma);
