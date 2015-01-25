#1. 標準モジュールの利用
次の関数群を定義せよ。  
なお`Data.Ord`、`Data.List`、`Data.Map`を用いて良い。  
また、非負整数を受け取る関数については負数を受け取った時の挙動を考慮しなくてよい。

  1. `frequencyList` : リスト`xs`を受け取り、`xs`内の要素の出現数で降順ソートしたリストを返す関数
  2. `initialMap` : 文字列のリスト`ss`を受け取り、その文字から始まる文字列のリストへのMapを返す関数  
    ただし、空文字列が含まれる場合はその要素を無視すること
  3. `infixPalindromicNumber` : 非負整数`n`を受け取り、その数を文字列として含む最小の回文数を返す関数  
    なお、回文数とは「逆から数字を読んでも同じ数になる数」のことをいう

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
> initialMap ["hoge", "fuga", "hogehoge", "piyo", "", "fugapiyo"]
fromList [('f',["fugapiyo","fuga"]),('h',["hogehoge","hoge"]),('p',["piyo"])]

> :t infixPalindromicNumber
infixPalindromicNumber :: Int -> Int
> infixPalindromicNumber 0
0
> infixPalindromicNumber 12
121
> infixPalindromicNumber 21
121
> infixPalindromicNumber 765
56765
```

#2. バーナム暗号
### バーナム暗号の定義
ビット毎の排他的論理和は、同じ演算を2回行うと元に戻る性質を持っている。
```haskell
x `xor` y `xor` y == x
```
これを利用し、暗号と復号に同一の鍵を用いるのが *バーナム暗号* である。

今、暗号化対象となる平文を数列`[1,2,3]`、暗号化鍵を`[2,3,2]`とする。  
リストの各要素同士の排他的論理和を取ると
```haskell
1 `xor` 2 == 3
2 `xor` 3 == 1
3 `xor` 2 == 1
```
となり、暗号文`[3,1,1]`が得られる。  
復号の際には、同様に暗号化鍵との排他的論理和を取って
```haskell
3 `xor` 2 == 1
1 `xor` 3 == 2
1 `xor` 2 == 2
```
となり、平文`[1,2,3]`を得る。

### 問
暗号鍵となる文字列`k`と、暗号化対象となる平文の文字列`s`を受け取り、暗号文の文字列を返す関数`vernam`を定義せよ。  
なお、`k`の長さが`s`より短い場合は、`k`を繰り返して使用せよ。

ビットごとの排他的論理和は`Data.Bits`に`xor`として定義されており、これを使って良い。  
ただし、`Char`は`Bits`のインスタンスではないため、直接`xor`を適用できないことに注意すること。  
必要ならば`Data.Char`モジュールの関数を使って良い。

### 例
```haskell
> :t vernam
vernam :: String -> String -> String
> vernam "\NUL" "hogefuga"
"hogefuga"
> vernam "BIGHERO6" "Hello, I am Baymax."
"\n,+$*~o\DELb(*h\a36[#1i"
> vernam "BIGHERO6" "\n,+$*~o\DELb(*h\a36[#1i"
"Hello, I am Baymax."
```
