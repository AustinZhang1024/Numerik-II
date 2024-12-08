#import "conf.typ": conf

#show: conf.with(exercise_num: [08])

= Matrix exponential.

== i

Firstly, we can get:

$
  norm(A^k)=norm(A dot.c A dots A) lt.eq.slant norm(A) norm(A) dots norm(A) = norm(A)^k
$

So we can get:

$
  norm(A^k/k!) lt.eq.slant norm(A^k) / k!
$

If we can prove for every $A$, holds $sum_(k=0)^infinity norm(A^k) / k! $ converges, then we can prove this problem.

Let $a=norm(A)$ and $a_k = a^k/k!$.

So we can get:

$
  lim_(k->infinity) (a_(k+1) / a_k) = lim_(k->infinity) (a / (k+1)) = 0 < 1
$

By ratio test, we can get $sum_(k=0)^infinity a_k$ converges.

Above all, we can get $sum_(k=0)^infinity norm(A^k) / k! $ converges absolutely for all $A in R^(n times n)$.

== ii

According to Definition 2.24, we can get:

$
  e^(A+B) =& sum_(k=0)^infinity ((A+B)^k) / k! \
  =& sum_(k=0)^infinity (sum_(i=0)^k binom(k, i)A^i B^(k-i)) / k! \
  =& sum_(k=0)^infinity (sum_(i=0)^k k! / (i!(k-i)!) A^i B^(k-i)) / k! \
  =& sum_(k=0)^infinity sum_(i=0)^k (A^i B^(k-i)) / (i!(k-i)!)
$ <A_add_B>

and

$
  e^A e^B = sum_(i=0)^infinity A^i / i! sum_(j=0)^infinity B^j / j! \
$ <A_times_B>

For every k, i in @A_add_B makes $(A^i B^(k-i))/(i!(k-i)!)$,
we can find that $j=k-i$ makes there are two elements $A^i/i!$ and $B^(j)/j! = B^(k-i)/(k-i)!$ in @A_times_B that are the same as $(A^i B^(k-i))/(i!(k-i)!)$ and vice versa.

So

$
  sum_(k=0)^infinity sum_(i=0)^k (A^i B^(k-i)) / (i!(k-i)!) = sum_(i=0)^infinity A^i / i! sum_(j=0)^infinity B^j / j!
$

== iii

According to ii, and $A(-A)=(-A) A$, we can get:

$
  e^A e^(-A) = e^(A-A) = e^(0) = I
$

So $e^A$ is invertible and $(e^A)^(-1) = e^(-A)$.

== iv

We have a square matrix $A$, then $A$ is invertible iff $A$ has rank $n$.

According to iii, we can get $e^A$ is invertible.

So $"rank"(e^A) = n$

So $det(e^A)!=0$
== v

$
  upright(d) / (upright(d)x) e^(A x) =& lim_(h->0) (e^(A(x+h)) - e^(A x)) / h \
  =& lim_(h->0) (e^(A x) e^(A h) - e^(A x)) / h \
  =& e^(A x) lim_(h->0) (e^(A h) - I) / h \
  =& e^(A x) lim_(h->0) (sum_(k=0)^infinity ((A h)^k) / k! - I) / h \
  =& e^(A x) lim_(h->0) (I + A h + sum_(k=2)^infinity (A^k h^k) / k! -I) / h \
  =& e^(A x) lim_(h->0) (A + sum_(k=2)^infinity (A^k h^(k-1)) / k!) \
  =& A e^(A x)
$

= Stability function at $infinity$.

According to Definition 2.12, we can get the definition of stability function at $infinity$:

$
  R(infinity) =& lim_(z->infinity) R(z) \
  =& lim_(z->infinity) 1+z bold(b)^T (I-z A)^(-1)bold(1) \
  =& 1+lim_(z->infinity) z bold(b)^T (z(I / z - A))^(-1)bold(1) \
  =& 1+lim_(z->infinity) z bold(b)^T 1 / z (I / z - A)^(-1)bold(1) \
  =& 1+lim_(z->infinity) bold(b)^T (I / z - A)^(-1)bold(1) \
  =& 1+bold(b)^T (- A)^(-1) bold(1) \
  =& 1-bold(b)^T A^(-1) bold(1) \
$

So we only need to prove $bold(b)^T A^(-1) bold(1) = 1$.

Let $A = mat(a_11, a_12, dots, a_(1 s);
a_21, a_22, dots, a_(2 s);
dots.v, dots.v, , dots.v;
a_(s 1), a_(s 2), dots, a_(s s))$ and $bold(x) = vec(x_1, x_2, dots.v, x_s)^T = bold(b)^T A^(-1)$.

So $bold(x) A = bold(b)^T$ and $bold(b)^T A^(-1) bold(1) = sum_(i=1)^s x_i$. Then we can get:

$
  cases(
    a_11 x_1 + a_21 x_2 + dots + a_(s 1) x_s = b_1,
    a_12 x_1 + a_22 x_2 + dots + a_(s 2) x_s = b_2,
    dots,
    a_(1 s) x_1 + a_(2 s) x_2 + dots + a_(s s) x_s = b_s
  )
$ <A_x_b>

== Case (a)

In this case, we can get:

$
  cases(
    a_11 x_1 + a_21 x_2 + dots + a_(s 1) x_s = a_(s 1),
    a_12 x_1 + a_22 x_2 + dots + a_(s 2) x_s = a_(s 2),
    dots,
    a_(1 s) x_1 + a_(2 s) x_2 + dots + a_(s s) x_s = a_(s s)
  )
$

or

$
  cases(
    a_11 x_1 + a_21 x_2 + dots + a_(s 1) (x_s-1) = 0,
    a_12 x_1 + a_22 x_2 + dots + a_(s 2) (x_s-1) = 0,
    dots,
    a_(1 s) x_1 + a_(2 s) x_2 + dots + a_(s s) (x_s-1) = 0
  )
$

Because $A$ is non-singular, we can get $x_1 = x_2 = dots = x_s - 1 = 0$.

So $sum_(i=1)^s x_i = 1$

== Case (b)

From the first line of @A_x_b, we can get

$
  b_1 x_1 + b_1 x_2 + dots + b_1 x_s = b_1
$

So $sum_(i=1)^s x_i = 1$

Above all, we can get $sum_(i=1)^s x_i = 1$ or $R(infinity)=0$ if one of condition a and b satisfied.

= Second order boundary value problem with first order term and upwind discretization, GMRES with restart.

Code is shown in `sheet08_3.ipynb`.

We can get the number of iterations of GMRES(restart) is bigger than GMRES. As $epsilon$ decreases, the number of iterations of GMRES(restart) decreases faster than Jacobi method and Gauss Seidel method. But the number of iterations of GMRES(restart) is still bigger than Gauss Seidel method when restart and $epsilon$ is small.

As $epsilon$ decreases and restart increases, the number of iterations of GMRES(restart) decreases.