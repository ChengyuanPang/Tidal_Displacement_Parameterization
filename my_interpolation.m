function B = my_interpolation(X,Y,Z,A,x,y,z,B,hf,ws)

ws = ws.^2;

allnans = find(isnan(A(:)));
A(allnans) = 0;

drypoints = find(hf==0);
B(drypoints) = 0;

fixnans = find(isnan(B(:)));

N = length(fixnans);

for n = 1:N

xx = X - x(fixnans(n));
yy = Y - y(fixnans(n));
zz = Z - z(fixnans(n));

xx = - xx.*xx;
yy = - yy.*yy;
zz = - zz.*zz;

scl = 0.5; sumweight = 0;
while sumweight<1e-6,
scl = 2*scl;
weight = exp((xx/ws(1) + yy/ws(2) + zz/ws(3))/scl^2);
weight(allnans) = 0;
sumweight = sum(weight(:));
end

dummy = A .* weight./sumweight;

B(fixnans(n)) = sum(dummy(:));

end


