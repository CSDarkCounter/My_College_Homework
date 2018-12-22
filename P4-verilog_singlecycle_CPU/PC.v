`timescale 1ns / 1ps

module PC(
	 input clk,
    input reset,
	 input [1:0] jump,
	 input [2:0] nPC_sel,
	 input [31:0] ins,
	 input [31:0] pc_ins,
    output [31:0] address
    );
	//jal指令取出要跳转的地址
	wire [25:0] cs_ins;
	assign cs_ins = ins[25:0];
	
	//转换输出类型
	reg [31:0] cs_address;
	assign address = cs_address;
	initial begin
		cs_address <= 32'h00003000;
	end
	
	//每个时钟上升沿到来更新指令地址
	always @(posedge clk)begin
		if(reset)begin
			cs_address <= 32'h00003000;
		end
		else begin
			if(jump == 2'b01 && nPC_sel == 3'b001)begin	//beq跳转
				cs_address <= cs_address + 4 + {{16{ins[15]}}, ins[15:0], 2'b00};
			end
			
			else if(nPC_sel == 3'b010)begin	//jal跳转
				cs_address <= {cs_address[31:28], cs_ins, {2{1'b0}}}; 
			end
			
			else if(nPC_sel == 3'b011)begin	//jr跳转
				cs_address <= pc_ins;
			end
			
			else begin	//正常跳转
				cs_address <= cs_address + 4;
			end
		end
	end

endmodule
