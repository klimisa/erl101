-module(assignment1). 
-export([perimeter/1,enclose/1,area/1,bits/1]).

-include_lib("eunit/include/eunit.hrl").

%% format of a point: {X,Y} 
%% format of a rectangle: {rectangle, {X1,Y1}, {X2,Y2}} 
%% {X1,Y1} 
%% +-------+ 
%% | | 
%% | | 
%% +-------+ 
%% {X2,Y2} 
%% 
%% or {rectangle, A, B} 
%% +-------+ 
%% | | 
%% A | | 
%% +-------+ 
%% B 
%% 
%% format of a triangle: {triangle, B, H} 
%% 
%% |\ 
%% | \ 
%% H | \ 
%% |___\ 
%% B 
%% 
%% format of a shape: {shape, [{X1,Y1}, {X2,Y2},... {XN,YN}]} points in clockwise or counterclockwise order 
%% example to represent a triangle as shape 
%% 
%% {X1,Y1} 
%% /\ 
%% / \ 
%% / \ 
%% {X3,Y3} /______\ {X2,Y2} 
%% 
%% eg: {shape,[{10,10},{15,20},{20,10}]} 
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% calculates the perimeter of a shape 
%% input: a shape 
%% output: invalid_shape or number

perimeter({shape, [{_X1,_Y1}=H,{_X2,_Y2},{_X3,_Y3}|_T]=L}) -> 
perimeter_({shape, L ++ [H]}); 
perimeter(_) -> invalid_shape.

perimeter_({shape, [_]}) -> 0; 
perimeter_({shape, [{X1,Y1},{X2,Y2}=N | T]}) -> 
len({X1,Y1},{X2,Y2})+perimeter_({shape, [N|T]}).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% calculates the smallest enclosing rectangle of the shape. 
%% input: a shape 
%% output: invalid_shape or the rectangle 
enclose({shape, [{_X1,_Y1},{_X2,_Y2},{_X3,_Y3}|_T]=L}) -> 
enclose_(L, {}); 
enclose(_) -> invalid_shape.

enclose_([], {MinX,MinY,MaxX,MaxY}) -> {rectangle, {MinX, MinY}, {MaxX, MaxY}}; 
enclose_([{X,Y}|T], {}) -> 
enclose_(T, {X,Y,X,Y}); 
enclose_([{X,Y}|T], {MinX,MinY,MaxX,MaxY}) -> 
enclose_(T, {min(X,MinX),min(Y,MinY), max(X,MaxX),max(Y,MaxY)}).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% calculates the area of the shape (triangle, rectangle, shape). 
%% input: a shape, a triangle or a rectangle 
%% output: invalid_shape or number 
%% 
area({triangle, B, H}) when is_number(B) and is_number(H) -> 0.5*B*H; 
area({rectangle, {_X1,_Y1}, {_X2,_Y2}}=R)-> area(reactangle2shape(R)); 
area({rectangle, A, B}) when is_number(A) and is_number(B)-> float(A*B); 
area({shape, [{_X1,_Y1}=H,{_X2,_Y2},{_X3,_Y3}|_T]=L}) -> 
area_({shape, L ++ [H]},0); 
area(_) -> invalid_shape.

%% calculated by: ((x1*y2-y1*x2)+(x2*y3-y2*x3)...(xny1-yn*x1)) / 2 
area_({shape, [_]}, Acc) -> abs(Acc / 2); 
area_({shape, [{X1,Y1},{X2,Y2}=N | T]},Acc) -> 
area_({shape, [N|T]}, Acc+(X1*Y2 - Y1*X2)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% calculates the sum of the bits in the binary representation of a positive integer 
%% input: positive integer 
%% output: sum of the bits in the binary representation 
bits (0) -> 0; 
bits (N) when N >=0 -> 
N band 1 + bits(N bsr 1).

%% helper ---------------------------------------------------------------------

triangle2shape({triangle, B, H}) when is_number(B) and is_number(H) -> 
{shape, [{0,H},{B,0},{0,0}]}.

reactangle2shape({rectangle, {X1, Y1}, {X2, Y2}}) -> {shape, [{X1,Y1},{X2,Y1},{X2,Y2},{X1,Y2}]}; 
reactangle2shape(_) ->invalid_rectangle. 
len({_X,Y1}, {_X,Y2}) -> 
abs(Y1-Y2); 
len({X1,_Y}, {X2,_Y}) -> 
abs(X1-X2); 
len({X1,Y1}, {X2,Y2}) -> 
hypotenuse(abs(X1-X2),abs(Y1-Y2)). 

hypotenuse(A, B) -> 
math:sqrt(square(A)+square(B)).

square(X) ->X*X.

%% tests ---------------------------------------------------------------------

shape_test() -> 
?assertEqual(invalid_shape, perimeter({shape,[]})), 
?assertEqual(invalid_shape, perimeter({shape,[{10,10}]})), 
?assertEqual(invalid_shape, perimeter({shape,[{10,10},{10,20}]})), 
?assertEqual("32.361",truncate3(perimeter({shape,[{10,10},{15,20},{20,10}]}))), 
?assertEqual("34.142",truncate3(perimeter({shape,[{10,10},{10,20},{20,10}]}))), 
?assertEqual("34.142",truncate3(perimeter({shape,[{10,10},{10,20},{20,10},{10,10}]}))).

enclose_test() -> 
?assertEqual(invalid_shape, enclose({shape,[]})), 
?assertEqual(invalid_shape, enclose({shape,[{10,10}]})), 
?assertEqual(invalid_shape, enclose({shape,[{10,10},{10,20}]})), 
?assertEqual({rectangle,{10,10},{20,20}}, enclose({shape,[{10,10},{10,20},{20,10}]})).

reactangle2shape_test() -> 
?assertEqual({shape,[{10,10},{20,10},{20,20},{10,20}]}, reactangle2shape({rectangle,{10,10},{20,20}})).

area_test() -> 
?assertEqual(invalid_shape, area({shape,[]})), 
?assertEqual(invalid_shape, area({shape,[{10,10}]})), 
?assertEqual(invalid_shape, area({shape,[{10,10},{10,20}]})), 
?assertEqual(50.0, area({shape,[{10,10},{10,20},{20,10}]})), 
?assertEqual(100.0, area({rectangle,{10,10},{20,20}})), 
?assertEqual(100.0, area({rectangle,10,10})), 
?assertEqual(50.0, area({triangle,10,10})), 
?assertEqual(50.0, area(triangle2shape({triangle,10,10}))).

bits_test() -> 
?assertEqual(0, bits(0)), 
?assertEqual(1, bits(1)), 
?assertEqual(1, bits(2)), 
?assertEqual(2, bits(3)), 
?assertEqual(1, bits(4)), 
?assertEqual(2, bits(5)), 
?assertEqual(2, bits(6)), 
?assertEqual(3, bits(7)), 
?assertEqual(1, bits(8)).

truncate3(F) -> 
lists:flatten(io_lib:format("~.3f",[F])).