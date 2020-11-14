# -- Top level includes, they should only appear here
include("network/types.jl")
include("network/trophic.jl")
include("dynamics/lotkavolterra.jl")

include("utils/plot.jl")
# --

using Random, Plots, Distributions
seed = 11148705
Random.seed!(seed)


N, p = 10, .5


N = nv(g)

x0 = ones(N)
r = rand(Uniform(0.5, 0.55), N)
κ = rand(Uniform(0.5, 0.55), N)

params = (r, κ)

ds, g = dynamicsonerdos(lv_evolve, SVector{N}(x0), params)

tr = trajectory(ds, 100)

T, N = size(tr)
t = collect(1:T)

plot(xaxis="t", yaxis="x", dpi=800)

for i in 1:N
    plot!(t, tr[:, i], label="$i")
end

savefig("plots/lv-dynamics.png")