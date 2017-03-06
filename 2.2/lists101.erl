-module(lists101).
-export([head/1,product/1,maximum/1,product_t/1]).

head([X|_Xs]) -> X.
% tail([_X|Xs]) -> Xs.

% second(Xs) -> head(tail(Xs)).

% secondP([_X,Y|_Zs]) -> Y.


% Direct recursion
product([])->
    1;
product([X|Xs])->X*product(Xs).

product_test() ->
    6 == product([1,2,3]). 

% Tail recursion
% product(Xs)->product(Xs,1).

% product([],P)->
%     P;
% product([X|Xs],P)->product(Xs,P*X).

% Direct recursion
% maximum([X])->
%     X;
% maximum([X,Y|Xs])->
%     maximum([max(X,Y)|Xs]).
maximum([X])->
    X;
maximum([X|Xs])->
   max(X, maximum([Xs])).

% Tail recursion
% maximum(Xs)->
%     maximum(Xs,0).

% maximum([X],M)->
%     max(X,M);
% maximum([X|Xs],M)->
%     maximum(Xs, max(X,M)).

product_t(Xs) -> product_t(Xs, 1).

product_t([], _) -> 1;
product_t([X|Xs], Acc) -> product_t(Xs, X * Acc).

