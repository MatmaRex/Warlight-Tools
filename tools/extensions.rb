#coding: utf-8
require 'savage'

Point = Savage::Directions::Point
class Savage::Directions::Point
	def self.[] x, y
		Savage::Directions::Point.new(x, y)
	end
	def + other
		self.class.new(self.x + other.x, self.y + other.y)
	end
	
	def distance_sq other
		(self.x - other.x)**2  +  (self.y - other.y)**2
	end
	def distance other
		Math.sqrt self.distance_sq other
	end
end

def min *a; a.min; end
def max *a; a.max; end
