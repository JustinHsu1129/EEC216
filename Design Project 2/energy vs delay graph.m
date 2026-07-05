% -------------------------------------------------------------------------
% 32-bit Carry Select Adder: Minimum Energy Point (MEP) Analysis
% -------------------------------------------------------------------------

% 1. Load the Data
vdd = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

% Raw data from Cadence
delay_s = [5.6850e-08, 8.5800e-09, 2.1900e-09, 1.0150e-09, 6.5180e-10, ...
           4.8810e-10, 3.9960e-10, 3.4770e-10, 3.1550e-10];
       
energy_J = [4.7998e-14, 2.0657e-14, 9.6573e-15, 7.4263e-15, 7.3943e-15, ...
            8.2315e-15, 9.7710e-15, 1.2142e-14, 1.5631e-14];

% 2. Scale Data for Clean Axes
delay_ns = delay_s * 1e9;     % Convert seconds to nanoseconds
energy_fJ = energy_J * 1e15;  % Convert Joules to femtojoules

% 3. Create Figure
figure('Name', 'MEP Analysis', 'Color', 'w', 'Position', [100, 100, 800, 500]);

% 4. Left Y-Axis: Energy (Linear Scale)
yyaxis left
plot(vdd, energy_fJ, '-o', 'LineWidth', 2.5, 'MarkerSize', 8, 'MarkerFaceColor', '#0072BD');
ylabel('Total Energy per Operation (fJ)', 'FontWeight', 'bold', 'FontSize', 12);
ax = gca;
ax.YColor = '#0072BD'; % Match axis color to line color
ylim([0, 50]);         % Lock axis so the U-shape is distinct

% Highlight the Minimum Energy Point
[min_energy, min_idx] = min(energy_fJ);
hold on;
plot(vdd(min_idx), min_energy, 'p', 'MarkerSize', 16, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'y');
text(vdd(min_idx) + 0.02, min_energy + 2, ...
    sprintf('MEP: %.2f fJ @ %.1f V', min_energy, vdd(min_idx)), ...
    'FontSize', 11, 'FontWeight', 'bold', 'BackgroundColor', 'w', 'EdgeColor', 'k');

% 5. Right Y-Axis: Delay (Logarithmic Scale)
% Used a log scale here because the delay jumps massively from 0.3ns to 56ns!
yyaxis right
semilogy(vdd, delay_ns, '-s', 'LineWidth', 2.5, 'MarkerSize', 8, 'MarkerFaceColor', '#D95319');
ylabel('Critical Path Delay (ns) [Log Scale]', 'FontWeight', 'bold', 'FontSize', 12);
ax = gca;
ax.YColor = '#D95319'; % Match axis color to line color

% 6. General Formatting
title('Minimum Energy Point (MEP) vs. Supply Voltage', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Supply Voltage V_{DD} (V)', 'FontWeight', 'bold', 'FontSize', 12);
xlim([0.15 1.05]);
grid on;
ax.GridAlpha = 0.3;

% 7. Legend
legend('Total Energy', 'Minimum Energy Point', 'Critical Delay', 'Location', 'north', 'FontSize', 11);