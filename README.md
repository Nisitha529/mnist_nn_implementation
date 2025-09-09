# MNIST Digit Recognition Neural Network in Verilog
---
This project implements a complete neural network accelerator on FPGA for MNIST handwritten digit recognition. The system features a multi-layer architecture with configurable parameters and AXI-Lite interface for communication with processors. The design efficiently processes 28x28 pixel images through four neural network layers to classify digits 0-9 with optimized resource utilization.

## Project Overview
This project implements a complete neural network accelerator on Zybo FPGA designed for MNIST handwritten digit recognition. The system features a multi-layer perceptron architecture with optimized hardware implementation using fixed-point arithmetic and efficient resource utilization. The design processes 28×28 pixel images through four neural network layers to classify digits 0-9 with high accuracy while maintaining low latency and power consumption suitable for edge deployment.

## Module Descriptions
### Neuron module
The neuron module serves as the fundamental computation unit within the neural network architecture. It implements a complete artificial neuron with configurable parameters for input size, data width, and weight precision. The module performs multiply-accumulate operations using a weight memory block and includes a saturation logic to prevent arithmetic overflow in fixed-point computations. Key features include pipelined processing for high throughput, ReLU activation function implementation, and proper handling of validation signals for coordinated data flow through the network layers.

### Weight Memory Module
This module provides efficient storage for neural network weights using block RAM initialized from Memory Initialization Files (MIF). The design supports parameterized memory depth and data width, allowing flexible configuration for different network architectures. The read-enable interface ensures weight values are available precisely when needed during the computation cycle, optimizing memory bandwidth and power consumption.

### ReLu Activation Module
The Rectified Linear Unit (ReLU) activation module implements the popular activation function with proper saturation handling for fixed-point arithmetic. The design processes 32-bit inputs and produces 16-bit outputs, efficiently converting the accumulated sum from the neuron computation into activated outputs while preventing numerical overflow through careful saturation logic.

### sig_rom (Sigmoid activation)
Provides sigmoid activation through a precomputed lookup table stored in ROM. Converts input values to addresses and outputs the corresponding sigmoid value from the memory initialization file.

### MaxFinder module
This component identifies the neuron with the highest output value in the final layer, corresponding to the predicted digit classification. The module processes all output layer results simultaneously and returns the index of the maximum value along with a validation signal, enabling efficient decision-making without requiring external processing.

### Layer Modules (1-4)
These modules instantiate complete neural network layers with parameterized configurations. Each layer contains multiple neuron instances with specific weight files and bias values optimized for the MNIST classification task. The layers are designed with appropriate input sizes: Layer 1 processes the 784 input features with its 30 neurons, Layers 2-3 serve as hidden layers with 30, and 10 neurons, and Layer 4 produces the final 10 output classifications.

### Top-Level Module
The top-level module integrates all neural network components and implements an AXI-Lite interface for communication with external processors (Zynq PS). It manages the complete data flow through the network layers, coordinates the pipelined processing of input values, and generates interrupts when classification results are ready. The design includes parameterized layer configurations and handles proper reset synchronization across all components.

## Results Files

### Fully Connected Neural Network Model
<img width="561" height="763" alt="model_architecture" src="https://github.com/user-attachments/assets/216d8c34-4849-45dc-a859-92b8367b5e9a" />

### Final Block Design Implementation
<img width="1817" height="756" alt="bd_snapshot" src="https://github.com/user-attachments/assets/c182aca4-bed5-49a7-8d67-52d554c89e14" />

### Final accuracy after simulation
<img width="552" height="202" alt="Accuracy" src="https://github.com/user-attachments/assets/c19407d5-9c22-43de-93d3-d9f022041652" />
