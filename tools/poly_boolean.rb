#coding: utf-8

require 'clipper'

def intersection a, b
	c = Clipper::Clipper.new

	c.add_subject_polygon a.map(&:to_a)
	c.add_clip_polygon b.map(&:to_a)
	c.intersection(:non_zero, :non_zero)[0].map{|pnt| Point.new(*pnt)}
end
