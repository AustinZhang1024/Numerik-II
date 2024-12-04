#import "conf.typ": conf

#show: conf.with(exercise_num: [07])

= Several methods applied to the model problem of linear stability.

Code is shown in `ex07_1.ipynb`.

According to Remark 2.10, the solution of (2.7) is

$
  y(x) = exp(lambda x)
$

By implementing the three methods, we can compare the numerical solution with the exact solution.

The results are shown in the following figures.

#align(center)[
  #image("1_error_plot.png", width: 70%)
]

For easier reading, the graph of the $log_2("meshes")$ and $log$

#align(center)[
  #image("1_log_error_plot.png", width: 70%)
]

= Stability function of classical Runge-Kutta scheme.

According to Example 1.33, we can get $A$ and $bold(b)^T$ of the _Classical Runge-Kutta scheme_.

$
  A = mat(
    0,0,0,0;
    1/2,0,0,0;
    0,1/2,0,0;
    0,0,1,0
  )
  quad
  bold(b)^T = mat(1/6,1/3,1/3,1/6)
$

According to Definition 2.12, we can calaulate the stability function of the _Classical Runge-Kutta scheme_.

$
  R(z) =& 1 + z bold(b)^T (I-z A)^(-1) bold(1) \
  =& 1 + z mat(1/6,1/3,1/3,1/6) ( mat(1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1)-z mat(0,0,0,0;1/2,0,0,0;0,1/2,0,0;0,0,1,0) )^(-1) vec(1,1,1,1) \
  =& 1 + z mat(1/6,1/3,1/3,1/6)mat(1,0,0,0;-z/2,1,0,0;0,-z/2,1,0;0,0,-z,1)^(-1) vec(1,1,1,1) \
  =& 1 + z mat(1/6,1/3,1/3,1/6)mat(1,0,0,0;z/2,1,0,0;z^2/4,z/2,1,0;z^3/4,z^2/2,z,1) vec(1,1,1,1) \
  =& 1 + z vec(1/6+z/6+z^2/12+z^3/24, 1/3+z/6+z^2/12, 1/3+z/6, 1/6)^T vec(1,1,1,1) \
  =& 1+z(1 / 6+z / 6+z^2 / 12+z^3 / 24 + 1 / 3+z / 6+z^2 / 12 + 1 / 3+z / 6 + 1 / 6) \
  =& 1 + z + z^2 / 2 + z^3 / 6 + z^4 / 24
$

According to Definition 2.16, the domain of stability is the set:

$
  S = {z in CC: abs(R(z)) <= 1} = {z in CC: abs(1 + z + z^2/2 + z^3/6 + z^4/24) <= 1}
$

To draw the sketch of the domain of stability, code is shown in `ex07_2.ipynb`.
The domain of stability is shown in the following figure.

#align(center)[
  #image("2_stability_domain.png", width: 70%)
]

= Second order boundary value problem with first order term and upwind discretization; GMRES.

== a

With Tayler expansion, we have

$
  u_(overline(x),i) =& (u(x_i) - u(x_(i-1))) / h \
  =& (u(x_i) - u(x_i - h)) / h \
  =& (u(x_i)-[u(x_i)-h u'(x_i)+h^2 / 2u''(x_i)+o(h^3)]) / h \
  =& (h u'(x_i)-h^2 / 2u''(x_i)+o(h^3)) / h \
  =& u'(x_i)-h / 2u''(x_i)+o(h^2) \
  =& u'(x_i) + O(h)
$

== b

Code is shown in `ex07_3.ipynb`.

== c

For better comparation, we plot the graph of the $-log(epsilon)$ and $log("error")$

#align(center)[
  #image("3_c.png", width: 70%)
]

We can get:
+ The error becomes larger as the $epsilon$ becomes smaller.
+ The erroe becomes smaller as the $h$ becomes smaller.

== d