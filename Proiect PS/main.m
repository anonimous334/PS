
clc
clear

M=32; % numărul de antene de recepție
K=8; % număr de utilizatori
N=32; % numărul de elemente IRS

T0=K; % numărul minim de simboluri pilot în prima etapă
T1=N; % numărul minim de simboluri pilot în a doua etapă

if M>=N
    T2=K-1; % numărul minim de simboluri pilot în a treia etapă
else
    T2=ceil(N*(K-1)/M); % numărul minim de simboluri pilot în a treia etapă
end

T=T0+T1+T2;

%% parametrii canalului

d0=0.01;
d_bs=d0*100^(-2.2); % pierderea căii între IRS și BS
d_ue=d0*(10*rand(K,1)+5).^(-2.1); % pierderea căii între IRS și utilizatori
d_drl=d0*(10*rand(K,1)+100).^(-4.2); % pierderea canalelor directe

c_irs=0.3+0.4*1j; % channel correlation
c_bs=0.5+0.3*1j;  % channel correlation

C_irs=C_gen(N,c_irs); 
C_bs=C_gen(M,c_bs);
SNR=10000; % i.e., no noise.


%% ===============Phase I===========================

F0_temp=dftmtx(T0);
A0=F0_temp(1:K,:); % pilot matrix

H_drl_mtx=[];

for i_h=1:K
   H_drl_temp=sqrtm(C_bs)*1/sqrt(2)*(randn(M,1)+1j*randn(M,1))*sqrt(d_drl(i_h));
   H_drl_mtx=[H_drl_mtx H_drl_temp];
end

Y0=H_drl_mtx*A0;
H_drl_mtx_es=Y0*A0'/T0;

%% =========Phase II============================== 

P1_bit=1;
F1=dftmtx(T1);
Phi1=F1(1:N,:); %phi în faza II; matrice DFT nenormalizată. Etapa MMSE: T=N
a1=diag(ones(T1,1))*sqrt(P1_bit); % pilot; a=diag(1,1,...,1)*sqrt(P1/N)

H_bs_hat=1/sqrt(2)*(randn(M,N)+1j*randn(M,N));
H_bs=sqrt(d_bs)*sqrtm(C_bs)*H_bs_hat*sqrtm(C_irs);

H_ue1_hat=1/sqrt(2)*(randn(N,1)+1j*randn(N,1));
H_ue1=sqrt(d_ue(1))*sqrtm(C_irs)*H_ue1_hat;

H1_mtx=H_bs*diag(H_ue1);
a1_drl=ones(1,T1);

Y1=H1_mtx*Phi1*a1+H_drl_mtx(:,1)*a1_drl; 
Y1=Y1-H_drl_mtx_es(:,1)*a1_drl;
H1_mtx_es=Y1*Phi1'/T1;

%% ========Phase III====================================

coeff=zeros(N,K); %notă: coeficientul 1' utilizator este setat la zero. 

for k=2:K

 % generând canale de la utilizatorul 2 la K.
 
 H_uek_hat=1/sqrt(2)*(randn(N,1)+1j*randn(N,1));
 H_uek=sqrt(d_ue(k))*sqrtm(C_irs)*H_uek_hat;
 
 coeff(:,k)=H_uek./H_ue1;

end

% channel estimation

if M>=N
  coeff_es=coeffes2_MgeN(H1_mtx_es,K,coeff,H1_mtx,H_drl_mtx_es,H_drl_mtx); % channel estimation algorithm for M>=N
else
  coeff_es=coeffes2_MlN(M,H1_mtx_es,N,K,coeff,H1_mtx,H_drl_mtx_es,H_drl_mtx); % channel estimation algorithm for M<N
end

%% recuperați toate canalele reale și calcularea MSE normalizate

coeff_es(:,1)=[];
coeff(:,1)=[];

coeff_es=reshape(coeff_es,(K-1)*N,1);
coeff=reshape(coeff,(K-1)*N,1);

H_drl_es=reshape(H_drl_mtx_es,M*K,1);
H_drl=reshape(H_drl_mtx,M*K,1);

H1_es=reshape(H1_mtx_es,M*N,1);
H1=reshape(H1_mtx,M*N,1);

H_es=[H_drl_es;H1_es];
H_real=[H_drl;H1];

for iii=1:K-1

  H_es_temp=H1_mtx_es*diag(coeff_es((iii-1)*N+1:iii*N));
  H_real_temp=H1_mtx*diag(coeff((iii-1)*N+1:iii*N));

  H_es_temp2=reshape(H_es_temp,N*M,1);
  H_real_temp2=reshape(H_real_temp,N*M,1);

  H_es=[H_es;H_es_temp2];
  H_real=[H_real;H_real_temp2];       
end

p_s=H_real'*H_real; % aproximarea puterii totale a canalului
MSE=(H_es-H_real)'*(H_es-H_real)/p_s; 

fprintf('Normalized Mean Square Error: ');

disp(MSE);

if MSE<10^(-10)
   fprintf('Perfect Channel Estimation');
end