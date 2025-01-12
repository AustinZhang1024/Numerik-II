#import "conf.typ": conf

#show: conf.with(exercise_num: [10])

= Stability function of ode23s.

To find the stability function of `ode23s`,
we can consider the following ODE:

$
  y'(x) = lambda y(x); quad y(0) = 1
$

In this case, $f(y) = lambda y$,
and $J = lambda$

So, we can calculate the butcher tableau now.

According to the definition 1.22,
we can get:

$
  cases(
  K_1 = f(y_k + h a_11K_1+h a_12 K_2) = lambda (y_k + h a_11K_1+h a_12 K_2),
  K_2 = f(y_k + h a_21K_1+h a_22 K_2) = lambda (y_k + h a_21K_1+h a_22 K_2),
  Phi = b_1K_1 + b_2K_2,
  )
$

And according to the question,
we can insert the values of $K_1$, $K_2$ into the above equations.
Then we can get:

$
  cases(
    (I-a h J)K_1 = f(y_k)= lambda y_k,
    (I-a h J)K_2 = f(y_k + 1/2 h K_1) - a h lambda K_1 = lambda (y_k + 1/2 h K_1) - a h lambda K_1
  )
$

Now, we can get
$K_1=(lambda y_k)/(1-a h lambda)$ and

$
  K_2 &= (lambda (y_k + 1 / 2 h K_1) - a h lambda K_1) / (1-a h lambda) \
  &=(lambda (y_k + 1 / 2 h (lambda y_k) / (1-a h lambda)) - a h lambda (lambda y_k) / (1-a h lambda)) / (1-a h lambda) \
  &=(lambda (1-a h lambda)y_k + 1 / 2 h lambda^2 y_k - a h lambda^2y_k) / (1-a h lambda)^2
$

Because of $a = 1/(2+sqrt(2))$, we can get:

$
  a^2 &= 1 / (2+sqrt(2))^2 \
  &= ((2-sqrt(2)) / ((2+sqrt(2))(2-sqrt(2))))^2 \
  &= ((2-sqrt(2)) / 2)^2 \
  &= (4+2-4sqrt(2)) / 4 \
  &= (8-4sqrt(2)-2) / 4 \
  &= 2a-1 / 2
$

So,

$
  y_(k+1) &= y_k + h K_2 \
  &= y_k + h (lambda (1-a h lambda)y_k + 1 / 2 h lambda^2 y_k - a h lambda^2y_k) / (1-a h lambda)^2 \
  &= (y_k (1-a h lambda)^2 + h (lambda (1-a h lambda)y_k + 1 / 2 h lambda^2 y_k - a h lambda^2y_k)) / (1-a h lambda)^2 \
  &= (1+(1-2a)h lambda + (a^2-2a+1 / 2)h^2 lambda^2) / (1-a h lambda)^2y_k \
  &stretch(=)^(a^2=2a-1 / 2) (1+(1-2a)h lambda) / (1-a h lambda)^2y_k \
  &stretch(=)^("Remark 2.10") (1+(1-2a)z) / (1-a z)^2y_k
$

= 3-step Adams-Bashforth method.

According to Example 3.5,
we can get the 3-step Adams-Bashforth method as follows:

$
  cases(
    y_(k+1) = y_k + h (beta_0 f(x_(k), y_(k))+beta_1 f(x_(k-1), y_(k-1))+beta_2 f(x_(k-2), y_(k-2))),
    beta_0 = integral_0^1 (s+1)/1 (s+2)/2 text("d\u{200b}")s,
    beta_1 = integral_0^1 s/(-1) (s+2)/1 text("d\u{200b}")s,
    beta_2 = integral_0^1 (s)/(-2) (s+1)/(-1) text("d\u{200b}")s,
  )
$

Now, we can calculate the $beta_i$,
and then we can get the answer.

$
  beta_0 &= integral_0^1 (s+1) / 1 (s+2) / 2 text("d\u{200b}")s \
  &= 1 / 2 integral_0^1 s^2 + 3s + 2 text("d\u{200b}")s \
  &= 1 / 2 lr((1/3 s^3 + 3/2 s^2 + 2s) |)_0^1 \
  &= 1 / 2 (1 / 3 + 3 / 2 + 2) \
  &= 23 / 12
