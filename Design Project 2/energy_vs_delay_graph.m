% -------------------------------------------------------------------------
% 32-bit Carry Select Adder: Minimum Energy Point (MEP) Analysis
% -------------------------------------------------------------------------

% 1. Load the Exact Final Data (Skipping 0.1V since it fails)
vdd = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

% Final Delay Data from SKILL output (seconds)
delay_s = [6.8540e-08, 9.8420e-09, 2.4210e-09, 1.0800e-09, 6.8150e-10, ...
           5.0590e-10, 4.1210e-10, 3.5750e-10, 3.2380e-10];
       
% Final Energy Data from SKILL output (Joules)
energy_J = [4.8508e-14, 2.4628e-14, 1.1164e-14, 8.1141e-15, 7.8732e-15, ...
            8.6471e-15, 1.0173e-14, 1.2562e-14, 1.6094e-14];

% 2. Scale Data for Clean Axes
delay_ns = delay_s * 1e9;     % Convert seconds to nanoseconds
energy_fJ = energy_J * 1e15;  % Convert Joules to femtojoules

% 3. Create Figure
figure('Name', 'Final MEP Analysis', 'Color', 'w', 'Position', [100, 100, 800, 500]);

% 4. Left Y-Axis: Energy (Linear Scale)
yyaxis left
plot(vdd, energy_fJ, '-o', 'LineWidth', 2.5, 'MarkerSize', 8, 'MarkerFaceColor', '#0072BD');
ylabel('Total Energy per Operation (fJ)', 'FontWeight', 'bold', 'FontSize', 12);
ax = gca;
ax.YColor = '#0072BD'; 
ylim([0, 55]); % Locked to fit the 48.5 fJ peak at 0.2V cleanly

% Highlight the Minimum Energy Point
[min_energy, min_idx] = min(energy_fJ);
hold on;
plot(vdd(min_idx), min_energy, 'p', 'MarkerSize', 16, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'y');
text(vdd(min_idx) + 0.02, min_energy + 2, ...
    sprintf('MEP: %.2f fJ @ %.1f V', min_energy, vdd(min_idx)), ...
    'FontSize', 11, 'FontWeight', 'bold', 'BackgroundColor', 'w', 'EdgeColor', 'k');

% 5. Right Y-Axis: Delay (Logarithmic Scale)
yyaxis right
semilogy(vdd, delay_ns, '-s', 'LineWidth', 2.5, 'MarkerSize', 8, 'MarkerFaceColor', '#D95319');
ylabel('Critical Path Delay (ns) [Log Scale]', 'FontWeight', 'bold', 'FontSize', 12);
ax = gca;
ax.YColor = '#D95319'; 

% 6. General Formatting
title('Minimum Energy Point (MEP) vs. Supply Voltage', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Supply Voltage V_{DD} (V)', 'FontWeight', 'bold', 'FontSize', 12);
xlim([0.15 1.05]);
grid on;
ax.GridAlpha = 0.3;

% 7. Legend
legend('Total Energy', 'Minimum Energy Point', 'Critical Delay', 'Location', 'north', 'FontSize', 11);