using Test

mytests = [
    "coordinate_utils.jl"
    "poisson_equation.jl"
]

for mytest in mytests
    include(mytest)
end
