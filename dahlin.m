N=1;
T=0.8;
Tf=0.15;
alpha=exp(-T/Tf);                      % ? = e -T / ?f
beta=1-alpha;
condition=tf([0 0  beta],[1 -alpha  -beta],0.8,'variable','z^-1');   
                                                   %[C(z)/R(z)] / [1+C(z)/R(z)] = (1- ?)Z-(N+1) / 1- ? Z-1-(1- ?) Z-(N+1) 
n1=[0 1];                                    %Gp(s)=1/0.4s+1
d1=[0.4 1];
[n2, d2]=pade(0.8,1);
n3=conv(n1,n2);
d3=conv(d1,d2);
cprocess=tf(n3,d3);
dprocess=c2d(cprocess,0.8);                   %G(s) to G(z)
dcontroller=condition*(1/dprocess);       %D(z)=[C(z)/R(z)]*[1/G(z)]
system=dcontroller*dprocess; 	     %forward loop D(z)*G(z)
overallsystem=feedback(system,1,-1);    %feedback system D(z)*G(z)/(1+D(z)*G(z))
t=0:0.8:80;
y=step(overallsystem,t);
plot(t,y);
xlabel('time');
ylabel('amplitude');
title('Response of the system- Dahlins algorithm'); 
