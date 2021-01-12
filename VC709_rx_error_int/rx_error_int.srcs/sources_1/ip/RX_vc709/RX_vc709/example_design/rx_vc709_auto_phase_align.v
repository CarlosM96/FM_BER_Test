////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 3.6
//  \   \         Application : 7 Series FPGAs Transceivers Wizard 
//  /   /         Filename : rx_vc709_auto_phase_align.v
// /___/   /\     
// \   \  /  \ 
//  \___\/\___\ 
//
//
// Module RX_vc709_auto_phase_align
// Generated by Xilinx 7 Series FPGAs Transceivers Wizard
// 
// 
// (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 


`timescale 1ns / 1ps
`define DLY #1


module RX_vc709_AUTO_PHASE_ALIGN  
    (                     STABLE_CLOCK,            //Stable Clock, either a stable clock from the PCB
                                                   //or reference-clock present at startup.
                          RUN_PHALIGNMENT,         //Signal from the main Reset-FSM to run the auto phase-alignment procedure
                          PHASE_ALIGNMENT_DONE,    // Auto phase-alignment performed sucessfully
                          PHALIGNDONE,             //\ Phase-alignment signals from and to the
                          DLYSRESET,               // |transceiver.
                          DLYSRESETDONE,           ///
                          RECCLKSTABLE              //on the RX-side.
    );


      input   wire   STABLE_CLOCK;                          
      input   wire   RUN_PHALIGNMENT;                       
      output  reg    PHASE_ALIGNMENT_DONE;            
      input   wire   PHALIGNDONE;        
      output  reg    DLYSRESET;          
      input   wire   DLYSRESETDONE;      
      input   wire   RECCLKSTABLE;


   localparam [1:0]
               INIT = 2'b00,
               WAIT_PHRST_DONE = 2'b01,
               COUNT_PHALIGN_DONE = 2'b10,
               PHALIGN_DONE = 2'b11;

    
  reg [1:0] phalign_state;
  reg       phaligndone_prev;
  wire      phaligndone_ris_edge;
  wire      phaligndone_sync;
  wire      dlysresetdone_sync;

  reg [1:0] count_phalign_edges;


  //Clock Domain Crossing
 RX_vc709_sync_block sync_PHALIGNDONE
        (
           .clk             (STABLE_CLOCK),
           .data_in         (PHALIGNDONE),
           .data_out        (phaligndone_sync)
        );

 RX_vc709_sync_block sync_DLYSRESETDONE
        (
           .clk             (STABLE_CLOCK),
           .data_in         (DLYSRESETDONE),
           .data_out        (dlysresetdone_sync)
        );

 
  //The logic below implements the procedure to do automatic phase-alignment on the
  //7-series GTX as described in ug476pdf, version 1.3, Chapters "Using the TX Phase 
  //Alignment to Bypass the TX Buffer" and "Using the RX Phase Alignment to Bypass 
  //the RX Elastic Buffer"
  //Should the logic below differ from what is described in a later version of the 
  //user-guide, you are using an auto-alignment block, which is out of date and needs
  //to be updated for safe operation.
  

  always @(posedge STABLE_CLOCK)
  begin
      phaligndone_prev <= `DLY phaligndone_sync; 
  end 

   assign phaligndone_ris_edge = ((phaligndone_prev == 0) && (phaligndone_sync == 1)) ? 1'b1 : 1'b0;
  
  always @(posedge STABLE_CLOCK)
  begin
      if ((RUN_PHALIGNMENT == 1'b0) || (RECCLKSTABLE == 1'b0))
      begin 
        DLYSRESET             <= `DLY 1'b0;
        count_phalign_edges   <= `DLY 2'b00;
        PHASE_ALIGNMENT_DONE  <= `DLY 1'b0;
        phalign_state         <= `DLY INIT;
      end

      else
      begin
        if (phaligndone_ris_edge == 1)
        begin
          if (count_phalign_edges < 3)
            count_phalign_edges <= `DLY count_phalign_edges + 1'b1;
        end
        DLYSRESET   <= `DLY 1'b0;
                  
        case (phalign_state)
           INIT :
           begin 
               PHASE_ALIGNMENT_DONE <= `DLY 1'b0;
               if ((RUN_PHALIGNMENT == 1'b1) && (RECCLKSTABLE == 1'b1))
               begin
                   //DLYSRESET is toggled to '1'
                   DLYSRESET     <= `DLY 1'b1;
                   phalign_state <= `DLY WAIT_PHRST_DONE;
               end 
           end          
            
           WAIT_PHRST_DONE :
           begin
            if (dlysresetdone_sync == 1'b1)
              phalign_state <= `DLY COUNT_PHALIGN_DONE;
           end
            //No timeout-check here as that is done in the main FSM
            
           COUNT_PHALIGN_DONE :
           begin
            if (phaligndone_ris_edge)

              //For GTX: Only on the second edge of the PHALIGNDONE-signal the 
              //         phase-alignment is completed
              //For GTH, GTP: TXSYNCDONE indicates the completion of Phase Alignment
              phalign_state <= `DLY PHALIGN_DONE;
           end
          
           PHALIGN_DONE :
           begin
            PHASE_ALIGNMENT_DONE <= `DLY 1'b1;
           end

           default:
              phalign_state      <= `DLY INIT;

        endcase        
      end       
  end 

  endmodule
