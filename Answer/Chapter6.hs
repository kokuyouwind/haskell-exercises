module Answer.Chapter6
    (
      sortByFrequency
    , initialMap
    , infixPalindromicNumber
    , vernam
    ) where
    import Data.Ord
    import Data.List
    import qualified Data.Map as Map
    import Data.Char
    import Data.Bits

    -- (1.1)
    sortByFrequency :: Ord a => [a] -> [a]
    sortByFrequency = map head . sortBy (comparing $ Down . length) . group . sort

    -- (1.2)
    initialMap :: [String] -> Map.Map Char [String]
    initialMap = Map.fromListWith (++) . map (\s -> (head s, [s])) . filter (not . null)

    -- (1.3)
    infixPalindromicNumber :: Int -> Int
    infixPalindromicNumber n = head [m | m <- [0..], let m' = show m, reverse m' == m', show n `isInfixOf` m']

    -- (2)
    vernam :: String -> String -> String
    vernam k s = map chr $ zipWith xor (map ord $ cycle k) (map ord s)
