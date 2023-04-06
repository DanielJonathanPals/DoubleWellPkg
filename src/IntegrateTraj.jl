include("System.jl")

abstract type Updater end

struct RandomParamUpdate <: Updater
    sys::System
    σ_params::Union{Vector{Float64},Number,Int64}
end

function (param_up::RandomParamUpdate)(x::Number,p::Vector{Float64})
    x += param_up.sys.forcing(x,p) * param_up.sys.dt + param_up.sys.noise * sqrt(param_up.sys.dt) * randn()
    p .+= param_up.σ_params .* randn(length(p)) .* sqrt(param_up.sys.dt)
    return x,p
end
