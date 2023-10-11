% object(FILE_ID, Instance_id, Type, seg(START_X, START_Y, END_X, END_Y)).
% file_record(FILE, FILE_ID).
% CONSTANTS
parallel_margin(0.005).
length_margin(20).
% FILE_RECORDS
file_record("1/1 - faulty.pcd", 0).
% BIM_PROPERTIES
railing_length(0, 620).
railing_height(0, 100).
min_num_poles(0, 4).
min_num_boards(0, 3).
object(0, 0, pole, seg(248, 0, 255, 108)).
object(0, 1, pole, seg(50, 0, 63, 108)).
object(0, 2, pole, seg(578, 0, 583, 108)).
object(0, 3, board, seg(1, 91, 621, 96)).
object(0, 4, board, seg(0, 43, 621, 49)).
