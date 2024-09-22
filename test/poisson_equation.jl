module TestPoissonEquation

using Test
using DeviceSimulation: neighbor_sum

@testset "neighbor_sum" begin
    @test neighbor_sum(ones(Float64, 1)) == ones(Float64, 1)
    @test neighbor_sum(ones(Float64, 2)) == ones(Float64, 2)
    @test neighbor_sum(ones(Float64, 3)) == [1.0, 2.0, 1.0]
    @test neighbor_sum(ones(Float64, 1, 1)) == ones(Float64, 1, 1)
    @test neighbor_sum(ones(Float64, 2, 2)) == ones(Float64, 2, 2)
    @test neighbor_sum(ones(Float64, 3, 3)) == [1.0 1.0 1.0; 1.0 4.0 1.0; 1.0 1.0 1.0]
    @test neighbor_sum(ones(Float64, 4, 4)) ==
          [1.0 1.0 1.0 1.0; 1.0 4.0 4.0 1.0; 1.0 4.0 4.0 1.0; 1.0 1.0 1.0 1.0]
    @test neighbor_sum(ones(Float64, 4, 4, 4)) == [
        1.0 1.0 1.0 1.0; 1.0 1.0 1.0 1.0; 1.0 1.0 1.0 1.0; 1.0 1.0 1.0 1.0;;;
        1.0 1.0 1.0 1.0; 1.0 6.0 6.0 1.0; 1.0 6.0 6.0 1.0; 1.0 1.0 1.0 1.0;;;
        1.0 1.0 1.0 1.0; 1.0 6.0 6.0 1.0; 1.0 6.0 6.0 1.0; 1.0 1.0 1.0 1.0;;;
        1.0 1.0 1.0 1.0; 1.0 1.0 1.0 1.0; 1.0 1.0 1.0 1.0; 1.0 1.0 1.0 1.0
    ]
end

end  # module
