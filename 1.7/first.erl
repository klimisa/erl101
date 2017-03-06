-module(first).
-export([double/1,mult/2,area/3,square/1,triple/1]).

mult(X,Y) -> X*Y.

double(X) -> mult(X,2).

triple(X) -> mult(X,3).

square(X) -> mult(X,X).

area(A,B,C) -> 
    S = (A+B+C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C)).