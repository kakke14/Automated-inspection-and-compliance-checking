% :- table best_class/3.
% :- table file_violations/2.
% :- table class_violations/2.
object(file_id, Object_id, File_id):-
    % file_record(_, File_id),
    object(File_id, Object_id, _, _).
object(type, Object_id, Type):-
    object(_, Object_id, Type, _).
object(first_coordinate, Object_id, Coordinate):-
    object(_, Object_id, _, seg(X1,Y1,_,_)),
    Coordinate is (X1,Y1).
object(second_coordinate, Object_id, Coordinate):-
    object(_, Object_id, _, seg(_,_,X2,Y2)),
    Coordinate is (X2,Y2).
object(geometry, Object_id, Geometry):-
    object(_, Object_id, _, Geometry).
object(geometry_y1, Object_id, Y1):-
    object(_, Object_id, _, seg(_,Y1,_,_)).
object(geometry_y2, Object_id, Y2):-
    object(_, Object_id, _, seg(_,_,_,Y2)).




%% OBJECT LENGTH
calc_length(seg(X1,Y1,X2,Y2),Len):-
    Len is sqrt((X2-X1)**2 + (Y2-Y1)**2).

board_length(Object_id, Length):-
    object(type, Object_id, board), 
    object(geometry, Object_id, Geometry),
    calc_length(Geometry, Length).

pole_length(Object_id,Length):-
    object(type, Object_id, pole), 
    object(geometry, Object_id, Geometry),
    calc_length(Geometry, Length).

obj_length(Object_id, Length):-
    object(geometry, Object_id, Geometry),
    calc_length(Geometry, Length).

% FILE DIMENSIONS
file_height(File_id, Height):-
    file_record(_, File_id),
    setof(Y2, 
        Y1^X1^X2^Object_id^
        (object(file_id,Object_id, File_id),
        object(geometry, Object_id, seg(X1, Y1, X2, Y2))), %ASSUMTIONTION Y2 IS HIGHER 
    L),
    reverse(L,[Height|_]).

file_length(File_id, Length):-
    file_record(_, File_id),
    setof(X2, 
        Y1^X1^Y2^Object_id^
        (object(file_id,Object_id, File_id),
        object(geometry, Object_id, seg(X1, Y1, X2, Y2))), %ASSUMTIONTION Y2 IS HIGHER 
    L),
    reverse(L,[Length|_]).


% DIRECTION VECTOR
direction_vector(seg(X1,Y1,X2,Y2), (V1,V2)):-
    calc_length(seg(X1,Y1,X2,Y2),Length),
    V1 is abs(X2-X1)/Length,
    V2 is abs(Y2-Y1)/Length.

multiply_vector((V11,V12), (V21,V22),(Vr1,Vr2)):-
    Vr1 is V11 * V21,
    Vr2 is V12 * V22.
    
pole_direction(Object_id, Vector):-
    object(_,Object_id, pole, Seg),
    direction_vector(Seg,Vector).

board_direction(Object_id, Vector):-
    object(_, Object_id, board, Seg),
    direction_vector(Seg,Vector).

obj_direction(Object_id, Vector):-
    object(_, Object_id, _, Seg),
    direction_vector(Seg,Vector).


% % COUNT OF RAILING OBJECTS
count_objects(File_id,Type,N):- 
    setof(
        Object_id, 
        (object(file_id, Object_id, File_id), object(type, Object_id, Type)), 
        L ), 
        length(L,N).
        

count_boards(File_id,N):- 
    count_objects(File_id,board,N).

count_poles(File_id,N):- 
    count_objects(File_id,pole,N).

% SIMILARITY
similar(X,Y, Margin):-
    Res is abs(X-Y),
    Res<Margin.

similar_V((V1,V2),(V3,V4),Margin):-
    dot((V1,V2),(V3,V4),DotProd),
    similar(DotProd, 1.0, Margin).

