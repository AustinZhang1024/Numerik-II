#import "conf.typ": conf

#show: conf.with(exercise_num: [03])

= Consistency conditions for a 3#super("rd") order Runge–Kutta scheme with three stages.

First, we need to calculate the increments $K_1$, $K_2$, and $K_3$ for the Runge-Kutta scheme. We have:

$
  cases(
    K_1(y,h) &=& f(y_k),
    K_2(y,h) &=& f(y_k + a_(21) h K_1) \
    &=& f(y_k + a_(21) h f(y_k)) \
    &=& f(y_k) + c_2 h f(y_k) diff_y f(y_k) + ((c_2 h f(y_k))^2) / 2 diff_(y y) f(y_k) + o(h^3),
    K_3(y,h) &=& f(y_k + a_(31) h K_1 + a_(32) h K_2) \
    &=& f(y_k + a_(31) h f(y_k) + a_(32) h K_2) \
    &=& f(y_k) + (a_(31) h f(y_k) + a_(32) h (f(y_k) + a_(21) h f(y_k) diff_y f(y_k) + ((a_(21) h f(y_k))^2) / 2 diff_(y y) f(y_k) + o(h^3))) diff_y f(y_k) \
    &&+ (a_(31) h f(y_k) + a_(32) h (f(y_k) + a_(21) h f(y_k) diff_y f(y_k) + ((a_(21) h f(y_k))^2) / 2 diff_(y y) f(y_k) + o(h^3)))^2/2 diff_(y y) f(y_k) + o(h^3) \
    &=&f(y_k) + c_3 h f(y_k) diff_y f(y_k) + a_(32)c_2 h^2 f(y_k) (diff_y f(y_k))^2 + 1/2 h^2 c_3^2 (f(y_k))^2 diff_(y y) f(y_k) + o(h^3)
  )
$

Then, we can calculate:

$
  y(x_k+h) =& y(x_k) + h y'(x_k) + h^2 / 2 y''(x_k) + h^3 / 6 y'''(x_k) + o(h^4) \
  =& y(x_k) + h f(y_k) + h^2 / 2 f(y_k) diff_y f(y_k) \
  &+ h^3 / 6 [f(y_k) (diff_y f(y_k))^2+(f(y_k))^2diff_(y y) f(y_k)] + o(h^4)
$

Now, we can calculate the local error:

$
  "le"(x_k+h)=&y(x_k+h)-y_(k+1) \
  =& y(x_k+h)-y(x_k) - h Phi(y(x_k)) \
  =&y(x_k) + h f(y_k) + h^2 / 2 f(y_k) diff_y f(y_k) \
  &+ h^3 / 6 [f(y_k) (diff_y f(y_k))^2+(f(y_k))^2diff_(y y) f(y_k)] + o(h^4) \
  &- y(x_k) - h (b_1 K_1 + b_2 K_2 + b_3 K_3) \
  =& h f(y_k) + h^2 / 2 f(y_k) diff_y f(y_k)
  + h^3 / 6 [f(y_k) (diff_y f(y_k))^2+(f(y_k))^2diff_(y y) f(y_k)] \
  & + o(h^4) -h b_1 f(y_k) - h b_2 [
    f(y_k) + c_2 h f(y_k) diff_y f(y_k) + ((c_2 h f(y_k))^2) / 2 diff_(y y) f(y_k) + o(h^3)
  ] \
  &- h b_3 [
    f(y_k) + c_3 h f(y_k) diff_y f(y_k) + a_(32)c_2 h^2 f(y_k) (diff_y f(y_k))^2 + 1 / 2 h^2 c_3^2 (
      f(y_k)
    )^2 diff_(y y) f(y_k) + o(h^3)
  ] \
  =& (1-b_1 -b_2-b_3) h f(y_k) + (1 / 2-b_2 c_2 - b_3 c_3) h^2 f(y_k) diff_y f(y_k) + (1 / 6-a_32 b_3 c_2)h^3 f(y_k) (
    diff_y f(y_k)
  )^2 \
  &+ (1 / 6-1 / 2 b_2 c_2^2- 1 / 2 b_3 c_3^2)h^3(f(y_k))^2 diff_(y y) f(y_k) + o(h^4)
$

so:

$
  cases(
    sum_(i=n)^3 b_i = 1,
    b_2c_2+ b_3c_3 = 1 / 2,
    a_32 b_3 c_2 = 1 / 6,
    b_2 c_2^2+  b_3 c_3^2 = 1 / 3
  )
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

Code of question 1, 2 and 3 is shown in `3.py`.

== (a)

After running the code, we can get: *The spectral condition number of the matrix is increasing as $h$ decreases.*

== (b)

