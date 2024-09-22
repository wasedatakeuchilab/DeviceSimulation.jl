"""
    isboundary(A, I)

Return true if index `I` is in boudary of array `A`.

# Examples

```jldoctest
julia> A = zeros(3, 3);

julia> isboundary(A, CartesianIndex(1, 1))
true

julia> isboundary(A, CartesianIndex(2, 2))
false
```
"""
function isboundary(A::Array{T,N}, I::CartesianIndex{N})::Bool where {T,N}
    ~all(1 < i < n for (i, n) = zip(Tuple(I), size(A)))
end
