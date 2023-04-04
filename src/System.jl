abstract type Space end

struct PhaseSpace <: Space
    dim::Int64
end

struct ParamSpace <: Space
    dim::Int64
end

struct ProductSpace <: Space
    param::ParamSpace
    phase::PhaseSpace
end

function ProductSpace(param_dim::Int64,phase_dim::Int64)
    param = ParamSpace(param_dim)
    phase = PhaseSpace(phase_dim)
    return ProductSpace(param,phase)
end

struct System
    deterministic_forcing::Function
    σ::Union{Vector{Float64},Float64,Int64} #Noise amplitudes for additive noise in phase space
    prod_space::ProductSpace
end


function double_well(x::Vector{Float64},p::Vector{Float64})
    x^3*p[1] + x*p[2] + p[3]
end

DoubleWell = System(double_well,ProductSpace(3,1))