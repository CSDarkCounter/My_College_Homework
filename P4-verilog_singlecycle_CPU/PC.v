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
	//jalָ��ȡ��Ҫ��ת�ĵ�ַ
	wire [25:0] cs_ins;
	assign cs_ins = ins[25:0];
	
	//ת���������
	reg [31:0] cs_address;
	assign address = cs_address;
	initial begin
		cs_address <= 32'h00003000;
	end
	
	//ÿ��ʱ�������ص�������ָ���ַ
	always @(posedge clk)begin
		if(reset)begin
			cs_address <= 32'h00003000;
		end
		else begin
			if(jump == 2'b01 && nPC_sel == 3'b001)begin	//beq��ת
				cs_address <= cs_address + 4 + {{16{ins[15]}}, ins[15:0], 2'b00};
			end
			
			else if(nPC_sel == 3'b010)begin	//jal��ת
				cs_address <= {cs_address[31:28], cs_ins, {2{1'b0}}}; 
			end
			
			else if(nPC_sel == 3'b011)begin	//jr��ת
				cs_address <= pc_ins;
			end
			
			else begin	//������ת
				cs_address <= cs_address + 4;
			end
		end
	end

endmodule
