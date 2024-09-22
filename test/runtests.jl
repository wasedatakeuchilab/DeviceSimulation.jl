using Test

mytests = [
    "coordinate_utils.jl"
]

for mytest in mytests
    include(mytest)
end
