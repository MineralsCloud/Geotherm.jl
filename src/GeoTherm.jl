"""
# module GeoTherm

- Julia version: 1.0
- Author: qz
- Date: 2018-08-08

# Examples

```jldoctest
julia>
```
"""
module GeoTherm

using Reexport

include("LoadData.jl")
include("data.jl")
include("interp.jl")
include("integrate.jl")

@reexport using LoadData
@reexport using data
@reexport using interp
@reexport using integrate

end
