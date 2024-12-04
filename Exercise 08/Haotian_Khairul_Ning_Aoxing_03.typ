#import "conf.typ": conf

#show: conf.with(exercise_num: [08])

= Matrix exponential.

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
  e^A e^(-A) = e^(A-A) = e^(0) = bold(1)
$

So $e^A$ is invertible and $(e^A)^(-1) = e^(-A)$.

== v

$
  upright(d) / (upright(d)x) e^(A x) =& lim_(h->0) (e^(A(x+h)) - e^(A x)) / h \
  =& lim_(h->0) (e^(A x) e^(A h) - e^(A x)) / h \
  =& e^(A x) lim_(h->0) (e^(A h) - bold(1)) / h \
  =& e^(A x) lim_(h->0) (sum_(k=0)^infinity ((A h)^k) / k! - 1) / h \
  =& e^(A x) lim_(h->0) (1 + A h + sum_(k=2)^infinity (A^k h^k) / k! -1) / h \
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

// TODO: How to prove here?

= Second order boundary value problem with first order term and upwind discretization, GMRES with restart.