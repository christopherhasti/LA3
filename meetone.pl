#!/bin/gprolog --consult-file

:- include('data.pl').

% meetone(Person, QuerySlot)
% True if Person has a FreeSlot that fully contains the QuerySlot.
meetone(Person, QuerySlot) :-
    free(Person, FreeSlot),
    timein(QuerySlot, FreeSlot).

main :- findall(Person,
		meetone(Person,slot(time(8,30,am),time(8,45,am))),
		People),
	write(People), nl, halt.

:- initialization(main).
