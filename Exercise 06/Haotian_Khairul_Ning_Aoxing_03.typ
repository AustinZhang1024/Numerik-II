#import "conf.typ": conf

#show: conf.with(exercise_num: [06])

= Radau-IA method.

According to Remark 2.6, we can get B(3) and D(2) as follows:

$
  B(3) =& cases(
    b_1 + b_2 = 1,
    b_1c_1 + b_2c_2 = 1/2,
    b_1c_1^2 + b_2c_2^2 = 1/3
  ) \
  D(
    2
  ) =& cases(
    b_1a_11+b_2a_21 = b_1(1-c_1),
    b_1a_12+b_2a_22 = b_2(1-c_2),
    b_1c_1a_11+b_2c_2a_21 = 1/2b_1(1-c_1^2),
    b_1c_1a_12+b_2c_2a_22 = 1/2b_2(1-c_2^2)
  )
$

Because the Radau-IA method takes the left boundary of the interval as a node,
we have $c_1 = 0$.

Therefore, we can get $b_1 = 1/4$, $b_2 = 3/4$ and $c_2 = 2/3$.

Then we can get $a_11 = 1/4$, $a_12 = -1/4$, $a_21 = 1/4$, $a_22 = 5/12$.

So the Butcher tableau of the Radau-IA method is:

#align(center)[#table(
    columns: 3,
    stroke: none,
    $0$, table.vline(), $1 / 4$, $-1 / 4$,
    $2 / 3$, $1 / 4$, $5 / 12$,table.hline(),
    [], $1 / 4$, $3 / 4$,
  )
]

= Representation of the numerical solution of the model IVP.

According to Definition 1.22, we can get:

$
  y_(k+1)=y_k+h bold(b)^T bold(K)
$

and according to Remark 2.10:

$
  bold(K) =& vec(
    K_1, K_2, dots.v, K_s
  ) \
  =& vec(
    f(
      t_k+c_1h, y_k+h sum_(j=1)^(s) a_(1j)K_j
    ),
    f(
      t_k+c_2h, y_k+h sum_(j=1)^(s) a_(2j)K_j
    ),
    dots.v,
    f(
      t_k+c_s h, y_k+h sum_(j=1)^(s) a_(s j)K_j
    )
  ) \
  =& vec(
    lambda(y_k + h sum_(j=1)^(s) a_(1j)K_j),
    lambda(y_k + h sum_(j=1)^(s) a_(2j)K_j),
    dots.v,
    lambda(y_k + h sum_(j=1)^(s) a_(s j)K_j)
  ) \
  =& lambda (bold(1) y_k + h bold(A)bold(K))
$

so, we can get:

$
  bold(K) = (bold(I)-lambda h bold(A))^(-1)lambda bold(1) y_k
  = (bold(I) - z bold(A))^(-1)lambda bold(1) y_k
$

So:

$
  y_(k+1) =& y_k + h bold(b)^T (bold(I) - z bold(A))^(-1)lambda bold(1) y_k \
  =& (1+z bold(b)^T (bold(I) - z bold(A))^(-1) bold(1))y_k
  =& R(h lambda) y_k
$

So:

$
  y_k =& R(h lambda) y_(k-1) \
  =& R(h lambda)^2 y_(k-2) \
  dots& \
  =& R(h lambda)^k y_0 \
  =& R(h lambda)^k
$

= Second order boundary value problem with first order term.

Code is shown in `ex06_3.ipynb`

== a

After running the code, we can get the following plot:

#align(center)[#image("a.png", width: 70%)]

And the line of $epsilon=10^(-4)$ and $epsilon=10^(-6)$ looks like a same line.

We can observe: the smaller the $epsilon$, the graph will be more like a straight line.

== b

With Taylor expansion, we can get:

$
  u_(x,i) =& (u(x_(i+1))-u(x_(i-1)))/(2h) \
  =& (u(x_(i)+h)-u(x_(i)-h))/(2h) \
  =& [(u(x_i)+h u'(x_i)+h^2/2 u''(x_i)+h^3/6 u'''(x_i)+o(h^3))\
  &-(u(x_i)-h u'(x_i)+h^2/2 u''(x_i)-h^3/6 u'''(x_i)+o(h^3))] div (2h) \
  =& (2h u'(x_i)+2h^3/6 u'''(x_i)+o(h^3))/(2h) \
  =& u'(x_i)+h^2/3 u'''(x_i)+o(h^2) \
  =& u'(x_i)+O(h^2)
$

== c



== d
