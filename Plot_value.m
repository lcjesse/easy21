clear all
src=load('D:\Study\��ѧѧϰ\��һ��\������������Ӧ��\���Ĵ���ҵ\easy21\easy21\value_state_action_log.txt');

x=[];
y=[];
z=[];

for i=1:242
    x(i)=src(i,1);
    y(i)=src(i,2);
    z(i)=src(i,3);
end

figure(1)
tri = delaunay(x,y);
trimesh(tri,x,y,z);
grid on
title('Optimal value function ');
xlabel('dealer showing');
ylabel('player sum');
zlabel('Value');


