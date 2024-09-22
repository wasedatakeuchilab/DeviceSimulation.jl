import StaticArrays as SA
import Interpolations as Itp

abstract type AbstractField end

"""
    ScalarField{N} <: AbstractField

An N-dimension `AbstractField` whose value is a scalar.

# Constructors

# Examples
```jldoctest
julia> ScalarField{1}([1, 2, 3], [1])
ScalarField{1}([1.0, 2.0, 3.0], [1.0])

julia> ScalarField{2}([1 2 3; 4 5 6], [0.1, 0.5])
ScalarField{2}([1.0 2.0 3.0; 4.0 5.0 6.0], [0.1, 0.5])
```
"""
struct ScalarField{N} <: AbstractField
    val::Array{Float64,N}
    Δx::SA.SVector{N,Float64}
end

function Base.getindex(f::ScalarField{N}, i::Any)::Float64 where {N}
    return f.val[i]
end

function Base.setindex!(f::ScalarField{N}, val::Any, i::Any)::Float64 where {N}
    f.val[i] = val
end

"""
    VectorField{N} <: AbstractField

An N-dimension `AbstractField` whose value is a vector.

# Constructors

# Examples
```jldoctest
julia> VectorField{1}([[1], [2], [3]], [1])
VectorField{1}(StaticArraysCore.MVector{1, Float64}[[1.0], [2.0], [3.0]], [1.0])

julia> VectorField{2}([[[1, 2]] [[3, 4]];], [0.1, 0.5])
VectorField{2}(StaticArraysCore.MVector{2, Float64}[[1.0, 2.0] [3.0, 4.0]], [0.1, 0.5])
"""
struct VectorField{N} <: AbstractField
    val::Array{SA.MVector{N,Float64},N}
    Δx::SA.SVector{N,Float64}
end

function Base.getindex(f::VectorField{N}, i::Any)::SA.MVector{N,Float64} where {N}
    return f.val[i]
end

function Base.setindex!(
    f::VectorField{N},
    val::Any,
    i::Any,
)::SA.MVector{N,Float64} where {N}
    f.val[i] = val
end

"""
    gradient(f, x)

Calculate the gradient vector of the scalar field `f` at the position `x`.

# Examples
```jldoctest
julia> Δx = 0.1; x = collect(0.0:Δx:1.0);

julia> f = ScalarField{1}(x.^2, [Δx]);

julia> gradient(f, 0.1)
1-element StaticArraysCore.SVector{1, Float64} with indices SOneTo(1):
 0.10000000000000002

julia> gradient(f, 0.5)
1-element StaticArraysCore.SVector{1, Float64} with indices SOneTo(1):
 0.8999999999999999
```
"""
function gradient(f::ScalarField{N}, x::Float64...)::SA.SVector{N,Float64} where {N}
    u = Tuple(collect(0:n-1) * f.Δx[i] for (i, n) in enumerate(size(f.val)))
    itp = Itp.linear_interpolation(u, f.val)
    return Itp.gradient(itp, x...)
end
