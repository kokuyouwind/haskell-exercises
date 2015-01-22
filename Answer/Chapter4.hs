module Answer.Chapter4
    (
      tri_number
    , tetration
    , index
    , even_odd
    , insert
    , isort
    , part_num
    ) where

    -- (1.1)
    tri_number :: Int -> Int
    tri_number 0 = 0
    tri_number n = n + tri_number (n-1)

    -- (1.2)
    tetration :: Integer -> Integer -> Integer
    tetration _ 0 = 1
    tetration x n = x^(tetration x (n-1))

    -- (1.3)
    index :: Int -> [a] -> a
    index _ [] = error "index outbounded"
    index 0 (x:_) = x
    index n (_:xs) = index (n-1) xs

    -- (1.4)
    even_odd :: [Int] -> ([Int], [Int])
    even_odd [] = ([], [])
    even_odd (x:xs)
        | x `mod` 2 == 0 = (odds, x:evens)
        | otherwise  = (x:odds, evens)
        where (odds, evens) = even_odd xs

    -- (2.1)
    insert :: Ord a => [a] -> a -> [a]
    insert [] y = [y]
    insert xs@(x:_) y | y < x = y:xs
    insert (x:xs) y = x:(insert xs y)

    -- (2.2)
    isort :: Ord a => [a] -> [a]
    isort [] = []
    isort (x:xs) = insert (isort xs) x

    --- (3)
    part_num :: Int -> Int
    part_num n = part_num' n 1
        where part_num' n m
               | n == m = 1
               | n < m  = 0
               | otherwise = part_num' (n-m) m + part_num' n (m+1)
