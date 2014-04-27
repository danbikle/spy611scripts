~/spy611/script/ma/readme.txt

The scripts in this dir depend on vectors built from features which mostly depend
on moving averages of price.

Typical scenario:

cron collects latest sp500 price at 12:50 and issues predictions.

cron does it again at 13:10.

I then run ./bt.bash to issue predictions using the ma-vectors.

It's not clear that the ma-vectors lead to better predictions.

But each ma-feature does seem more predictive as a stand-alone feature.
