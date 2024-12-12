% Определяем категории марок
category(fauna).
category(flora).
category(sport).
category(cosmos).

% Определяем персонажей (поросята и волк)
character(nif_nif).
character(naf_naf).
character(nuf_nuf).
character(wolf).

% Основной предикат для решения задачи
solve :-
    Characters = [P1, P2, P3, P4],
    arrange_characters([P1, P2, P3, P4]),
    verify_conditions([P1, P2, P3, P4]),
    display_results([P1, P2, P3, P4]).

% Расставляем персонажей по порядку
arrange_characters([P1, P2, P3, P4]) :-
    member([wolf, fauna], [P1, P2, P3, P4]),
    member([nif_nif, NifCollection], [P1, P2, P3, P4]), category(NifCollection), NifCollection \= fauna,
    member([naf_naf, NafCollection], [P1, P2, P3, P4]), category(NafCollection), NafCollection \= fauna,
    member([nuf_nuf, NufCollection], [P1, P2, P3, P4]), category(NufCollection), NufCollection \= fauna.

% Проверка выполнения условий
verify_conditions(Characters) :-
    left_of([wolf, fauna], [naf_naf, NafCollection], Characters),
    right_of([nif_nif, NifCollection], [_, cosmos], Characters),
    opposite([nuf_nuf, NufCollection], [naf_naf, NafCollection], Characters),
    NufCollection \= sport,
    all_unique([fauna, NifCollection, NafCollection, NufCollection]).

% Проверка, что один персонаж сидит слева от другого
left_of(Left, Right, List) :-
    append(_, [Left, Right | _], List).

% Проверка, что один персонаж сидит справа от другого
right_of(Right, Left, List) :-
    append(_, [Left, Right | _], List).

% Проверка, что один персонаж сидит напротив другого
opposite(One, Two, List) :-
    length(List, Len),
    Half is Len // 2,
    append(Front, Back, List),
    length(Front, Half),
    append(_, [One | _], Front),
    append(_, [Two | _], Back).

% Проверка, что все элементы в списке уникальны
all_unique([]).
all_unique([H|T]) :-
    \+ member(H, T),
    all_unique(T).

% Вывод результатов
display_results(Characters) :-
    write('Seating order and collections: '), nl,
    member([Person, Collection], Characters),
    format('~w collects ~w~n', [Person, Collection]),
    fail.
display_results(_).

% Запуск программы
:- initialization(solve).