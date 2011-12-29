#coding: utf-8

def is_inside polygon, p
	n = polygon.length
	angle=0;
	p1 = Point[0,0]
	p2 = Point[0,0]

	polygon.each_index do |i|
		p1.x = polygon[i].x - p.x;
		p1.y = polygon[i].y - p.y;
		p2.x = polygon[(i+1)%n].x - p.x;
		p2.y = polygon[(i+1)%n].y - p.y;
		angle += __angle2d(p1.x,p1.y,p2.x,p2.y);
	end

	if ((angle).abs < Math::PI)
		return false
	else
		return true
	end
end

def __angle2d x1, y1, x2, y2
	theta1 = Math.atan2(y1,x1) rescue 0
	theta2 = Math.atan2(y2,x2) rescue 0
	dtheta = theta2 - theta1;
	while (dtheta > Math::PI)
		dtheta -= 2*Math::PI;
	end
	while (dtheta < -Math::PI)
		dtheta += 2*Math::PI;
	end

	return dtheta
end
