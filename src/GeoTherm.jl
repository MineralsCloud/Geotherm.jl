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

# include("LoadData.jl")
include("Geometry.jl")
include("Interpolate.jl")
include("Integrate.jl")
include("Bind.jl")

# @reexport using LoadData
@reexport using Geometry
@reexport using Interpolate
@reexport using Integrate
@reexport using Bind

end
