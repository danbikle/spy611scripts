% /a/ks/b/matlab/panera22/genisoos1.m

% I use this function to help me generate in-sample and out-of-sample
% data for Logistic Regression from a table full of vectors:

% Demo:

% spyv         = cr_myvectors(spyall);
% boundry_date = datenum([2014 08 01]);
% is_size      = 20 * 1000;
% oos_size     = 1000;
% isoos1tables = genisoos1(spyv, boundry_date, is_size, oos_size);

function structout = genisoos1(spyv, boundry_date, is_size, oos_size)
is1table  = spyv((spyv.cpdate < boundry_date), : ) ;
oos1table = spyv((spyv.cpdate > boundry_date), : ) ;

size_is1table  = size(is1table);
size_oos1table = size(oos1table);

if(size_is1table(1) > is_size)
  % Make it smaller by truncating older observations:
  is1table  = is1table( end-is_size+1:end , : );
end

if(size_oos1table(1) > oos_size)
  % Make it smaller by truncating older observations:
  oos1table  = oos1table( end-oos_size+1:end , : );
end

% Add weight to the newer rows in is1table.
is1table_weighted = weighttable(is1table);

structout.is1table          = is1table;
structout.is1table_weighted = is1table_weighted;
structout.oos1table         = oos1table;

% done




