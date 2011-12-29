class Point < Array
	def x; self[0]; end
	def y; self[1]; end
	
	def to_s; "(#{x}, #{y})"; end
	def inspect; "Point[#{x}, #{y}]"; end
	
	def + other
		Point[self.x + other.x,  self.y + other.y]
	end
	def - other
		Point[self.x - other.x,  self.y - other.y]
	end
end


def area poly
	n=poly.length
	0.5 * (0...n).map{|i| poly[i].x * poly[(i+1)%n].y - poly[(i+1)%n].x * poly[i].y }.inject(&:+)
end

def area_r poly
	n=poly.length
	Rational((0...n).map{|i| poly[i].x * poly[(i+1)%n].y - poly[(i+1)%n].x * poly[i].y }.inject(&:+), 2)
end

def centroid poly
	n=poly.length
	a=area poly
	
	x=1.0/(a*6) * (0...n).map{|i| (poly[i].x + poly[(i+1)%n].x) * (poly[i].x * poly[(i+1)%n].y - poly[(i+1)%n].x * poly[i].y) }.inject(&:+)
	y=1.0/(a*6) * (0...n).map{|i| (poly[i].y + poly[(i+1)%n].y) * (poly[i].x * poly[(i+1)%n].y - poly[(i+1)%n].x * poly[i].y) }.inject(&:+)
	
	Point[x, y]
end

def centroid_r poly
	n=poly.length
	a=area_r poly
	
	x=Rational((0...n).map{|i| (poly[i].x + poly[(i+1)%n].x) * (poly[i].x * poly[(i+1)%n].y - poly[(i+1)%n].x * poly[i].y) }.inject(&:+), a*6)
	y=Rational((0...n).map{|i| (poly[i].y + poly[(i+1)%n].y) * (poly[i].x * poly[(i+1)%n].y - poly[(i+1)%n].x * poly[i].y) }.inject(&:+), a*6)
	
	Point[x, y]
end



if __FILE__ == $0
	polygons={
		square:[
			Point[0, 0],
			Point[1, 0],
			Point[1, 1],
			Point[0, 1],
		],
		triangle:[
			Point[0, 0],
			Point[1, 0],
			Point[0, 1],
		],
		weirdo:[
			Point[0, 0],
			Point[3, 0],
			Point[3, 2],
			Point[2, 1],
			Point[0, 2],
		],
		letterU:[
			Point[0, 0],
			Point[0, 3],
			Point[1, 3],
			Point[1, 1],
			Point[2, 1],
			Point[2, 3],
			Point[3, 3],
			Point[3, 0],
		]
	}

	maxlen=polygons.map{|k,v| k.to_s.length}.max
	polygons.each_pair{|name, poly| puts "#{name.to_s.rjust maxlen}: area #{area poly}, centroid #{centroid poly}"}
	puts ''
	polygons.each_pair{|name, poly| puts "#{name.to_s.rjust maxlen}: area_r #{area_r poly}, centroid_r #{centroid_r poly}"}


	# require 'benchmark'
	# puts Benchmark.realtime{10_000.times{centroid polygons[:letterU]}}
	# puts Benchmark.realtime{10_000.times{centroid_r polygons[:letterU]}}
end


