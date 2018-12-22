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
	//ת���������
	reg [31:0] cs_dout;
	assign dout = cs_dout;
	
	//��ʼ��
	integer i;
	reg [31:0] datamemory [0:1023];
	initial begin
		for(i=0; i<1024; i=i+1)begin
				datamemory[i] <= 0;
		end
		cs_dout <= 0;
	end
	
	//RAM��ʱ�������ظ�������
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
	
	//RAM���ݵĶ�������Ҫʱ���źţ������źű��˾�Ҫ�������
	always @(addr_dm[11:2], MemWrite, din)begin
			cs_dout <= datamemory[addr_dm[11:2]];
	end

endmodule
