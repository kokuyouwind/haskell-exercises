{-# LANGUAGE TemplateHaskell #-}

import Test.QuickCheck
import Test.QuickCheck.Monadic
import Control.Exception hiding (assert)
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

eitherToMaybe :: Either a b -> Maybe b
eitherToMaybe (Right x) = Just x
eitherToMaybe (Left _) = Nothing

tryQ :: a -> IO (Either SomeException a)
tryQ = try . evaluate

maybeQ :: a -> IO (Maybe a)
maybeQ = fmap eitherToMaybe . tryQ

prop_qadd q1 q2 = monadicIO $ do
  res1 <- run $ maybeQ (Src.qadd q1 q2)
  res2 <- run $ maybeQ (Ans.qadd q1 q2)
  assert $ res1 == res2
test_qadd = quickCheck prop_qadd

prop_qequal q1 q2 = monadicIO $ do
  res1 <- run $ maybeQ (Src.qequal q1 q2)
  res2 <- run $ maybeQ (Ans.qequal q1 q2)
  assert $ res1 == res2
test_qequal = quickCheck prop_qequal

prop_qlist q n = monadicIO $ do
  res1 <- run $ maybeQ (take n $ Src.qlist q)
  res2 <- run $ maybeQ (take n $ Ans.qlist q)
  assert $ res1 == res2
test_qlist = quickCheck prop_qlist

test = $quickCheckAll
