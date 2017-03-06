-module(submission).
-export([perimeter/1,area/1,enclose/1,bits/1,bits_tr/1]).

% Submission
% https://gist.github.com/klimisa/d6dd462aaf7b268b064b8dc18fa3dd58

% Shapes
perimeter({triangle,A,B,C}) -> 
    A+B+C;
perimeter({rectangle,W,L}) ->  % W:Witdh,L:Length
    2*(L+W);
perimeter({circle,R}) ->       % R:Radius
    2*(math:pi()*R).

area({triangle,B,H}) ->   % B:Base,H:Height
    (B*H)/2;
area({rectangle,W,L}) ->  % W:Witdh,L:Length
    W*L;
area({circle,R}) ->       % R:Radius
    pi*math:pow(R,2).

% Really don't want to do this, hope that pattern matching is correct
enclose({triangle,B,HB}) ->   % B:Base,HB:Height
    (B*HB)/4;
enclose({rectangle,W,L}) ->  % W:Witdh,L:Length
    {rectangle,W,L};
enclose({circle,R,T}) ->       % R:Radius
    {rectangle,R,T}.

% Summing the bits
% ex.
% 157 ÷ 2 = 78    with a remainder of 1
%  78 ÷ 2 = 39    with a remainder of 0
%  39 ÷ 2 = 19    with a remainder of 1
%  19 ÷ 2 = 9     with a remainder of 1
%   9 ÷ 2 = 4     with a remainder of 1
%   4 ÷ 2 = 2     with a remainder of 0
%   2 ÷ 2 = 1     with a remainder of 0
%   1 ÷ 2 = 0	  with a remainder of 1

% Direct recursion
bits(0) ->
    0;
bits(N) ->
    R = abs(N rem 2),
    R + bits(N div 2).

% Tail recursion
bits_tr(N) ->
    bits_t(N,0).

bits_t(0,S) ->
    abs(S);
bits_t(N,S) ->
    R = N rem 2,
    bits_t(N div 2, S + R).