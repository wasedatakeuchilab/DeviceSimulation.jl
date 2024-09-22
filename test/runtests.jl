using Test

mytests = [
    "coordinate_utils.jl"
    "field.jl"
    "poisson_equation.jl"
]

for mytest in mytests
    include(mytest)
end
