import os

# Global Configuration
DATAWIDTH       = 16
SIGMOIDWIDTH    = 5
WEIGHTINTWIDTH  = 4
NUM_LAYERS      = 4
BIAS_DIR        = "/media/nisitha/My_Passport/MOODLE/Vivado_projects/neuralNetwork-master/neuralNetwork-master/Tut-5/src/fpga/rtl"
OUTPUT_PREFIX   = "layer_"

# Layer Configuration (define-style)
LAYER_CONFIG = {
    1: {"neurons": 30, "weights": 784, "act": "relu"},
    2: {"neurons": 30, "weights": 30,  "act": "relu"},
    3: {"neurons": 10, "weights": 30,  "act": "relu"},
    4: {"neurons": 10, "weights": 10,  "act": "relu"}
}

def read_bias_value(bias_file):
    with open(bias_file, 'r') as f:
        value = f.readline().strip()
        return f"16'b{value.zfill(16)}"

def generate_layer(layer_num, num_neurons, num_weights, act_type):
    filename = f"{OUTPUT_PREFIX}{layer_num}.v"
    with open(filename, 'w') as f:
        f.write("`timescale 1ns / 1ps\n\n")
        f.write(f"module layer_{layer_num} #(\n")
        f.write(f"  parameter NUM_INPUTS      = {num_neurons},\n")
        f.write(f"  parameter DATAWIDTH       = {DATAWIDTH},\n")
        f.write(f"  parameter WEIGHTINTWIDTH  = {WEIGHTINTWIDTH}\n")
        f.write(f")(\n")
        f.write(f"  input                        clk,\n")
        f.write(f"  input                        rst,\n")
        f.write(f"  input                        input_valid,\n")
        f.write(f"  input  [DATAWIDTH-1:0]       input_val,\n")
        f.write(f"  output [DATAWIDTH*{num_neurons}-1:0]   x_out,\n")
        f.write(f"  output [{num_neurons-1}:0]             o_valid\n")
        f.write(f");\n\n")

        for i in range(num_neurons):
            weight_filename = f"\"w_{layer_num}_{i}.mif\""
            bias_file_path  = os.path.join(BIAS_DIR, f"b_{layer_num}_{i}.mif")
            bias_literal    = read_bias_value(bias_file_path)

            f.write(f"  neuron #(\n")
            f.write(f"    .NUM_INPUTS      (NUM_INPUTS),\n")
            f.write(f"    .DATAWIDTH       (DATAWIDTH),\n")
            f.write(f"    .WEIGHTINTWIDTH  (WEIGHTINTWIDTH),\n")
            f.write(f"    .BIAS            ({bias_literal}),\n")
            f.write(f"    .WEIGHTFILE      ({weight_filename})\n")
            f.write(f"  ) n_{i} (\n")
            f.write(f"    .clk             (clk),\n")
            f.write(f"    .rst             (rst),\n")
            f.write(f"    .input_val       (input_val),\n")
            f.write(f"    .input_valid     (input_valid),\n")
            f.write(f"    .out             (x_out[{i}*DATAWIDTH+:DATAWIDTH]),\n")
            f.write(f"    .out_valid       (o_valid[{i}])\n")
            f.write(f"  );\n\n")

        f.write("endmodule\n")
    print(f"Generated: {filename}")

def generate_all_layers():
    for layer in range(1, NUM_LAYERS + 1):
        config = LAYER_CONFIG[layer]
        generate_layer(
            layer_num   = layer,
            num_neurons = config["neurons"],
            num_weights = config["weights"],
            act_type    = config["act"]
        )

if __name__ == "__main__":
    generate_all_layers()
