% /a/ks/b/matlab/panera22/fill_spyall.m

% I use this script to fill a table named spyall with data from a newer csv file and an older csv file.
% The newer file should have been filled within the last 10 or 15 minutes.
% The older file can be as old as a month before I encounter a gap.

% Demo:
% spyall = fill_spyall;

function atable = fill_spyall()
atable = table();

% Done already:
% spy_since2000          = readtable('data/SPY30min_bars_since2000.csv');
% scat1                  = strcat(spy_since2000.Date, spy_since2000.Time);
% spy_since2000.cpdate   = datenum(scat1,'mm/dd/yyyyHH:MM');
% spy_since2000.datestr2 = datestr(spy_since2000.cpdate,'yyyy-mm-dd HH:MM');
% spy_since2000.cp       = spy_since2000.Close;
% spytop = spy_since2000( : , {'cpdate','datestr2','cp'});

spytop        = readtable('data/spyall2014_09_18_23_30.csv');
spytop_bottom = spytop.datestr2(end)

spy_recent                = readtable('data/spy_recent.csv');
spy_recent.days_since1970 = (spy_recent.seconds_since1970/3600.0)/24.0;
spy_recent.cpdate         = datenum('1970', 'yyyy') + spy_recent.days_since1970;
spy_recent.datestr2       = datestr(spy_recent.cpdate,'yyyy-mm-dd HH:MM');

spytop_boundry = max(spytop.cpdate)

spybottom = spy_recent( (spy_recent.cpdate > spytop_boundry) , {'cpdate','datestr2','cp'})

% If spybottom has rows, add them, else dont:
size_spybottom = size(spybottom)
if(size_spybottom(1) > 0)
  atable = vertcat(spytop,spybottom);
else
  atable = spytop;
end

% Backup spyall to csv, eventually the backups will replace 
% data/SPY30min_bars_since2000.csv

back_date = datestr(max(atable.cpdate),'yyyy_mm_dd_HH_MM')

spyall_backup = strcat('data/spyall', back_date, '.csv')

writetable(atable,spyall_backup)

% end
