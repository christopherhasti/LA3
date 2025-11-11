free(ann,slot(time(8,0,am),time(9,0,am))).
free(ann,slot(time(10,0,am),time(11,0,am))).
free(ann,slot(time(8,0,pm),time(9,0,pm))).

free(bob,slot(time(7,0,am),time(8,30,am))).
free(bob,slot(time(10,0,am),time(11,0,am))).
free(bob,slot(time(11,30,am),time(9,0,pm))).

free(carla,slot(time(8,0,am),time(9,0,am))).
free(carla,slot(time(10,0,am),time(10,15,am))).
free(carla,slot(time(11,0,am),time(8,30,pm))).

free(dave,slot(time(8,0,am),time(9,0,am))).
free(dave,slot(time(10,0,am),time(11,0,am))).

free(ed,slot(time(9,0,am),time(10,0,am))).

% timelte(Time1, Time2)
% True if Time1 is less than or equal to Time2.
% Uses the built-in term comparison @=<
timelte(T1, T2) :-
    T1 @=< T2.

% timelt(Time1, Time2)
% True if Time1 is strictly less than Time2.
timelt(T1, T2) :-
    T1 @< T2.

% timein(ContainedSlot, ContainerSlot)
% True if ContainedSlot is fully inside ContainerSlot.
timein(slot(S1, E1), slot(S2, E2)) :-
    timelte(S2, S1),  % Container start <= Contained start
    timelte(E1, E2).  % Contained end <= Container end

% max_time(T1, T2, Max)
% Finds the later of two times.
max_time(T1, T2, T1) :- timelte(T2, T1). % If T2 <= T1, Max is T1
max_time(T1, T2, T2) :- timelt(T1, T2).  % If T1 < T2, Max is T2

% min_time(T1, T2, Min)
% Finds the earlier of two times.
min_time(T1, T2, T1) :- timelte(T1, T2). % If T1 <= T2, Min is T1
min_time(T1, T2, T2) :- timelt(T2, T1).  % If T2 < T1, Min is T2