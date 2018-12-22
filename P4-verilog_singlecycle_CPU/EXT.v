`timescale 1ns / 1ps

module ext(
    input [15:0] imm,
    input [2:0] Extop,
    output [31:0] out
    );
	
	//转化输出类型
	reg [31:0] cs_out;
	assign out = cs_out;
	
	//信号变化立即更新扩展结果
	always @(imm, Extop)begin
		if(Extop == 3'b000)
		begin
			cs_out <= {{16{1'b0}}, imm};
		end
				
		else if(Extop == 3'b001)
		begin
			cs_out <= {{16{imm[15]}}, imm};
		end
				
		else if(Extop == 3'b010)
		begin
			cs_out <= {imm, {16{1'b0}}};
		end
				
		else
		begin
				
		end
	end
	
endmodule
