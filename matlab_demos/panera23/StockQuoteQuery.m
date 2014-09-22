function [date, close, open, low, high, volume, closeadj] = StockQuoteQuery(symbol, start_date, end_date, frequency, varargin)
% STOCKQUOTEQUERY -- Fetch historical stock prices for a given ticker symbol
%     from the YAHOO web serve using the MATLAB Java URL interface.  
%     See SQQ for a function that calls STOCKQUOTEQUERY and allows for 
%     flexibility in input and output and for more explanation of inputs and outputs.
%
%     v1.3b Michael Boldin 10/23/2003  
%       changes made to make R12 compatible
%       uses findstr instead of strfind;
%
%     v1.4  Michael Boldin  2/16/2007
%       fixed problem with datenum() conversion at line 196
%       when YAHOO changed date format to 'yyyy-mm-dd';
%       see  date_format= 'yyyy-mm-dd'  & try daten=;
%
%     Note:  STOCKQUOTEQUERY is based on GETSTOCKDATA by Peter Webb of Mathworks, 
%     as explained in the October 2002 MATLAB News and Notes article
%     "Internet Enabled Data Analysis and Visualization with MATLAB"  
%     See notes below for corrections of problems and additional
%     features.
%
% Required Inputs:  (SYMBOL, START_DATE, END_DATE, FREQUENCY).
%    optional: VERBOSE=1 or 'V' as fifth input to display run time notes and status
%                      
% Outputs:  Parallel vectors (column arrays). 
%   DATE:       Date for the quotes
%   CLOSE:      Closing market price
%   OPEN:       Opening price
%   HIGH:       High price (during trading day or frequency period)
%   LOW:        Low price (during trading day or frequency period)
%   VOLUME:     Volume (during trading day or frequency period)
%   CLOSEADJ:   Close Adjusted for Splits 
%
%
% Corrections and additions to GETSTOCKDATA
%   --verifies YAHOO server tables have 7 elements on a line before parsing the line.
%       The server tables sometimes show extra lines for dividend payments and splits. 
%   --close(breader); close(ireader); close(stream); commented out-- caused problems.
%   --adjusts query parameters to refer to January as month '0', not '1', and February 
%       as  '1', and so on. (This is a feature of the YAHOO system. STOCKQUOTEQUERY uses
%       1 to 12 numbering for months in the input-output parameter translation.) 
%   --flips data vectors to normal date order (increasing, oldest to most recent).
%   --does not require month(), day() or year() functions, uses datevec. 
%   --keeps VOLUME and CLOSEADJ data.
%   --SQQ has flexible input options, especially for dates. 
%   --R12 compatible.
%    


% Initialize input variables to empty matrices
dates = cell(1); date = [];
open = []; high = []; low = []; close = []; closeadj = [];
volume= [];
stockdata = {}; %Cell array for holding data lines from query

matlabv= str2num(version('-release'));
connect_query_data=0;  %this variable holds the status of the query steps;

date_format= 'yyyy-mm-dd';  %used to convert to datenum on try-catch;

verbose=0;
if ( nargin < 4 ),
    error('Not enough inputs');
elseif ( nargin >= 5 );
    v5=varargin{1};
    if isnumeric(v5), verbose=v5; end;
    if ischar(v5) & strncmp(upper(v5),'VERBOSE',1), verbose=1; end;
end;

symbol=upper(symbol);

% Set up the dates and query string
date1=datenum(start_date);   date2=datenum(end_date);
if date1 > date2; %switch dates;
    date1= date2;
    date2= datenum(start_date);
end;  
urlString = YahooUrlString(symbol, date1, date2, frequency);


% Prepare to query the server by opening the URL and using the 
% Java URL class to establish the connection.

if (verbose>=1);
    disp('Contacting YAHOO server using ...');
    disp(['url = java.net.URL(' urlString ')']);
end;
url = java.net.URL(urlString);

% Based on GETSTOCKDATA,
% Once the connection is established, create a stream object to read the
% data that the server has returned. This method creates a buffered i/o 
% stream object and then reads an entire line at a time (rather 
% than single characters).

try
    stream = openStream(url);
    ireader = java.io.InputStreamReader(stream);
    breader = java.io.BufferedReader(ireader);
    connect_query_data= 1; %connect made;
catch
    connect_query_data= -1;  %could not connect case;
    disp(['URL: ' urlString]);
    error(['Could not connect to server. It may be unavailable. Try again later.']);
    stockdata={};
    return;
end

if (verbose>=1);
    disp(['Reading data for symbol ' symbol '...']);
end;

% First line has column header labels
line = readLine(breader);
if (verbose>=1);
    disp('Header Line');
    disp(breader);
    disp ' '
