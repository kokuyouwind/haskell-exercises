module Test.Util
    (
      tryEval
    , SafeString(..)
    ) where
    import Test.QuickCheck
    import Data.Functor
    import Control.Exception hiding (assert)

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
