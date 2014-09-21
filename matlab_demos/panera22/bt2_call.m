% bt2_call.m

% I use this script to help me develop the api which controls bt2().

% Set the size of each is-table:
is1_rowcount = 20 * 1000;

% Set the size of each oos-table:
oos_rowcount = 100;

% Specify how far back to look for info about previous predictions.
corrpwindow_size = 6;

% Starting point of is-data:
isstart = 1

spyv = readtable('data/spyv.csv');
rowcount_spyv = rowcount(spyv)

while(isstart+is1_rowcount+oos_rowcount < rowcount_spyv)
  bt2(is1_rowcount, oos_rowcount, corrpwindow_size, isstart, spyv);
  isstart = isstart + oos_rowcount
end

% done
