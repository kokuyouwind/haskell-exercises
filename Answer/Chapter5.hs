module Answer.Chapter5
    (
      applyPair
    , applyN
    , squares
    , fromBinary
    , tails
    , powerSet
    , pointed1
    , pointFree1
    , pointed2
    , pointFree2
    , pointed3
    , pointFree3
    , pointed4
    , pointFree4
    , pointed5
    , pointFree5
    , church
    , unchurch
    , csucc
    , cadd
    , cmul
    , cpred
    , cTrue
    , cFalse
    , churchb
    , unchurchb
    , cnot
    , cand
    , cor
    , cif
    , cis0
    , ceven
    , cevennot0
    , clte2
    ) where

    -- (1.1)
    applyPair :: (a -> b) -> (a, a) -> (b, b)
    applyPair f (x,y) = (f x, f y)

    -- (1.2)
    applyN :: (a -> a) -> Int -> a -> a
    applyN _ 0 = id
    applyN f n = (f.) $ applyN f $ n - 1

    -- (1.3)
    squares :: Int -> [Int]
    squares n = takeWhile (<= n) $ map (^2) [1..]

    -- (2.1)
    fromBinary :: [Int] -> Int
    fromBinary = foldl ((+) . (*2)) 0

    -- (2.2)
    tails :: [a] -> [[a]]
    tails = scanr (:) []

    -- (2.3)
    powerSet :: [a] -> [[a]]
    powerSet = foldr (\x acc -> map (x:) acc ++ acc) [[]]

    -- (3.1)
    pointed1 :: [Int] -> [Int]
    pointed1 xs = map negate (map (+10) (filter (>0) xs))

    pointFree1 :: [Int] -> [Int]
    pointFree1 = map (negate . (+10)) . filter (>0)

    -- (3.2)
    pointed2 :: [[Int]] -> [Int]
    pointed2 xss = scanl (+) 0 (map (foldl (*) 1) (filter (\xs -> length xs >= 2) xss))

    pointFree2 :: [[Int]] -> [Int]
    pointFree2 = scanl (+) 0 . map (foldl (*) 1) . filter ((>=2) . length)

    -- (3.3)
    pointed3 :: [a -> a] -> a -> a
    pointed3 fs x = foldl (\x f -> f x) x fs

    pointFree3 :: [a -> a] -> a -> a
    pointFree3 = flip $ foldl $ flip ($)

    -- (3.4)
    pointed4 :: (a -> [b]) -> [a] -> [b]
    pointed4 f xs = concat (map f xs)

    pointFree4 :: (a -> [b]) -> [a] -> [b]
    pointFree4 = (concat.) . map

    -- (3.5)
    pointed5 :: (Int -> [Int]) -> [Int] -> [Int]
    pointed5 f xs = foldl (\ys g -> g ys) xs (replicate 3 (\zs -> concat (map f zs)))

    pointFree5 :: (Int -> [Int]) -> [Int] -> [Int]
    pointFree5 = (flip $ foldl $ flip ($)) . replicate 3 . ((concat.) . map)

    -- (4.1.1)
    church 0 _ z = z
    church n f z = f $ church (n-1) f z

    -- (4.1.2)
    unchurch c = c (+1) 0

    -- (4.1.3)
    csucc c f z = f $ c f z

    -- (4.1.4)
    cadd c1 c2 f z = c1 f (c2 f z)

    -- (4.1.5)
    cmul c1 c2 f z = c1 (c2 f) z

    -- (4.1.6)
    cpred c f z = c (\g h -> h (g f)) (\u -> z) (\u -> u)

    -- (4.2 pre-defined)
    cTrue :: t -> t -> t
    cTrue = \t f -> t

    cFalse :: t -> t -> t
    cFalse = \t f -> f

    -- (4.2.1)
    churchb True = cTrue
    churchb False = cFalse

    -- (4.2.2)
    unchurchb cb = cb True False

    -- (4.2.3)
    cnot cb = cb cFalse cTrue

    -- (4.2.4)
    cand cb1 cb2 = cb1 cb2 cFalse

    -- (4.2.5)
    cor cb1 cb2 = cb1 cTrue cb2

    -- (4.3 pre-defined)
    cif :: (Bool -> Bool -> Bool) -> t -> t -> t
    cif cb t f = if unchurchb cb then t else f

    -- (4.3.1)
    cand' cb1 cb2 = cif cb1 cb2 cFalse
    cis0 c = c (cand' cFalse) cTrue

    -- (4.3.2)
    cnot' cb = cif cb cFalse cTrue
    ceven c = c cnot' cTrue

    -- (4.3.3)
    cevennot0 c = ceven c `cand'` (cnot' $ cis0 c)

    -- (4.3.4)
    clte2 c = cis0 $ cpred $ cpred c
