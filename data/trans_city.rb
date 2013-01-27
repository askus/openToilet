require 'iconv'
class String
	def to_my_utf8
		::Iconv.conv('UTF-8//IGNORE', 'big5', self + ' ')[0..-2]
	end
end

fout= File.open('seeds.rb', 'w')
fout.puts("# encoding: utf8")
fout.puts('Toilet.delete_all')

isFirst=true
total =0
open( 'taipei_city.csv','r:big5' ) do |f|
	while text = f.gets
		if isFirst
			isFirst = false
			next
		end
		tmp = text.strip!.split(",")
		name = tmp[0].to_my_utf8  #.delete("公廁坐落：")
		address = tmp[4].to_my_utf8
		lnt = tmp[5]
		lat = tmp[6]
		fout.puts( 'Toilet.create(:name => \'' + name + '\', :address => \'' + address + '\', :longitude => ' + lnt + ', :latitude => ' + lat + ')' ) 
		total += 1 
	end 
end

fout.puts('ToiletRating.delete_all')
fout.puts('for toilet in Toilet.all do ')
fout.puts('	ToiletRating.create( :toilet_id => toilet.id, :cleanness=>3, :safety=>3, :privacy=>3, :comfort=>3, :has_hook=>false, :has_tissue=>false)')
fout.puts('end') 



=begin
isFirst=true
File.open( 'taipei_bank.csv' ) do |f|
	while text = f.gets
		if isFirst
			isFirst = false
			next
		end
		tmp = text.split(",")
		name =( tmp[0],tmp[1]) 
		lnt = tmp[5]
=end
