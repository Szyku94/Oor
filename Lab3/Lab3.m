N=400;
P=randn(N,2);
multi=0;
Pr1=randn(N/4,2);
Pr1=[Pr1(:,1)+randn(1,1)*multi Pr1(:,2)+randn(1,1)*multi];
Pr2=randn(N/4,2);
Pr2=[Pr2(:,1)+randn(1,1)*multi Pr2(:,2)+randn(1,1)*multi];
Pr3=randn(N/4,2);
Pr3=[Pr3(:,1)+randn(1,1)*multi Pr3(:,2)+randn(1,1)*multi];
Pr4=randn(N/4,2);
Pr4=[Pr4(:,1)+randn(1,1)*multi Pr4(:,2)+randn(1,1)*multi];
P=[Pr1;Pr2;Pr3;Pr4];
X=[];
c1=randn(1,2);
c2=randn(1,2);
c3=randn(1,2);
c4=randn(1,2);
C1=repmat(c1,N,1);
C2=repmat(c2,N,1);
C3=repmat(c3,N,1);
C4=repmat(c4,N,1);
B1o=false(N,1);
B2o=false(N,1);
B3o=false(N,1);
B4o=false(N,1);
ok=false;
C1new=c1;
C2new=c2;
C3new=c3;
C4new=c4;
i=0;
J=[];
while ~ok
C1dis=sum((C1-P).^2,2);
C2dis=sum((C2-P).^2,2);
C3dis=sum((C3-P).^2,2);
C4dis=sum((C4-P).^2,2);
B1=(C1dis<C2dis)&(C1dis<C3dis)&(C1dis<C4dis);
B2=(C2dis<C1dis)&(C2dis<C3dis)&(C2dis<C4dis);
B3=(C3dis<C2dis)&(C3dis<C1dis)&(C3dis<C4dis);
B4=(C4dis<C2dis)&(C4dis<C3dis)&(C4dis<C1dis);
P1=P(B1,:);
P2=P(B2,:);
P3=P(B3,:);
P4=P(B4,:);
c1new=mean(P1);
c2new=mean(P2);
c3new=mean(P3);
c4new=mean(P4);
C1new=[C1new;c1new];
C2new=[C2new;c2new];
C3new=[C3new;c3new];
C4new=[C4new;c4new];
ok=isequal(B1,B1o)&isequal(B2,B2o)&isequal(B3,B3o)&isequal(B4,B4o);
plot(P1(:,1),P1(:,2),'.','MarkerSize',10,'Color',[0.223, 0.415, 0.694]);
hold on;
plot(P2(:,1),P2(:,2),'.','MarkerSize',10,'Color',[0.854, 0.486, 0.188]);
plot(P3(:,1),P3(:,2),'.','MarkerSize',10,'Color',[0.243, 0.588, 0.317]);
plot(P4(:,1),P4(:,2),'.','MarkerSize',10,'Color',[0.8, 0.145, 0.161]);
plot(c1(:,1),c1(:,2),'ko','MarkerSize',10,'MarkerFaceColor','k');
plot(c2(:,1),c2(:,2),'ko','MarkerSize',10,'MarkerFaceColor','k');
plot(c3(:,1),c3(:,2),'ko','MarkerSize',10,'MarkerFaceColor','k');
plot(c4(:,1),c4(:,2),'ko','MarkerSize',10,'MarkerFaceColor','k');
plot(C1new(:,1),C1new(:,2),'k-','MarkerSize',10,'MarkerFaceColor','m');
plot(C2new(:,1),C2new(:,2),'k-','MarkerSize',10,'MarkerFaceColor','m');
plot(C3new(:,1),C3new(:,2),'k-','MarkerSize',10,'MarkerFaceColor','m');
plot(C4new(:,1),C4new(:,2),'k-','MarkerSize',10,'MarkerFaceColor','m');
plot(C1new(end,1),C1new(end,2),'ko','MarkerSize',10,'MarkerFaceColor','m');
plot(C2new(end,1),C2new(end,2),'ko','MarkerSize',10,'MarkerFaceColor','m');
plot(C3new(end,1),C3new(end,2),'ko','MarkerSize',10,'MarkerFaceColor','m');
plot(C4new(end,1),C4new(end,2),'ko','MarkerSize',10,'MarkerFaceColor','m');
hold off;
axis equal;
B1o=B1;
B2o=B2;
B3o=B3;
B4o=B4;
C1=repmat(c1new,N,1);
C2=repmat(c2new,N,1);
C3=repmat(c3new,N,1);
C4=repmat(c4new,N,1);
J=[J;sum(C1dis(B1,:))+sum(C2dis(B2,:))+sum(C3dis(B3,:))+sum(C4dis(B4,:))];
pause(0.1);
i=i+1;
end;
X=[X;J(end)];
J(end);
Pul1=floor(size(P1,1)*0.5);
Pul2=floor(size(P2,1)*0.5);
Pul3=floor(size(P3,1)*0.5);
Pul4=floor(size(P4,1)*0.5);
du=[ones(Pul1,1) zeros(Pul1,3);zeros(Pul2,1) ones(Pul2,1) zeros(Pul2,2);
    zeros(Pul3,2) ones(Pul3,1) zeros(Pul3,1);zeros(Pul4,3) ones(Pul4,1)]';
