m = 2;
theta_star = 179*pi/180;
theta_end = pi/180;
n = 5000;
theta = linspace(theta_star, theta_end, n);
gamma = 1.7e11;
alpha = 0.01;
H_k = 0.04;
h = m*H_k;
arr_phi = zeros(n,1);
arr_theta = zeros(n,1);
arr_theta(1) = theta_star;
arr_phi(1) = 0;
ii = 2;

dt = 1e-12;
time = 0;
ext_mag_work = 0;
theta_switch = 0;

while true
    arr_phi(ii) = gamma*(H_k*cos(arr_theta(ii-1)) + h)*dt/(1 + alpha*alpha) + arr_phi(ii-1);
    arr_theta(ii) = alpha*sin(arr_theta(ii-1))*arr_phi(ii-1)*dt + arr_theta(ii-1);
    arr_theta(ii) = mod(arr_theta(ii), 2*pi); % wrap theta into [0, 2*pi]
    
    % Determine the energy dissipation and switching time
    if arr_theta(ii) < theta_end || ii > n
        theta_switch = arr_theta(ii);
        break
    else
        if ii > 2
            ext_mag_work = ext_mag_work - gamma*H_k*cos(arr_theta(ii-1))*(arr_phi(ii-1)-arr_phi(ii-2));
        end
        time = time + dt;
    end
    
    ii = ii+1;
end



% Display the results
fprintf('Switching time: %e s\n', time);
fprintf('Energy dissipation: %e J\n', ext_mag_work);

