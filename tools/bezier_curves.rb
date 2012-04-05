#coding: utf-8

def bezier_quadra p1, p2, p3, mu
	p = Point[0,0]

	mu2 = mu * mu;
	mum1 = 1 - mu;
	mum12 = mum1 * mum1;
	p.x = p1.x * mum12 + 2 * p2.x * mum1 * mu + p3.x * mu2;
	p.y = p1.y * mum12 + 2 * p2.y * mum1 * mu + p3.y * mu2;
	# p.z = p1.z * mum12 + 2 * p2.z * mum1 * mu + p3.z * mu2;

	return p
end

def bezier_cubic p1, p2, p3, p4, mu
	mum1 = 1 - mu;
	a, b, c, d = mum1**3, 3*mu*mum1**2, 3*mu**2*mum1, mu**3
	
	x = a*p1.x + b*p2.x + c*p3.x + d*p4.x;
	y = a*p1.y + b*p2.y + c*p3.y + d*p4.y;
	# p.z = mum13*p1.z + 3*mu*mum1*mum1*p2.z + 3*mu*mu*mum1*p3.z + mu3*p4.z;

	return Point[x,y]
end
