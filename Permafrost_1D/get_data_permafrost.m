%
% input data for 1-d finite element program


format compact
format short e
g = 9.812;

% initial number of nodes and elements
nelem = 75;
nnode = 76;
% approximate maximum number of nodes
maxnodes = 76;


ntime = 100000;%100000;%120000;%24000
iprint = 100;
time = 00000;
delt = 1;%1;%5
delt0 = 0.0; % unit in years
delt1 = 69000;%60000%10000;% unit in years
delt2 = 70000;%80000%92000;% unit in years
delt3 = 80000;%102000;% unit in years

nu_i=zeros(ntime,2810);
xx_ice=zeros(ntime,2810);




% subsidence rate (m/yr)


% fluid density (kg/m3)
rho_f = 1000;
% solid density density (kg/m3)
rho_s = 2300;
% ice density
rho_ice = 900;
% grid spacing (m)
delz = 10;
ic = 76;
z(nnode) = 750.0;
tp(nnode) = 0.0;
% elevations fixed in z_inpu
z_ls = 750;
z_input;
for i = 1:nnode
    tp(ic) = -4 + (z(i))*0.031088083;
    ic = ic -1;
end
% for n=1:nnode-1
%     
%     z(ic-1) = z(ic) - delz;
%     tp(ic) = (1000-z(ic-1))*0.03;
%     ic = ic-1;
%     if (z(ic) < 900) 
%     delz = delz*1.02;
%     end
%     if(delz > 3) 
%         delz = 3;
%     end
% end

    
% node-wise data:
%tp = 1.0*ones(1,nnode);
t_init = tp;
% cin_class.m input data and dimensioning matrices

% element-wise data
% connectivity information
for m=1:nnode
i(m) = m;
j(m) = m+1;
end


% specified flux
% nqbc - number of spec. flux b.c.'s
% nq - node number for spec. fluid flux
% qb - value of spec. fluid flux

nqbc = 1;
nq = [1];
qb = [0];

% boundary conditions
% heat flow
% ntbc - number spec. temp b.c's
% nt - node number for speficied temp
% tb - value of spec. temp b.c.

ntbc = 1;
nt = [76];
tb = [-7];
% specified flux
% njbc - number of spec. flux b.c.'s
% nj - node number for heat spec. flux
% jb - value of spec. head flux

njbc = 1;
nj = [1];
jb = [0.06];


% dimensioning matrices for the program
% local capacitance and stiffness matrices
pp = zeros(2,2);
aa = zeros(2,2);
bb  = zeros(2,1);
% global stiffness matrix
a = zeros(nnode,nnode);
% load vector
b = zeros(nnode,1);
iprint = 10;

% initialze output variables
index = zeros(ntime/iprint,maxnodes);
%elevation = zeros(ntime/iprint,maxnodes);
%temp = zeros(ntime/iprint,maxnodes);




xls(1) = 0;
delx = 1000;
icenode = 2810;
Ho = 4000.0; % max ice sheet thickness, unit in m
Lo = 1300000; % ice sheet length, unit in m


for n=2:icenode
    xls(n) = xls(n-1)+delx;
end
