{-# LANGUAGE TemplateHaskell #-}

import Test.QuickCheck
import Test.QuickCheck.Modifiers
import Data.Functor
import qualified Src.Chapter6 as Src
import qualified Answer.Chapter6 as Ans

genSafeChar :: Gen Char
genSafeChar = elements ['a'..'z']
genSafeString :: Gen String
genSafeString = listOf genSafeChar
newtype SafeString = SafeString { unwrapSafeString :: String }
    deriving Show
instance Arbitrary SafeString where
    arbitrary = SafeString <$> genSafeString

prop_sortByFrequency (SafeString xs) =  Src.sortByFrequency xs == Ans.sortByFrequency xs
test_sortByFrequency = quickCheck prop_sortByFrequency

prop_initialMap xss =  Src.initialMap xss' == Ans.initialMap xss'
    where types = xss::([SafeString])
          xss' = map unwrapSafeString xss
test_initialMap = quickCheck prop_initialMap

prop_infixPalindromicNumber (NonNegative n) =  Src.infixPalindromicNumber n == Ans.infixPalindromicNumber n
test_infixPalindromicNumber = quickCheck prop_infixPalindromicNumber

prop_vernam (SafeString k) (SafeString s) = (not . null) k ==>  Src.vernam k s == Ans.vernam k s
test_vernam = quickCheck prop_vernam

test = $quickCheckAll
