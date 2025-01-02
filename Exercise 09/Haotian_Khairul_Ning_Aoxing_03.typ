#import "conf.typ": conf

#show: conf.with(exercise_num: [09])

= Linear system of ordinary differential equations.

According to the given system of ordinary differential equations, we can rewrite it:

$
  cases(
    y'(x) = y(x) + z'(x),
    z'(x) = z(x) + u'(x),
    u'(x) = u(x) + x,
  )
$

By observing the system, we only need to solve the ODE of $y'(x) = y(x) + z'(x)$, and use the backward sustitution to solve the rest of the ODEs.

Firstly, we solve the homogeneous form of the equation:

$
  y'(x) = y(x)
  => (text("d.")y) / y = (text("d.")x)
  =>ln abs(y) = x + C
  => y = C e^x
$

Then we make $y=C(x)e^x$, and put it into the original equation. We can get:

$
  & C'(x) e^x + C(x) e^x = C(x) e^x + z'(x) \
  => & C'(x) e^x = z'(x) \
  => & C(x) = integral z'(x) e^(-x) text("d.")x \
  => & y(x) = e^x integral z'(x) e^(-x) text("d.")x \
$

So the solution of the original equation is:

$
  y(x) = z(x) + e^x integral e^(-x) z(x) text("d.")x
$

Now we can use the backward sustitution to solve the rest of the ODEs:

$
  u(x) &= e^x integral x e^(-x) text("d.")x \
  &= e^x (-x e(-x) - e^(-x) + C_1) \
  &= -1 - x + C_1 e^x
$

$
  z(x) &= e^x integral (-1 + C_1 e^x) e^(-x) text("d.")x \
  &= e^x integral -e^(-x) + C_1 text("d.")x \
  &= e^x (e^-x + C_1 x + C_2) \
  &= 1 + C_1 x e^x + C_2 e^x
$

$
  y(x) &= e^x integral (C_1 e^x + C_1 x e^x + C_2 e^x) e^(-x) text("d.")x \
  &= e^x integral C_1 + C_1 x + C_2 text("d.")x \
  &= e^x (C_1 x + C_1 x^2 / 2 + C_2 x + C_3) \
  &= C_1 / 2 x^2 e^x + (C_1 + C_2) x e^x + C_3 e^x
$

So the general solution of the system of ODEs is:

$
  cases(
    y(x) = C_1/2 x^2 e^x  + (C_1 + C_2) x e^x + C_3 e^x,
    z(x) = 1 + C_1 x e^x + C_2 e^x,
    u(x) = -1 - x + C_1 e^x,
  )
$

= Moore-Penrose inverse, pseudo inverse.

= Conjugate gradient (CG) method.
