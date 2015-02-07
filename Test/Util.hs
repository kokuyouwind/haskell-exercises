module Test.Util
    (
      listeq
    , tryEval
    , SafeString(..)
    ) where
    import Test.QuickCheck
    import Data.Function(on)
    import Data.List(sort)
    import Data.Functor
    import Control.Exception hiding (assert)

    listeq :: Ord a => [a] -> [a] -> Bool
    listeq = (==) `on` sort

    eitherToMaybe :: Either a b -> Maybe b
    eitherToMaybe (Right x) = Just x
    eitherToMaybe (Left _) = Nothing

    tryEval' :: a -> IO (Either SomeException a)
    tryEval' = try . evaluate

    tryEval :: a -> IO (Maybe a)
    tryEval = fmap eitherToMaybe . tryEval'

    genSafeChar :: Gen Char
    genSafeChar = elements ['a'..'z']

    genSafeString :: Gen String
    genSafeString = listOf genSafeChar

    newtype SafeString = SafeString { unwrapSafeString :: String }
        deriving Show
    instance Arbitrary SafeString where
        arbitrary = SafeString <$> genSafeString
