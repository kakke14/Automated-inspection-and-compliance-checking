% object(FILE_ID, Instance_id, Type, seg(START_X, START_Y, END_X, END_Y)).
% file_record(FILE, FILE_ID).
% CONSTANTS
parallel_margin(0.005).
length_margin(20).
% FILE_RECORDS
file_record("6/6_compliant_inside.pcd", 0).
file_record("6/6_compliant_outside.pcd", 1).
file_record("6/6_faulty_inside.pcd", 2).
file_record("6/6_faulty_outside.pcd", 3).
% BIM_PROPERTIES
railing_length(0, 175).
railing_length(1, 175).
railing_length(2, 175).
railing_length(3, 175).
railing_height(0, 100).
railing_height(1, 100).
railing_height(2, 100).
railing_height(3, 100).
min_num_poles(0, 2).
min_num_poles(1, 2).
min_num_poles(2, 2).
min_num_poles(3, 2).
min_num_boards(0, 3).
min_num_boards(1, 3).
min_num_boards(2, 3).
min_num_boards(3, 3).
object(0, 0, pole, seg(5, 0, 7, 173)).
object(0, 1, pole, seg(166, 0, 168, 172)).
object(1, 2, pole, seg(1, 0, 3, 215)).
object(1, 3, pole, seg(152, 0, 159, 215)).
object(2, 4, pole, seg(159, 0, 161, 205)).
object(2, 5, pole, seg(4, 0, 7, 206)).
object(3, 6, pole, seg(2, 0, 8, 216)).
object(3, 7, pole, seg(161, 0, 163, 215)).
object(0, 8, board, seg(1, 95, 175, 96)).
object(0, 9, board, seg(0, 40, 175, 41)).
object(0, 10, board, seg(0, 3, 176, 5)).
object(1, 11, board, seg(1, 96, 160, 97)).
object(1, 12, board, seg(0, 42, 160, 43)).
object(1, 13, board, seg(0, 5, 160, 6)).
object(2, 14, board, seg(1, 94, 164, 95)).
object(2, 15, board, seg(0, 4, 164, 5)).
object(3, 16, board, seg(0, 95, 171, 97)).
object(3, 17, board, seg(0, 4, 171, 6)).
