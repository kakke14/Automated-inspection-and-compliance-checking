% object(FILE_ID, Instance_id, Type, seg(START_X, START_Y, END_X, END_Y)).
% file_record(FILE, FILE_ID).
% CONSTANTS
parallel_margin(0.005).
length_margin(20).
% FILE_RECORDS
file_record("3/3 - left.pcd", 0).
file_record("3/3 - left_top_cut.pcd", 1).
file_record("3/3 - right.pcd", 2).
% BIM_PROPERTIES
railing_length(0, 140).
railing_length(1, 140).
railing_length(2, 140).
railing_height(0, 90).
railing_height(1, 90).
railing_height(2, 90).
min_num_poles(0, 2).
min_num_poles(1, 2).
min_num_poles(2, 2).
min_num_boards(0, 1).
min_num_boards(1, 1).
min_num_boards(2, 1).
object(0, 0, pole, seg(136, 52, 138, 282)).
object(0, 1, pole, seg(4, 52, 7, 282)).
object(1, 2, pole, seg(7, 52, 9, 109)).
object(1, 3, pole, seg(137, 52, 138, 109)).
object(2, 4, pole, seg(130, 48, 133, 288)).
object(2, 5, pole, seg(1, 48, 4, 288)).
object(0, 6, board, seg(0, 88, 143, 92)).
object(1, 7, board, seg(0, 88, 143, 92)).
object(2, 8, board, seg(0, 86, 137, 88)).
