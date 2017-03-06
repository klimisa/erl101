-module(second).
-export([hypotenuse/2,perimeter/2,area/2]).

hypotenuse(X,Y) ->
    S = first:square(X) + first:square(Y),
    math:sqrt(S).

perimeter(X,Ye) ->
    X+Y+hypotenuse(X,Y).

area(X,Y) ->
first:mult(X,Y) / 2.

