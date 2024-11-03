#import "conf.typ": conf

#show: conf.with(exercise_num: [02])

= Repetition: Analytical solution of an initial value problem.

Firstly, we solve homogeneous form of the equation:

$
  &x y' + 3y=0 \
  =>& x (text("d.")y) / (text("d.")x) + 3y=0 \
  =>& (text("d.")y) / y = -(3text("d.")x) / x \
  =>& ln|y| = -3ln|x|+ln C \
  =>& y = C x^(-3)
$

Then we make $y=C(x)x^(-3)$, and put it into the original equation. We can get:

$
  &x(-3x^(-4)C(x)+x^(-3)C'(x))+3C(x)x^(-3)=x^2 \
  =>&C'(x)=x^4 \
  =>&C(x)=1 / 5 x^5+C
$

So the solution of the original equation is:

$
  y = 1 / 5 x^2 + C x^(-3)
$

and because $x_0=0$, $y_0=0$, so we can get $C=0$.

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

Code is shown in the attachment `3b.py`.

And the result is:

#align(center)[#table(align: center, columns: 6, $1/8$, $1/16$, $1/32$, $1/64$, $1/128$, $1/256$, $0.1785$, $0.0063$, $0.0022$, $0.0008$, $0.0003$, $9.8757 times 10^(-5)$)]

== (c)

For $h_1$, $h_2$, we have:

$
  cases(norm(u-u_(h_1))_(l^2)=c h_1^alpha, norm(u-u_(h_2))_(l^2)=c h_2^alpha)
$

so:

$
  norm(u-u_(h_1))_(l^2) / norm(u-u_(h_2))_(l^2) = (h_1 / h_2)^alpha
$

and we can get:

$
  alpha = log(norm(u-u_(h_1))_(l^2) / norm(u-u_(h_2))_(l^2)) / log(h_1 / h_2)
$

From 3.b, we can get the 2 finest grids are $h_1=1/128$, $h_2=1/256$, and the corresponding errors are $2.79325571 times 10^(-4)$, $9.87567759 times 10^(-05)$.

So, we can get:

$
  alpha = log((2.79325571 times 10^(-4)) / (9.87567759 times 10^(-5))) / log((1/128) / (1/256)) = 1.4999960104358394
$