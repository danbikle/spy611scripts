% /a/ks/b/matlab/panera22/genisoos.m

% I use this function to help me generate in-sample and out-of-sample
% data for Logistic Regression from a table full of vectors:

% Demo:

% spyv         = cr_myvectors(spyall);
% boundry_date = datenum([2014 08 01]);
% is_size      = 20123;
% oos_size     = 40.0 * 2 * 24;
% [istable, oostable] = genisoos(spyv, boundry_date, is_size, oos_size);

function [istable, oostable] = genisoos(spyv, boundry_date, is_size, oos_size)
istable  = spyv((spyv.cpdate < boundry_date), : ) ;
oostable = spyv((spyv.cpdate > boundry_date), : ) ;

size_istable  = size(istable);
size_oostable = size(oostable);

istable  = istable( end-size_istable(1) +1:end , : );
oostable = oostable(end-size_oostable(1)+1:end , : );

% Add weight to the newer rows in istable.
% Assume I start with 20123 rows or more:

w1 = istable( end-1*5000:end , : );
w2 = istable( end-2*5000:end , : );
w3 = istable( end-3*5000:end , : );

istable = vertcat(istable,w1,w2,w3);

% done




