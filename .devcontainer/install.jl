import Pkg

packages = [
    "BenchmarkTools"
    "IJulia"
    "Plots"
    "PlotlyJS"
]

for package = packages
    Pkg.add(package)
end
