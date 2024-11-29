#import "conf.typ": conf

#show: conf.with(exercise_num: [06])

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

== c

== d