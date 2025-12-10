onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/clk
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/rst
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/D_out
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/d_out_valid
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/rd_en
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/Jmp_branch_address
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/jmp_branch_valid
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/branch_nt_next_inst
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/branch_signal
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/PC_in
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/PC_out
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/Instr
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/rd_en_o
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/abort
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/empty
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/FIFO_out
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/rp
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/wp
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/IFQ_mux_2_bypass_mux
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/IFQ_mux_1st_instr
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/IFQ_mux_1st_or_FIFO_inst
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/PC_in_Plus_16
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/PC_in_reg
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/fifo_full
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/PC_out_i_w
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/IFQ_after_bnt
add wave -noupdate -group IFQ /tb_risc_v_superscalar/dut/ifq_instance/IFQ_bnt
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/clk
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/rst
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/ifetch_pc_plus_four
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/ifetch_instruction
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/ifetch_empty_flag
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/cdb_tag
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/cdb_valid
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/cdb_data
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/cdb_branch
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/cdb_branch_taken
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/dispatch_jmp_branch_addr
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/dispatch_jump_branch
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/dispatch_ren
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/en_div_dispatch
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/en_mult_dispatch
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/en_store_load_dispatch
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/en_int_dispatch
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/dispatcher_2_int_queue
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/dispatcher_2_lw_sw_queue
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/dispatcher_2_mult_or_div
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/branch_nt_next_inst
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/branch_signal
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/issueque_int_full
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/stall_branch
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/instr_rs1_addr
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/instr_rs2_addr
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/instr_rd_addr
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/instr_opcode
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/instr_func3
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/instr_func7
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/read_enable_w
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/Instruction_2_decode
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/rs1_tag_W
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/rs1_valid_w
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/rs2_tag_W
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/rs2_valid_w
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/rd_regfile_rst_w
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/Imm_o_w
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/Branch_jump_addr_w
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/branch_signal_W
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/jump_signal_w
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/Tagout_tf_W
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/ff_tf_w
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/et_tf_w
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/sel_data_rs1
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/sel_data_rs2
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/rs1_data_dispatcher
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/rs2_data_dispatcher
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/RS1_regfile
add wave -noupdate -group Dispatcher /tb_risc_v_superscalar/dut/dispatcher_instance/RS2_regfile
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/clk
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/wdata0_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/waddr0_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/wen0_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/wdata1_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/wen1_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/rsaddr_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/rstag_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/rsvalid_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/rtaddr_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/rttag_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/rtvalid_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/cdb_valid
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/cdb_tag_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/rd_regfile_rst
add wave -noupdate -group RST /tb_risc_v_superscalar/dut/dispatcher_instance/rst_module/cdb_clear_addr
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/clk
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/reset
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_enable
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_rs_data
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_rs_tag
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_rs_data_val
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_rt_data
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_rt_tag
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_rt_data_val
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_opcode
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_func3
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_func7
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/dispatch_rd_tag
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/issueque_full
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/cdb_tag
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/cdb_data
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/cdb_valid
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/issueque_ready
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/issueque_rs_data
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/issueque_rt_data
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/issueque_rd_tag
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/issueque_opcode
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/issueque_funct3
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/issueque_funct7
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/issueblk_done
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/instruction_ready
add wave -noupdate -group {Int queue} /tb_risc_v_superscalar/dut/integer_queue_instance/shift_after_issue
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/clk
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/rst
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/ready_int
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/ready_mult
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/ready_div
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/ready_mem
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/div_exec_ready
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/issue_int
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/issue_mult
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/issue_div
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/issue_mem
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/lru
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/issue_oneclk
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/CDB_reservation_reg_aux
add wave -noupdate -group {Issue Unit} /tb_risc_v_superscalar/dut/issue_unit_instance/CDB_reservation_reg
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/issue_int
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/Opcode
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/Funct3
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/Funct7
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/RS1
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/RS2
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/RD_Tag
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/cdb_int_unit
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/alu_zero_w
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/ALU_Result_w
add wave -noupdate -group {Int exec} /tb_risc_v_superscalar/dut/int_exec_unit_instance/ALU_Opcode_w
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/clk
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/rst
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/issue_int
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/issue_mem
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/issue_div
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/issue_mult
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/CDB_Int
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/CDB_Mem
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/CDB_Mult
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/CDB_Div
add wave -noupdate -expand -group CDB /tb_risc_v_superscalar/dut/cdb_logic_feedback_instance/CDB_output
add wave -noupdate -group RegFile /tb_risc_v_superscalar/dut/dispatcher_instance/RegFile_module/clk
add wave -noupdate -group RegFile /tb_risc_v_superscalar/dut/dispatcher_instance/RegFile_module/rst
add wave -noupdate -group RegFile /tb_risc_v_superscalar/dut/dispatcher_instance/RegFile_module/Read_reg1
add wave -noupdate -group RegFile /tb_risc_v_superscalar/dut/dispatcher_instance/RegFile_module/Read_reg2
add wave -noupdate -group RegFile /tb_risc_v_superscalar/dut/dispatcher_instance/RegFile_module/Write_reg
add wave -noupdate -group RegFile /tb_risc_v_superscalar/dut/dispatcher_instance/RegFile_module/Write_Data
add wave -noupdate -group RegFile /tb_risc_v_superscalar/dut/dispatcher_instance/RegFile_module/Read_data1
add wave -noupdate -group RegFile /tb_risc_v_superscalar/dut/dispatcher_instance/RegFile_module/Read_data2
add wave -noupdate -expand -group {TAG FIFO} /tb_risc_v_superscalar/dut/dispatcher_instance/tag_fifo_module/clk
add wave -noupdate -expand -group {TAG FIFO} /tb_risc_v_superscalar/dut/dispatcher_instance/tag_fifo_module/rst
add wave -noupdate -expand -group {TAG FIFO} /tb_risc_v_superscalar/dut/dispatcher_instance/tag_fifo_module/cdb_tag_tf
add wave -noupdate -expand -group {TAG FIFO} /tb_risc_v_superscalar/dut/dispatcher_instance/tag_fifo_module/cdb_tag_tf_valid
add wave -noupdate -expand -group {TAG FIFO} /tb_risc_v_superscalar/dut/dispatcher_instance/tag_fifo_module/ren_tf
add wave -noupdate -expand -group {TAG FIFO} /tb_risc_v_superscalar/dut/dispatcher_instance/tag_fifo_module/tagout_tf
add wave -noupdate -expand -group {TAG FIFO} /tb_risc_v_superscalar/dut/dispatcher_instance/tag_fifo_module/ff_tf
add wave -noupdate -expand -group {TAG FIFO} /tb_risc_v_superscalar/dut/dispatcher_instance/tag_fifo_module/ef_tf
add wave -noupdate -expand -group {TAG FIFO} /tb_risc_v_superscalar/dut/dispatcher_instance/tag_fifo_module/rp
add wave -noupdate -expand -group {TAG FIFO} /tb_risc_v_superscalar/dut/dispatcher_instance/tag_fifo_module/wp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {95000 ps} 0} {{Cursor 2} {33779 ps} 0} {{Cursor 3} {45187 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 474
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {24040 ps} {114524 ps}
