% /a/ks/b/matlab/table_demo.m

% This is a simple demo of how to create a table in matlab.

days = ['m','t','w']'
prices = [100.1, 100.2, 100.5]'
weather = ['s','c','r']'

mytable = table(days,prices,weather)

monums = [1.1,2.1,33.3]'

mytable.somenums = monums

mytable.prices

% avoid:
mytable(:,mytable.days == 't')

% All cols where mytable.days == 't'
mytable(mytable.days == 't',:)

% select days,weather where days == 't'
mytable(mytable.days == 't',{'days','weather'})

myrow = table()
myrow.days = 'f'
myrow.prices = 100.0
myrow.weather = 'w'
myrow.somenums = 5.4

mytable
myrow

table2 = vertcat(mytable,myrow)

