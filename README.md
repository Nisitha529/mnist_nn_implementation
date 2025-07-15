# MNIST Digit Recognition Neural Network in Verilog

Hardware implementation of a fixed-point, fully-connected neural network to classify handwritten digits (0–9) from the MNIST dataset. Written entirely in Verilog.

---

## Table of Contents

- [Motivation](#motivation)  
- [Features](#features)  
- [Modules Overview](#modules-overview)  
- [Top-Level Interface](#top-level-interface)  

---

## Motivation

This project demonstrates how to implement neural network inference in pure hardware using Verilog. It is aimed at hobbyists, students, and FPGA/ASIC designers interested in realizing neural classification on embedded platforms — showcasing fixed-point arithmetic, pipelined design, and state-machine-based control.

---

## Features

- **4-layer network architecture**:  
  - Layer sizes: 784→30→30→10→10
- **Serial data processing**: one pixel per clock cycle
- **Fixed-point arithmetic**: 16-bit width with configurable integer portion (`WEIGHTINTWIDTH`)
- **ReLU activation**: applied in all layers
- **Weight initialization**: via `.mif` files per neuron
- **Max-finder**: hardware module to determine the predicted digit

---

## Modules Overview

### `top_mnist.v`
- Coordinates data flow and layer execution via a state machine
- Handles serial input of 784 pixels, propagates through all layers, and outputs final prediction

### `layer_X.v`
- Parametrized modules for each layer (number of inputs/neuron count)
- Reads weights, applies bias, activates via ReLU, and outputs serialized data

### `neuron.v`
- Core computation: MAC (multiply–accumulate), bias addition, saturation, and activation

### `relu.v`
- Applies `y = max(0, x)`

### `sig_rom.v`
- Sigmoid activation via read-only memory *(currently inactive)*

### `weight_memory.v`
- Manages `.mif` files providing neuron-specific weights

### `maxfinder.v`
- Scans 10 final output values and selects the index of the highest

---
## Top-Level Interface

```verilog
top_mnist #(
  .DATAWIDTH(16),
  .WEIGHTINTWIDTH(4)
) dut (
  .clk           (clk),          // system clock
  .rst           (rst),          // active-high reset
  .input_valid   (pixel_valid),  // asserted per input pixel
  .input_val     (pixel_data),   // 16-bit pixel sample
  .out           (digit_out),    // predicted digit (4-bit)
  .out_valid     (result_valid)  // indicates valid output
);
