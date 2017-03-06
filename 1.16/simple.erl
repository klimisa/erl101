-module(simple).
-export([howManyEqual/3,exOr1/2,exOr2/2,exOr3/2,exOr4/2,maxThree/3]).

howManyEqual(X,X,X) ->
    1;
howManyEqual(X,X,_) ->
    2;
howManyEqual(X,_,X) ->
    2;
howManyEqual(_,X,X) ->
    2;
howManyEqual(_X,_Y,_Z) ->
    3.

exOr1(true,false) ->
    false;
exOr1(false,true) ->
    false;
exOr1(_,_) ->
    true.

exOr2(true,X) ->
    not(X);
exOr2(false,X) ->
    X.

exOr3(X,X) ->
    true;
exOr3(_,_) ->
    false.

exOr4(X,Y) ->
    X=/=Y.

maxThree(X,X,X) ->
    X;
maxThree(X,X,Y) ->
    max(X,Y);
maxThree(X,Y,X) ->
    max(X,Y);
maxThree(Y,X,X) ->
    max(X,Y);
maxThree(X,Y,Z) ->
    max(X,max(Y, Z)).