Pu=[P1(1:Pul1,:);P2(1:Pul2,:);P3(1:Pul3,:);P4(1:Pul4,:)]';
Pwl1=size(P1,1)-Pul1;
Pwl2=size(P2,1)-Pul2;
Pwl3=size(P3,1)-Pul3;
Pwl4=size(P4,1)-Pul4;
dw=[ones(Pwl1,1) zeros(Pwl1,3);zeros(Pwl2,1) ones(Pwl2,1) zeros(Pwl2,2);
    zeros(Pwl3,2) ones(Pwl3,1) zeros(Pwl3,1);zeros(Pwl4,3) ones(Pwl4,1)]';
Pw=[P1(Pul1+1:end,:);P2(Pul2+1:end,:);P3(Pul3+1:end,:);P4(Pul4+1:end,:)]';
lw1=2;
lw2=8;
lw3=6;
lw4=4;
minmax=[-4 4;-4 4];
siec=newff(minmax,[lw1,lw2,lw3,lw4],{'logsig','logsig','logsig','logsig'});
siec.trainParam.show=50;
siec.trainParam.lr=0.1;
siec.trainParam.epochs=5000;
siec.trainParam.goal=0.000000000001;
[siec tr]=train(siec,Pu,du);
x1=-4:0.01:4;
x2=x1;
X=[x1;x2];
X=combntns(-4:0.01:4,2)';
X=[X(2,:) X(1,:) x1;X(1,:) X(2,:) x1];
Y=sim(siec,X);
[c d]=max(Y);
Px1=X(:,d(1,:)==1)';
Px2=X(:,d(1,:)==2)';
Px3=X(:,d(1,:)==3)';
Px4=X(:,d(1,:)==4)';
plot(Px1(:,1),Px1(:,2),'.','MarkerSize',10,'Color',[0.223, 0.415, 0.394]);
hold on;
plot(Px2(:,1),Px2(:,2),'.','MarkerSize',10,'Color',[0.554, 0.486, 0.188]);
plot(Px3(:,1),Px3(:,2),'.','MarkerSize',10,'Color',[0.243, 0.288, 0.317]);
plot(Px4(:,1),Px4(:,2),'.','MarkerSize',10,'Color',[0.5, 0.145, 0.161]);
plot(P1(:,1),P1(:,2),'.','MarkerSize',10,'Color',[0.223, 0.415, 0.694]);
plot(P2(:,1),P2(:,2),'.','MarkerSize',10,'Color',[0.854, 0.486, 0.188]);
plot(P3(:,1),P3(:,2),'.','MarkerSize',10,'Color',[0.243, 0.588, 0.317]);
plot(P4(:,1),P4(:,2),'.','MarkerSize',10,'Color',[0.8, 0.145, 0.161]);
plot(c1(:,1),c1(:,2),'ko','MarkerSize',10,'MarkerFaceColor','k');
plot(c2(:,1),c2(:,2),'ko','MarkerSize',10,'MarkerFaceColor','k');
plot(c3(:,1),c3(:,2),'ko','MarkerSize',10,'MarkerFaceColor','k');
plot(c4(:,1),c4(:,2),'ko','MarkerSize',10,'MarkerFaceColor','k');
plot(C1new(:,1),C1new(:,2),'k-','MarkerSize',10,'MarkerFaceColor','m');
plot(C2new(:,1),C2new(:,2),'k-','MarkerSize',10,'MarkerFaceColor','m');
plot(C3new(:,1),C3new(:,2),'k-','MarkerSize',10,'MarkerFaceColor','m');
plot(C4new(:,1),C4new(:,2),'k-','MarkerSize',10,'MarkerFaceColor','m');
plot(C1new(end,1),C1new(end,2),'ko','MarkerSize',10,'MarkerFaceColor','m');
plot(C2new(end,1),C2new(end,2),'ko','MarkerSize',10,'MarkerFaceColor','m');
plot(C3new(end,1),C3new(end,2),'ko','MarkerSize',10,'MarkerFaceColor','m');
plot(C4new(end,1),C4new(end,2),'ko','MarkerSize',10,'MarkerFaceColor','m');
hold off;
axis equal;
yu=sim(siec,Pu);
[a b]=max(yu);
[c d]=max(du);
BladU=sum(b~=d)
yw=sim(siec,Pw);
[a b]=max(yw);
[c d]=max(dw);
BladW=sum(b~=d)