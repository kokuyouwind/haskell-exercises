{-# LANGUAGE TemplateHaskell #-}

import Test.Util
import Test.QuickCheck
import Test.QuickCheck.Monadic
import Data.List
import Data.Function
import qualified Src.Chapter5 as Src
import qualified Answer.Chapter5 as Ans

prop_applyPair (Blind n) (Blind m) t =  Src.applyPair f t == Ans.applyPair f t
    where types = t::(Int,Int)
          f x = x * n + m
test_applyPair = quickCheck prop_applyPair

prop_applyN (Blind (NonZero p)) (NonNegative n) m =  Src.applyN f n m == Ans.applyN f n m
    where types = (n::Int, m::Int)
          f x = (x + 1) `mod` p
test_applyN = quickCheck prop_applyN

prop_squares (NonNegative n) =  Src.squares n == Ans.squares n
test_squares = quickCheck prop_squares

prop_fromBinary (NonNegative n) =  Src.fromBinary bs == Ans.fromBinary bs
    where bs = reverse . unfoldr (\b -> if b == 0 then Nothing else Just (b `mod` 2 , b `div` 2)) $ n
test_fromBinary = quickCheck prop_fromBinary

prop_tails (SafeString s) =  Src.tails s == Ans.tails s
test_tails = quickCheck prop_tails

prop_powerSet (SafeString s) =  Src.powerSet s' == Ans.powerSet s'
    where s' = take 10 s
test_powerSet = quickCheck prop_powerSet

prop_pointFree1 xs =  Src.pointFree1 xs == Ans.pointFree1 xs
    where types = xs::[Int]
test_pointFree1 = quickCheck prop_pointFree1

prop_pointFree2 xss =  Src.pointFree2 xss == Ans.pointFree2 xss
    where types = xss::[[Int]]
test_pointFree2 = quickCheck prop_pointFree2

prop_pointFree3 (Blind (NonNegative n)) m =  Src.pointFree3 fs m == Ans.pointFree3 fs m
    where types = m::Int
          fs = map (+) $ take n $ [1..]
test_pointFree3 = quickCheck prop_pointFree3

prop_pointFree4 (Blind (NonNegative n)) xs =  Src.pointFree4 f xs == Ans.pointFree4 f xs
    where types = xs::[Int]
          f x = take n [x..]
test_pointFree4 = quickCheck prop_pointFree4

prop_pointFree5 (Blind n) xs =  Src.pointFree5 f xs == Ans.pointFree5 f xs
    where types = xs::[Int]
          f x = [x, x+n]
test_pointFree5 = quickCheck prop_pointFree5

ceq :: ((Int -> Int) -> Int -> Int) -> ((Int -> Int) -> Int -> Int) -> Bool
ceq = (==) `on` Ans.unchurch

beq :: (Bool -> Bool -> Bool) -> (Bool -> Bool -> Bool) -> Bool
beq = (==) `on` Ans.unchurchb

prop_church (NonNegative n) =  Src.church n `ceq` Ans.church n
    where types = n::Int
test_church = quickCheck prop_church

prop_unchurch (NonNegative n) =  Src.unchurch n' == Ans.unchurch n'
    where types = n::Int
          n' = Ans.church n
test_unchurch = quickCheck prop_unchurch

prop_csucc (NonNegative n) =  Src.csucc n' `ceq` Ans.csucc n'
    where types = n::Int
          n' = Ans.church n
test_csucc = quickCheck prop_csucc

prop_cadd (NonNegative n) (NonNegative m) =  Src.cadd n' m' `ceq` Ans.cadd n' m'
    where types = (n::Int, m::Int)
          n' = Ans.church n
          m' = Ans.church m
test_cadd = quickCheck prop_cadd

prop_cmul (NonNegative n) (NonNegative m) =  Src.cmul n' m' `ceq` Ans.cmul n' m'
    where types = (n::Int, m::Int)
          n' = Ans.church n
          m' = Ans.church m
test_cmul = quickCheck prop_cmul

prop_cpred (NonNegative n) =  Src.cpred n' `ceq` Ans.cpred n'
    where types = n::Int
          n' = Ans.church n
test_cpred = quickCheck prop_cpred

prop_churchb b =  Src.churchb b `beq` Ans.churchb b
    where types = b::Bool
test_churchb = quickCheck prop_churchb

prop_unchurchb b =  Src.unchurchb b' == Ans.unchurchb b'
    where types = b::Bool
          b' = Ans.churchb b
test_unchurchb = quickCheck prop_unchurchb

prop_cnot b =  Src.cnot b' `beq` Ans.cnot b'
    where types = b::Bool
          b' = Ans.churchb b
test_cnot = quickCheck prop_cnot

prop_cand b1 b2 =  Src.cand b1' b2' `beq` Ans.cand b1' b2'
    where types = (b1::Bool, b2::Bool)
          b1' = Ans.churchb b1
          b2' = Ans.churchb b2
test_cand = quickCheck prop_cand

prop_cor b1 b2 =  Src.cor b1' b2' `beq` Ans.cor b1' b2'
    where types = (b1::Bool, b2::Bool)
          b1' = Ans.churchb b1
          b2' = Ans.churchb b2
test_cor = quickCheck prop_cor

prop_cis0 (NonNegative n) =  Src.cis0 n' `beq` Ans.cis0 n'
    where types = n::Int
          n' = Ans.church n
test_cis0 = quickCheck prop_cis0

prop_ceven (NonNegative n) =  Src.ceven n' `beq` Ans.ceven n'
    where types = n::Int
          n' = Ans.church n
test_ceven = quickCheck prop_ceven

prop_cevennot0 (NonNegative n) =  Src.cevennot0 n' `beq` Ans.cevennot0 n'
    where types = n::Int
          n' = Ans.church n
test_cevennot0 = quickCheck prop_cevennot0

prop_clte2 (NonNegative n) =  Src.clte2 n' `beq` Ans.clte2 n'
    where types = n::Int
          n' = Ans.church n
test_clte2 = quickCheck prop_clte2

test = $quickCheckAll
