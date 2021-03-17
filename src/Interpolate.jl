"""
# module Interpolate



# Examples

```jldoctest
julia>
```
"""
module Interpolate

using Geotherm.Geometry: Point2D, Point3D, Rectangle

export linear_interpolate, bilinear_interpolate

"""
    linear_interpolate(a, b)

Return a function of the linear interpolation between any 2 points `(x₁, f(x₁))` and `(x₂, g(x₂))`.
"""
function linear_interpolate(a::Point2D, b::Point2D)
    x₁, y₁, x₂, y₂ = a.x, a.y, b.x, b.y
    @assert x₁ != x₂ "The x-coordinates of the 2 arguments `a` and `b` cannot be equal!"
    return x -> ((x₂ - x) * y₁ + (x - x₁) * y₂) / (x₂ - x₁)
end

"""
    bilinear_interpolate(q₁₁, q₁₂, q₂₁, q₂₂)

If 4 points consisting of a rectangle and their z-coordinates are known, return a bilinear interpolation of the 4 points.
"""
function bilinear_interpolate(q₁₁::T, q₁₂::T, q₂₁::T, q₂₂::T) where {T<:Point3D}
    x₁, x₂, y₁, y₂ = q₁₁.x, q₂₁.x, q₁₁.y, q₂₂.y
    z₁₁, z₁₂, z₂₁, z₂₂ = map(q -> q.z, (q₁₁, q₁₂, q₂₁, q₂₂))
    rec = Rectangle(x₁, y₁, x₂, y₂)
    return function (x, y)
        if Point2D(x, y) ∉ rec
            error("point ($x, $y) is out of boundary $rec.")
        end
        v₁ = linear_interpolate(Point2D(x₁, z₁₁), Point2D(x₂, z₂₁))(x)
        v₂ = linear_interpolate(Point2D(x₁, z₁₂), Point2D(x₂, z₂₂))(x)
        return linear_interpolate(Point2D(y₁, v₁), Point2D(y₂, v₂))(y)
    end
end

end