dissimilar(X,Y, Margin):-
    Res is abs(X-Y),
    Res >= Margin.

dissimilar_V((V1,V2),(V3,V4),Margin):-
    dot((V1,V2),(V3,V4),DotProd),
    dissimilar(DotProd, 1.0, Margin).

% DOT PRODUCT
dot((V11,V12), (V21,V22), DotProd):-
    DotProd is (V11 * V21) + (V12 * V22).


is_between(Low, Val, High):-
    Low < Val, 
    Val < High. 

top_board(File_id, Board_id):-
    object(file_id, Board_id, File_id),
    file_record(_, File_id),
    object(type, Board_id, board),
    object(geometry, Board_id, seg(_, Y1, _, Y2)),
    railing_height(File_id, Required_height),
    Start is Required_height*2/3, End is Required_height*3/3,
    (is_between(Start, Y1, End);is_between(Start, Y2, End)).


middle_board(File_id, Board_id):-
    object(file_id, Board_id, File_id),
    file_record(_, File_id),
    object(type, Board_id, board),
    object(geometry, Board_id, seg(_, Y1, _, Y2)),
    railing_height(File_id, Required_height),
    Start is Required_height*1/3, End is Required_height*2/3,
    (is_between(Start, Y1, End);is_between(Start, Y2, End)).

    

toe_board(File_id, Board_id):-
    object(file_id, Board_id, File_id),
    file_record(_,File_id),
    object(type, Board_id, board),
    object(geometry, Board_id, seg(_, Y1, _, Y2)),
    railing_height(File_id,Required_height),
    Start is Required_height*0/3, End is Required_height*1/3,
    is_between(Start, Y1, End),is_between(Start, Y2, End). % ASSUMPTION Both ends has to bee down flush with flooring


left_pole(File_id, Pole_id):-
    object(file_id, Pole_id, File_id),
    file_record(_,File_id),
    object(type, Pole_id, pole),
    object(geometry, Pole_id, seg(X1, _, X2, _)),
    railing_length(File_id, Required_length),
    Start is Required_length*0/3, End is Required_length*1/3,
    (is_between(Start-20, X1, End);is_between(Start, X2, End)).


middle_pole(File_id, Pole_id):-
    object(file_id, Pole_id, File_id),
    object(type, Pole_id, pole),
    object(geometry, Pole_id, seg(X1, _, X2, _)),
    railing_length(File_id, Required_length),
    Start is Required_length*1/3, End is Required_length *2/3,
    (is_between(Start, X1, End);is_between(Start, X2, End)).
  

right_pole(File_id, Pole_id):-
    object(file_id, Pole_id, File_id),
    object(type, Pole_id, pole),
    object(geometry, Pole_id, seg(X1, _, X2, _)),
    railing_length(File_id, Required_length),
    Start is Required_length*2/3, End is Required_length*3/3,
    (is_between(Start, X1, End);is_between(Start, X2, End+20)).


%VIOLATIONS
% violation(violation_id, 0, middle_pole_missing).
% violation(violation_id, 1, left_pole_missing).
% violation(violation_id, 2, toe_board_too_short).
% violation(violation_id, 3, top_board_sloped).
% violation(violation_id, 4, middle_board_too_high).
% violation(violation_id, 5, middle_board_sloped).
% violation(violation_id, 6, middle_pole_too_far_right).
% violation(violation_id, 7, right_pole_missing).
% violation(violation_id, 8, middle_board_too_short).
% violation(violation_id, 9, middle_board_missing).
% violation(violation_id, 10, toe_board_missing).
% violation(violation_id, 11, top_board_missing).
% violation(violation_id, 12, top_board_too_short).
% violation(violation_id, 13, middle_board_too_low).


%VIOLATION DEFINITIONS


