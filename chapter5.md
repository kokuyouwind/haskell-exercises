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
以下の関数群を*再帰を用いずに*定義せよ。  

  1. `fromBinary` : `0`か`1`のみからなるリスト`xs`を受け取り、`xs`を2進数表現と解釈した場合の10進数値を返す関数
  2. `tails` : リスト`xs`を受け取り、`xs`の全ての末尾部分リストを返す関数
  3. `powerSet` : リスト`xs`を受け取り、`xs`のべき集合を返す関数

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

*Main> :t powerSet
powerSet :: [a] -> [[a]]
*Main> powerSet [1,2,3]
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
**ラムダ計算**は、関数を値とし、関数の適用のみを定義した計算モデルである。  
以下では形式的な定義を扱わず、問題を通して*関数の適用のみで計算が成立する*ことを示す。

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
ただし、3～6については*組み込みの数値演算子を用いず、関数適用のみを用いて定義する*こと。  
なお非負整数を受け取る関数については、負数を受け取った場合の挙動を考慮しなくて良い。  

  1. `church` : 非負整数`n`を受け取り、対応するチャーチ数を返す関数
  2. `unchurch` : チャーチ数`c`を受け取り、対応する非負整数を返す関数
  3. `csucc` : チャーチ数`c`を受け取り、それより1大きいチャーチ数を返す関数
  4. `cadd` : チャーチ数`c1`、`c2'`を受け取り、`c1`と`c2`を加算したチャーチ数を返す関数
  5. `cmul` : チャーチ数`c1`、`c2'`を受け取り、`c1`と`c2`を乗算したチャーチ数を返す関数
  6. `cpred` : チャーチ数`c`を受け取り、それより1小さいチャーチ数を返す関数  
    ただし、0より小さくなる場合には0を返す  
    ヒント:`\g h -> h (g f)`というラムダ式を用いよ  
      この式を`F`としたとき、`F(F a)`は`\h -> h (f (a f))`に簡約される  
      また`F(F(F a))`は`\h -> h (f (f (a f)))`に簡約される  

### 例
```haskell
*Main> church 5 (1:) []
[1,1,1,1,1]
*Main> unchurch $ church 5
5
*Main> unchurch $ csucc $ church 5
6
*Main> unchurch $ church 3 `cadd` church 2
5
*Main> unchurch $ church 3 `cmul` church 2
6
*Main> unchurch $ cpred $ church 0
0
*Main> unchurch $ cpred $ church 1
0
*Main> unchurch $ cpred $ church 2
1
*Main> unchurch $ cpred $ church 5
4
```

## 4.2 チャーチ真理値
### チャーチ真理値の定義

チャーチ数と同様、真理値も関数を用いて表す事ができる。  
  - `True` : `\t f -> t`
  - `False` : `\t f -> f`

このように関数を用いて真理値を表現したものを**チャーチ真理値**という。  
端的に言って、`True`に対応するチャーチ真理値は2つの値を受け取り1つめの値を返す関数、`False`に対応するチャーチ真理値は2つの値を受け取り2つめの値を返す関数である。

### 問
以下の関数を定義せよ。  
ただし、3～5については*組み込みの論理演算子やif式などを用いず、関数適用のみを用いて定義する*こと。  
なお、次のようにチャーチ真理値をあらかじめ定義しておくと良い。
```haskell
cTrue :: t -> t -> t
cTrue = \t f -> t

cFalse :: t -> t -> t
cFalse = \t f -> f
```

  1. `churchb` : 真理値`b`を受け取り、対応するチャーチ真理値を返す関数
  2. `unchurchb` : チャーチ真理値`cb`を受け取り、対応する真理値を返す関数
  3. `cnot` : チャーチ真理値`cb`を受け取り、その否定を返す関数
  4. `cand` : チャーチ真理値`cb1`、`cb2`を受け取り、その論理積を返す関数
  5. `cor` : チャーチ真理値`cb1`、`cb2`を受け取り、その論理和を返す関数

### 例
```haskell
*Main> unchurchb $ churchb True
True
*Main> unchurchb $ churchb False
False

*Main> unchurchb $ cnot cTrue
False
*Main> unchurchb $ cnot cFalse
True

*Main> unchurchb $ cTrue `cand` cTrue
True
*Main> unchurchb $ cFalse `cand` cTrue
False
*Main> unchurchb $ cTrue `cand` cFalse
False
*Main> unchurchb $ cFalse `cand` cFalse
False

*Main> unchurchb $ cTrue `cor` cTrue
True
*Main> unchurchb $ cFalse `cor` cTrue
True
*Main> unchurchb $ cTrue `cor` cFalse
True
*Main> unchurchb $ cFalse `cor` cFalse
False
```

## 4.3 ラムダ計算と型付け
### 導入
以下のような、ブール真理値`cb`を受け取り、それと同じ値を返す関数`cid`を考える。
```haskell
cid cb = cb cTrue cFalse
```
右辺を見ると、`cb`が`cTrue`の時は第一引数である`cTrue`が返され、`cFalse`の時は第二引数である`cFalse`が返されることが分かる。  
実際、この関数は以下のとおり想定通りに動作する。
```haskell
*Main> unchurchb $ cid cTrue
True
*Main> unchurchb $ cid cFalse
False
```
`cid`の型について考えよう。  
チャーチ真理値の型は`t -> t -> t`であり、`cid`はチャーチ真理値を受け取りチャーチ真理値を返す。  
よって、`cid`全体の型は`(t -> t -> t) -> (t -> t -> t)`であることが期待されるであろう。  
しかしながら、この型を指定して`cid`を定義するとコンパイルエラーが起こる。  
型を指定せずに定義した場合、Haskellは以下のような型を推論する。
```haskell
*Main> :t cid
cid :: ((t1 -> t1 -> t1) -> (t2 -> t2 -> t2) -> t) -> t
```
これはどういうことだろうか？  
ここで、`cid`の式中に表れる`cb`の型を`a -> b -> t`としてみよう。  
上述の通り、`cTrue`の型は`t1 -> t1 -> t1`、`cFalse`の型は`t2 -> t2 -> t2`として定義されていることを考えると、明らかに`a`は`t1 -> t1 -> t1`、`b`は`t2 -> t2 -> t2`と等しくなければならない。  
つまり`cb`の型は`(t1 -> t1 -> t1) -> (t2 -> t2 -> t2) -> t`でなければならず、よって`cid`全体の型は`((t1 -> t1 -> t1) -> (t2 -> t2 -> t2) -> t) -> t`となる。  

