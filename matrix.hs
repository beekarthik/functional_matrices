
-- Numeric operators/operations

add x y = x+y
sub x y = x-y
dot x y = x*y

-- Vector operators/operations

vector f = zipWith (f)

sumList::(Num a)=> [a] -> a
sumList [] = 0
sumList (x:xs) = x + sumList xs

--Matrix operators/operations

matrix f = zipWith (zipWith f)

transpose ([]:xs) = []
transpose x = (map head x) : transpose (map tail x)

mulMatrix x y = [[sumList (vector dot a b)| b<-(transpose y)]| a<-x]

reduceMatrix::(Fractional a, Ord a) => [[a]] -> [[a]]
reduceMatrix (x:[]) = [x]
reduceMatrix (x:xs)
    | firstColZero (x:xs) = (x : (reduceMatrix  (subMatrix xs)))
    | 0 == head x         = reduceMatrix $ xs++[x]
    | otherwise           = (x : (map (0:) ((reduceMatrix . subMatrix . clearFirstCol) $ (x:xs))))
    where
        firstColZero x = all (==0) (map head x)

        subMatrix x = map tail $ tail x

        clearFirstCol (x:xs) = (x:map (scaledSubtract x) xs)

        scaledSubtract:: (Fractional a, Ord a) => [a] -> [a] -> [a]
        scaledSubtract (x:xs) (y:ys)
          | y == 0    = (0:ys)
          | otherwise = vector add (scaled y (x:xs)) (y:ys)
          where
              scaled:: (Fractional a) => a -> [a] ->[a]
              scaled y (x:xs) = map (*(-y/x)) (x:xs)
