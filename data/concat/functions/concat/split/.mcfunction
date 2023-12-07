#> concat:concat/split/
# 引数として渡された文字列を '"' または '\' で分割した文字列群を返す
# 戻り値に '"' 及び '\' は含まれる
# @input
#   storage concat: split.arg
#     分割対象の文字列
# @output
#   storage concat: split.result
#     分割結果 (入力とは逆順)
# @within
#   concat:concat/**

data modify storage concat: split.result set value []

execute store result storage concat: split.index int 1 run data get storage concat: split.arg

data modify storage concat: split.marker set from storage concat: split.index

execute unless data storage concat: split{index:0} run function concat:concat/split/loop

data modify storage concat: substr.arg set from storage concat: split.arg
data modify storage concat: substr.from set value 0
data modify storage concat: substr.to set from storage concat: split.marker
function concat:concat/substr/

data modify storage concat: split.result append from storage concat: substr.result
data remove storage concat: substr
