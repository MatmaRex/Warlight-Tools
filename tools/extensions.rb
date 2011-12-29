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
end

def min *a; a.min; end
def max *a; a.max; end
