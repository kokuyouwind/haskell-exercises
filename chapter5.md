#1. 基本的な高階関数
次の関数群を定義せよ。  
なお非負整数を受け取る関数については、非負整数を受け取った場合の挙動を考慮しなくて良い。  

  1. `applyPair` : 関数`f`を受け取り、ペア(2-Tuple)を受け取って両方の要素に`f`を適用する関数を返す関数
  2. `applyN` : 関数`f`と非負整数`n`を受け取り、`x`を受け取って`f`を`x`に`n`回適用する関数を返す関数
  3. `squares` : 非負整数`n`を受け取り、`n`以下の全ての平方数を返す関数

###例
```haskell
*Main> :t applyPair
applyPair :: (a -> b) -> (a, a) -> (b, b)
*Main> applyPair (*2) (10, 20)
(20,40)

*Main> :t applyN
applyN :: (a -> a) -> Int -> a -> a
*Main> applyN (1:) 3 []
[1,1,1]

*Main> :t squares
squares :: Int -> [Int]
*Main> squares 50
[1,4,9,16,25,36,49]
```

#2. 畳み込み
以下の関数群を定義せよ。  

  1. `fromBinary` : `0`か`1`のみからなるリスト`xs`を受け取り、`xs`を2進数表現と解釈した場合の10進数値を返す関数
  2. `tails` : リスト`xs`を受け取り、`xs`の全ての末尾部分リストを返す関数
  3. `parts` : リスト`xs`を受け取り、`xs`の全ての部分リストを返す関数

### 例
```haskell
*Main> :t fromBinary
fromBinary :: [Int] -> Int
*Main> fromBinary [1,0,1,0]
10

*Main> :t tails
tails :: [a] -> [[a]]
*Main> tails [1,2,3]
[[1,2,3],[2,3],[3],[]]

*Main> :t parts
parts :: [a] -> [[a]]
*Main> parts [1,2,3]
[[1,2,3],[1,2],[1,3],[1],[2,3],[2],[3],[]]
```

#3. ポイントフリースタイル
(記述中)

#4. ラムダ計算
*難易度の高いトピックである*  
(記述中)
