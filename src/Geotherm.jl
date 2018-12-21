"""
# module Geotherm



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

@reexport using Geotherm.Geometry
@reexport using Geotherm.Interpolate
@reexport using Geotherm.Integrate
@reexport using Geotherm.Bind

end
