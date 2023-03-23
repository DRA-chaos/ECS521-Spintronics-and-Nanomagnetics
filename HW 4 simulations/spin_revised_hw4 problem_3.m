close all
clear all

m = 2;
theta_star = 179*pi/180;
theta_end = pi/180;
n = 5000000;
%n=10000;
theta = linspace(theta_star, theta_end, n);
gamma = 1.7e11;
alpha = 0.1;
H_k = 0.04;
h = m*H_k;
arr_phi = zeros(n,1);
arr_theta = zeros(n,1);
arr_theta(1) = theta_star;
arr_phi(1) = pi/2;
ii = 2;

dt = 1e-13;

while true
    arr_phi(ii) = (gamma*H_k/(1 + alpha*alpha))*(cos(arr_theta(ii-1)) + m)*dt + arr_phi(ii-1);
   
    %arr_phi(ii) = gamma*(H_k*cos(arr_theta(ii-1)) + h)*dt/(1 + alpha*alpha) ;
    arr_theta(ii) = -alpha*sin(arr_theta(ii-1))*(arr_phi(ii)-arr_phi(ii-1)) + arr_theta(ii-1);
    %arr_theta(ii) = mod(arr_theta(ii), 2*pi); % wrap theta into [0, 2*pi]

    if arr_phi(ii)>2*pi
        arr_phi(ii) = arr_phi(ii)- 2*pi;
    end
    if arr_phi(ii)<0
        arr_phi(ii) = arr_phi(ii) + 2*pi;
    end
    
    %if arr_theta(ii) < theta_end 
    if arr_theta(ii) < theta_end || ii > n
        break
    end
    %plot (arr_theta(ii))
    ii = ii+1;
    disp(ii)
end

figure
plot(arr_theta(1:ii))

figure
plot(arr_phi(1:ii))

mx = sin(arr_theta(1:ii)).*cos(arr_phi(1:ii));
my = sin(arr_theta(1:ii)).*sin(arr_phi(1:ii));
mz = cos(arr_theta(1:ii));

figure
plot3(mx, my, mz)
xlabel('mx')
ylabel('my')
zlabel('mz')