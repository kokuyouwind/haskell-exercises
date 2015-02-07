{-# LANGUAGE TemplateHaskell #-}

import Test.Util
import Test.QuickCheck
import Test.QuickCheck.Modifiers
import Data.Function
import Data.List(sort)
import qualified Data.Map as Map
import qualified Src.Chapter6 as Src
import qualified Answer.Chapter6 as Ans

prop_sortByFrequency (SafeString xs) =  Src.sortByFrequency xs == Ans.sortByFrequency xs
test_sortByFrequency = quickCheck prop_sortByFrequency

prop_initialMap xss =  Src.initialMap xss' `mapEq` Ans.initialMap xss'
    where types = xss::([SafeString])
          xss' = map unwrapSafeString xss
          mapEq = (==) `on` Map.map sort
test_initialMap = quickCheck prop_initialMap

prop_infixPalindromicNumber (NonNegative n) =  Src.infixPalindromicNumber n == Ans.infixPalindromicNumber n
test_infixPalindromicNumber = quickCheck prop_infixPalindromicNumber

prop_vernam (SafeString k) (SafeString s) = (not . null) k ==>  Src.vernam k s == Ans.vernam k s
test_vernam = quickCheck prop_vernam

test = $quickCheckAll
