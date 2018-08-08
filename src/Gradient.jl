"""
# module Gradient

- Julia version: 1.0
- Author: qz
- Date: 2018-08-08

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