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

We can assume that the Moore-Penrose inverse $A^+ = mat(alpha; beta; gamma)$

According to the Moore-Penrose conditions, we can get:

$
  #let Amat = math.mat(2, 3, 4)
  #let Aplus = math.mat((sym.alpha,), (sym.beta,), (sym.gamma,))
  cases(
    Amat Aplus Amat = Amat,
    Aplus Amat Aplus = Aplus,
    (Amat Aplus)^T = Amat Aplus,
    (Aplus Amat)^T = Aplus Amat,
  )
$

By calculating the equations above, we can get:

$
  cases(
    mat(2(2alpha+3beta+4gamma), 3(2alpha+3beta+4gamma), 4(2alpha+3beta+4gamma)) = mat(2, 3, 4),
    mat(2(2alpha+3beta+4gamma); 3(2alpha+3beta+4gamma); 4(2alpha+3beta+4gamma)) = mat(2; 3; 4),
    mat(2alpha+3beta+4gamma) = mat(2alpha+3beta+4gamma),
    mat(2alpha,3alpha,4alpha;2beta,3beta,4beta;2gamma,3gamma,4gamma) = mat(2alpha,2beta,2gamma;3alpha,3beta,3gamma;4alpha,4beta,4gamma),
  )
$

By rearranging the equations above, we can get:

$
  cases(
    2alpha+3beta+4gamma = 1,
    3alpha = 2beta,
    4alpha = 2gamma,
    4beta = 3gamma,
  )
$

So we can get the answer:

$
  cases(
    alpha = 2/9,
    beta = 1/3,
    gamma = 4/9,
  )
$

And the Moore-Penrose inverse is:

$
  A^+ = mat(2/9; 1/3; 4/9)
$

= Conjugate gradient (CG) method.

Code is shown in `sheet09_3.ipynb`.

== a

After executed the code, we can get the number of iteration keeps $1/(2h)$.

#align(center)[
  #image("sheet09_3_a.svg", width: 75%)
]

== b

The CG method implemented by `scipy.sparse.linalg.cg`, the number of iterations is only 1.
It's way faster than my own implementation.

== c

To measure the performance of the two CG methods,
I decide to use the two methods solve the question 3.a in $1000$ times and calculate the total time.

The total time of my own implementation is $25.13917112350464$s, and the total time of `scipy.sparse.linalg.cg` is $22.611215353012085$s (Time here maybe not the same as in the code because it changes every time after execution).

So the `scipy.sparse.linalg.cg` is $10$% faster than my own implementation.
