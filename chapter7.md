#1. 基本的なデータ型の利用

データ型`Ternary`、`Stack`、`Dfa`を以下のように定義する。

```haskell
import qualified Data.Set as Set
import qualified Data.Map as Map


data Ternary = T | F | I
data Stack a = Empty | Top a (Stack a)
data Dfa a = Dfa {
      start :: Int
    , end   :: Set.Set Int
    , delta :: Map.Map (Int, a) Int
}
```

なお、それぞれの型は以下を意図している。
- `Ternary` : [3値論理](http://ja.wikipedia.org/wiki/3%E5%80%A4%E8%AB%96%E7%90%86)の型
- `Stack` : `a`型を格納する[スタック](http://ja.wikipedia.org/wiki/%E3%82%B9%E3%82%BF%E3%83%83%E3%82%AF)の型
- `DFA` : `a`型を文字とする[決定性有限オートマトン](http://ja.wikipedia.org/wiki/%E6%B1%BA%E5%AE%9A%E6%80%A7%E6%9C%89%E9%99%90%E3%82%AA%E3%83%BC%E3%83%88%E3%83%9E%E3%83%88%E3%83%B3)の型

これらのデータ型を用いた以下の関数群を定義せよ。


#2. 型クラスの定義と利用

#3. ペアノ数

#4. 型無しラムダ計算
