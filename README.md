すごいHaskell楽しく演習！
=================

「すごいHaskell楽しく学ぼう！」の自作章末演習問題です。  
社内勉強会のために作っているものを公開します。  

章番号については、オーム社から出ている日本語訳版と対応しています。([Amazon](http://amzn.to/1uS2ja1))  
原文をオンラインで読むことが出来ますが、こちらは章番号がずれていますのでご注意ください。([英語サイト](http://learnyouahaskell.com/chapters))

## 章リンク

- [第1章 はじめの第一歩](https://github.com/kokuyouwind/haskell-exercises/blob/master/chapter1.md)
- 第2章 型を信じろ!(演習なし)
- [第3章 関数の構文](https://github.com/kokuyouwind/haskell-exercises/blob/master/chapter3.md)
- [第4章 Hello再帰!](https://github.com/kokuyouwind/haskell-exercises/blob/master/chapter4.md)
- [第5章 高階関数](https://github.com/kokuyouwind/haskell-exercises/blob/master/chapter5.md)
- [第6章 モジュール](https://github.com/kokuyouwind/haskell-exercises/blob/master/chapter6.md)
- 第7章 型や型クラスを自分で作ろう
- 第8章 入出力
- 第9章 もっと入力、もっと出力
- 第10章 関数型問題解決法
- 第11章 ファンクターからアプリティカティブファンクターへ
- 第12章 モノイド
- 第13章 モナドがいっぱい
- 第14章 もうちょっとだけモナド

## ディレクトリ構成

- `Src` : 問題を解くためのテンプレートが格納されています。こちらのファイルを直接編集してください。
- `Answer` : 解答が格納されています。どうしても解けない場合に参照してください。
- `Test` : 自分の解答が正しいかを格納するための自動テストが格納されています。

## テスト方法

テストには`QuickCheck`を利用しているため、`QuickCheck`をインストールしてください。`cabal`コマンドが使える場合には、
```shell
$ cabal install QuickCheck
```
でインストールできます。

章ごとの問題を全てテスト時には、`ghci`をプロジェクトルートで起動した後、該当のテストファイルを読み込み、`test`を実行します。  
また、特定の関数のみテストする場合には、同様にテストファイルを読み込んだ後、`test_(関数名)`を実行します。  
例えば、第1章のテストを実行する場合は以下のようになります。
```haskell
> :l Test/Chapter1.hs
> test -- 第1章のテストを全て実行
=== prop_manlen from Test/Chapter1.hs:7 ===
*** Failed! Exception: 'Prelude.undefined' (after 1 test):
((0,0),(0,0))

=== prop_points from Test/Chapter1.hs:10 ===
*** Failed! Exception: 'Prelude.undefined' (after 1 test):
0

=== prop_mancircle from Test/Chapter1.hs:13 ===
*** Failed! Exception: 'Prelude.undefined' (after 1 test):
0

False
> test_manlen -- manlen関数のテストのみ実行
*** Failed! Exception: 'Prelude.undefined' (after 1 test):
```

なお`:l Test/Chapter1.hs`を実行した後に`:e Src/ChapterX.hs`で回答を編集した場合、最新の回答でテストが実行されます。  
このため、問題を解く際には以下のようなワークフローをおすすめします。
```haskell
> :l Test/Chapter1.hs -- 初めにテストファイルを読み込む
Ok, modules loaded: Src.Chapter1, Answer.Chapter1, Main.
> test_manlen -- これから実装する関数のテストが失敗することを確認する
*** Failed! Exception: 'Prelude.undefined' (after 1 test):
((0,0),(0,0))
> :e Src/Chapter1.hs -- 問題を解く
> test_manlen -- 再度テストを実行し、成功するか確認する
+++ OK, passed 100 tests.
```