% Missing parts
violation(toe_board_missing, File_id):-
    file_record(_,File_id),
    min_num_boards(File_id, Req_B), % middle board only make sense if more than or equal to 2 boards are expected
    Req_B>=3,
    not(toe_board(File_id,_)).

violation(middle_board_missing, File_id):-
    file_record(_,File_id),
    min_num_boards(File_id, Req_B), % middle board only make sense if more than or equal to 2 boards are expected
    Req_B>=2,
    not(middle_board(File_id, _)).

violation(top_board_missing, File_id):-
    file_record(_,File_id),
    not(top_board(File_id, _)).

violation(left_pole_missing, File_id):-
    file_record(_,File_id),
    not(left_pole(File_id, _)).

violation(middle_pole_missing, File_id):-
    file_record(_, File_id),
    min_num_poles(File_id, Required_poles), % it does not make sense to talk about a midle pole, when 3 poles are not require
    Required_poles=3,
    not(middle_pole(File_id, _)).

violation(right_pole_missing, File_id):-
    file_record(_,File_id),
    not(right_pole(File_id, _)).

% Length of parts
violation(top_board_too_short_right, File_id):-
    file_record(_, File_id),
    top_board(File_id, Board_id),
    board_length(Board_id, Length), 
    railing_length(File_id, Required_length),
    not(similar(Required_length,Length,20)),
    object(geometry, Board_id, seg(X1,_,X2,_)),
    X1<(Length-X2).

violation(top_board_too_short_left, File_id):-
    file_record(_, File_id),
    top_board(File_id, Board_id),
    board_length(Board_id, Length), 
    railing_length(File_id, Required_length),
    not(similar(Required_length,Length,20)),
    object(geometry, Board_id, seg(X1,_,X2,_)),
    X1>(Required_length-X2).

violation(middle_board_too_short_right, File_id):-
    file_record(_,File_id),
    middle_board(File_id, Board_id),
    board_length(Board_id, Length), 
    railing_length(File_id, Required_length),
    not(similar(Required_length,Length,20)),
    object(geometry, Board_id, seg(X1,_,X2,_)),
    X1<(Required_length-X2).

violation(middle_board_too_short_left, File_id):-
    file_record(_,File_id),
    middle_board(File_id, Board_id),
    board_length(Board_id, Length), 
    railing_length(File_id, Required_length),
    not(similar(Required_length,Length,20)),
    object(geometry, Board_id, seg(X1,_,X2,_)),
    X1>(Required_length-X2).

violation(toe_board_too_short_right, File_id):-
    file_record(_,File_id),
    toe_board(File_id, Board_id),
    board_length(Board_id, Length), 
    railing_length(File_id,Required_length),
    not(similar(Required_length,Length,20)),
    object(geometry, Board_id, seg(X1,_,X2,_)),
    X1<(Required_length-X2).

violation(toe_board_too_short_left, File_id):-
    file_record(_,File_id),
    toe_board(File_id, Board_id),
    board_length(Board_id, Length), 
    railing_length(File_id, Required_length),
    not(similar(Required_length,Length,20)),
    object(geometry, Board_id, seg(X1,_,X2,_)),
    X1>(Required_length-X2).

% Placement of parts
% approach comments
%* first condition is satisfied only if there are no middle poles
%* second condition: setof sorts (and so remove duplicates), and the list pattern only matches when there are at least two elements

violation(middle_board_too_low, File_id):-
    file_record(_,File_id),
    min_num_boards(File_id, Req_B), % middle board only make sense if more than or equal to 2 boards are expected
    Req_B>=2,
    not(middle_board(File_id,_)),
    setof(Object_id, toe_board(File_id, Object_id), [_,_|_]).

violation(middle_board_too_high, File_id):-
    file_record(_,File_id),
    min_num_boards(File_id, Req_B), % middle board only make sense if more than or equal to 2 boards are expected
    Req_B>=2,
    not(middle_board(File_id,_)),
    setof(Object_id, top_board(File_id, Object_id), [_,_|_]). 

