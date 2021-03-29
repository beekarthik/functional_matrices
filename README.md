# Matrix Operations but with Functional Programming

## Preface
Long story short, my linear algebra ability is beyond subpar. Something about rows and columns is deeply upsetting to my brain and that makes working with matrices very difficult. Ask me to prove something about linear operators in generality? No problem. Ask me to multiply two matrices together and I cannot guarantee anything.

The goal with this project was to learn the basics of functional programming and hopefully in the future as I get better at FP, I can come back to this and make this rudimentary code faster, more elegant, and more readable.

## How to Use

To use this file you will need to [download GHC](https://www.haskell.org/downloads/) and the file matrix.hs. Then move to the directory with matrix.hs in terminal or command line and run...

    ghci
or

    stack ghci
depending on how you installed GHC. Once in the interactive session, run...

    :l matrix.hs
and you will have access to all of the functions listed below.

### Functions


`add, sub, dot` - self-explanatory binary operations for numbers


`vector, matrix` - takes a bivariate numeric function f and returns a functions that will apply f element-wise to two vectors or matrices

```Haskell
> let vdotprod = vector dot
> vdotprod [1,2,3] [4,5,6]
[4,10,18]

> matrix add [[1, 0],[0,1]] [[0, 1],[1,0]]
[[1,1],[1,1]]
```

`transpose` - takes a matrix and returns its transpose

 ```Haskell
 > transpose [[1,1,2],[3,5,8],[13,21,34]]
[[1,3,13],[1,5,21],[2,8,34]]
```

`mulMatrix` - take two matrices and computes their matrix product

`ref` - takes a matrix and returns it in row-echelon form also known as upper triangular form

```Haskell
> ref [[1,2,2,4,8],[0,1,1,2,6],[-1,-2,2,-4,8],[0,0,3,2,1]]
[[1,2,2,4,8],
 [0,1,1,2,6],
 [0,0,4,0,16],
 [0,0,0,2,-11]]
```

`identityMatrix` - takes in an input number n and return an identity matrix of size n

```Haskell
> identityMatrix 3
[[1,0,0],
 [0,1,0],
 [0,0,1]]
```

### Stuff To Come
- fix matrix inversion by implementing RREF
- solving augmented matrices
- finding eigenvalues/eigenvectors
- providing matrix diagonalization
- providing Jordan Canonical Form and Jordan basis


## Why Haskell
On a general level I think there are other people that do a far better job of explaining why functional programming is something worth learning. Here are some resources that I thought were truly brilliant.
- [This brilliant 10 minute intro](https://www.youtube.com/watch?v=RqvCNb7fKsg)
- [A 2 hour in depth lecture by the same guy](https://www.youtube.com/watch?v=8UfA7tUPil8) (This is the single best tutorial I have ever seen on the internet. It's pure genius please give it a watch)
- [A series of blog posts about FP](https://ryandsouza.in/blog/007-why-functional-programming-matters-1)

Personally, I found functional programming to be a very elegant way of instructing a computer. A lot of the time it felt like I was writing a combination of english and math, as one would in a proof. Very enjoyable programming experience and also I am please to learn that in a lot of different benchmarks, Haskell can come close to C in terms of performance. This should be the future.
