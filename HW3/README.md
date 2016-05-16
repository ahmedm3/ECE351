#ECE351

##HW3 - ALU Design Implementation

#####Requirements:
- Verilog Simulator (can be ModelSim, iverilog, etc..)
- Python3.4 if you want to re-run the vector generator
- gcc if you want to re-run the vector generator for the logical operations
- if you're using a mac and iverilog, you need vvp, as well as gtkwave if you want to look at waveforms

#####How to run it (ModelSIm):
- Please just run it however you want

#####How to run it (Macbook):
- Open up your terminal and cd to the project directory
- run the Makefile by typing make
- run the command: vvp a.out to look at the console
- run the command: gtkwave waveForm.vcd to look at the waveform

#####How to run the test vector generator:
- cd to the project directory
- For the python generator, run python3 generate_data.py --help 
- For the C generator for logical operations, run: gcc logical_op.c, then ./a.out
