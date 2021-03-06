%2d EM wave with absorbing boundary using pml
c0 = 3e8; 
epsilon=8.85e-12;
miu=1.257e-6;
dt=0.1/c0;

steps=102;
x=linspace(0,101,102);
 y=linspace(0,101,102);
T= 300;
Ez=zeros(steps,steps);
Hx=zeros(steps,steps);
Hy=zeros(steps,steps);

for m=1:steps
    for n=1:steps
        sigma(m,n)=0.009;
    end
end
for m=10:90
    for n=10:90
    sigma(m,n)=0;
    end
end
for m=1:steps
    for n=1:steps
        vise(m,n)=(sigma(m,n)*dt)/(2*epsilon);%loss for e field
        
    end 
end

for n = 1:T
for l = 1: steps
    for m = 1:steps-1
   Hx(m,l) = ((1-vise(l,m))/(1+vise(l,m))) .*Hx(m,l)-(1/(2*c0*miu.*(1+vise(l,m)))).*(Ez(m+1,l)-Ez(m,l));
    end
end
for p = 1: steps
    for q= 1:steps-1
   Hy(p,q) =((1-vise(p,q))/(1+vise(p,q))) .* Hy(p,q)+(1/(2*c0*miu.*(1+vise(p,q)))).*(Ez(p,q+1)-Ez(p,q));
    end
end
for r = 2: steps
    for s = 2:steps
   Ez(r,s) =((1-vise(r,s))/(1+vise(r,s))) .* Ez(r,s)+(1/(2*c0*epsilon.*(1+vise(r,s)))).*(Hy(r,s)-Hy(r,s-1))-( 1/(2*c0*epsilon.*(1+vise(r,s)))).*(Hx(r,s)-Hx(r-1,s));
    end
end

    Ez(50,50) =sin((2*pi/20)*n);
 mesh(x,y,Ez);
   axis([0 101 0 101 -2 2]);
    getframe;
end