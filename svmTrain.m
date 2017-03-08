function svm = svmTrain(X,Y,kertype,C)

n=50;
x1 = randn(2,n);
x2 = 5+randn(2,n);
y1 = ones(1,n);
y2 = -ones(1,n); 
X = [x1,x2];        
Y = [y1,y2];
C = 10;  

kertype = 'linear';

options = optimset;    % Options�����������㷨��ѡ�����������
options.LargeScale = 'off'; %largescaleָ���ģ������off��ʾ�ڹ�ģ����ģʽ�ر�
options.Display = 'off';  %����������ζ��û�����

n = length(Y);  %����Y�ĳ���
H = (Y'*Y).*kernel(X,X,kertype);
f = -ones(n,1); %fΪ1*n��-1,f�൱��Quadprog�����е�c
A = [];
b = [];
Aeq = Y; %�൱��Quadprog�����е�A1,b1
beq = 0;
lb = zeros(n,1); %�൱��Quadprog�����е�LB��UB
ub = C*ones(n,1);
a0 = zeros(n,1);  % a0�ǽ�ĳ�ʼ����ֵ
[a,fval,eXitflag,output,lambda]  = quadprog(H,f,A,b,Aeq,beq,lb,ub,a0,options);

epsilon = 1e-8;                     
sv_label = find(abs(a)>epsilon);  %0<a<a(max)����ΪxΪ֧������     
svm.a = a(sv_label);
svm.Xsv = X(:,sv_label);
svm.Ysv = Y(sv_label);
svm.svnum = length(sv_label);



%svm.label = sv_label;
