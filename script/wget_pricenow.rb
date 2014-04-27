# ~/spy611/script/wget_pricenow.rb

myfile = File.open("/home/dan/tmp/SPY.html")
doc = Nokogiri::HTML(myfile)
myfile.close

# p doc.css('#yfs_l84_spy')

myspan = doc.css('#yfs_l84_spy')[0]

# p myspan

mych = myspan.children

p mych.inner_text.to_f


# end


