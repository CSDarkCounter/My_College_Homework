`timescale 1ns / 1ps

module ALU(
    input [31:0] s1,
    input [31:0] s2,
    input [3:0] cal_op,
    input [31:0] extim,
	 input [1:0] ALUSrcA,
    input [2:0] ALUSrcB,
	 input [31:0] pc_ins,
    output [31:0] result,
	 output [1:0] jump
    );
	 
	//转换输出类型
	reg [31:0] cs_result;
	reg cs_jump;
	assign result = cs_result;
	assign jump = cs_jump;
	
	//选操作数
	wire [31:0] s4;
	assign s4 = (ALUSrcA[0]) ? pc_ins : s1;
	
	wire [31:0] s3;
	assign s3 = (ALUSrcB[1]) ? 4 : (ALUSrcB[0] ? extim : s2);
	
	//初始化输出
	initial begin
		cs_result <= 0;
		cs_jump <= 0;
	end
	
	//信号变化立即更新
	always @(s4, s3, cal_op)begin
		case (cal_op)
			4'b0000:
				begin
					cs_result <= s4 + s3;
				end
				
			4'b0001:
				begin
					cs_result <= s4 - s3;
				end
				
			4'b0010:
				begin
					cs_result <= s4 | s3;
				end
				
			4'b0011:
				begin
					cs_jump <= (s4 == s3) ? 2'b01 : 2'b00;	//把beq跳转的控制信号直接合在ALU中
				end
				
			4'b1111:
				begin
					cs_result <= s3;
				end
				
			default:
				begin
			
				end
			endcase
			
	end
	
endmodule
