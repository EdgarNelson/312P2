:- use_module(library(clpfd)).

sudokuX(Grid) :-
    domain(Grid),
    Rows = Grid,
    convert(Rows, Columns),
    subgrids(Rows, Blocks),
    diagonal(DA,Rows),
    diagonal(DB,Columns),
    maplist(all_distinct, Rows),
    maplist(all_distinct, Columns),
    maplist(all_distinct, Blocks),
    all_distinct(DA),
    all_distinct(DB),
    maplist(label, Rows).

% Each list has a domain 1..9
domain([]).
domain([H|T]) :-
    H ins 1..9,
    domain(T).

% Convert Rows <-> Columns
convert([], []).
convert([F|R],[H|T]) :-
    check_remove_firsts(F, [H|T], Ts),
    check_remove_firsts(H, [F|R], Rs),
    rest(Ts,Columns),
    rest(Rs,Rows),
    convert(Rows,Columns).

% check_remove_firsts(H, T, C) :-
% H is a list of all the first elements of each list in T
% C same as T but without the first elements of each list
check_remove_firsts([],[],[]).
check_remove_firsts([H|R],[[H|T]|Ts],[T|Rs]) :-
    check_remove_firsts(R, Ts, Rs).

% Converts list of rows into list of subgrids
subgrids([A,B,C,D,E,F,G,H,I], Blocks) :-
    subgrids(A,B,C,Block1), subgrids(D,E,F,Block2), subgrids(G,H,I,Block3),
    append([Block1, Block2, Block3], Blocks).

subgrids([], [], [], []).
subgrids([A,B,C|Bs1],[D,E,F|Bs2],[G,H,I|Bs3], [Block|Blocks]) :-
    Block = [A,B,C,D,E,F,G,H,I],
    subgrids(Bs1, Bs2, Bs3, Blocks).

% Diagonal of Grid
diagonal([],[]).
diagonal([H|T],[F|R]) :-
    first(H,F),
    rests(R,Rs),
    diagonal(T,Rs).

% First element in list
first(H,[H|T]).

% Rest of elements in list
rest([H|T],T).

% Rest of elements of each list
rests([],[]).
rests([H|T], [F|R]) :-
    rest(H,F),
    rests(T,R).


