# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /media/nisitha/My_Passport/MOODLE/Vivado_projects/cnn_character_recognition/custom_cnn_implementation/custom_nn_implementation/vsw_21/plt_mnist/platform.tcl
# 
# OR launch xsct and run below command.
# source /media/nisitha/My_Passport/MOODLE/Vivado_projects/cnn_character_recognition/custom_cnn_implementation/custom_nn_implementation/vsw_21/plt_mnist/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {plt_mnist}\
-hw {/media/nisitha/My_Passport/MOODLE/Vivado_projects/cnn_character_recognition/custom_cnn_implementation/custom_nn_implementation/custom_nn_implementation/bd_mnist_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out {/media/nisitha/My_Passport/MOODLE/Vivado_projects/cnn_character_recognition/custom_cnn_implementation/custom_nn_implementation/vsw_21}

platform write
platform generate -domains 
platform active {plt_mnist}
platform generate
