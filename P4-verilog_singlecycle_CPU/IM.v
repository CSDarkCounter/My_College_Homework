`timescale 1ns / 1ps
module IM(
	 input clk,
    input [31:0] addr_im,
    output [4:0] rs,
	 output [4:0] rt,
	 output [4:0] rd,
	 output [15:0] imm,
	 output [5:0] Opcode,
	 output [5:0] Func,
	 output [31:0] ins
    );
	 
	//转换输出类型，并将译码过程合并于此
	reg [31:0] cs_ins;
	assign ins = cs_ins;	//取出的是什么指令
	assign rs = cs_ins[25:21];
	assign rt = cs_ins[20:16];
	assign rd = cs_ins[15:11];
	assign imm = cs_ins[15:0];
	assign Opcode = cs_ins[31:26];
	assign Func = cs_ins[5:0];
	
	
	reg [31:0] insmemory [0:1023];
	
	initial begin
		$readmemh("code.txt", insmemory);
		cs_ins <= 0;	//初始化指令
	end
	
	always @(addr_im[9:0])begin	//指令地址变了就直接更新，而不是等时钟上升沿(ROM没有时钟信号)
		cs_ins <= insmemory[(addr_im - 32'h00003000) >> 2];
	end
	
	
endmodule
