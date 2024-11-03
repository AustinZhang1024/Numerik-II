#import "conf.typ": conf

#show: conf.with(exercise_num: [03])

= Consistency conditions for a 3#super("rd") order Runge–Kutta scheme with three stages.

First, we need to calculate the increments $K_1$, $K_2$, and $K_3$ for the Runge-Kutta scheme. We have:

$
  cases(
    K_1(y,h) &=& f(y_k),
    K_2(y,h) &=& f(y_k + a_(21) h K_1) \
    &=& f(y_k + a_(21) h f(y_k)) \
    &=& f(y_k) + a_(21) h f(y_k) diff_y f(y_k) + ((a_(21) h f(y_k))^2) / 2 diff_y^2 f(y_k) + O(h^3),
    K_3(y,h) &=& f(y_k + a_(31) h K_1 + a_(32) h K_2) \
    &=& f(y_k + a_(31) h f(y_k) + a_(32) h (f(y_k) + a_(21) h f(y_k))) \
    &=& f(y_k) + (a_(31) h f(y_k) + a_(32) h (f(y_k) + a_(21) h f(y_k))) diff_y f(y_k) \
    &&+ (a_(31) h f(y_k) + a_(32) h (f(y_k) + a_(21) h f(y_k)))^2/2 diff_y^2 f(y_k) + O(h^3)
  )
$

Then, we can calculate:

$
  y(x_k+h) =& y(x_k) + h y'(x_k) + h^2 / 2 y''(x_k) + h^3 / 6 y'''(x_k) + O(h^4) \
  =& y(x_k) + h f(y_k) + h^2 / 2 f(y_k) diff_y f(y_k) \
  &+ h^3 / 6 [f(y_k) (diff_y f(y_k))^2+(f(y_k))^2diff_y^2 f(y_k)] + O(h^4)
$

= Matrices in classical iteration schemes.

== (a)

According to Example 3.8 in the notes, $G_"GS" = M^(-1)N=(D+L)^(-1)(-U)=-(D+L)^(-1)U$

so we have:

$
  0 &= D G_("GS") + L G_("GS") + U \
  &= D (-(D+L)^(-1)U) + L (-(D+L)^(-1)U) + U \
  &= -(D+L)(D+L)^(-1)U + U \
  &= -U + U \
  &= 0
$

== (b)

According to Remark 3.5 in the notes, $A=D+L+U$, so we have:

$
  &D+omega L \
  =& D + omega / 2 L + omega / 2 L \
  =& D + omega / 2(A-D-U) + omega / 2 L \
  =& (1-omega / 2)D + omega / 2 A + omega / 2 (L-U) \
$

$
  &(1-omega)D-omega U \
  =&(1-omega)D - omega / 2 U - omega / 2 U \
  =&(1-omega)D - omega / 2 (A-D-L) - omega / 2 U \
  =&(1-omega / 2)D - omega / 2 A + omega / 2 (L-U) \
$

= Programming problem: damped Jacobi and SOR method.