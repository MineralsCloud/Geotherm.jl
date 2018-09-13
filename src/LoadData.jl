"""
# module LoadData



# Examples

```jldoctest
julia>
```
"""
module LoadData

using CSV, DataFrames

export load_csv

load_csv(d::Dict{String, String}) = Dict(k => CSV.read(v) for (k, v) in d)

end