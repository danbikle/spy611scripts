% /a/ks/b/matlab/panera22/genisoos1.m

% I use this function to help me generate in-sample and out-of-sample
% data for Logistic Regression from a table full of vectors:

% Demo:

% spyv         = cr_myvectors(spyall);
% boundry_date = datenum([2014 08 01]);
% is_size      = 20123;
% oos_size     = 40.0 * 2 * 24;
% [is1table, oostable] = genisoos1(spyv, boundry_date, is_size, oos_size);

% function [is1table, oostable] = genisoos1(spyv, boundry_date, is_size, oos_size)
function structout = genisoos1(spyv, boundry_date, is_size, oos_size)
is1table  = spyv((spyv.cpdate < boundry_date), : ) ;
oos1table = spyv((spyv.cpdate > boundry_date), : ) ;

size_is1table  = size(is1table);
size_oos1table = size(oos1table);

is1table  = is1table( end-size_is1table(1) +1:end , : );
oos1table = oos1table(end-size_oos1table(1)+1:end , : );

% Add weight to the newer rows in is1table.
% Assume I start with 20123 rows or more:

w1 = is1table( end-1*5000:end , : );
w2 = is1table( end-2*5000:end , : );
w3 = is1table( end-3*5000:end , : );

is1table = vertcat(is1table,w1,w2,w3);

structout.is1table  = is1table;
structout.oos1table = oos1table;

% done




