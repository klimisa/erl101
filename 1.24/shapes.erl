-module(shapes). 
-export([area/1, perimeter/1, bits/1, bits_tail/1, test/0]).

% Here's the model of the Data Structures I've used to describe triangles, circles and rectangles 
% I think the triangle might be a bit verbose, having each coordinate described as a separate, nested tuple 

% { triangle, { {AX, AY}, {BX, BY}, {CX, CY} } } 
% { circle, { RADIUS } } 
% { rectangle, { HEIGHT, WIDTH } }

%%%% UTILITIES %%%% 
point_distance( { AX, AY }, { BX, BY } ) -> 
    math:sqrt( math:pow(BX - AX, 2) + math:pow(BY - AY, 2) ).

%%%% AREA %%%% 
area({ triangle, { {AX, AY}, {BX, BY}, {CX, CY} } }) -> 
    A = point_distance( { AX, AY }, { BX, BY } ), 
    B = point_distance( { BX, BY }, { CX, CY } ), 
    C = point_distance( { CX, CY }, { AX, AY } ),
    S = (A + B + C) / 2, % calculate semi-perimeter 
    math:pow( S * (( S - A ) * ( S - B ) * ( S - C )), 0.5);
area({ circle, { RADIUS }}) -> 
    math:pi() * RADIUS * RADIUS;
area({ rectangle, { HEIGHT, WIDTH } }) -> 
    HEIGHT * WIDTH.

%%%% PERIMETER %%%% 
perimeter({ circle, { RADIUS } }) -> 
    2 * math:pi() * RADIUS;
perimeter({ rectangle, { HEIGHT, WIDTH } }) -> 
    (HEIGHT * 2) + (WIDTH * 2);
perimeter({ triangle, { {AX, AY}, {BX, BY}, {CX, CY} } }) -> 
    A = point_distance( { AX, AY }, { BX, BY } ), 
    B = point_distance( { BX, BY }, { CX, CY } ), 
    C = point_distance( { CX, CY }, { AX, AY } ), 
    A + B + C.

%%%% ENCLOSE %%%% 
enclose({ rectangle, { HEIGHT, WIDTH } }) -> 
    { rectangle, { HEIGHT, WIDTH } };
enclose({ circle, { RADIUS } }) -> 
    { rectangle, { RADIUS * 2, RADIUS * 2 } };
enclose({ triangle, { {AX, AY}, {BX, BY}, {CX, CY} } }) -> 
    WIDTH = lists:max([AX, BX, CX]) - lists:min([AX, BX, CX]), 
    HEIGHT = lists:max([AY, BY, CY]) - lists:min([AY, BY, CY]), 
    { rectangle, { WIDTH, HEIGHT } }.

%%%% BITS %%%% 
bits(0) -> 
    0;
bits(N) when N >= 0 -> 
    (N rem 2) + bits(N div 2).

bits_tail(N) -> 
bits_tail(N, 0).

bits_tail(0, ACC) -> 
ACC;

bits_tail(N, ACC) -> 
bits_tail(N div 2, ACC + (N rem 2)).

%%%% TESTS %%%% 
test_perimeter() -> 
30 = perimeter({rectangle, {5, 10}}), 
31.41592653589793 = perimeter({circle, {5}}), 
21.05997848692523 = perimeter({triangle, {{ 1, 1 }, { 5, 5 }, { 10, 1 }}}), 
ok.

test_area() -> 
3.141592653589793 = area({circle, { 1 } }), 
200 = area({rectangle, { 100, 2 }}), 
17.999999999999996 = area({triangle, {{ 1, 1 }, { 5, 5 }, { 10, 1 }}}), 
ok.

test_enclose() -> 
{ rectangle, { 10, 10 } } = enclose({circle, { 5 }}), 
{ rectangle, { 20, 20 } } = enclose({rectangle, { 20, 20 }}), 
{ rectangle, { 20, 10 } } = enclose({triangle, { { 0, 0 }, { 10, 10 }, { 20, 0 } } }).

test_bits() -> 
3 = bits(7), 
1 = bits(8), 
3 = bits_tail(7), 
4 = bits_tail(8).

test() -> 
test_area(), 
test_perimeter(), 
test_enclose(), 
test_bits(), 
ok.

