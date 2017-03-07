-module(t38).
-export([beat/1,lose/1,result/2,tournament/2]).

beat(rock) -> paper;
beat(paper) -> scissors;
beat(scissors) -> rock.

lose(rock) -> scissors;
lose(paper) -> rock;
lose(scissors) -> paper.

result(A,B) ->
    case {beat(A),lose(A)} of
        {B,_} -> lose;
        {_,B} -> win;
        _ -> draw
    end.   

tournament(Xs,Ys) ->
    tournament1(Xs,Ys,0).

tournament1(_Xs,[],R) ->
    R;
tournament1([],_Ys,R) ->
    R;
tournament1([X|Xs],[Y|Ys],R) ->
    case result(X,Y) of
        draw -> tournament1(Xs,Ys,R);
        lose -> tournament1(Xs,Ys,R-1);
        win  -> tournament1(Xs,Ys,R+1)
    end.
