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
	p = Point[0,0]

	mum1 = 1 - mu;
	mum13 = mum1 * mum1 * mum1;
	mu3 = mu * mu * mu;

	p.x = mum13*p1.x + 3*mu*mum1*mum1*p2.x + 3*mu*mu*mum1*p3.x + mu3*p4.x;
	p.y = mum13*p1.y + 3*mu*mum1*mum1*p2.y + 3*mu*mu*mum1*p3.y + mu3*p4.y;
	# p.z = mum13*p1.z + 3*mu*mum1*mum1*p2.z + 3*mu*mu*mum1*p3.z + mu3*p4.z;

	return p
end
