#set math.equation(numbering: "(1)")

#let info = (
  ("Bai", "Haotian", "haotiab00@zedat.fu-berlin.de"),
  ("Islam", "Khairul", "khairui00@zedat.fu-berlin.de"),
  ("Luheng", "Ning", "ningl02@zedat.fu-berlin.de"),
  ("Zhang", "Aoxing", "aoxiz00@zedat.fu-berlin.de"),
)

#align(center)[
  #set par(spacing: 7pt)
  #text(size: 24pt, weight: "bold")[Numerical Mathematics II]

  #text(size: 18pt)[Exercise Problems 01]

  Exercise Group 03

  #for (first, last, email) in info [
    #box(width:7em)[#align(left)[#first, #last]] #box(width:12em)[#align(right)[#link("mailto:" + email)]] \
  ]

]

= Forward Euler method.

== (a)

$
  y'(x) = (1 / (1+x)-y(x)) / (1+x)=1 / (1+x)^2-y(x) / (1+x)
$

According to Example 1.5:

$
  y_(k+1) = y_k + h_k (1 / (1+x)^2-y_k / (1+x))
$

Code is as below:

#include "1a_code.typ"

therefore the answer is shown in the following figure:

#figure(image("1a.png", width: 80%))

and $y_k$ is shown in the following table:

#align(center)[#table(
    columns: 11,
    align: center,
    [$i$], [1], [2], [3], [4], [5], [6], [7], [8], [9], [10],
    [$h_1$], [0.9722], [0.9354], [0.8966], [0.8587], [0.8228], [], [], [], [], [],
    [$h_2$], [0.9917], [0.9785], [0.9624], [0.9447], [0.9262], [0.9074], [0.8886], [0.8701], [0.8520], [0.8344],
  )]

== (b)

$
  y(1) = (ln(2)+1) / 2
$

so the error is:

$
  |y(1)-y_k| = |(ln(2)+1) / 2-y_k|
$

the answer is shown in the following table:

#align(center)[#table(
    columns: 3,
    align: center,
    [$h$], [0.2], [0.1],
    [$|y(1)-y_k|$], [0.023756129962512418], [0.01218788869225873],
  )]

== (c)

According to the table above, we can get: *The error is decreasing as $h$ decreases.*

= Vector norms.

== (a)

From Remark 2.3, we just need to proove:

$
  lim_(p -> infinity) ||underline(x)||_p = lim_(p -> infinity) (
    sum^n_(i=1)|x_i|^p
  )^(1 / p)=max_(i=1,dots,n)|x_i| = ||underline(x)||_infinity
$

because $|underline(x_i)| > 0$, therefore:

$
  max_(i=1,dots,n)|x_i|^p lt.eq.slant sum^n_(i=1)|x_i|^p lt.eq.slant sum^n_(i=1)max_(i=1,dots,n)|x_i|^p=n times max_(i=1,dots,n)|x_i|^p
$

so we can get:

$
  &max_(i=1,dots,n)|x_i| = lim_(p -> infinity) (max_(i=1,dots,n)|x_i|^p)^(1 / p) \
  & lt.eq.slant lim_(p -> infinity) (sum^n_(i=1)|x_i|^p)^(1 / p) = lim_(p -> infinity) ||underline(x)||_p \
  &lt.eq.slant lim_(p -> infinity) (
    n times max_(i=1,dots,n)|x_i|^p
  )^(1 / p) = lim_(p -> infinity) n^(1 / p) max_(i=1,dots,n)|x_i|=max_(i=1,dots,n)|x_i| lim_(p -> infinity) n^(1 / p) \
  &= max_(i=1,dots,n)|x_i|
$

== (b)

Let $A=mat(a_(11), a_(12), dots.c, a_(1n); a_(21), a_(22), dots.c, a_(2n); dots.v, dots.v,,dots.v;
a_(n 1), a_(n 2), dots.c, a_(n n))$, $underline(x)=vec(x_1, x_2, dots.v, x_n)$, then we can get:

$
  A underline(x)=vec(sum^n_(j=1)a_(1j)x_j, sum^n_(j=1)a_(2j)x_j, dots.v, sum^n_(j=1)a_(n j)x_j)
$

thus:

$
  ||A underline(x)||_2=(sum^n_(i=1)|sum_(j=1)^n a_(i j)x_j|^2)^(1 / 2) &lt.eq.slant (
    sum^n_(i=1)sum_(j=1)^n|a_(i j)|^2|x_j|^2
  )^(1 / 2) \
  &= (sum^n_(i=1)sum_(j=1)^n|a_(i j)|^2 sum_(j=1)^n |x_j|^2)^(1 / 2) \
  &= (sum^n_(i=1)sum_(j=1)^n|a_(i j)|^2)^(1 / 2) (sum_(j=1)^n |x_j|^2)^(1 / 2) \
  &= ||A||_F ||underline(x)||_2
$

so we can get:

$
  ||A underline(x)||_2 lt.eq.slant ||A||_F ||underline(x)||_2
$

= Finite Difference matrix for the second order derivative

== (a)

$
  u_(x x,i)&=(u(x_(i+1))-2u(x_(i))+u(x_(i-1))) / h^2 \
  &stretch("=")^("Taylor expansion") ([u(x_i)+h u'(x_i)+h^2 / 2 u''(x_i)+h^3 / 6 u'''(x_i)+o(h^4)]-2u(
    x_i
  )) / h^2 \ &quad+([u(x_i)-h u'(x_i)+h^2 / 2u''(x_i)-h^3 / 6u'''(x_i)+o(h^4)]) / (h^2) \
  &=(h^2u''(x_i)+o(h^4)) / h^2 \
  &=u''(x_i)+o(h^2)
$

== (b)

Insert $u''(x_i) = u_(x x,i)$ and $f_i=f(x_i)$ at every point of ${x_i}$, $i=1,2,dots,n-1$

We can get the linear system:
$
  u(x_(i+1))-2u(x_i)+u(x_(i-1))=-h^2f_i quad i=1,2,dots,n-1
$

and the boundary condition is $u(x_0)=u_0=a$ and $u(x_n)=u_n=b$

== (c)

By reducing the linear system of equations, for $u_i$, $i=1,2,dots,n-1$, we can get:

$
  u_(i+1)-2u_i+u_(i-1)=-h^2f_i quad i=1,2,dots,n-1
$

consider the boundary condition, we can get:

$
  cases(-2u_1+u_2=-h^2f_1-a & i=1, u_(i+1)-2u_i+u_(i-1)=-h^2f_i & 1<i<n-1, u_(n-2)-2u_(n-1)=-h^2f_(n-1)-b quad & i=n-1)
$

== (d)

Code is shown below:

#include "3d_code.typ"