{-# LANGUAGE TemplateHaskell #-}

import Test.Util
import Test.QuickCheck
import Test.QuickCheck.Monadic
import qualified Src.Chapter4 as Src
import qualified Answer.Chapter4 as Ans

prop_tri_number (NonNegative n) =  Src.tri_number n == Ans.tri_number n
test_tri_number = quickCheck prop_tri_number

prop_tetration (NonNegative n) (NonNegative m) =  Src.tetration n' m' == Ans.tetration n' m'
    where n' = n `mod` 5
          m' = m `mod` 4
test_tetration = quickCheck prop_tetration

prop_index (NonNegative n) (SafeString xs) =  monadicIO $ do
  res1 <- run $ tryEval $ Src.index n xs
  res2 <- run $ tryEval $ Ans.index n xs
  assert $ res1 == res2
test_index = quickCheck prop_index

prop_even_odd xs =  Src.even_odd xs == Ans.even_odd xs
    where types = xs::[Int]
test_even_odd = quickCheck prop_even_odd

prop_insert (Ordered xs) x =  Src.insert xs x == Ans.insert xs x
    where types = (xs::[Int], x::Int)
test_insert = quickCheck prop_insert

prop_isort xs =  Src.isort xs == Ans.isort xs
    where types = xs::[Int]
test_isort = quickCheck prop_isort

prop_part_num (Positive n) =  Src.part_num n' == Ans.part_num n'
    where n' = n `mod` 30
test_part_num = quickCheck prop_part_num

test = $quickCheckAll
