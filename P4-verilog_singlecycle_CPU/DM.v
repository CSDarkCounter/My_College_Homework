`timescale 1ns / 1ps

module DM(
	 input clk,
    input reset,
    input MemWrite,
    input [31:0] addr_dm,
    input [31:0] din,
	 input [31:0] WPC,
    output [31:0] dout
    );
	//转换输出类型
	reg [31:0] cs_dout;
	assign dout = cs_dout;
	
	//初始化
	integer i;
	reg [31:0] datamemory [0:1023];
	initial begin
		for(i=0; i<1024; i=i+1)begin
				datamemory[i] <= 0;
		end
		cs_dout <= 0;
	end
	
	//RAM在时钟上升沿更新数据
	always @(posedge clk)begin
		if(reset)begin
			for(i=0; i<1024; i=i+1)begin
				datamemory[i] <= 0;
			end
		end
		
		else begin
			if(MemWrite)begin
				$display("@%h: *%h <= %h", WPC, addr_dm, din);
				datamemory[addr_dm[11:2]] <= din;
			end
		end
	end
	
	//RAM数据的读出不需要时钟信号，输入信号变了就要更新输出
	always @(addr_dm[11:2], MemWrite, din)begin
			cs_dout <= datamemory[addr_dm[11:2]];
	end

endmodule
