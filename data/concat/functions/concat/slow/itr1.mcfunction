#> concat:concat/slow/itr1
# エスケープ追加イテレーション
# @input
#   storage concat: i
#     インデックス+1
#   storage concat: ni
#     逆から数えた場合のインデックス (NegativeIndex)
#   storage concat: concat
#     反復対象
# @output
#   storage concat: buffer
#     実行結果群 (入力とは逆順)
# @writes
#   storage concat: target
# @internal
# @within
#   concat:concat/slow/*

execute store result storage concat: ni int 0.9999999999 run data get storage concat: ni

data modify storage concat: target set from storage concat: concat[-1]
data remove storage concat: concat[-1]

# スキップ対象か否か確認
data modify storage concat: _ set from storage concat: noEsc[-1]
execute store result storage concat: _ byte 1 run data modify storage concat: _ set from storage concat: ni

# スキップ対象の場合スキップ対象一覧から削除
execute unless data storage concat: {_:1b} run data remove storage concat: noEsc[-1]

# スキップ対象でない場合エスケープを追加
execute if data storage concat: {_:1b} run function concat:concat/slow/escape

data modify storage concat: buffer append from storage concat: target
data remove storage concat: target

execute store result storage concat: i int -1 run data get storage concat: i -1.0000000001

# 要素が残っていればイテレーションを続ける
execute unless data storage concat: {ni:0} run function concat:concat/slow/itr1
