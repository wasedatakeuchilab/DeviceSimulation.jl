import Pkg

packages = [
    "BenchmarkTools"
    "IJulia"
    "JuliaFormatter"
    "Plots"
    "PlotlyJS"
    "PlotlyBase"
]

for package in packages
    Pkg.add(package)
end
