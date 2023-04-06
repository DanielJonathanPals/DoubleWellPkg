include("System.jl")

struct Obs
    f::Function
    name::String
end

function (obs::Obs)(x,p)
    obs.f(x,p)
end

derivative_double_well(x,p) = 3*p[1]*x^2 + p[2]*x
curvature_double_well(x,p) = 6*p[1]*x

λ = Obs(derivative_double_well,"λ")
curve = Obs(curvature_double_well,"Curvature")
