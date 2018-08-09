"""
# module Plot

- Julia version: 1.0
- Author: qz
- Date: 2018-08-09

# Examples

```jldoctest
julia>
```
"""
module Plot

using GR

function plot_trace(ps)
    xs = map(p -> p.x, ps)
    ys = map(p -> p.y, ps)
    GR.plot(xs, ys)
end

end