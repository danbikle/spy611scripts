# ~/spy611/script/wget_noon.rb

myfile = File.open("/home/dan/tmp/GSPC.html")
doc = Nokogiri::HTML(myfile)
myfile.close

# p doc.css('#yfs_l84_spy')

closing_price = doc.css('#yfs_l10_xyzgspc')[0].children.inner_text.sub(/,/,'')

day_now = Time.now.to_s.sub(/ .*/,'')

puts (delsql = "DELETE FROM mydata WHERE ydate = '#{day_now}';")
puts (inssql = "INSERT INTO mydata(ydate,closing_price) VALUES('#{day_now}', #{closing_price});")

# end
