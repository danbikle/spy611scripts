% /a/ks/b/matlab/panera22/genisoos1.m

% I use this function to help me generate in-sample and out-of-sample
% data for Logistic Regression from a table full of vectors:

% Demo:

% spyv     = cr_myvectors(spyall);
% is_size  = 20 * 1000
% oos_size = 100
% isstart  = 1
% [is1table oos1table] = genisoos1(spyv, is_size, oos_size, isstart);

function [is1table oos1table] = genisoos1(spyv, is_size, oos_size, isstart)

isend    = isstart+is_size-1
oosstart = isend+3
oosend   = oosstart+oos_size-1

is1table  = spyv( isstart:isend   , : ) ;
oos1table = spyv( oosstart:oosend , : ) ;

% done




