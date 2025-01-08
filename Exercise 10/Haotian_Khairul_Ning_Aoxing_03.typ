#import "conf.typ": conf

#show: conf.with(exercise_num: [09])

= Stability function of ode23s.

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

// TODO: Maybe modified according to the hint.

= M-matrices.
