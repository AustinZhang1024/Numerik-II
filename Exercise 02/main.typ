#import "conf.typ": conf

#show: conf.with(exercise_num: [02])

= Repetition: Analytical solution of an initial value problem.

$
  x y'(x)+3 y(x)=x^2
$

both sides times $x^2$, we can get:

$
  x^3 y'(x)+3x^2y(x)=(x^3y(x))'=x^4
$

integrate both sides:

$
  x^3y(x)=1 / 5x^5+C
$

because $x_0=0$, $y_0=0$, so $C=0$

so:

$
  y(x)=1 / 5 x^2
$

= Estimate for a sequence of real numbers.

if $n=0$, the inequality is true.

if $n>0$, we can get:

$
  |x_n| &lt.eq.slant (1+delta)|x_(n-1)|+beta\
  &lt.eq.slant (1+delta)((1+delta)|x_(n-2)|+beta)+beta\
  &dots\
  &lt.eq.slant (1+delta)^n |x_0|+beta(1+delta+...+(1+delta)^(n-1))\
  &= (1+delta)^n |x_0|+(1-(1+delta)^n) / (1-(1+delta))beta\
  &= (1+delta)^n |x_0|+((1+delta)^n-1) / delta beta\
  &lt.eq.slant e^(n delta)|x_0|+(e^(n delta)-1) / delta beta
$

Now, we will prove $1+delta lt.eq.slant e^delta$.

let $g(delta)=delta - ln(1+delta)$, $delta>0$.

so $g'(delta)=1-1/(1+delta)=delta/(1+delta)>0$.

thus,
$
  g(delta)>lim_(delta -> 0^+)g(0)=0
$

so $1+delta lt.eq.slant e^delta$.

= Boundary value problem and the convergence of its finite difference approximation.

== (a)

$
  u''&=6pi cos(3pi x)-9pi^2x sin(3pi x) quad in (0,1)\
  u(0)&=0 \
  u(1)&=0
$

integrate both sides:

$
  u' = sin(3pi x)+3pi x cos(3pi x)+C_1
$

integrate both sides again:

$
  u = C_1 x + C_2 + x sin(3pi x)
$

plug in the boundary conditions:

$
  u(0)=C_2=0\
  u(1)=C_1+C_2+sin(3pi)=0
$

so:

$
  cases(C_1=0, C_2=0)
$

hence:

$
  u=x sin(3pi x)
$

== (b)

== (c)