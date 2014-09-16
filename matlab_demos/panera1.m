% panera1.m
% I use this script to demo logistic regression of stock market data
% Get data from yahoo for ^GSPC
startDate = datenum( [ 1944 1 1 ] );
endDate  = now; %  datenum([2014 9 30]);
symbl = '^GSPC';

freq = 'd' ;


[date, close, open, low, high, volume, closeadj] ... 
                = StockQuoteQuery( symbl, startDate, endDate, freq) ;
            
subplot( 2, 1, 1) ; plot( date, closeadj, 'r' );datetick('x','mm/dd/yy');

% Create vectors from yahoo data
% I want ...
% date, close, 1day-lag
mystruct10 = struct('date',date, 'datestr', datestr(date), 'close',close);
vDiff = (close(2:end) - close(1:end-1));
vDiffNorm1 = vDiff./close(1:end-1);

%mystruct11 = (struct('date',date, 'datestr', datestr(date), 'close',close))(2:end);
mystruct11 = struct('date',date(2:end), 'datestr', datestr(date(2:end)), 'close',close(2:end), 'prevClose', close(1:end-1), 'diffNorm1', vDiffNorm1);
mystruct12 = struct ...
    ('date',date(3:end), 'datestr', datestr(date(3:end)), 'close',close(3:end), 'prevClose', close(3:end-1), 'n1dg1', vDiffNorm1(2:end), 'n1dg2', vDiffNorm(3:end));
%length(mystruct11)
%length(vDiff)

%mystruct12 = [mystruct11,'lag1d',vDiff]

% Create in-sample vectors from vectors
% Create od-of-sample vectors from vectos
% Predict y-values of oos-vectors
% Compare predicted y-values to real y-values
% Compare matlab validation to linux validation

