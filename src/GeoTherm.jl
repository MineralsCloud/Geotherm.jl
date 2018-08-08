"""
# module GeoTherm

- Julia version: 0.7
- Author: qz
- Date: 2018-08-08

# Examples

```jldoctest
julia>
```
"""
module GeoTherm

using Reexport

include("data.jl")
include("interp.jl")
include("integrate.jl")

@reexport using data
@reexport using interp
@reexport using integrate

end
