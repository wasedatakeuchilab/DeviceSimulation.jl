module TestCoordinateUtils

using Test
using DeviceSimulation: isboundary

@testset "isboundary" begin
    @testset "1 dimension" begin
        A_1d = zeros(3)
        @test isboundary(A_1d, CartesianIndex(1)) == true
        @test isboundary(A_1d, CartesianIndex(2)) == false
        @test isboundary(A_1d, CartesianIndex(3)) == true
    end

    @testset "2 dimension" begin
        A_2d = zeros(3, 3)
        @test isboundary(A_2d, CartesianIndex(1, 1)) == true
        @test isboundary(A_2d, CartesianIndex(1, 2)) == true
        @test isboundary(A_2d, CartesianIndex(1, 3)) == true
        @test isboundary(A_2d, CartesianIndex(2, 1)) == true
        @test isboundary(A_2d, CartesianIndex(2, 2)) == false
        @test isboundary(A_2d, CartesianIndex(2, 3)) == true
        @test isboundary(A_2d, CartesianIndex(3, 1)) == true
        @test isboundary(A_2d, CartesianIndex(3, 2)) == true
        @test isboundary(A_2d, CartesianIndex(3, 3)) == true
    end

    @testset "3 dimension" begin
        A_3d = zeros(3, 3, 3)
        @test isboundary(A_3d, CartesianIndex(1, 1, 1)) == true
        @test isboundary(A_3d, CartesianIndex(1, 1, 2)) == true
        @test isboundary(A_3d, CartesianIndex(1, 1, 3)) == true
        @test isboundary(A_3d, CartesianIndex(1, 2, 1)) == true
        @test isboundary(A_3d, CartesianIndex(1, 2, 2)) == true
        @test isboundary(A_3d, CartesianIndex(1, 2, 3)) == true
        @test isboundary(A_3d, CartesianIndex(1, 3, 1)) == true
        @test isboundary(A_3d, CartesianIndex(1, 3, 2)) == true
        @test isboundary(A_3d, CartesianIndex(1, 3, 3)) == true
        @test isboundary(A_3d, CartesianIndex(2, 1, 1)) == true
        @test isboundary(A_3d, CartesianIndex(2, 1, 2)) == true
        @test isboundary(A_3d, CartesianIndex(2, 1, 3)) == true
        @test isboundary(A_3d, CartesianIndex(2, 2, 1)) == true
        @test isboundary(A_3d, CartesianIndex(2, 2, 2)) == false
        @test isboundary(A_3d, CartesianIndex(2, 2, 3)) == true
        @test isboundary(A_3d, CartesianIndex(2, 3, 1)) == true
        @test isboundary(A_3d, CartesianIndex(2, 3, 2)) == true
        @test isboundary(A_3d, CartesianIndex(2, 3, 3)) == true
        @test isboundary(A_3d, CartesianIndex(3, 1, 1)) == true
        @test isboundary(A_3d, CartesianIndex(3, 1, 2)) == true
        @test isboundary(A_3d, CartesianIndex(3, 1, 3)) == true
        @test isboundary(A_3d, CartesianIndex(3, 2, 1)) == true
        @test isboundary(A_3d, CartesianIndex(3, 2, 2)) == true
        @test isboundary(A_3d, CartesianIndex(3, 2, 3)) == true
        @test isboundary(A_3d, CartesianIndex(3, 3, 1)) == true
        @test isboundary(A_3d, CartesianIndex(3, 3, 2)) == true
        @test isboundary(A_3d, CartesianIndex(3, 3, 3)) == true
    end
end

end  # module
