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
    forcing::Function #Function of the form f(x,p) whith x a vector in phase space and p a vector in parameter space
    prod_space::ProductSpace
    noise::Union{Number,Vector{Float64}}
    dt::Number
    function System(f,p,n,dt)
        param = ones(p.param.dim)
        try
            s = f(1.,param)
        catch 
            error("The input of the forcing function is not compatible with the structure of the product space")
        end
        if !(typeof(f(1.,param)) <: Number)
            error("The output of the forcing function is not compatible with the structure of the product space")
        end
        if !(typeof(n) <: Number)
            error("The noise is incompatible with the phase space dimension")
        end
        new(f,p,n,dt)
    end
end

function System(forcing::Function,prod_space::ProductSpace;dt::Number=0.01,σ=0)
    System(forcing,prod_space,σ,dt)
end


function double_well(x::Number, p::Vector{Float64})
    x^3*p[1] + x*p[2] + p[3]
end

DoubleWell = System(double_well, ProductSpace(3,1);σ=0.05)