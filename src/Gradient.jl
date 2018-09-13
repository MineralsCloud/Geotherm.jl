"""
# module Gradient



# Examples

```jldoctest
julia>
```
"""
module Gradient

using DataFrames

export geothermal_gradient

function geothermal_gradient(d::Dict{String, DataFrames.DataFrame})
    α = d["α"]
    V = d["v"]
    cp = d["cp"]
    x -> α * V * T / Cp * x
end

end