`timescale 1ns / 1ps

module control(
    input [5:0] Opcode,
    input [5:0] Func,
    output [2:0] nPC_sel,
    output [3:0] ALUop,
    output [2:0] RegDst,
	 output [1:0] ALUSrcA,
    output [2:0] ALUSrcB,
    output RegWrite,
    output MemWrite,
    output [2:0] Extop,
    output [1:0] MemorALU
    );
	reg cs_addu;
	reg cs_subu;
	reg cs_ori;
	reg cs_lw;
	reg cs_sw;
	reg cs_beq;
	reg cs_lui;
	reg cs_jal;
	reg cs_jr;
	
	assign nPC_sel[2] = 0;
	assign nPC_sel[1] = (cs_jal || cs_jr) ? 1 : 0;
	assign nPC_sel[0] = (cs_jr || cs_beq) ? 1 : 0;
	assign ALUop[3] = (cs_lui) ? 1 : 0;
	assign ALUop[2] = (cs_lui) ? 1 : 0;
	assign ALUop[1] = (cs_lui || cs_beq || cs_ori) ? 1 : 0;
	assign ALUop[0] = (cs_beq || cs_lui || cs_subu) ? 1 : 0;
	assign RegDst[2] = 0;
	assign RegDst[1] = (cs_jal) ? 1 : 0;
	assign RegDst[0] = (cs_subu || cs_addu) ? 1 : 0;
	assign ALUSrcA[0] = (cs_jal) ? 1 : 0;
	assign ALUSrcA[1] = 0;
	assign ALUSrcB[0] = (cs_ori || cs_sw || cs_lw || cs_lui) ? 1 : 0;
	assign ALUSrcB[1] = (cs_jal) ? 1 : 0;
	assign ALUSrcB[2] = 0;
	assign RegWrite = (cs_jal || cs_subu || cs_addu || cs_lw || cs_lui || cs_ori) ? 1 : 0;
	assign MemWrite = (cs_sw) ? 1 : 0;
	assign Extop[2] = 0;
	assign Extop[1] = (cs_lui) ? 1 : 0;
	assign Extop[0] = (cs_sw || cs_lw) ? 1 : 0;
	assign MemorALU[0] = (cs_lw) ? 1 : 0;
	assign MemorALU[1] = 0;
	
	initial begin
		cs_addu <= 0;
		cs_subu <= 0;
		cs_ori <= 0;
		cs_lw <= 0;
		cs_sw <= 0;
		cs_beq <= 0;
		cs_lui <= 0;
		cs_jal <= 0;
		cs_jr <= 0;
	end
	
	always @(Opcode, Func)begin
		if(Opcode == 6'b000000 && Func == 6'b100001)begin
			cs_addu <= 1;
			cs_subu <= 0;
			cs_ori <= 0;
			cs_lw <= 0;
			cs_sw <= 0;
			cs_beq <= 0;
			cs_lui <= 0;
			cs_jal <= 0;
			cs_jr <= 0;
		end
	
		else if(Opcode == 6'b000000 && Func == 6'b100011)begin
			cs_addu <= 0;
			cs_subu <= 1;
			cs_ori <= 0;
			cs_lw <= 0;
			cs_sw <= 0;
			cs_beq <= 0;
			cs_lui <= 0;
			cs_jal <= 0;
			cs_jr <= 0;
		end
	
		else if(Opcode == 6'b001101)begin
			cs_addu <= 0;
			cs_subu <= 0;
			cs_ori <= 1;
			cs_lw <= 0;
			cs_sw <= 0;
			cs_beq <= 0;
			cs_lui <= 0;
			cs_jal <= 0;
			cs_jr <= 0;
		end
		
		else if(Opcode == 6'b100011)begin
			cs_addu <= 0;
			cs_subu <= 0;
			cs_ori <= 0;
			cs_lw <= 1;
			cs_sw <= 0;
			cs_beq <= 0;
			cs_lui <= 0;
			cs_jal <= 0;
			cs_jr <= 0;
		end
		
		else if(Opcode == 6'b101011)begin
			cs_addu <= 0;
			cs_subu <= 0;
			cs_ori <= 0;
			cs_lw <= 0;
			cs_sw <= 1;
			cs_beq <= 0;
			cs_lui <= 0;
			cs_jal <= 0;
			cs_jr <= 0;
		end
		
		else if(Opcode == 6'b000100)begin
			cs_addu <= 0;
			cs_subu <= 0;
			cs_ori <= 0;
			cs_lw <= 0;
			cs_sw <= 0;
			cs_beq <= 1;
			cs_lui <= 0;
			cs_jal <= 0;
			cs_jr <= 0;
		end
		
		else if(Opcode == 6'b001111)begin
			cs_addu <= 0;
			cs_subu <= 0;
			cs_ori <= 0;
			cs_lw <= 0;
			cs_sw <= 0;
			cs_beq <= 0;
			cs_lui <= 1;
			cs_jal <= 0;
			cs_jr <= 0;
		end
		
		else if(Opcode == 6'b000011)begin
			cs_addu <= 0;
			cs_subu <= 0;
			cs_ori <= 0;
			cs_lw <= 0;
			cs_sw <= 0;
			cs_beq <= 0;
			cs_lui <= 0;
			cs_jal <= 1;
			cs_jr <= 0;
		end
		
		else if(Opcode == 6'b000000 && Func == 6'b001000)begin
			cs_addu <= 0;
			cs_subu <= 0;
			cs_ori <= 0;
			cs_lw <= 0;
			cs_sw <= 0;
			cs_beq <= 0;
			cs_lui <= 0;
			cs_jal <= 0;
			cs_jr <= 1;
		end
		
		else begin
			cs_addu <= 0;
			cs_subu <= 0;
			cs_ori <= 0;
			cs_lw <= 0;
			cs_sw <= 0;
			cs_beq <= 0;
			cs_lui <= 0;
			cs_jal <= 0;
			cs_jr <= 0;
		end
	end
endmodule
