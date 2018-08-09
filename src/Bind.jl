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

using NearestNeighbors

using Geometry: Point, Rectangle, point_to_vector
using Interpolate: bilinear_interpolate
using Integrate: runge_kutta

import Base.bind

export bind, pre

function pre(p::Point, adiabat::Matrix)
    x, y = p.x, p.y
    tree = NearestNeighbors.KDTree(adiabat)
    index, _ = NearestNeighbors.knn(tree, p, 1)
    adiabat[index]
end

function bind(p0::Point{T}, rec::Rectangle{T}, h=0.01; n=1000) where T <: Real
    # runge_kutta(p0, bilinear_interpolate(rec), h; n=n)
end

end