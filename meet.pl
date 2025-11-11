#!/bin/gprolog --consult-file

:- include('data.pl').
:- include('uniq.pl').

% overlap(Slot1, Slot2, OverlapSlot)
% Succeeds if the two slots overlap.
overlap(slot(S1, E1), slot(S2, E2), slot(OS, OE)) :-
    max_time(S1, S2, OS), % Overlap Start
    min_time(E1, E2, OE), % Overlap End
    timelt(OS, OE).      % True if OS < OE (i.e., a valid slot)

% meet_list(ListOfPeople, CommonSlot)
% Finds a common meeting slot for everyone in the list.

% Base case: A common slot for one person is any of their free slots.
meet_list([Person], Slot) :-
    free(Person, Slot).

% Recursive case: Find overlap between Head's slot and Tail's common slot.
meet_list([H|T], CommonSlot) :-
    free(H, HeadSlot),
    meet_list(T, TailSlot),
    overlap(HeadSlot, TailSlot, CommonSlot).

% meet(Slot)
% Finds a single common slot for all people defined in people/1.
meet(Slot) :-
    people(List),
    meet_list(List, Slot).

people([ann,bob,carla]).

main :- findall(Slot, meet(Slot), Slots),
        uniq(Slots, Uniq),
        write(Uniq), nl, halt.

:- initialization(main).
