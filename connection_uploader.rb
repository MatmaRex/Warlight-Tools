# coding: utf-8
$:.unshift File.dirname($0)
puts 'Starting up, be patient...'
puts ''

require 'pp'
require 'progressbar'

require 'savage'

require 'nokogiri'
require 'builder'
require 'markaby'

require 'net/http'


require './tools/extensions'
require './tools/bezier_curves'
require './tools/area_centroid'

require './tools/svg_territory_parsing'

def ask!
	print '> '
	return gets.strip
end



################################################################
# script starts here
################################################################


puts "This tool will allow you to automatically create 
connections on your map."
puts ""
puts "It will have to ask you for your e-mail and password. This data 
is *not* remembered or used for any malicious purposes, 
it's simply required to confirm that it's your map 
and you have the right to edit it."
puts ""
puts "It will also need the map's id. You can get it 
by clicking \"Get Link for Sharing\", 
the id is the number displayed at the end of public link."
puts ""
puts ""

puts 'Enter the name of file to work on: '
infile = ask!
infile += '.svg' unless infile.end_with? '.svg'

while !File.exist? infile
	puts 'No such file! Try again:'
	infile = ask!
	infile += '.svg' unless infile.end_with? '.svg'
end
puts ""

puts "And now the map's and your data: [warning - your password will be visible]"
print "Map id:   "; mapid = gets.strip;
print "E-mail:   "; email = gets.strip;
print "Password: "; userpass = gets.strip;

puts ""


puts 'Working... this may take some time. Go have a cup of tea or something.'
at_exit{puts "Press enter to exit."; gets} # don't close the window, ever - show error information
$talktome = true


svg = File.read infile
territs = all_territs_in_svg svg

class Array
	attr_accessor :_bbox_cache
	attr_accessor :_bbox_cache_hash
	
	def bounding_box
		if self.hash == @_bbox_cache_hash
			@_bbox_cache
		else
			left, right = *self.map{|p| p.x}.minmax
			top, bottom = *self.map{|p| p.y}.minmax
			
			@_bbox_cache_hash = self.hash
			@_bbox_cache = [ Point[left, top],  Point[right, bottom] ]
		end
	end
	
	def bbox_intersect? other
		bb1 = self.bounding_box
		bb2 = other.bounding_box
		
		return (
			(
				bb2.map(&:x).any?{|x| x.between? *bb1.map(&:x) } or
				bb1.map(&:x).any?{|x| x.between? *bb2.map(&:x) }
			)\
			and
			(
				bb2.map(&:y).any?{|y| y.between? *bb1.map(&:y) } or
				bb1.map(&:y).any?{|y| y.between? *bb2.map(&:y) }
			)
		)
	end
	def bbox_close? other, dist=5
		a = other.bounding_box
		# enlarge the other bbox by dist
		a[0].x -= dist
		a[0].y -= dist
		a[1].x += dist
		a[1].y += dist
		
		self.bbox_intersect? a
	end
end


# ary.combination(2).

n = territs.length
count = n*(n-1)/2
puts "Finding connections... (checking #{count} pairs)"
pbar = ProgressBar.new("Progress", count)

connections = []

territs.to_a.combination(2).each do |(id1, poly1), (id2, poly2)|
	if poly1.bbox_close? poly2
		conn = poly1.product(poly2).any?{|p1, p2| p1.distance_sq(p2) < 25 }
		if conn
			connections << [id1, id2]
		end
	end
	
	pbar.inc
end
pbar.finish

puts ""
puts "Great, we've done it! Uploading data..."
puts ""

Markaby::Builder.set :indent, 2
Markaby::Builder.set :auto_validation, false
mab = Markaby::Builder.new
mab.tag! 'setMapDetails' do
	tag! 'email', email
	tag! 'password', userpass
	tag! 'mapID', mapid
	
	connections.each do |id1, id2|
		tag! 'addTerritoryConnection', id1: id1, id2: id2, wrap:'Normal'
	end
end
xml = mab.to_s

puts xml

api = 'http://warlight.net'

http = Net::HTTP.start('warlight.net')
response = http.post('/API/SetMapDetails.aspx', xml)

if response.is_a?(Net::HTTPOK) && (response.body =~ /<Success/)
	puts "It appears to have worked! Go check your map in the map designer now."
else
	puts "Well damn, something didn't work. :( It might be a good idea to report the error along with the data below."
	p response
	puts response
end