このように、Haskellの型付けでは関数適用後の値が元の関数と別の型になるため、関数適用を計算の礎とするラムダ計算では型が付けられない場合が存在する。  
以下の例では`cTrue`に`cid`を1度適用するだけだが、全体として正しく型付けできずコンパイルエラーとなる。
```haskell
*Main> unchurchb $ church 1 cid cTrue

<interactive>:19:10:
    Occurs check: cannot construct the infinite type:
    (以下省略)
```

この問題を解決するため、以下のように`cif`を利用して`cid'`を定義しよう。
```haskell
cif cb t f = if unchurchb cb then t else f
cid' cb = cif cb cTrue cFalse
```
`cid'`の型は以下のようになり、先ほどの例も正しく動作する。
```haskell
*Main> :t cid'
cid' :: (Bool -> Bool -> Bool) -> t -> t -> t
*Main> unchurchb $ church 1 cid' cTrue
True
```

`cif`は型の問題を解決するために存在するだけであり、実質的には`cif cb t f`は`cb t f`と同値であることに注意して欲しい。  
つまり、`cif`を用いて定義できる様々な関数は、型の問題を除けば`cif`を用いずに記述することが出来る。  
次の問では、`cif`を利用することで、チャーチ数とチャーチ真理値を組み合わせたいくつかの関数を定義する。

### 問
以下の関数を、*組み込みの演算子や再帰、if式などを用いず、関数適用のみを用いて定義*せよ。  
なお、必要に応じて`cnot`、`cand`、`cor`を、`cnot'`、`cand'`、`cor'`という名前で`cif`を利用して再定義せよ。

  1. `cis0` : チャーチ数`c`を受け取り、それが0に対応するチャーチ数なら`cTrue`を、それ以外なら`cFalse`を返す関数
  2. `ceven` : チャーチ数`c`を受け取り、それが偶数に対応するチャーチ数なら`cTrue`を、それ以外なら`cFalse`を返す関数
  3. `cevennot0` : チャーチ数`c`を受け取り、それが0でない偶数に対応するチャーチ数なら`cTrue`を、それ以外なら`cFalse`を返す関数
  4. `clte2` : チャーチ数`c`を受け取り、それが2以下の数に対応するチャーチ数なら`cTrue`を、それ以外なら`cFalse`を返す関数

### 例
```haskell
*Main> unchurchb $ cis0 $ church 0
True
*Main> unchurchb $ cis0 $ church 1
False
*Main> unchurchb $ cis0 $ church 2
False

*Main> unchurchb $ ceven $ church 10
True
*Main> unchurchb $ ceven $ church 7
False

*Main> unchurchb $ cevennot0 $ church 0
False
*Main> unchurchb $ cevennot0 $ church 1
False
*Main> unchurchb $ cevennot0 $ church 2
True
*Main> unchurchb $ cevennot0 $ church 4
True

*Main> unchurchb $ clte2 $ church 0
True
*Main> unchurchb $ clte2 $ church 1
True
*Main> unchurchb $ clte2 $ church 2
True
*Main> unchurchb $ clte2 $ church 3
False
*Main> unchurchb $ clte2 $ church 4
False
```

## 総括
演習の通り、関数のみを用いて数や真理値を定義し、関数適用のみを用いて計算を行うことができる。  
このように、関数のみを値とし、関数適用のみを定義した計算モデルが**ラムダ計算**である

なお今回は扱わなかったが、この体系の中で再帰を定義することもでき、これを利用して階乗などの演算も定義することができる。  
ラムダ計算の体系は非常に強力であり、**チューリング完全**であることが知られている。  
これはおおまかに言って、汎用プログラミング言語で可能な計算はラムダ計算でも可能である、ということを意味する。  

ラムダ計算を理論の礎とする言語に**Lisp**がある。  
またLispに限らず、**Haskell**など**ML**など多くの関数型言語はラムダ計算が理論的な基盤となっている。

## 参考
`Bool`型の演算については上述の通り`cif`を用いて型の問題をある程度避けたが、本質的な問題は解決していない。  
例えば、以下のようにチャーチ数の減算`csub`を定義することはできない。
```haskell
csub c1 c2 = c1 cpred c2
```
ここでいう本質的な問題とは「関数適用を行った結果が元の関数と同じ型を持つことができない」ということであり、型付きラムダ計算を型付けの基盤とする言語では通常回避できない問題である。  
なお、OCamlでは`-rectypes`オプションを使用することで利用することができるが、本来型付けに失敗してほしい場面でも型がついてしまう場合があることから、デフォルトではオフになっている。  
さらに詳しくこのトピックについて知りたい場合は、[型システム入門](http://www.amazon.co.jp/dp/4274069117)の第20章「再帰型」を参照すると良い。

この問題を避ける一つの方法は、Haskellの言語構造としてのラムダ式を用いる代わりに、ラムダ計算の項を再帰的なデータ型として表現することである。  
第7章の演習で、この方法を用いてラムダ計算を実装する演習を行う。
