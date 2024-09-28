import StaticArrays as SA

"""Dirac constant[eV・s]"""
const ħ = 6.58211195 * 1e-16

# TODO: Add docstring
"""
"""
mutable struct Electron{N}
    x::SA.MVector{N,Float64}
    k::SA.MVector{3,Float64}
    mass::SA.MVector{3,Float64}
end

function Electron{N}(mass::Vector{Float64}) where {N}
    Electron{N}(zeros(N), zeros(3), mass)
end

"""
    velocity(elec)

Return the velocity of the electron.

# Examples
```jldoctest
julia> elec = Electron([1.0, 1.0, 1.0])
Electron{3}([0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [1.0, 1.0, 1.0])

julia> velocity(elec)
3-element StaticArraysCore.MVector{3, Float64} with indices SOneTo(3):
 0.0
 0.0
 0.0

julia> elec.k .= [3, 4, 0] / ħ;

julia> velocity(elec)
3-element StaticArraysCore.MVector{3, Float64} with indices SOneTo(3):
 3.0
 4.0
 0.0

```
"""
function velocity(elec::Electron{N})::SA.MVector{3,Float64} where {N}
    return ħ * elec.k ./ elec.mass
end

"""
    velocity(elec)

Return the energy of the electron.

# Examples
```jldoctest
julia> elec = Electron([1.0, 1.0, 1.0])
Electron{3}([0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [1.0, 1.0, 1.0])

julia> energy(elec)
0.0

julia> elec.k .= [3, 4, 0] / ħ;

julia> velocity(elec)
12.5

```
"""
function energy(elec::Electron{N})::Float64 where {N}
    v = velocity(elec)
    return 0.5 * sum(@. elec.mass * v^2)
end
