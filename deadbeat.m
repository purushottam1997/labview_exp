n=[0 1];                                                    %Gp(s)=1/0.4s+1
d=[.4 1];
conprocess=tf(n,d);
disprocess=c2d(conprocess,1);               %continuous to discrete of G(s) 
                                                                %G(z)=z(Gp(s)Gho(s))
z=tf('z',1);
condition=1/(z-1);                                    %[c(z)/R(z)] / [1- c(z)/R(z)] = 1/(z-1)
discontroller=(1/disprocess)*condition;  %D(z)=(1/G(z))*(1/(z-1))
system=discontroller*disprocess;            %forward loop D(z)*G(z)
overallsystem=feedback(system,1)         %feedback system D(z)*G(z)/(1+D(z)*G(z))
t=0:1:10;
y=step(overallsystem,t);
plot(t,y);
xlabel('time');
ylabel ('amplitude');
title('Response of the System-dead beat algorithm');
