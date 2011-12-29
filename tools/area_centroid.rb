#coding: utf-8

def area poly
	n=poly.length
	0.5 * (0...n).map{|i| poly[i].x * poly[(i+1)%n].y - poly[(i+1)%n].x * poly[i].y }.inject(&:+)
end

def centroid poly
	n=poly.length
	a=area poly
	
	x=1.0/(a*6) * (0...n).map{|i| (poly[i].x + poly[(i+1)%n].x) * (poly[i].x * poly[(i+1)%n].y - poly[(i+1)%n].x * poly[i].y) }.inject(&:+)
	y=1.0/(a*6) * (0...n).map{|i| (poly[i].y + poly[(i+1)%n].y) * (poly[i].x * poly[(i+1)%n].y - poly[(i+1)%n].x * poly[i].y) }.inject(&:+)
	
	Point[x, y]
end
