module TestElectron

using Test
using DeviceSimulation: Electron, velocity, energy, ħ

@testset "Electron" begin
    mass = [1.0, 1.0, 1.0]
    @testset "1-dimension" begin
        elec = Electron{1}(mass)
        @test elec.x == [0.0]
        @test elec.k == [0.0, 0.0, 0.0]
        @test elec.mass == mass
    end
    @testset "2-dimension" begin
        elec = Electron{2}(mass)
        @test elec.x == [0.0, 0.0]
        @test elec.k == [0.0, 0.0, 0.0]
        @test elec.mass == mass
    end
    @testset "3-dimension" begin
        elec = Electron{3}(mass)
        @test elec.x == [0.0, 0.0, 0.0]
        @test elec.k == [0.0, 0.0, 0.0]
        @test elec.mass == mass
    end
end

@testset "velocity" begin
    mass = [1.0, 2.0, 3.0]
    @test velocity(Electron{1}([0.0], [0.0, 0.0, 0.0], mass)) == [0.0, 0.0, 0.0] * ħ
    @test velocity(Electron{1}([0.0], [1.0, 0.0, 0.0], mass)) == [1.0, 0.0, 0.0] * ħ
    @test velocity(Electron{1}([0.0], [1.0, 1.0, 0.0], mass)) == [1.0, 0.5, 0.0] * ħ
    @test velocity(Electron{1}([0.0], [1.0, 1.0, 3.0], mass)) == [1.0, 0.5, 1.0] * ħ
end

@testset "energy" begin
    mass = [1.0, 2.0, 3.0]
    @test energy(Electron{1}([0.0], [0.0, 0.0, 0.0], mass)) == 0.0 * 0.5 * ħ^2
    @test energy(Electron{1}([0.0], [1.0, 0.0, 0.0], mass)) == 1.0 * 0.5 * ħ^2
    @test energy(Electron{1}([0.0], [1.0, 1.0, 0.0], mass)) == 1.5 * 0.5 * ħ^2
    @test energy(Electron{1}([0.0], [1.0, 1.0, 3.0], mass)) == 4.5 * 0.5 * ħ^2
end

end  # module
