"""
# module Bind

- Julia version: 1.0
- Author: qz
- Date: 2018-08-09

# Examples

```jldoctest
julia> find_nearest(collect(1:10.0), 3.6)
4
```
"""
module Bind

using BisectPy: bisect_left

using Geometry: Point, Rectangle, SurfacePoint, point_to_surface_point
using Interpolate: bilinear_interpolate
using Integrate: runge_kutta_iter

import Base.bind

export bind



end