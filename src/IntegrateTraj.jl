include("System.jl")

struct ParamUpdate
    σ_params::Union{Vector{Float64},Float64,Int64}
    dt::Float64
end

function (param_up::ParamUpdate)(p::Vector{Float64})
    p .+= param_up.σ_params .* randn(length(p)) .* sqrt(param_up.dt)
    return p
end

struct FullUpdate
    param_up::ParamUpdate
    sys::System
end

function (full_up::FullUpdate)(x,p)
    x = full_up.sys.deterministic_forcing(x,p) .+ full_up.sys.param_up.dt*randn(full_up.sys.prod_space.phase.dim)
    p .+= full_up.param_up(p)
    return x,p
end


