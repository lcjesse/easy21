clear all
src0=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0_E_0.txt');
src1=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.01_E_0.txt');
src2=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.1_E_0.txt');
src3=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.2_E_0.txt');
src4=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.4_E_0.txt');
src5=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.6_E_0.txt');
src6=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.8_E_0.txt');
src7=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_1_E_0.txt');
% src0=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.01_E_0.txt');
% src1=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.01_E_0.01.txt');
% src2=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.01_E_0.1.txt');
% src3=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.01_E_0.2.txt');
% src4=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.01_E_0.4.txt');
% src5=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.01_E_0.6.txt');
% src6=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.01_E_0.8.txt');
% src7=load('D:\Study\大学学习\研一下\神经网络理论与应用\第四次作业\easy21\easy21\reward_episode_log_A_0.01_E_1.txt');
x=[];
y0=[];
y1=[];
y2=[];
y3=[];
y4=[];
y5=[];
y6=[];
y7=[];
z0=[];
z1=[];
z2=[];
z3=[];
z4=[];
z5=[];
z6=[];
z7=[];
for i=1:20
    x(i)=src0(i,1);
    y0(i)=src0(i,3)
    y1(i)=src1(i,3);
    y2(i)=src2(i,3);
    y3(i)=src3(i,3);
    y4(i)=src4(i,3);
    y5(i)=src5(i,3);
    y6(i)=src6(i,3);
    y7(i)=src7(i,3);
    
    z0(i)=src0(i,2)
    z1(i)=src1(i,2);
    z2(i)=src2(i,2);
    z3(i)=src3(i,2);
    z4(i)=src4(i,2);
    z5(i)=src5(i,2);
    z6(i)=src6(i,2);
    z7(i)=src7(i,2);
    
end
figure(1)
plot(x,y0,x,y1,x,y2,x,y3,x,y4,x,y5,x,y6,x,y7,'linewidth',3);
legend('A=0','A=0.01','A=0.1','A=0.2','A=0.4','A=0.6','A=0.8','A=1');
title('reward episode curve(E=0)');
xlabel('episode');
ylabel('total reward(per 1000 episodes)');

hold on
figure(2)
plot(x,z0,x,z1,x,z2,x,z3,x,z4,x,z5,x,z6,x,z7,'linewidth',3);
legend('A=0','A=0.01','A=0.1','A=0.2','A=0.4','A=0.6','A=0.8','A=1');
title('winrate episode curve(E=0)');
xlabel('episode');
ylabel('win rate');

% figure(1)
% plot(x,y0,x,y1,x,y2,x,y3,x,y4,x,y5,x,y6,x,y7,'linewidth',3);
% legend('E=0','E=0.01','E=0.1','E=0.2','E=0.4','E=0.6','E=0.8','E=1');
% title('reward episode curve(A=0.01)');
% xlabel('episode');
% ylabel('total reward(per 1000 episodes)');
% 
% hold on
% figure(2)
% plot(x,z0,x,z1,x,z2,x,z3,x,z4,x,z5,x,z6,x,z7,'linewidth',3);
% legend('E=0','E=0.01','E=0.1','E=0.2','E=0.4','E=0.6','E=0.8','E=1');
% title('winrate episode curve(A=0.01)');
% xlabel('episode');
% ylabel('win rate');