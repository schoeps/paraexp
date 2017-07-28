% load inductor matrices and other information
load('data/inductor_matrices.mat');
%%%     Mepsi .......... M_eps^-1 matrix 
%%%     Mmui ........... M_nu matrix
%%%     C .............. curl matrix
%%%     nx ............. number of nodes in x direction
%%%     ny ............. number of nodes in y direction
%%%     nz ............. number of nodes in z direction
%%%     np ............. number of nodes
%%%     x .............. x valuse of nodes
%%%     y .............. y values of nodes
%%%     z .............. z values of nodes
%%%     signal ......... function handle containing excitation signal
%%%     j_space ........ j vector, containing 1 at index of excitation

% assemble system matrix A
A = [sparse(3*np,3*np),    -Mmui*C; ...
     Mepsi*C',            sparse(3*np,3*np)];
% assemble right-hand side g(t)
g = @(t) [sparse(3*np,1);...
          -Mepsi*j_space*signal(t)];
% set initial condition u0=[h0; e0]
u0 = sparse(6*np,1);
% set relevant time interval [t0, t_end]
T = [0, 2e-11];
% function f(t,u) = u' = Au + g
f = @(t,u) A*u + g(t);

% materials
mu0 = 4*pi*1e-7; % [H/m] : permeability of vacuum
eps0 = 8.8541878176e-12; % [F/m] : permittivity of vacuum

% Leapfrog parameters
dt     = sqrt(mu0*eps0)/sqrt((1/min(diff(x)))^2+(1/min(diff(y)))^2+(1/min(diff(z)))^2) 
t      = T(1):dt:T(end);

% fields
h_new   = zeros(3*np,1); 
e_new   = zeros(3*np,1); 
h_old   = zeros(3*np,1); 
e_old   = zeros(3*np,1); 

% outputs
n = 100;
t_out = zeros(1,ceil(length(t)/n));
h = zeros(3*np,length(t_out)); 
e = zeros(3*np,length(t_out));

% output voltage
v = zeros(1,length(t));

% time loop
for i=1:length(t)
    t_lf = t(i);
    % right hand side
    js = j_space*signal(t_lf-dt/2);
    % compute new electrical voltage
    e_new = e_old+dt*(Mepsi*(C'*h_old-js));
    % compute new magnetic voltage
    h_new = h_old-dt*(Mmui*(C*e_new));
    % save fields
    if mod(i-1,n)==0
        fprintf('Store step %d/%d at time: %e s\n',i,length(t),t_lf);
        k=(i-1)/n+1;
        e(:,k) = e_new;
        h(:,k) = h_new;
        t_out(k)= t_lf;
    end %if
    % save output voltage
    v(i) = e_new(find(j_space));
    % next
    h_old = h_new;
    e_old = e_new;
end %while

% plot output voltage
figure;
plot(t,signal(t),t,-v);
legend('Current','Voltage');
xlim([0 2e-11]);
ylabel('current (I) and voltage (V)');
xlabel('time (s)');
grid on
