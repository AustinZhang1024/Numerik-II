#import "conf.typ": conf

#show: conf.with(exercise_num: [04])

= Embedded Runge-Kutta scheme with two stages.

According to Remark 1.41, the Butcher tableau of an embedded Runge-Kutta scheme with two stages is:

#align(center)[#table(
    columns: 4,
    stroke: none,
    $0$, table.vline(), [], [],[],
    $c_2$, $a_21$, [],table.hline(),[],
    [], $b_1$, $b_2$,$p=1$,
    [], $accent(b_1,tilde)$, $accent(b_2,tilde)$,$q=2$
  )
]

From Theorem 1.26, Theorem 1.27 and Remark 1.28, we have:

$
  cases(
    a_21 = b_1,
    b_1 + b_2 = 1,
    accent(b_1,tilde) + accent(b_2,tilde) = 1,
    c_2 = a_21,
    accent(b_2,tilde) c_2 = 1/2
  )
$

So, we can get:

#align(center)[#table(
    columns: 4,
    stroke: none,
    $0$, table.vline(), [], [],[],
    $c_2$, $c_2$, [],table.hline(),[],
    [], $c_2$, $1-c_2$,$p=1$,
    [], $1-1 / (2c_2)$, $1 / (2c_2)$,$q=2$
  )
]

If $c_2=1$, we have:

#align(center)[#table(
    columns: 4,
    stroke: none,
    $0$, table.vline(), [], [],[],
    $1$, $1$, [],table.hline(),[],
    [], $1$, $0$,$p=1$,
    [], $1 / 2$, $1 / 2$,$q=2$
  )
]

For $p=1$, this is the explicit Euler method.

For $q=2$, this is the method of Heun (Page 15).

= Convergence of damped Jacobi method.

Let $G_("Jac")$ and $G_("dJac")$ be the iteration matrix of Jacobi method and damped Jacobi method.

According to Theorem 3.3, Jacobi method converages if and only if $rho(G_("Jac"))<1$

Let $lambda$ is an eigenvalues of $G_("Jac")$, $mu$ is an eigenvalue of $G_("dJac")$

So $-1 lt.eq.slant -rho(G_("Jac")) lt.eq.slant lambda lt.eq.slant rho(G_("Jac")) < 1$

According to Lemma 3.12, so we can get:

$
  mu =& 1 - omega + omega lambda \
  lt.eq.slant& 1 - omega + omega rho(G_("Jac")) \
  <& 1 - omega + omega = 1
$

and
$
  mu =& 1 - omega + omega lambda \
  gt.eq.slant& 1 - omega + omega (-rho(G_("Jac"))) \
  >& 1 - omega - omega = 1 - 2 omega \
  gt.eq.slant& -1
$

So $-1 lt.eq.slant mu lt.eq.slant 1$, which means damped Jacobi method converages.

= Optimal relaxation parameter for SOR method.

Behavior of the relaxation parameter $W_("OPT")$ as $h$ decreases.
The formula for the optimal relaxation parameter is

$
  W_("OPT") = 2 / (1+sin(pi h))
$

As the grid spacing $h$ decreases, $sin(pi h)$ approaches $0$, the SOR method requires a higher relaxation parameter
for optimal performance, maximizing at 2.

$W_("OPT")$ is designed to minimize the spectral radius of the iteration matrix.
Thus accelerating the convergence.

Across different grid sizes, $W_("OPT")$ should consistently yield
the lowest iteration count needed for convergence compared to other values.

The gap in iteration counts between $W_("OPT")$ and other relaxation parameters will
widen emphasizing the advantage of using the optimal value in large systems.

= Optimal damping parameter for Richarson iteration with s.p.d. matrix.

According to Definition 4.2, the iteration matrix is $G = I-alpha A$

So, $rho(G) = max |1-alpha lambda_i|$, where $lambda_i$ is the eigenvalues of $A$

Because $A$ is s.p.d. matrix, so $lambda_i > 0$

Let $lambda_("max")=max lambda_i$, $lambda_("min")=min lambda_i$

== Case I

When $alpha < 0$, $rho(G) = max |1-alpha lambda_i|=1-alpha lambda_("max") > 1$

== Case II

When $alpha = 0$, $rho(G) = max |1-alpha lambda_i|=1$

== Case III

When $alpha > 0$, we have $1-alpha lambda_("min") gt.eq.slant 1-alpha lambda_("max")$

=== Case 3.1

When $1-alpha lambda_("min") gt.eq.slant 1-alpha lambda_("max") gt.eq.slant 0$, we have $0 < alpha lt.eq.slant 1/lambda_("max") lt.eq.slant 1/lambda_("min")$ and

$
  rho(G) =& 1-alpha lambda_("min") \
  gt.eq.slant& (lambda_("max")-lambda_("min")) / lambda_("max")\
  >& (lambda_("max")-lambda_("min")) / (lambda_("max")+lambda_("min"))
$

=== Case 3.2

When $0 gt.eq.slant 1-alpha lambda_("min") gt.eq.slant 1-alpha lambda_("max")$, we have $alpha gt.eq.slant 1/lambda_("min")$ and

$
  rho(G) =& alpha lambda_("max")-1 \
  gt.eq.slant& (lambda_("max")-lambda_("min")) / lambda_("min")\
  >& (lambda_("max")-lambda_("min")) / (lambda_("max")+lambda_("min"))
$

=== Case 3.3

When $1-alpha lambda_("min") gt.eq.slant 0 gt.eq.slant 1-alpha lambda_("max")$, we have:

$
  rho(G) =& max{|1-alpha lambda_("min")|, |1-alpha lambda_("max")|} \
  =& max{1-alpha lambda_("min"), alpha lambda_("max")-1} \
$

==== Case 3.3.1

When $1-alpha lambda_("min") > alpha lambda_("max")-1$, we have $0 < alpha < 2/(lambda_("max")+lambda_("min"))$,

$
  rho(G) =& |1-alpha lambda_("min")| \
  =& 1-alpha lambda_("min") \
  >& (lambda_("max")-lambda_("min")) / (lambda_("max")+lambda_("min"))
$

==== Case 3.3.2

When $1-alpha lambda_("min") = alpha lambda_("max")-1$, we have $alpha = 2/(lambda_("max")+lambda_("min"))$,

$
  rho(G)=(lambda_("max")-lambda_("min")) / (lambda_("max")+lambda_("min")) < 1
$

==== Case 3.3.3

When $1-alpha lambda_("min") < alpha lambda_("max")-1$, we have $alpha > 2/(lambda_("max")+lambda_("min"))$,

$
  rho(G) =& |1-alpha lambda_("max")| \
  =& alpha lambda_("max")-1 \
  >& (lambda_("max")-lambda_("min")) / (lambda_("max")+lambda_("min"))
$

Above all, the optimal damping parameter is $2/(lambda_("max")+lambda_("min"))$.

In this case, $rho(G) < 1$, so the iteration converages.