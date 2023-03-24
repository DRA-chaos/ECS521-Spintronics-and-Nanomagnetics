import numpy as np
import matplotlib.pyplot as plt

# Define parameters
Hk = 1.0
Hz = 2.0*Hk
alpha1 = 0.01  # damping parameter
alpha2 = 0.1
theta_initial = np.pi  # initial angle in radians (approximately 180 degrees)
t_final = 100.0
N = 100  # number of grid points in space
dx = 1.0/N  # grid spacing in space
dt = 0.01  # time step

# Initialize magnetization vector
theta = np.zeros(N) + theta_initial

# Define finite difference coefficients for second derivative
A = np.eye(N, k=1) - 2*np.eye(N) + np.eye(N, k=-1)
A /= dx*dx

# Define time evolution matrix
def evolve(theta, alpha):
    M = np.eye(N) - alpha*A
    H = Hz*np.cos(theta) - Hk*np.sin(2*theta)
    theta_new = np.linalg.solve(M, theta + dt*H)
    return theta_new

# Time evolution loop
t = 0.0
switch_time1 = None
switch_time2 = None
E1 = []
E2 = []
while t < t_final:
    # Evolve magnetization with damping alpha1
    theta = evolve(theta, alpha1)
    t += dt
    # Compute energy dissipation
    E1.append(alpha1*np.sum(np.square(A@(theta-np.zeros(N)+theta_initial))))
    # Check for switching
    if switch_time1 is None and np.max(theta) >= np.pi/2:
        switch_time1 = t
    # Evolve magnetization with damping alpha2
    theta = evolve(theta, alpha2)
    t += dt
    # Compute energy dissipation
    E2.append(alpha2*np.sum(np.square(A@(theta-np.zeros(N)+theta_initial))))
    # Check for switching
    if switch_time2 is None and np.max(theta) >= np.pi/2:
        switch_time2 = t

# Plot results
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8, 8))
ax1.plot(np.arange(N)*dx, theta/np.pi)
ax1.set_xlabel('x')
ax1.set_ylabel(r'$\theta/\pi$')
ax2.plot(np.arange(len(E1))*dt, E1, label=r'$\alpha=0.01$')
ax2.plot(np.arange(len(E2))*dt, E2, label=r'$\alpha=0.1$')
ax2.set_xlabel('t')
ax2.set_ylabel('Energy dissipation')
ax2.legend()
plt.show()

# Print switching delay and energy dissipation
print('Switching delay for alpha=0.01:', switch_time1)
print('Switching delay for alpha=0.1:', switch_time2)
print('Energy dissipation for alpha=0.01:', E1[-1])
print('Energy dissipation for alpha=0.1:', E2[-1])
