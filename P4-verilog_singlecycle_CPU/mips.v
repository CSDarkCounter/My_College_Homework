`timescale 1ns / 1ps

module mips(
    input clk,
    input reset
    );
	 
	wire [1:0] jump;
	wire [2:0] nPC_sel;
	wire [31:0] ins;
	wire [31:0] address_im;
	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] rd;
	wire [15:0] imm;
	wire [5:0] Opcode;
	wire [5:0] Func;
	wire [2:0] RegDst;
	wire RegWrite;
	wire [1:0] MemorALU;
	wire [31:0] datafromMem;
   wire [31:0] reg_out1;
   wire [31:0] reg_out2;
	wire [3:0] ALUop;
	wire [1:0] ALUSrcA;
	wire [2:0] ALUSrcB;
	wire MemWrite;
	wire [2:0] extop;
	wire [31:0] extim;
	wire [31:0] result;
	wire [31:0] pc_ins;
	
	
	control cs_control(Opcode, Func, nPC_sel, ALUop, RegDst, ALUSrcA, ALUSrcB, RegWrite, MemWrite, extop, MemorALU);
	PC pc(clk, reset, jump, nPC_sel, ins, pc_ins, address_im);
	IM im(clk, address_im, rs, rt, rd, imm, Opcode, Func, ins);
	grf cs_grf(clk, reset, Opcode, Func, rs, rt, rd, RegDst, RegWrite, MemorALU, datafromMem, result, address_im, reg_out1, reg_out2, pc_ins);
	ext cs_ext(imm, extop, extim);
	ALU alu(reg_out1, reg_out2, ALUop, extim, ALUSrcA, ALUSrcB, address_im, result, jump);
	DM dm(clk, reset, MemWrite, result, reg_out2, address_im, datafromMem);
	
endmodule
