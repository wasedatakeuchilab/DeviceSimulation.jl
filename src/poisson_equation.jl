"""
    poisson_equation!(u, f)

Solve the Poisson equation Δ`u` = `f`.

The algolithm is Gauss-Sidel method.

# Examples
```jldoctest
julia> u = zeros(3, 3);

julia> f = [
0.0 0.0 0.0
0.0 3.0 0.0
0.0 0.0 0.0];

julia> poisson_equation!(u, f)
3×3 Matrix{Float64}:
 0.0  0.0   0.0
 0.0  0.75  0.0
 0.0  0.0   0.0

```
"""
function poisson_equation!(
    u::Array{Float64,D},
    f::Array{Float64,D};
    ε::Float64 = 1e-6,
    max_loop::Int64 = 1000,
)::Array{Float64,D} where {D}
    for _ = 1:max_loop
        new_u = (neighbor_sum(u) .+ f) / 2D
        err = maximum(abs, new_u .- u)
        u .= new_u
        err < ε && break
    end
    return u
end

"""
    neighbor_sum(A)

Return the total of values that the Manhattan distance is 1 for each value of `A`.

# Examples
```jldoctest
julia A = [
1.0 1.0 1.0
1.0 1.0 1.0
1.0 1.0 1.0];

julia> neighbor_sum(A)
3×3 Matrix{Float64}:
 1.0  1.0  1.0
 1.0  4.0  1.0
 1.0  1.0  1.0

julia> A = [
1.0 1.0 1.0 1.0
2.0 2.0 2.0 2.0
2.0 2.0 2.0 2.0
1.0 1.0 1.0 1.0];

julia> neighbor_sum(A)
4×4 Matrix{Float64}:
 1.0  1.0  1.0  1.0
 2.0  7.0  7.0  2.0
 2.0  7.0  7.0  2.0
 1.0  1.0  1.0  1.0

```
"""

function neighbor_sum(A::Array{Float64,D})::Array{Float64,D} where {D}
    d(I::CartesianIndex, J::CartesianIndex)::Int64 = Tuple(I - J) .|> abs |> sum

    _neighbor_sum(I::CartesianIndex)::Float64 = begin
        isneighbor(J::CartesianIndex)::Bool = d(I, J) == 1
        I1 = oneunit(I)

        if isboundary(A, I)
            return A[I]
        else
            return sum(A[J] for J = filter(isneighbor, (I-I1):(I+I1)))
        end
    end

    return reshape([_neighbor_sum(I) for I = CartesianIndices(A)], size(A))
end
