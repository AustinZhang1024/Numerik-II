#import "conf.typ": conf

#show: conf.with(exercise_num: [11])

= BDF2 with variable step size.

Consider the Newtown polynomial $p(x)$ of degree 2 through the points $(x_(k+1), y_(k+1)), (x_k, y_k), (x_(k-1), y_(k-1))$.

Then we have:

$
  p(x) &= [y_(k+1)] + (x - x_(k+1)) [y_(k+1), y_k] + (x-x_(k+1))(x - x_k) [y_(k+1), y_k, y_(k-1)] \
  &= y_(k+1) + (x - x_(k+1)) (y_k - y_(k+1)) / (x_k - x_(k+1)) + ((x - x_(k+1))(x - x_k)) / (x_(k-1)-x_(k+1))((y_(k-1)-y_k) / (x_(k-1)-x_k) - (y_k-y_(k+1)) / (x_k-x_(k+1))) \
  &= y_(k+1) + (x - x_(k+1)) (y_(k+1) - y_k) / h_(k+1) - ((x - x_(k+1))(x - x_k)) / (h_k+h_(k+1))((y_k-y_(k-1)) / (h_k) - (y_(k+1)-y_k) / (h_(k+1)))
$

Then we have:

$
  p'(x) &= (y_(k+1) - y_k) / h_(k+1) - ((x - x_(k+1))+(x-x_k)) / (h_k+h_(k+1))((y_k-y_(k-1)) / (h_k) - (y_(k+1)-y_k) / (h_(k+1)))
$

Then we have:

$
  f(x_(k+1), y_(k+1)) =& p'(x_(k+1)) \
  =& (y_(k+1) - y_k) / h_(k+1) - h_(k+1) / (h_k+h_(k+1))((y_k-y_(k-1)) / (h_k) - (y_(k+1)-y_k) / (h_(k+1))) \
  =& h_(k+1) / (h_k (h_k+h_(k+1)))y_(k-1) - (1 / h_(k+1)+h_(k+1) / (h_k (h_k+h_(k+1)))+1 / (h_k+h_(k+1)))y_k \
  & + (1 / h_(k+1)+1 / (h_k+h_(k+1)))y_(k+1) \
  =& sigma_(k+1) / (h_k+h_(k+1))y_(k-1) - (sigma_(k+1)^2+2sigma_(k+1)+1) / (h_(k+1)(sigma_(k+1)+1))y_k + (2sigma_(k+1)+1) / (h_(k+1)(sigma_(k+1)+1))y_(k+1)
$

= Properties of M-matrices.

Recall the Definition 8.17 of M-matrices.
There are 3 conditions:

+ $a_(i j) lt.eq.slant 0$ for $i,j = 1, ..., n, i!=j$
+ $A$ is non-singular
+ $A^(-1)$ is non-negative

= a

First of all,
we consider multiply a positive number $c$ with the $k$-th row of $A$.
Then we get a new matrix $B$.
We define $A=(a_(i j))$,
and the new matrix $B = (b_(i j))$.
Then we have $b_(k j) = c a_(k j)$ in which $k in [n]$,
and $b_(i j) = a_(i j)$ in which $i != k$.

Now,
condition 1 is still satified because $c > 0$.

As for condition 2,
since $A$ is non-singular,
the determinant of $A$ is not zero.
Then the determinant of $B$ is $c det(A)$.
Still satified.

Now,
we only need to prove that $B^(-1)$ is non-negative.

We can consider the adjugate matrix of $A$ and $B$.
Because $A^(-1)=(op("adj")(A))/det(A)$.

According to the definition of the adjugate matrix,
we have:

$
  op("adj")(A) stretch(=)^(M "is the minor of" A) ((-1)^(i+j)M_(j i))
$

$
  op("adj")(B) stretch(=)^(N "is the minor of" B) ((-1)^(i+j)N_(j i))
$

Then we have $N_(i j) = M_(i j)$ in which $i=k$,
and $N_(i j) = c M_(i j)$ in which $i != k$.
Which means the signature of $M_(i j)$ and $N_(i j)$ are the same.

So we have $B^(-1)$ keeps non-negative.

Above all,
we can prove that $B$ is also a M-matrix.
Or more formally,
$A$ is a M-matrix and $c > 0$,
then multiplying a positive number $c$ with the $k$-th row of $A$,
the new matrix $B$ is also a M-matrix.

If we multiply a positive number $c$ with the $k$-th column of $A$,
we have $B^T$ is also a M-matrix.
So condition 1 and 2 are still satified.

And we have $(B^T)^(-1)=(B^(-1))^T$,
so $B^(-1)$ is also non-negative. #h(1fr) #math.qed

= b

Consider the matrix $A= mat(1,-2;0,1)$ and $B=mat(1,0;-2,1)$

Then we have $A^(-1)=mat(1,2;0,1)$ and $B^(-1)=mat(1,0;2,1)$

So both $A$ and $B$ are M-matrices.

But $A+B=mat(2,-2;-2,2)$,
which means $det(A+B)=0$.
So $A+B$ is singular and is not a M-matrix. #h(1fr) #math.qed

= Preconditioned conjugate gradient (PCG) method.

Code can be seen in `sheet11_3.ipynb`.

So we can get the number of iteration for each precondition.

The result is as follows:

#align(center)[
  #table(
    align: center,
    columns: 9,
    $h$,
    $1 / 8$,
    $1 / 16$,
    $1 / 32$,
    $1 / 64$,
    $1 / 128$,
    $1 / 256$,
    $1 / 512$,
    $1 / 1024$,

    $M=I$, $4$, $8$, $16$, $32$, $64$, $128$, $256$, $513$,
    $M=op("diag")(A)$, $4$, $8$, $16$, $32$, $64$, $128$, $256$, $512$,
    $M=op("SSOR")(A)$, $7$, $15$, $28$, $49$, $89$, $168$, $300$, $467$,
    $M=L^T L$, $7$, $11$, $12$, $13$, $15$, $16$, $17$, $18$,
  )
]

According to the result,
we can find that the number of iteration for $M=I$ and $M=op("diag")(A)$ are approximately equal to $1/(2h)$.
The number of iteration for $M=op("SSOR")(A)$ is a bit slower than no preconditioning and Jacobi preconditioner, however, it performs better than them then the step size is very small($h=1/1024$).
As for $M=L^T L$,
the number of iteration is the smallest among all the preconditioners and the number of iteration grows linearly when $h$ decreases exponentially.

And in this condition,
$op("diag")(A) = 2/h^2 I$,
$underline(z)_k$ maybe smaller compared to $M=I$,
but the coefficient $1/h^2$ does not affect the value of $underline(x)^((k))$,
$underline(r)^((k))$ and $mu_(k+1)$.
So we can consider $M=op("diag")(A)$ just changes the while loop condition smaller than the condition of $M=I$ by times the number $h^2/2$.
It should be a little bit faster than $M=I$,
but when $epsilon$ is very small,
the difference is not significant.