end;
    
    % Read all the available data. We know we've come to the end of the data
    % when the readLine call returns a zero length string. Store the data,
    % line by line, into a cell array. These strings will eventually be 
    % concatenated into one long string, and parsed by STRREAD, so make 
    % sure that each string ends with a comma (this uniformity makes for
    % easier parsing).
    
    not_done=1;
    ii=0;

    while not_done
        
        if (isempty(line) | prod(size(line)) == 0 ); 
            not_done=0;
            if (verbose>=1);
                disp(['... Finished, ' num2str(ii-1) ' lines of data']); 
            end;
            if ii > 0 & ~isempty(stockdata);
                connect_query_data = 2; %query processed;
            else;
                connect_query_data = -2;
            end;
            break; 
        end;
        
        ii=ii+1;  
        line = readLine(breader);
        line = char(line);
        if (verbose==2);
            disp(['Line ' num2str(ii) ': ' line]);
        end;
        
    % Add line to cell matrix if it has the full elements;
    %  try-if added to make R12 compatible
    try;
    if ( ~isempty(line) & size(line,2) > 3 & size(findstr(line,','),2) == 6 );
        line(end+1) = ','; 
        stockdata{ii} = line;
    end;
    catch; %do nothing in case of error above 
    end;
end

% Close the streams, in the opposite order in which they were opened.
%  from GETSTOCKDATA, but this caused problems so commented out   
%close(breader);
%close(ireader);
%close(stream);


% Make cell array one long string of comma-separated list of values
% grouped in sets of seven: DATE, OPEN, HIGH, LOW, CLOSE, VOLUME, CLOSE2.
% This pattern must repeat through the string in order to parse data
% correctly.
stockdata = cat(2,stockdata{:});

% Parse the string data into MATLAB numeric arrays. 
if (length(stockdata) > 0)    
    
    % Note that the order of -- open, high, low, close -- matches the YAHOO server table order,
    % not the function's output order of [date, close, open, low, high, volume, closeadj] 
    
    if matlabv >= 13;
      [dates, open, high, low, close, volume, closeadj] = strread(stockdata,'%s%f%f%f%f%n%f', 'delimiter', ',', 'emptyvalue', NaN);
    else; % R12 version of strread does not have 'emptyvalue' option;
      [dates, open, high, low, close, volume, closeadj] = strread(stockdata,'%s%f%f%f%f%n%f', 'delimiter', ',');
    end;
    
    % Reverse the data vectors to run oldest to most recent
    open=flipud(open); high=flipud(high);  low=flipud(low);
    close=flipud(close);  closeadj=flipud(closeadj);
    volume=flipud(volume);
    
    % Convert the string dates into date numeric format, '1-Jan-2000' or '2007-1-1';
    try;
      date=datenum(dates,date_format);
    catch;
        try;
          date=datenum(dates);
        catch;
         disp('Date format problem (not yyyy-mm-dd)');
         disp(' dates:');
         mm=min(size(dates,1),5);
         disp(dates(1:mm,:));
        end;
    end;    
    date=flipud(date);
    
    connect_query_data = 3; %data processed;
    
    if (verbose>=1);
        disp(['Converted stock data to dates, open, high, low, close, volume, close2']); 
        disp(['Dates: ' datestr(date(1)) ' to '   datestr(date(end)) '  ' num2str(size(close,1)) ' observations']);      
    end;
end

%end of STOCKQUOTEQUERY function


function [urlString] = YahooUrlString(symbol, start_date, end_date, freq);
% Builds the YAHOO Stock Data query string, a specially formatted URL 
%   For retrieving stock quote data from  server = 'http://table.finance.yahoo.com' 
%   This function is used by STOCKQUOTEQUERY (& SQQ) and is based on 
%   GETSTOCKDATA by Peter Webb of Mathworks 
%
% Inputs:
%   SYMBOL: String representing the stock symbol
%   START_DATE: Serial date number
%   END_DATE: Serial date number
%   FREQ: Daily ('d'), Monthly ('m'), or Weekly('w')

% Server URL (name) should not change, query parameters tagged to the end of
% server URL string will vary according to user inputs
server = 'http://table.finance.yahoo.com/table.csv';

% Set day, month and year for the start and end dates
[startYear startMonth startDay] = datevec(start_date);
[endYear endMonth endDay] = datevec(end_date);

query = ['?a=' num2str(startMonth-1) '&b=' num2str(startDay) '&c=' num2str(startYear) ...
         '&d=' num2str(endMonth-1)   '&e=' num2str(endDay)   '&f=' num2str(endYear) ...
         '&s=' num2str(symbol) '&y=0&g=' num2str(freq) ];
% note adjustment to month number - 1, January=0, December=11

% Concatenate the server name and query parameters to complete the URL+query string
urlString = [ server query ];

%end of YAHOOURLSTRING function