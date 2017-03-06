-module(index). 
-export([file_words/1,get_file_contents/1,show_file_contents/1,entry_lookup/2,fetch_entry/2,iter_lines/1,iter_lines/3,iter_words/2,iter_words/4]).

% Used to read a file into a list of lines. 
% Example files available in: 
% gettysburg-address.txt (short) 
% dickens-christmas.txt (long) 
% Get the contents of a text file into a list of lines. 
% Each line has its trailing newline removed.

get_file_contents(Name) -> 
{ok,File} = file:open(Name,[read]), 
Rev = get_all_lines(File,[]), 
lists:reverse(Rev).

% Auxiliary function for get_file_contents. 
% Not exported.

get_all_lines(File,Partial) -> 
case io:get_line(File,"") of 
eof -> file:close(File), 
Partial; 
Line -> {Strip,_} = lists:split(length(Line)-1,Line), 
get_all_lines(File,[Strip|Partial]) 
end.

% Show the contents of a list of strings. 
% Can be used to check the results of calling get_file_contents.

show_file_contents([L|Ls]) -> 
io:format("~s~n",[L]), 
show_file_contents(Ls); 
show_file_contents([]) -> 
ok. 

file_words(Filename) -> 
index_words_positions(iter_lines(get_file_contents(Filename))).

index_words_positions(W) -> 
words_positions(W, []).

words_positions([], Acc) -> 
Acc; 
words_positions([{Key,Index}|T], Acc) -> 
case entry_lookup(Acc, Key) of 
{K,L}=E -> 
NewTuple = update_line_list(E, Index), 
words_positions(T, lists:keyreplace(Key, 1, Acc, NewTuple)); 
undefined -> 
words_positions(T, lists:keystore(Key, 1, Acc, {Key, [{Index, Index}]})) 
end.

update_line_list({K, L}=E, Index) -> 
{FirstLine,LastLine} = LastPair = lists:last(L), 
case Index > LastLine + 1 of 
true -> {K, L ++ [{Index, Index}]}; 
false -> {K, lists:delete(LastPair, L) ++ [{FirstLine,Index}]} 
end.

%% "The brave men, living and dead, who struggled here, have" 
%% => [{"the", 1}, {"brave", 1}, {"the", 1}....] 
iter_lines(L) -> 
iter_lines(L, 1, []).

iter_lines([], _I, Acc) -> 
Acc; 
iter_lines([H|T], I, Acc) -> 
iter_lines(T, I + 1, Acc ++ iter_words(H, I)).

%% => {1, ["the", "brave", "men", "living", "and", "dead", "who", "struggled", "here", "have"]} 
iter_words(L, I) -> 
iter_words(L, I, [], []).

iter_words([], I, Acc, Partial) -> 
case length(Partial) > 0 of 
true -> Acc ++ [{Partial,I}]; 
false -> Acc 
end; 
iter_words([H|T], I, Acc, Partial) -> 
case lists:member(H, "\ .,;:-\t\n") of 
true -> 
case length(Partial) > 0 of 
true -> iter_words(T, I, Acc ++ [{Partial,I}], []); 
false -> iter_words(T, I, Acc, Partial) 
end; 
false -> iter_words(T, I, Acc, Partial ++ [nocap(H)]) 
end.

%% Extracted from the 'palindrom' exercise :) 
nocap(X) -> 
case $A =< X andalso X =< $Z of 
true -> X + 32; 
false -> X 
end.

%% Helper functions

%% Given an entry list, it returns the entry with key equal to the given key. 
entry_lookup([], _Key) -> 
undefined; 
entry_lookup([{Key,_}=E|_T], Key) when Key =/= E -> 
E; 
entry_lookup([_H|T], Key) -> 
entry_lookup(T, Key).

%% Given an entry list, it returns or creates the entry for a given key. 
fetch_entry(EntryList, Key) -> 
case entry_lookup(EntryList, Key) of 
undefined -> [Key, []]; 
E -> E 
end.