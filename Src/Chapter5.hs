module Answer.Chapter5
    (
      applyPair
    , applyN
    , squares
    , fromBinary
    , tails
    , power_set
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
    applyPair f (x,y) = _ {- Rewrite HERE! -}

    -- (1.2)
    applyN :: (a -> a) -> Int -> a -> a
    applyN f n = f {- Rewrite HERE! -}

    -- (1.3)
    squares :: Int -> [Int]
    squares n = [] {- Rewrite HERE! -}

    -- (2.1)
    fromBinary :: [Int] -> Int
    fromBinary xs = 0 {- Rewrite HERE! -}

    -- (2.2)
    tails :: [a] -> [[a]]
    tails xs = [[]] {- Rewrite HERE! -}

    -- (2.3)
    power_set :: [a] -> [[a]]
    power_set xs = [[]] {- Rewrite HERE! -}

    -- (3.1)
    pointed1 :: [Int] -> [Int]
    pointed1 xs = map negate (map (+10) (filter (>0) xs))

    pointFree1 :: [Int] -> [Int]
    pointFree1 xs = [] {- Rewrite HERE! -}

    -- (3.2)
    pointed2 :: [[Int]] -> [Int]
    pointed2 xss = scanl (+) 0 (map (foldl (*) 1) (filter (\xs -> length xs >= 2) xss))

    pointFree2 :: [[Int]] -> [Int]
    pointFree2 xss = [] {- Rewrite HERE! -}

    -- (3.3)
    pointed3 :: [a -> a] -> a -> a
    pointed3 fs x = foldl (\x f -> f x) x fs

    pointFree3 :: [a -> a] -> a -> a
    pointFree3 fs x = x {- Rewrite HERE! -}

    -- (3.4)
    pointed4 :: (a -> [b]) -> [a] -> [b]
    pointed4 f xs = concat (map f xs)

    pointFree4 :: (a -> [b]) -> [a] -> [b]
    pointFree4 f xs = [] {- Rewrite HERE! -}

    -- (3.5)
    pointed5 :: (Int -> [Int]) -> [Int] -> [Int]
    pointed5 f xs = foldl (\ys g -> g ys) xs (replicate 3 (\zs -> concat (map f zs)))

    pointFree5 :: (Int -> [Int]) -> [Int] -> [Int]
    pointFree5 f xs = [] {- Rewrite HERE! -}

    -- (4.1.1)
    church n f z = z {- Rewrite HERE! -}

    -- (4.1.2)
    unchurch c = 0 {- Rewrite HERE! -}

    -- (4.1.3)
    csucc c f z = z {- Rewrite HERE! -}

    -- (4.1.4)
    cadd c1 c2 f z = z {- Rewrite HERE! -}

    -- (4.1.5)
    cmul c1 c2 f z = z {- Rewrite HERE! -}

    -- (4.1.6)
    cpred c f z = z {- Rewrite HERE! -}

    -- (4.2 pre-defined)
    cTrue :: t -> t -> t
    cTrue = \t f -> t

    cFalse :: t -> t -> t
    cFalse = \t f -> f

    -- (4.2.1)
    churchb b = cFalse {- Rewrite HERE! -}

    -- (4.2.2)
    unchurchb cb = False {- Rewrite HERE! -}

    -- (4.2.3)
    cnot cb = cFalse {- Rewrite HERE! -}

    -- (4.2.4)
    cand cb1 cb2 = cFalse {- Rewrite HERE! -}

    -- (4.2.5)
    cor cb1 cb2 = cFalse {- Rewrite HERE! -}

    -- (4.3 pre-defined)
    cif :: (Bool -> Bool -> Bool) -> t -> t -> t
    cif cb t f = if unchurchb cb then t else f

    -- (4.3.1)
    cis0 c = cFalse {- Rewrite HERE! -}

    -- (4.3.2)
    ceven c = cFalse {- Rewrite HERE! -}

    -- (4.3.3)
    cevennot0 c = cFalse {- Rewrite HERE! -}

    -- (4.3.4)
    clte2 c = cFalse {- Rewrite HERE! -}
