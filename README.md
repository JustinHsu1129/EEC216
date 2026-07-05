# EEC216 Design Project 2

**Author:** Justin Hsu  
**Date:** 3/10/26

---

## Overview
This repository contains the design and verification of a 32‑bit square‑root carry‑select adder implemented in Virtuoso. The adder is optimized for low power and high speed, employing hierarchical carry‑select cells (2‑bit, 3‑bit, up to 32‑bit) and carefully managed wire routing to mitigate parasitic effects.

---

## Summary of Simulated Results

| Parameter                | Simulated Result |
|--------------------------|-----------------:|
| Optimal Vdd              | 0.32 V |
| Critical path delay      | 7.4347 e‑09 s |
| Min leakage power        | 3.083720 e‑07 W |
| Max leakage power        | 8.064468 e‑07 W |
| Avg total power          | 2.902443 e‑06 W |
| Avg PDP (Power‑Delay)    | 2.902443 e‑14 J |
| Avg EDP (Energy‑Delay)   | 2.902443 e‑22 J·s |

---

## Critical Path
The worst‑case scenario occurs with inputs **A = 0xFFFFFFFF**, **B = 0x00000000**, and **Cin = 1**. In this state the adder propagates a carry through all 32 bits, making the path length maximal. The measured delay for this path is **7.4347 ns**.

---

## Wires + Parasitics
A long interconnect carries the propagate signal across the full 32‑bit slice chain. The resistance (R) and capacitance (C) of this wire increase with length, leading to higher RC delay and additional power consumption. The long wire also introduces capacitive coupling between adjacent routes, further degrading timing.

---

## Leakage Power
- **Minimum leakage:** 3.083720 e‑07 W (A = 0x00000000, B = 0x00000000, Cin = 0) – most NMOS devices are off, benefiting from stacked‑transistor reduction.
- **Maximum leakage:** 8.064468 e‑07 W (A = 0xFFFFFFFF, B = 0x00000000, Cin = 1) – only the final NMOS in the stack is off, so stacked‑transistor benefits vanish.

---

## Power, PDP, and EDP
The average power was estimated using 100 random input vectors, yielding:
- **Average total power:** 2.902443 e‑06 W
- **Average PDP:** 2.902443 e‑14 J
- **Average EDP:** 2.902443 e‑22 J·s

---

## Verification
All **43** functional tests passed at the operating point **Vdd = 0.32 V**:
```
========================================
 Starting 32-bit Adder Verification
========================================
--- Evaluating VDD = 0.32 V (VOH >= 0.288 V, VOL <= 0.032 V) ---
[PASS] 43/43 tests passed
>>> RESULT: VDD = 0.32 V is a VALID operating point <<<
```
The testbench covers edge cases, random vectors, and a full sweep of carry‑propagation scenarios.

---

## References
- C. Kamble, R. K. Siddharth, S. Patidar, M. H. Vasantha, K. Y. B. Nithin, *Design of Area‑Power‑Delay Efficient Square Root Carry Select Adder*, 2018 IEEE International Symposium on Smart Electronic Systems (iSES).
- “Design of 32 Bit Low Power and High Speed Square Root Carry Select Adder,” Ijrras.com, 2022. https://ijrras.com/design-of-32-bit-low-power-and-high-speed-square-root-carry-select-adder/
- Y. Ykuntam, M. Rao, G. Locharla, *Design of 32-bit Carry Select Adder with Reduced Area*, Int. J. Comput. Applications, vol. 75, no. 2, 2013. https://research.ijcaonline.org/volume75/number2/pxc3890353.pdf

---

*This README was automatically generated from the project report and simulation results.*
