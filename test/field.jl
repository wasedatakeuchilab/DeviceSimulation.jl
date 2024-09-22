module TestField

using Test
using StaticArrays: @SVector
using DeviceSimulation: ScalarField, VectorField, gradient

const ≈ = isapprox

@testset "gradient" begin
    @testset "1-dimension" begin
        Δx = 0.1
        f(x) = x^2
        ∇f(x) = [(f(x) - f(x - Δx)) / Δx]   # 後退差分
        sf = ScalarField{1}(f.(0.0:Δx:1.0), [Δx])
        for x in [0.2, 0.4, 0.6, 0.8]  # 境界は外挿になるため敢えてテストしない
            v = @SVector [x]
            @testset "v = $v" begin
                @test gradient(sf, v...) ≈ ∇f(v...)
            end
        end
    end

    @testset "2-dimension" begin
        Δx, Δy = 0.1, 0.5
        f(x, y) = x^2 + y
        ∇f(x, y) = [(f(x, y) - f(x - Δx, y)) / Δx, (f(x, y) - f(x, y - Δy)) / Δy]
        sf = ScalarField{2}([f(x, y) for x = 0.0:Δx:1.0, y = 0.0:Δy:1.0], [Δx, Δy])
        for x in [0.2, 0.4, 0.6, 0.8], y in [0.2, 0.4, 0.6, 0.8]
            v = @SVector [x, y]
            @testset "v = $v" begin
                @test gradient(sf, v...) ≈ ∇f(v...)
            end
        end
    end

    @testset "3-dimension" begin
        Δx, Δy, Δz = [0.1, 0.05, 0.01]
        f(x, y, z) = x * y + y * z + z * x
        ∇f(x, y, z) = [
            (f(x, y, z) - f(x - Δx, y, z)) / Δx,
            (f(x, y, z) - f(x, y - Δy, z)) / Δy,
            (f(x, y, z) - f(x, y, z - Δz)) / Δz,
        ]
        sf = ScalarField{3}(
            [f(x, y, z) for x = 0.0:Δx:1.0, y = 0.0:Δy:1.0, z = 0.0:Δz:1.0],
            [Δx, Δy, Δz],
        )
        for x in [0.2, 0.4, 0.6, 0.8], y in [0.2, 0.4, 0.6, 0.8], z in [0.2, 0.4, 0.6, 0.8]
            v = @SVector [x, y, z]
            @testset "v = $v" begin
                @test gradient(sf, v...) ≈ ∇f(v...)
            end
        end
    end
end

end  # module
