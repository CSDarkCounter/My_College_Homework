`timescale 1ns / 1ps

module grf(
	 input clk,
	 input reset,
	 input [5:0] Opcode,
	 input [5:0] Func,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [2:0] RegDst,
    input RegWrite,
	 input [1:0] MemorALU,
	 input [31:0] datafromMem,
	 input [31:0] datafromALU,
	 input [31:0] WPC,
    output [31:0] out1,
    output [31:0] out2,
	 output [31:0] pc_ins
    );
	
	//处理输出
	assign out1 = GPR[rs];
	assign out2 = GPR[rt];
	assign pc_ins = GPR[rs];	//为jr准备的
	
	//fr：向哪个寄存器写入数据
	wire [4:0] fr;
	assign fr = (RegDst[1]) ? 31 : (RegDst[0] ? rd : rt);
	
	//写入数据是啥
	wire [31:0] WR;
	assign WR = (MemorALU[0])?datafromMem : datafromALU;
	
	
	//初始化寄存器堆
	reg [31:0] GPR [0:31];
	integer j;
	initial begin
		for(j=0; j <= 31; j=j+1)begin
				GPR[j] <= 0;
			end
	end
	
	//每个时钟上升沿到来时更新寄存器的值
	always @(posedge clk)begin
		if(reset)begin
			for(j=0; j <= 31; j=j+1)begin
				GPR[j] <= 0;
			end
		end
		
		else begin
			if(RegWrite == 1)begin
				if(fr != 0)begin	//0号寄存器永远是0
					GPR[fr] = WR;
				end
				$display("@%h: $%d <= %h", WPC, fr, WR);
			end
		end
	end
	
endmodule
