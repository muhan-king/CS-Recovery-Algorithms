
%%
%----------------------------------------------------------------------------------%
%  1-D�ź�ѹ�����е�ʵ��(l1-MAGIC��l1_ls��l1����)   
%  ������M>=K*log(N/K),K��ϡ���,N�źų���,���Խ�����ȫ�ع�
%  �����--���Ͻ�ͨ��ѧǣ�����������ص�ʵ���� ����  Email: aresmiki@163.com
%  ���ʱ�䣺2017��04��27��
%---------------------------------------------------------------------------------%
clc;clear all;close all;
%% 1. ����ϡ����ź�
N=1024;
K=50;
x=zeros(N,1);
rand('state',8)
q=randperm(N); %�������1��N������
randn('state',10)
x(q(1:K))=randn(K,1); %��K�����������ŵ�x��
t=0:N-1;
%% 2. �����֪����
M=2*ceil(K*log(N/K));
Phi=randn(M,N);  %��˹������Ϊ��֪����
Phi=orth(Phi')';  %������
% Phi=(sqrt(N))*eye(M)*Phi;
Psi=(sqrt(N))*eye(N,N);  %����Psi���죬ʹ���ź�xϡ�裬����x��������ϡ��ģ�����������ǵ�λ��������

%% 3. �����ź�
y=Phi*x;
%% 4. �ع��ź� l1��С��   Using  l1-MAGIC
% A=Phi;   %�ָ�����,ϡ�軯����Ϊ��λ������Ϊ�źű�������ϡ��ģ�����Ҫ���κ�ϡ��任
A=Phi*Psi';
x0=A'*y;  %��С���˽����һ����ʼֵ
xh1=l1eq_pd(x0,A,[],y,1e-3);

%% 5. �ع��ź�l1��С��   Using l1_ls
lambda  = 0.01; % ���򻯲���
rel_tol = 1e-3; % Ŀ����Զ�ż��϶
quiet=1;   %������м���
[xh2,status]=l1_ls(A,y,lambda,rel_tol,quiet);

%% 6.�ָ��źź�ԭʼ�źűȽ�
figure
plot(t,Psi*xh1,'ko',t,x,'r.')
xlim([0,t(end)])
legend('l1-MAGIC�ָ��ź�','ԭʼ�ź�')

figure
plot(t,Psi*xh2,'ko',t,x,'r.')
xlim([0,t(end)])
legend('l1-ls�ָ��ź�','ԭʼ�ź�')