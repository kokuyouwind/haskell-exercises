{-# LANGUAGE TemplateHaskell #-}

import Test.Util
import Test.QuickCheck
import Test.QuickCheck.Monadic
import Data.Function
import Data.Functor
import qualified Src.Chapter3 as Src
import qualified Answer.Chapter3 as Ans

prop_tri_pattern (NonNegative n) =  Src.tri_pattern n' == Ans.tri_pattern n'
    where n' = n `mod` 20
test_tri_pattern = quickCheck prop_tri_pattern

prop_tri_guard (NonNegative n) =  Src.tri_guard n' == Ans.tri_guard n'
    where n' = n `mod` 20
test_tri_guard = quickCheck prop_tri_guard

prop_tri_case (NonNegative n) =  Src.tri_case n' == Ans.tri_case n'
    where n' = n `mod` 20
test_tri_case = quickCheck prop_tri_case

qnorm :: (Int, Int) -> (Int, Int)
qnorm (a,0) = (a,0)
qnorm (a,b) | b < 0 = qnorm (-a,-b)
qnorm (a,b) = (a `div` g, b `div` g)
  where g = gcd a b

qeq :: Maybe (Int, Int) -> Maybe (Int, Int) -> Bool
qeq = (==) `on` fmap qnorm

prop_qadd q1 q2 = monadicIO $ do
  res1 <- run $ tryEval $ Src.qadd q1 q2
  res2 <- run $ tryEval $ Ans.qadd q1 q2
  assert $ res1 `qeq` res2
test_qadd = quickCheck prop_qadd

prop_qequal q1 q2 = monadicIO $ do
  res1 <- run $ tryEval $ Src.qequal q1 q2
  res2 <- run $ tryEval $ Ans.qequal q1 q2
  assert $ res1 == res2
test_qequal = quickCheck prop_qequal

prop_qlist q n = monadicIO $ do
  res1 <- run $ tryEval $ take n $ Src.qlist q
  res2 <- run $ tryEval $ take n $ Ans.qlist q
  assert $ res1 == res2
test_qlist = quickCheck prop_qlist

test = $quickCheckAll
