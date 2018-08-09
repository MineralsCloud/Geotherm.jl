"""
# module Bind

- Julia version: 1.0
- Author: qz
- Date: 2018-08-09

# Examples

```jldoctest
julia>
```
"""
module Bind

using Geometry: Point, Rectangle
using Interpolate: bilinear_interpolate
using Integrate: runge_kutta

import Base.bind

export bind

function bind(p0::Point{T}, rec::Rectangle{T}, h=0.01; n=1000) where T <: Real
    runge_kutta(p0, bilinear_interpolate(rec), h; n=n)
end

end