violation(middle_pole_too_far_left, File_id):-
    file_record(_,File_id),
    min_num_poles(File_id, Required_poles), % it does not make sense to talk about a midle pole, when 3 poles are not require
    Required_poles=3,
    not(middle_pole(File_id,_)),
    setof(Object_id, left_pole(File_id, Object_id), [_,_|_]).

violation(middle_pole_too_far_right, File_id):-
    file_record(_,File_id),
    min_num_poles(File_id, Required_poles), % it does not make sense to talk about a midle pole, when 3 poles are not require
    Required_poles=3,
    not(middle_pole(File_id,_)),
    setof(Object_id, right_pole(File_id, Object_id), [_,_|_]).

% Sloped parts
violation(top_board_sloped, File_id):-
    file_record(_,File_id),
    top_board(File_id,Board_id),
    board_direction(Board_id, TopVector),
    parallel_margin(Margin),
    (
        (
            toe_board(File_id, ToeBoard_id), 
            board_direction(ToeBoard_id, ToeVec), 
            not(similar_V(TopVector,ToeVec,Margin))
        );
        (
            not(toe_board(File_id, _)), 
            not(similar_V(TopVector,(1.0,0.0),Margin))
        ) % if there is no toeboard we have to assume that the railing should be horizontal
    ).

violation(middle_board_sloped, File_id):-
    file_record(_,File_id),
    middle_board(File_id,Board_id),
    board_direction(Board_id, MVector),
    parallel_margin(Margin),
    (
        (toe_board(File_id, ToeBoard_id), board_direction(ToeBoard_id, ToeVec), dissimilar_V(MVector,ToeVec,Margin));
        (not(toe_board(File_id, _)), dissimilar_V(MVector,(1.0,0.0),Margin)) % if there is no toeboard we have to assume that the railing should be horizontal
    ).

% violation(too_few_poles, File_id):-
%     count_poles(File_id,Count_poles), 
%     min_num_poles(File_id, Required_poles),
%     Count_poles<Required_poles.

% violation(too_few_boards, File_id):-
%     count_boards(File_id,Count_boards), 
%     min_num_boards(File_id, Required_boards),
%     Count_boards<Required_boards.

% QUERY VIOLATIONS

% for the correct case we want the file_violation predicate to return the empty set. 
% NB setof returns false, when it only finds the empty set
% if we do this with an or we get both the set and the emty set, as prolog does the backtracing. 

% Solution 1: use the cut-opereator (!), which tell the engine that it should not backtrack if a solution is found, thus the empty set is not returned if a solution is found before the cut-operator (backtracking means that the found and returned part is falsified and the engine tries again)

file_violations_s1(F,S):-
    setof(Vio,(file_record(_, F), violation(Vio, F)),S),!;S=[].
% Solution 2: for a if, then statement IF -> (THEN) ; ELSE
file_violations_s2(F,S):-
    (setof(Vio,(file_record(_, F), violation(Vio, F)),S0)
    ->(S=S0)
    ;S=[]).

% Solution 3: is to do findall + sort approach, which works as findall would also return the empty set (hence not false), and the sort operation makes sure that there are no dublicates
file_violations_s3(F,S):-
    findall(Vio,(file_record(_, F), violation(Vio, F)),S0),
    sort(S0,S).

% We can prove the three solutions to return identical answers with:
% ?- file_record(_,F),file_violations_s1(F,S1), file_violations_s2(F,S2), file_violations_s3(F,S3), S1\=S2, S2\=S3.
% false.

file_violations(F,S):-
    file_record(_, F),
    setof(Vio, violation(Vio, F),S),!;S=[].

% similar approach as file_violations/2
class_violations(ClassName, Class_ID,ClassViolations):-
    setof(Violation, 
            (
                class(class_id, Class_ID, ClassName), 
                class(violation,Class_ID, Violation)
            ),
            ClassViolations),!;ClassViolations=[].

