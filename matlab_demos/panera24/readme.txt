/a/ks/b/matlab/panera24/readme.txt

I use the files in this dir to backtest close to close lr2lr predictions of GSPC.

The script which runs the backtest is 

panera24/btcc.m

If I want current predictions at noon:55,
I edit 

panera24/noon55price.m

Then I run 

panera21/noon55.m

Then later, at night after Yahoo updates GSPC prices,
I run

panera24/nightcc.m

to see if the predictions match the predictions I got at noon:55.
