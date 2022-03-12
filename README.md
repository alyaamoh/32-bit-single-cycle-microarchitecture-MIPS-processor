# 32-bit-single-cycle-microarchitecture-MIPS-processor
# Introduction
In this project, we are aim to implement a 32-bit single cycle MIPS RISK processor based on Harvard architecture using Verilog HDL.
The simulation was performed on Modelsim and The synthesis was done on Intel® Quartus Prime and implemented on Cyclone® IV FPGA. 
![toppppp](https://user-images.githubusercontent.com/82395215/158023322-60b62b56-b36a-4573-9877-5086d3f1e901.JPG)

# The main blocks
## Top Module
 The implementation consist of 4 main blocks:
1. Data Path.
2. Control Unit.
3. Instruction Memory.
4. Data Memory.

![datapath_fig](https://user-images.githubusercontent.com/82395215/158023522-92c61fa8-8293-4a64-b191-33d599484263.JPG)
![MIPS RTL](https://user-images.githubusercontent.com/82395215/158023533-fed688e5-1ce1-405c-ba7d-e251961d547c.JPG)
### Data Path
![datapath](https://user-images.githubusercontent.com/82395215/158023696-1472c87a-5034-4386-b691-30ab84941332.JPG)
### Control Unit
![control unit](https://user-images.githubusercontent.com/82395215/158023721-a9c84fe9-f955-4ec3-a9aa-2361b0551909.JPG)
# Simulation tests results
## Program 1:
GCD of 120 and 180.
![program1](https://user-images.githubusercontent.com/82395215/158023850-57eaf0ec-9960-4783-baab-f18499eed999.JPG)
## Program 2:
Factorial Number of 7.
![program2](https://user-images.githubusercontent.com/82395215/158023866-c786d877-5a4d-4783-97fd-d1f40f90be38.JPG)
## Program 3:
The Fibonacci series numbers.
![program3](https://user-images.githubusercontent.com/82395215/158023918-1aa8559e-6fd3-486e-a0aa-0ae5595bbcf0.JPG)
# References
David M. Harris, Sarah L. Harris - Digital Design and Computer Architecture