file_class_TP(TP, F_Vio, C_Vio):-
    intersection(F_Vio, C_Vio, TP).

file_class_FN(FN, F_Vio, C_Vio):-
    file_class_TP(TP, F_Vio, C_Vio),
    subtract(C_Vio, TP, FN).

file_class_FP(FP, F_Vio, C_Vio):-
    subtract(F_Vio, C_Vio, FP). 

compare_file_class(File_id, Class_ID, TP,FN, FP):-
    file_record(_,File_id),
    class(class_id,Class_ID,_),
    class_violations(_, Class_ID, C_Vio),
    file_violations(File_id,F_Vio),
    file_class_TP(TP, F_Vio, C_Vio),
    file_class_FN(FN, F_Vio, C_Vio),
    file_class_FP(FP, F_Vio, C_Vio).

len_file_class(File_id, Class_ID, LenTP,LenFN, LenFP):-
    file_record(_,File_id),
    class(class_id,Class_ID,_),
    compare_file_class(File_id, Class_ID, TP,FN, FP),
    length(TP,LenTP),
    length(FN,LenFN),
    length(FP,LenFP).
% table weight_class_fit/3
weight_class_fit(File_id, Class_ID, Fit):-
    file_record(_,File_id),
    class(class_id,Class_ID,_),
    len_file_class(File_id, Class_ID, LenTP,LenFN, LenFP),
    Fit is LenTP-(LenFN+LenFP).

best_class(File_id,L,LS):-
    setof((Class_id, Fit),Class_id^(weight_class_fit(File_id, Class_id, Fit)),L),%[(Classification, Final)|_]
    sort(2, @>=,L,LS).

classify_file(File_id, File_name, Class_id, Class_name, Fit):-
    file_record(File_name,File_id), 
    class(class_id, Class_id, Class_name),best_class(File_id,_,LS), 
    [Head|_]=LS, 
    (Class_id, Fit)=Head.

% checks wether the rule base are able to classify all the planned scenarios correctly
% this predicate ensures that the rule base is correct 
check_planned_scen(File_id,File_name,Actual_Class_name,Predicted_Class_name,TPos,FNeg,FPos, Fit):-
    compare_file_class(File_id, Class_id, TPos,FNeg, FPos),Class_id=File_id,
    classify_file(File_id,File_name,Predicted_Class_id,Predicted_Class_name,Fit),
    Predicted_Class_id\=File_id,
    Actual_Class_id is File_id,
    class(class_id,Actual_Class_id,Actual_Class_name).



% feasability study
best_class_feasability(Iteration, L, File_id):-
    file_record(_,File_id),
    file_iteration_mapping(Iteration, File_id),
    setof(
        (File_id,Predicted_Class_id),
                (classify_file(File_id,_,Predicted_Class_id,_,_)), 
        L).
best_class_feasability_T(Iteration,Time, LS):-
    call_time(
            setof(L, File_id^(best_class_feasability(Iteration, L, File_id)),LS),
        Time).

time_iteration(Iteration,Time,N):-
    call_time(
        (
            findall(
                    (Iteration, Class), 
                    (
                        file_iteration_mapping(Iteration, File_id),
                        file_record(_,File_id), 
                        classify_file(File_id,_,Class,_,_)
                    ),
                L),
            length(L,N)
        ),
    Time).

% findall(Iteration, file_iteration_mapping(Iteration, _),Its),sort(Its,Its_S), findall((It,N,Time),(member(It,Its_S), time_iteration(It,Time,N)),LO).findall(Iteration, 
% file_iteration_mapping(Iteration, _),Its),sort(Its,Its_S), findall((It,N,Time),(member(It,Its_S), time_iteration(It,Time,N)),LO), writefacts(LO).
writefacts(Res):-
    open('output.txt',write,Out),
    write(Out,Res),
    close(Out). 