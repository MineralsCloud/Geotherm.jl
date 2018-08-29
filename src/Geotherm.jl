"""
# module Geotherm

- Julia version: 1.0
- Author: qz
- Date: 2018-08-08

# Examples

```jldoctest
julia>
```
"""
module Geotherm

using Reexport

include("Geometry.jl")
include("Interpolate.jl")
include("Integrate.jl")
include("Bind.jl")
include("Plot.jl")

@reexport using Geotherm.Geometry
@reexport using Geotherm.Interpolate
@reexport using Geotherm.Integrate
@reexport using Geotherm.Bind
@reexport using Geotherm.Plot

end
