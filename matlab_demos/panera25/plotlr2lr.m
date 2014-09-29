% plotlr2lr.m

% Demo:
% plotlr2lr('data/my_lr2lr_rpt_2014_09_29_07_3753.csv')

function [ output_args ] = plotlr2lr( filename )
% I use this function to plot data in a CSV with columns:
% ydate, cp, upprob1, upprob2, pctg, ydatestr
% cp appears as blue.
% upprob2 appears as green.

s = readtable( filename);

date = s.ydate;
holdSpy = s.cp ./ s.cp(1);

leverageLongCloseToOpen = holdSpy;
for i=2:length(date)
    if( s.upprob2(i-1) > 0.5 ) 
        leverageLongCloseToOpen(i) = leverageLongCloseToOpen(i-1)* ...
            (1 + 0.02 * s.pctg(i-1));
    else
        leverageLongCloseToOpen(i) = leverageLongCloseToOpen(i-1);
    end;
end;    

plot( date, holdSpy, 'g', date, leverageLongCloseToOpen, 'b');
datetick('x','mm/dd/yy'); grid on;

end

