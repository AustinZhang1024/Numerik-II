#import "conf.typ": conf

#show: conf.with(exercise_num: [05])

= Properties of the matrix obtained with the finite difference discretization.

== a

Let $underline(x) = vec(x_1, x_2, dots, x_(n-1))$

So we can get:

$
  underline(x)^T A underline(x) =& 1 / h^2 (2x_1-x_2, 2x_2-x_1-x_3, dots, 2x_(n-1)-x_(n-2)) underline(x) \
  =& 1 / h^2 [(2x_1-x_2)x_1 + (2x_2-x_1-x_3)x_2 + dots + (2x_(n-1)-x_(n-2))x_(n-1)] \
  =& 1 / h^2 (2x_1^2-x_1x_2 + 2x_2^2-x_1x_2-x_1x_3 + dots + 2x_(n-1)^2-x_(n-2)x_(n-1)) \
  =& 1 / h^2 [x_1^2 + (x_1^2 - 2x_1x_2+x_2^2) + dots + (x_(n-1)^2 - 2x_(n-1)x_(n-2) + x_(n-2)^2) + x_(n-1)^2] \
  =& 1 / h^2 [x_1^2 + (x_1-x_2)^2 + (x_2-x_3)^2 + dots + (x_(n-1)-x_(n-2))^2 + x_(n-1)^2] \
  gt.eq.slant 0
$

And $underline(x)^T A underline(x)=0$ iff $underline(x)=0$.

So according to Definition 2.10, $A$ is positive definite.

== b

According to Definition 2.5, we only need to prove $A underline(v_k) = lambda_k underline(v_k)$.

So we need to prove:

$
  A underline(v_k) =& 1 / h^2 vec(
    2v_(k,1) - v_(k,2),
    2v_(k,2) - v_(k,1) - v_(k,3),
    dots,
    2v_(k,n-1) - v_(k,n-2)
  ) = vec(
    lambda_k v_(k,1),
    lambda_k v_(k,2),
    dots,
    lambda_k v_(k,n-1)
  ) = lambda_k underline(v_k)
$

Firstly, we can get:

$
  2 v_(k,1) - v_(k,2) =& 2 sin((k pi)/n) - sin((2k pi)/n) \
  =& 2 sin((k pi)/n) - 2 sin((k pi)/n) cos((k pi)/n) \
  =& 2 sin((k pi)/n) (1 - cos((k pi)/n)) \
  =& 4 sin^2((k pi) / (2n)) sin((k pi)/(n)) \
  =& h^2 lambda_k v_(k,1)
$

Secondly, for $i=2,3,n-2$, and sum-to-product identities (which we will prove later), we can get:

$
  2 v_(k,i) - v_(k,i-1) - v_(k,i+1) =& 2 sin((i k pi)/n) - sin(((i-1)k pi)/(n)) - sin(((i+1)k pi)/(n)) \
  =& 2 sin((i k pi)/n) - (sin(((i-1)k pi)/(n)) + sin(((i+1)k pi)/(n))) \
  =& 2 sin((i k pi)/n) - 2 sin((i k pi)/n) cos((k pi)/n) \
  =& 2 sin((i k pi)/n) (1 - cos((k pi)/n)) \
  =& 4 sin^2((k pi) / (2n)) sin((i k pi)/(n)) \
  =& h^2 lambda_k v_(k,i)
$

Finally, we can get:

$
  2 v_(k,n-1) - v_(k,n-2) =& 2 sin(((n-1)k pi) / n) - sin(((n-2)k pi) / (n)) \
  =& 2 sin(k pi - (k pi) / n) - sin(k pi - (2k pi) / n) \
  =& 2 [sin(k pi) cos((k pi) / n) - cos(k pi) sin((k pi) / n)] \
  &- [sin(k pi) cos((2k pi) / n) - cos(k pi) sin((2k pi) / n)] \
  =& cos(k pi)(sin((2k pi) / n)-2 sin((k pi) / n)) & #text(red)[$aleph$] \
  =& cos(k pi)(2 sin((k pi) / n)cos((k pi) / n) - 2 sin((k pi) / n)) \
  =& 2 cos(k pi) sin((k pi) / n)(cos((k pi) / n) - 1) \
  =& -4 sin^2((k pi) / (2n)) cos(k pi)sin((k pi) / n) \
  =& h^2 lambda_k (sin(k pi)cos((k pi) / n) -cos(k pi)sin((k pi) / n)) &#h(3em) #text(red)[$bet$] \
  =& h^2 lambda_k sin(k pi - (k pi) / n) \
  =& h^2 lambda_k v_(k,n-1)
$

In step $aleph$ and step $bet$, we use $sin(k pi)=0$.

=== sum-to-product identities

$
  sin(theta+phi) + sin(theta-phi) =& (sin theta cos phi + cos theta sin phi) + (sin theta cos phi - cos theta sin phi) \
  =& 2 sin theta cos phi
$

= Richarson iteration.

Code is shown in `2.ipynb`

After running the code, we can get:

+ The *bigger* the damping parameter, the *faster* the convergence.
+ The *wider* the mesh width, the *faster* the convergence.

The figure below shows the logarithm of iteration number with different damping parameters and mesh widths.

#align(center)[
  #image("richardson.png", width: 70%)
]
