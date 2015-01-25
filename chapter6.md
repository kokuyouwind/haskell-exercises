#1. 標準モジュールの利用
次の関数群を定義せよ。  
なお`Data.Ord`、`Data.List`、`Data.Map`を用いて良い。

  1. `frequencyList` : リスト`xs`を受け取り、`xs`内の要素の出現数で降順ソートしたリストを返す関数
  2. `initialMap` : 文字列のリスト`ss`を受け取り、その文字から始まる文字列のリストへのMapを返す関数

###例
```haskell
> :t sortByFrequency
sortByFrequency :: Ord a => [a] -> [a]
> sortByFrequency "abaacdabddddb"
"dabc"
> sortByFrequency ["high", "low", "middle", "high", "high", "middle"]
["high","middle","low"]

> :t initialMap
initialMap :: [String] -> Map.Map Char [String]
> initialMap ["hoge", "fuga", "hogehoge", "piyo", "fugapiyo"]
fromList [('f',["fugapiyo","fuga"]),('h',["hogehoge","hoge"]),('p',["piyo"])]
```

#2. 
### 定義


### 問


### 例
```haskell

```
