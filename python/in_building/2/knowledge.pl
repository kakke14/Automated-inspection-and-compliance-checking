% object(FILE_ID, Instance_id, Type, seg(START_X, START_Y, END_X, END_Y)).
% file_record(FILE, FILE_ID).
% CONSTANTS
parallel_margin(0.005).
length_margin(20).
% FILE_RECORDS
file_record("2/2 - compliant.pcd", 0).
file_record("2/2 - faulty.pcd", 1).
file_record("2/scen22.pcd", 2).
% BIM_PROPERTIES
railing_length(0, 480).
railing_length(1, 480).
railing_length(2, 480).
railing_height(0, 120).
railing_height(1, 120).
railing_height(2, 120).
min_num_poles(0, 4).
min_num_poles(1, 4).
min_num_poles(2, 4).
min_num_boards(0, 3).
min_num_boards(1, 3).
min_num_boards(2, 3).
object(0, 0, pole, seg(10, 0, 11, 119)).
object(0, 1, pole, seg(301, 1, 302, 119)).
object(0, 2, pole, seg(164, 3, 167, 119)).
object(1, 3, pole, seg(456, 0, 458, 110)).
object(1, 4, pole, seg(160, 0, 161, 109)).
object(1, 5, pole, seg(294, 0, 296, 110)).
object(1, 6, pole, seg(6, 0, 7, 109)).
object(2, 7, pole, seg(140, 17, 8, 17)).
object(0, 8, board, seg(0, 54, 488, 59)).
object(0, 9, board, seg(0, 106, 488, 111)).
object(0, 10, board, seg(0, 6, 488, 10)).
object(1, 11, board, seg(0, 31, 486, 43)).
object(1, 12, board, seg(1, 87, 486, 99)).
object(2, 13, board, seg(0, 10, 139, 11)).
