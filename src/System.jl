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
    deterministic_forcing::Function #Function of the form f(x,p) whith x a vector in phase space and p a vector in parameter space
    prod_space::ProductSpace
    dt::Number
end


function double_well(x::Number, p::Vector{Float64})
    x^3*p[1] + x*p[2] + p[3]
end

DoubleWell = System(double_well, ProductSpace(3,1),0.01)