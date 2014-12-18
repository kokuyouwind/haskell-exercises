#1. 基本的な高階関数
次の関数群を定義せよ。  
なお非負整数を受け取る関数については、負数を受け取った場合の挙動を考慮しなくて良い。  

  1. `applyPair` : 関数`f`を受け取り、ペア(2-Tuple)を受け取って両方の要素に`f`を適用する関数を返す関数
  2. `applyN` : 関数`f`と非負整数`n`を受け取り、`x`を受け取って`f`を`x`に`n`回適用する関数を返す関数
  3. `squares` : 非負整数`n`を受け取り、`n`以下の全ての平方数を返す関数

### 例
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

## 4.1 チャーチ数
### チャーチ数の定義

非負整数`n`に対して、「関数`f`と値`z`を受け取り、`f`を`z`に`n`回適用するような関数」を考える。  
例として、最初のいくつかの非負整数と、それに対応する関数を挙げていくと、
  - 0 : `\f z -> z`
  - 1 : `\f z -> f z`
  - 2 : `\f z -> f (f z)`
  - 3 : `\f z -> f (f (f z))`
のようになる。  
ここで、異なる数に対する関数は、明らかに互いに異なる。  
また、ある数とそれに対応する関数は、相互に変換が可能である。  
そこで、非負整数`n`と、それに対応する関数を同一視することにする。  
このように関数を用いて非負整数を表現したものを**チャーチ数**という。  

### 問
以下の関数を定義せよ。  
ただし、3～5については*組み込みの数値演算子を用いず、関数適用のみを用いて定義する*こと。  
なお非負整数を受け取る関数については、負数を受け取った場合の挙動を考慮しなくて良い。  

  1. `church` : 非負整数`n`を受け取り、対応するチャーチ数を返す関数
  2. `unchurch` : チャーチ数`c`を受け取り、対応する非負整数を返す関数
  3. `csucc` : チャーチ数`c`を受け取り、それより1大きいチャーチ数を返す関数
  4. `cadd` : チャーチ数`c`,`d`を受け取り、`c`と`d`を加算したチャーチ数を返す関数
  5. `cmul` : チャーチ数`c`,`d`を受け取り、`c`と`d`を乗算したチャーチ数を返す関数

### 例
```haskell
*Main> church 5 (1:) []
[1,1,1,1,1]
*Main> unchurch $ church 5
5
*Main> unchurch $ csucc $ church 5
6
*Main> unchurch $ cadd (church 3) (church 2)
5
*Main> unchurch $ cmul (church 3) (church 2)
6
```

## 4.2 真理値
### 真理値の定義

チャーチ数と同様、論理値も関数を用いて表す事ができる。  
  - `True` : `\t f -> t`
  - `False` : `\t f -> f`

端的に言って、`True`に対応する関数は2つの値を受け取り前者を返す関数、`False`に対応する関数は2つの値を受け取り後者を返す関数である。

### 問
(以下追記する)
