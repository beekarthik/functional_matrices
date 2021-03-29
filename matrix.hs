
-- Numeric operators/operations

add x y = x+y
sub x y = x-y
dot x y = x*y

numCols x = (length . head) $ x
numRows x = length x

-- Vector operators/operations

vector :: (a -> b -> c) -> [a] -> [b] -> [c]
vector f x y
    | length x /= length y = error "Vector lengths do not agree"
    | otherwise            = zipWith (f) x y

sumList :: (Num a) => [a]->a
sumList [] = 0
sumList (x:xs) = x + sumList xs

--Matrix operators/operations

matrix f x y
    | numRows x /= numRows y = error "Matrix dimensions do not agree"
    | numCols x /= numCols y = error "Matrix dimensions do not agree"
    | otherwise              = zipWith (zipWith (f)) x y

fullReverse :: [[a]] -> [[a]]
fullReverse x = (reverse (map (reverse) x))

transpose ::(Num a) => [[a]] -> [[a]]
transpose ([]:xs) = []
transpose x = (map head x) : transpose (map tail x)

mulMatrix::(Num a) => [[a]]->[[a]]->[[a]]
mulMatrix x y
    | numCols x /=  numRows y = error "Matrix dimensions do not agree"
    | otherwise = [[sumList (vector dot a b)| b<-(transpose y)]| a<-x]

ref :: (Fractional a, Ord a) => [[a]] -> [[a]]
ref (x:[]) = [x]
ref (x:xs)
    | firstColZero (x:xs) = (x : (ref  (subMatrix xs)))
    | 0 == head x         = ref $ xs++[x]
    | otherwise           = (x : (map (0:) ((ref . subMatrix . clearFirstCol) $ (x:xs))))
    where
        firstColZero x = all (==0) (map head x)
        subMatrix x = map tail $ tail x
        clearFirstCol (x:xs) = (x:map (scaledSubtract x) xs)
        scaledSubtract :: (Fractional a, Ord a) => [a] -> [a] -> [a]
        scaledSubtract (x:xs) (y:ys)
          | y == 0    = (0:ys)
          | otherwise = vector add (scaled y (x:xs)) (y:ys)
          where
              scaled :: (Fractional a) => a -> [a] ->[a]
              scaled y (x:xs) = map (*(-y/x)) (x:xs)


identityMatrix :: (Eq a, Enum a, Num a, Fractional b) => a -> [[b]]
identityMatrix 0 = [[]]
identityMatrix n = [[if i == j then 1.0 else 0.0 | j<-[1..n]]|i<-[1..n]]

turnI x = map (reverse) (reverse (ref (reverse (map (reverse) x))))

-- invert :: (Fractional a, Ord a) => [[a]] -> [[a]]
invert x
    | numRows x /= numCols x    = error "Not a square matrix"
    | (allZero . last . ref) $ x = error "Not invertible - does not have proper rank"
    | otherwise                  = detachInverse len (restructMat len (ref (restructMat len (ref $ (zipWith (++) x (identityMatrix (len)))))))
    where
        len = length x
        allZero x = all (==0) x
        restructMat n x = attachBackwards (map (splitAt n) x)
        attachBackwards x = zipWith (++) (fullReverse (map (fst) x)) (fullReverse (map (snd) x))
        detachInverse n x = map (take n) x
