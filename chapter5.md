#1. 基本的な高階関数
次の関数群を定義せよ。  
なお非負整数を受け取る関数については、負数を受け取った場合の挙動を考慮しなくて良い。  

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
以下の関数群をポイントフリースタイルで定義せよ。  
なお、ラムダ式も用いてはならない。

```haskell
-- (1) pointFree1という名前でポイントフリースタイルで再定義せよ
pointed1 :: [Int] -> [Int]
pointed1 xs = map negate (map (+10) (filter (>0) xs))

-- (2) pointFree2という名前でポイントフリースタイルで再定義せよ
pointed2 :: [[Int]] -> [Int]
pointed2 xss = scanl (+) 0 (map (foldl (*) 1) (filter (\xs -> length xs >= 2) xss))

-- (3) pointFree3という名前でポイントフリースタイルで再定義せよ
-- ヒント:flip及び($)を用いよ
pointed3 :: [a -> a] -> a -> a
pointed3 fs x = foldl (\x f -> f x) x fs

-- (4) pointFree3という名前でポイントフリースタイルで再定義せよ
-- ヒント:(.)をセクションで用いよ
pointed4 :: (a -> [b]) -> [a] -> [b]
pointed4 f xs = concat (map f xs)

-- (5) pointFree5という名前でポイントフリースタイルで再定義せよ
pointed5 :: (Int -> [Int]) -> [Int] -> [Int]
pointed5 f xs = foldl (\ys g -> g ys) xs (replicate 3 (\zs -> concat (map f zs)))
```

### 例
```haskell
*Main> pointed1 [0,10,20]
[-20,-30]
*Main> pointFree1 [0,10,20]
[-20,-30]

*Main> pointed2 [[1,2],[3],[4,5],[6]]
[0,2,22]
*Main> pointFree2 [[1,2],[3],[4,5],[6]]
[0,2,22]

*Main> pointed3 [(1+), (*2), (+5)] 10
27
*Main> pointFree3 [(1+), (*2), (+5)] 10
27

*Main> pointed4 (\x -> [x, x+1]) [1,10]
[1,2,10,11]
*Main> pointFree4 (\x -> [x, x+1]) [1,10]
[1,2,10,11]

*Main> pointed5 (\x -> [x,x*2]) [1,10]
[1,2,2,4,2,4,4,8,10,20,20,40,20,40,40,80]
*Main> pointFree5 (\x -> [x,x*2]) [1,10]
[1,2,2,4,2,4,4,8,10,20,20,40,20,40,40,80]
```

#4. ラムダ計算
*難易度の高いトピックである*  
(記述中)
