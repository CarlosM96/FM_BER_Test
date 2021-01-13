These are the folders that contain the projects used in the test.

AC701_test_code:

In this section you will find the verilog project for sending n-packets with n-words of 32 bits.
The internal clock is used with the jitter attenuator. This module generates PRBS data depending on 
the number of n-words and integrates it into the Full Mode protocol, repeating this process N times
depending on the number of n-packets.

The top module for this section is: 
FM_BER_Test/AC701_test_code/sfp_test_1.srcs/sources_1/imports/example_design/gtwizard_0_exdes.v

Vc709_rx_error_int:

In this section is the verilog project used in the vc709 for the test, which when detecting the special
character 3c of the Start of packet label, generates the same prbs used in AC701, to compare with the
received data. When it finishes receiving the n-packets, it will send the errors found by uart usb. 
The internal clock is used with the jitter attenuator.

The top module for this section is:
FM_BER_Test/VC709_rx_error_int/rx_error_int.srcs/sources_1/new/top.v

GTH_Automatic_simulation:

In this section you will find the verilog project used to simulate the behavior of the two previous sections,
it uses the same codes and connects the tx to the rx.

The top module for this section is:
FM_BER_Test/GTH_Automatic_simulation/GTH_Automatic.srcs/sources_1/new/top.v

Migen_codes:

In this section you will find the codes in Migen, in which all the logic used in the previous sections was modeled.
In order to use these codes it is necessary to install python3, Migen and Litex on your 
computer, since library codes were used. 
For more information access: https://m-labs.hk/gateware/migen/
