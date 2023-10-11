% object(FILE_ID, Instance_id, Type, seg(START_X, START_Y, END_X, END_Y)).
% file_record(FILE, FILE_ID).
% CONSTANTS
parallel_margin(0.005).
length_margin(20).
% FILE_RECORDS
file_record("4/4 - left.pcd", 0).
file_record("4/4 - middle.pcd", 1).
file_record("4/4 - right.pcd", 2).
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
object(0, 0, pole, seg(130, 30, 133, 284)).
object(0, 1, pole, seg(0, 30, 1, 168)).
object(0, 2, pole, seg(135, 169, 135, 281)).
object(1, 3, pole, seg(134, 30, 137, 285)).
object(1, 4, pole, seg(2, 30, 5, 285)).
object(2, 5, pole, seg(134, 30, 136, 280)).
object(2, 6, pole, seg(3, 30, 5, 280)).
