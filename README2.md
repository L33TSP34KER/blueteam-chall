# A kind of root kit
this is a weekend project to learn more about maldev on linux.

I was reading an paper on vx-underground about that kind of persistance and thought i would of been an great idea to try myself.
i'm quite happy with the result

the code is not always clean but eh its mostly an poc

Its my first time playing with .so file w/ rust its quite fun

it basicly work like that
- fork()
- bind addr (if impossible then close)
- listen tcp con
