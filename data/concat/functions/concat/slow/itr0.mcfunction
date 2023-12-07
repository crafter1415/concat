#> concat:concat/slow/itr0
# 引数分割イテレーション
# @input
#   storage concat: args_copy
# @output
#   storage concat: concat
#   storage concat: noEsc
# @writes
#   storage concat: split
# @internal
# @within
#   concat:concat/slow/*

data modify storage concat: split.arg set from storage concat: args_copy[-1]
data remove storage concat: args_copy[-1]
function concat:concat/split/
data modify storage concat: concat append from storage concat: split.result[]
data remove storage concat: split
data modify storage concat: _ set value ""
execute store result storage concat: _ byte 1 run data modify storage concat: _ set from storage concat: concat[-1]
execute unless data storage concat: {_:1b} run data remove storage concat: concat[-1]
execute if data storage concat: {_:1b} run data modify storage concat: noEsc append value 0
execute if data storage concat: {_:1b} store result storage concat: noEsc[-1] int 0.9999999999 run data get storage concat: concat
data remove storage concat: _

#tellraw @a {"storage":"concat:","nbt":"{}"}

execute if data storage concat: args_copy[0] run function concat:concat/slow/itr0