$

$
  beta_1 &= integral_0^1 s / (-1) (s+2) / 1 text("d\u{200b}")s \
  &= -1 integral_0^1 s^2 + 2s text("d\u{200b}")s \
  &= -1 lr((1/3 s^3 + s^2) |)_0^1 \
  &= -1 (1 / 3 + 1) \
  &= -4 / 3
$

$
  beta_2 &= integral_0^1 s / (-2) (s+1) / (-1) text("d\u{200b}")s \
  &= 1 / 2 integral_0^1 s^2 + s text("d\u{200b}")s \
  &= 1 / 2 lr((1/3 s^3 + 1/2 s^2) |)_0^1 \
  &= 1 / 2 (1 / 3 + 1 / 2) \
  &= 5 / 12
$

So the 3-step Adams-Bashforth method is:

$
  y_(k+1) &= y_k + h (23 / 12 f(x_(k), y_(k))-4 / 3 f(x_(k-1), y_(k-1))+5 / 12 f(x_(k-2), y_(k-2))) \
  &= y_k + h / 12 (23 f(x_(k), y_(k))-16 f(x_(k-1), y_(k-1))+5 f(x_(k-2), y_(k-2)))
$

= Compressed sparse row storage format.

According to Example 3.7 in `csr.pdf`,
we can get the compressed sparse row storage format as follows:

#table(
  align: center,
  columns: 16,
  [AA],
  $4$,
  $-1$,
  $8$,
  $10$,
  $10$,
  $-3$,
  $8$,
  $2$,
  $-1$,
  $6$,
  $-1$,
  $17$,
  $-6$,
  $11$,
  $7$,

  [JA],
  $1$,
  $4$,
  $7$,
  $8$,
  $2$,
  $3$,
  $6$,
  $9$,
  $1$,
  $5$,
  $8$,
  $4$,
  $2$,
  $6$,
  $9$,

  [IA], $1$, $5$, $9$, $12$, $13$, $16$,
)

We can also let IA stands for the end of each row,
and JA still stands for the column index of each element.

So, the compressed sparse row storage format is:

#table(
  align: center,
  columns: 16,
  [AA],
  $4$,
  $-1$,
  $8$,
  $10$,
  $10$,
  $-3$,
  $8$,
  $2$,
  $-1$,
  $6$,
  $-1$,
  $17$,
  $-6$,
  $11$,
  $7$,

  [JA],
  $1$,
  $4$,
  $7$,
  $8$,
  $2$,
  $3$,
  $6$,
  $9$,
  $1$,
  $5$,
  $8$,
  $4$,
  $2$,
  $6$,
  $9$,

  [IA], $0$, $4$, $8$, $11$, $12$, $15$,
)

= M-matrices.

Let $A^(-1)=(c_(i j))$,
according to condition 2,
we can get $c_(i j) gt.eq.slant 0$ for $i,j in [n]$.

According to the definition of the mulply of matrixes,
we can get

$
  A A^(-1) = (sum_(k=1)^n a_(i k) c_(k j)) =I
$

So, we can get

$
  cases(
    sum_(k=1)^n a_(i k) c_(k j) = 1  & "for" i=j,
    sum_(k=1)^n a_(i k) c_(k j) = 0  & "for" i != j
  )
$

So,

$
  a_(i i) c_(i i) = 1 - sum_(k=1;k!=i)^n a_(i k) c_(k i) quad "for" i=j,
$<con>


According to @con,
we can get

$
  a_(i i) c_(i i) &= 1 - sum_(k=1;k!=i)^n a_(i k) c_(k i) \
  &stretch(gt.eq.slant)^((a_(i k)c_(k i)lt.eq.slant 0)) 1 > 0
$

So, $a_(i i)$ and $c_(i i)$ should both bigger than 0,
or both smaller than 0.

But $c_(i i) gt.eq.slant 0$,
so $a_(i i)>0$ and $c_(i i)>0$. #h(1fr) #math.qed
