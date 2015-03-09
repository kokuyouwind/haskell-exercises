#1. 3値論理
### 3値論理の定義
通常の論理体系では、値は*真*(`True`)と*偽*(`False`)の2値のいずれかであるが、これを3値以上に拡張した論理体系を **多値論理** という。  
この中でもちょうど3値を用いるものを **3値論理** という。  
3値論理にはいくつかの定義があるが、以下では[クリーネの強3値論理](http://ja.wikipedia.org/wiki/3%E5%80%A4%E8%AB%96%E7%90%86#.E3.82.AF.E3.83.AA.E3.83.BC.E3.83.8D.E3.81.AE3.E5.80.A4.E8.AB.96.E7.90.86)を扱う。

*真*(`True`)と*偽*(`False`)に加えて、3つめの値として*未定義*(`Undefined`)を考える。  
*未定義*は*真*か*偽*ではあるが、どちらか分からないような値である。  
この論理体系の演算では、通常の2値論理での演算を元に、「`Undefined`が`True`と`False`のいずれかを取るかによって結果が変化する場合は`Undefined`、変化しない場合はその値」となるよう定義を拡張する。

例えば、`True or Undefined`の場合、`Undefined`の部分が`True`になっても`False`になっても、式全体の値は`True`になる。  
このため式全体の値は`True`になる。  
一方`False or Undefined`の場合、`Undefined`の部分が`True`になるか`False`になるかによって、式全体の値は異なる。  
このため式全体の値は`Undefined`になる。

演算の真理値表を以下に示す。  
`not`は論理否定を、`and`は論理積を、`or`は論理和を、それぞれ意味する。

| A | B |A and B|A or B|not A|
|:-:|:-:|:-----:|:----:|:---:|
| T | T |   T   |   T  |  F  |
| T | F |   F   |   T  |  F  |
| T | U |   U   |   T  |  F  |
| F | T |   F   |   T  |  T  |
| F | F |   F   |   F  |  T  |
| F | U |   F   |   U  |  T  |
| U | T |   U   |   T  |  U  |
| U | F |   F   |   U  |  U  |
| U | U |   U   |   U  |  U  |


### 問
3値論理のデータ型`Ternary`を以下のように定義する。
```haskell
data Ternary = T | F | U deriving (Show)
```
`T`は*真*を、`F`は*偽*を、`U`は*未定義*をそれぞれ意味する値である。 
このとき、以下の関数群を定義せよ。

  1. `tnot` : `Ternary`値を受け取り、その論理否定となる`Ternary`値を返す関数
  2. `tand` : `Ternary`値を2つ受け取り、それらの論理積となる`Ternary`値を返す関数
  3. `tor` : `Ternary`値を2つ受け取り、それらの論理和となる`Ternary`値を返す関数
  4. `teq` : `Ternary`値を2つ受け取り、それらが(2値論理として)等しいかを表す`Ternary`値を返す関数
  5. `tleq` : `Ternary`値を2つ受け取り、(2値論理として)1つめの値が2つめの値以下かを表す`Ternary`値を返す関数
    ただし、`F`は`T`より小さいものとする

### 例
```haskell
> tnot F
T
> tnot U
U
> tnot T
F

> T `tand` T
T
> T `tand` F
F
> U `tand` T
U

> T `tor` F
T
> U `tor` F
U
> F `tor` F
F

> T `teq` T
T
> F `teq` T
F
> U `teq` F
U
> U `teq` U
U

> T `tleq` F
F
> F `tleq` T
T
> F `tleq` U
T
> U `tleq` U
U
```

#2. スタック
### スタックの定義

### 問
`a`型のデータを格納するスタックのデータ型`Stack`を以下のように定義する。
```haskell
data Stack a = Empty | Top a (Stack a) deriving (Show)
```


### 例


#3. 決定性有限オートマトン
### 決定性有限オートマトンの定義

### 問
`Int`型の値を状態集合とし、`a`型の値を文字集合とする決定性有限オートマトンの型`Dfa`を以下のように定義する。
```haskell
import qualified Data.Set as Set
import qualified Data.Map as Map

data Dfa a = Dfa {
      start :: Int
    , end   :: Set.Set Int
    , delta :: Map.Map (Int, a) Int
} deriving (Show)
```

### 例


#4. ペアノ数
