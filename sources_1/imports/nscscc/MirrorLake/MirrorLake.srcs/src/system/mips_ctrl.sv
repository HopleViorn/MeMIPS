`define InstBus 31:0
`define InstAddrBus 31:0
`define RegAddrBus 4:0
`define RegBus 31:0
`define RamAddrBus 5:0


`define Ena 1'b1
`define Dis 1'b0

`define ZeroWord 32'b0

`define opcode_ORI 		6'b001101
`define opcode_ANDI		6'b001100
`define opcode_LUI		6'b001111
`define opcode_XORI		6'b001110
`define opcode_ADDIU	6'b001001
`define opcode_BNE		6'b000101
`define opcode_BEQ		6'b000100
`define opcode_BGTZ		6'b000111
`define opcode_J		6'b000010
`define opcode_JAL		6'b000011

`define opcode_LB		6'b100000
`define opcode_LW		6'b100011
`define opcode_SB		6'b101000
`define opcode_SW		6'b101011

`define opcode_MUL		6'b011100
	`define func_MUL	6'b000010
`define opcode_SPECIAL 	6'b000000
	`define func_ADD 	6'b100000
	`define func_ADDU	6'b100001
	`define func_XOR	6'b100110
	`define func_AND	6'b100100
	`define func_OR		6'b100101
	`define func_SLLV	6'b000100
	`define func_SLL	6'b000000
	`define func_SRL	6'b000010
	`define func_JR		6'b001000


module mips_ctrl(
	input wire clk,
	input wire rst,

	inout logic[31:0] base_ram_data,  //BaseRAM数据，低8位与CPLD串口控制器共享
    output logic[19:0] base_ram_addr, //BaseRAM地址
    output logic[3:0] base_ram_be_n,  //BaseRAM字节使能，低有效。如果不使用字节使能，请保持为0
    output logic base_ram_req,       //BaseRAM片选，低有效
    output logic base_ram_wr,       //BaseRAM读使能，低有效
	input logic base_ram_ok,

    //ExtRAM信号
    inout logic[31:0] ext_ram_data,  //ExtRAM数据
    output logic[19:0] ext_ram_addr, //ExtRAM地址
    output logic[3:0] ext_ram_be_n,  //ExtRAM字节使能，低有效。如果不使用字节使能，请保持为0
    output logic ext_ram_req,       //ExtRAM片选，低有效
    output logic ext_ram_wr,       //ExtRAM读使能，低有效
	input logic ext_ram_ok
);

reg[31:0] base_ram_write_data;
reg[31:0] ext_ram_write_data;
wire[31:0] ext_ram_read_data;
wire[31:0] base_ram_read_data;
reg[31:0] pc;

assign base_ram_write_data=0;
assign base_ram_wr=0;
assign	base_ram_addr=pc[15:2];
assign	base_ram_be_n=4'b0000;
assign base_ram_wr=0;
assign base_ram_req=1;
assign base_ram_data=base_ram_wr?base_ram_write_data:32'bz;
assign base_ram_read_data=base_ram_data;

assign ext_ram_data=ext_ram_wr?ext_ram_write_data:32'bz;
assign ext_ram_read_data=ext_ram_data;

wire[31:0] inst=base_ram_read_data;


wire[5:0] opcode=inst[31:26];
wire[4:0] rs=inst[25:21];
wire[4:0] rt=inst[20:16];
wire[4:0] rd=inst[15:11];
wire[15:0] imm=inst[15:0];
wire[31:0] imm_signed_extented={{16{imm[15]}},imm};
wire[5:0] func=inst[5:0];

wire[4:0] sa=inst[10:6];

wire[31:0] pc_4=pc+4;
wire[31:0] pc_8=pc+8;

reg[`RegBus] Reg[0:31];

reg[7:0] tmp;
reg[31:0] tmpReg;

reg branch_flag;
reg[`InstBus] branch_address;
logic stall;

always_comb begin
	if(rst) begin
		ext_ram_addr=0;
		ext_ram_wr=0;
		ext_ram_be_n=4'b0000;
		ext_ram_write_data=0;
		ext_ram_req=0;
		ext_ram_wr=0;
		stall=0;
	end else begin
		case(opcode)
			`opcode_SW:begin
				tmpReg=Reg[rs]+imm_signed_extented;
				ext_ram_addr=tmpReg[15:2];
				ext_ram_write_data=Reg[rt];
				ext_ram_wr=1;
				ext_ram_be_n=4'b0000;
				ext_ram_req=1;
				stall=~ext_ram_ok;
			end
			`opcode_SB:begin
				tmpReg=Reg[rs]+imm_signed_extented;
				ext_ram_addr=tmpReg[15:2];
				ext_ram_write_data=0;
				ext_ram_wr=1;
				ext_ram_be_n=4'b0000;
				ext_ram_req=1;
				stall=~ext_ram_ok;
			end
			`opcode_LB:begin
				tmpReg=Reg[rs]+imm_signed_extented;
				ext_ram_addr=tmpReg[15:2];
				ext_ram_write_data=0;
				ext_ram_wr=0;
				ext_ram_be_n=4'b1110;
				ext_ram_req=1;
				stall=~ext_ram_ok;
			end
			`opcode_LW:begin
				tmpReg=Reg[rs]+imm_signed_extented;
				ext_ram_addr=tmpReg[15:2];
				ext_ram_write_data=0;
				ext_ram_wr=0;
				ext_ram_be_n=4'b0000;
				ext_ram_req=1;
				stall=~ext_ram_ok;
			end
			default:begin
				ext_ram_addr=0;
				ext_ram_write_data=0;
				ext_ram_wr=0;
				ext_ram_be_n=4'b0000;
				ext_ram_req=0;
				stall=0;
			end
		endcase
	end
end

always @(posedge clk) begin
	if(rst==`Ena) begin 
		for(int i=0;i<32;i++) begin
			Reg[i]=`ZeroWord;
		end
		branch_flag<=0;
	end else if(~stall) begin
		case(opcode)
			`opcode_ORI: begin
				if(rt!=0)
				Reg[rt]<=Reg[rs]|imm;
				branch_flag<=0;
			end
			`opcode_XORI: begin
				if(rt!=0)
				Reg[rt]<=Reg[rs]^imm;
				branch_flag<=0;
			end
			`opcode_ADDIU:begin
				if(rt!=0)
				Reg[rt]<=Reg[rs]+{{16{imm[15]}},imm};
				branch_flag<=0;
			end
			`opcode_ANDI:begin
				if(rt!=0)
				Reg[rt]<=Reg[rs]&imm;
				branch_flag<=0;
			end
			`opcode_LUI:begin
				if(rt!=0)
				Reg[rt]<={imm,16'b0};
				branch_flag<=0;
			end

			`opcode_BEQ:begin
				if(Reg[rs]==Reg[rt]) begin
					branch_flag<=1;
					branch_address<=pc_4+{{16{imm[15]}},imm,2'b00};
				end else begin
					branch_flag<=0;
					branch_address<=`ZeroWord;
				end
			end
			`opcode_BNE:begin
				if(Reg[rs]!=Reg[rt]) begin
					branch_flag<=1;
					branch_address<=pc_4+{{16{imm[15]}},imm,2'b00};
				end else begin
					branch_flag<=0;
					branch_address<=`ZeroWord;
				end
			end
			`opcode_BGTZ:begin
				if(Reg[rs]&32'h8000_0000==`ZeroWord&&Reg[rs]!=`ZeroWord) begin
					branch_flag<=1;
					branch_address<=pc_4+{{16{imm[15]}},imm,2'b00};
				end else begin
					branch_flag<=0;
					branch_address<=`ZeroWord;
				end	
			end		
			`opcode_J: begin
				branch_flag<=1;
				branch_address<={pc_4[31:28],inst[25:0],2'b00};
			end			
			`opcode_JAL:begin
				Reg[31]<=pc_8;
				branch_flag<=1;
				branch_address<={pc_4[31:28],inst[25:0],2'b00};
			end

			`opcode_LB:begin
				branch_flag<=0;
				if(rt!=0)
				Reg[rt]<={{{24{ext_ram_read_data[7]}},ext_ram_read_data[7:0]}};
			end
			`opcode_LW:begin
				branch_flag<=0;
				if(rt!=0)
				Reg[rt]<=ext_ram_read_data;
			end
			`opcode_SB:begin
				branch_flag<=0;
			end
			`opcode_SW:begin
				branch_flag<=0;
			end
			
			`opcode_MUL :begin
				case(func) 
					`func_MUL:begin
						if(rs!=0)
						Reg[rs]<=Reg[rs]*Reg[rt];
					end
					default:begin
					end
				endcase
			end
			`opcode_SPECIAL:begin
				
				case(func)
					`func_ADDU:begin
					   branch_flag<=0;
					   if(rd!=0)
						Reg[rd]<=Reg[rs]+Reg[rt];
					end
					`func_XOR:begin
					   branch_flag<=0;
					   if(rd!=0)
						Reg[rd]<=Reg[rs]^Reg[rt];
					end
					`func_AND:begin
					   branch_flag<=0;
					   if(rd!=0)
						Reg[rd]<=Reg[rs]&Reg[rt];
					end
					`func_OR:begin
					   branch_flag<=0;
					   if(rd!=0)
						Reg[rd]<=Reg[rs]|Reg[rt];
					end
					`func_SLL:begin
					   branch_flag<=0;
					   if(rd!=0)
						Reg[rd]<=Reg[rt]<<sa;
					end
					`func_SRL:begin
					   branch_flag<=0;
					   if(rd!=0)
						Reg[rd]<=Reg[rt]>>sa;
					end			
                    `func_JR:begin
                        branch_flag<=1;
                        branch_address<=Reg[rs];
			         end
					default:begin
					end
				endcase
			end
			default:begin
				branch_flag<=0;
			end
		endcase
	end
end

always @(posedge clk) begin
	if(rst==`Ena) pc<=`ZeroWord;
	else if(stall) begin
		pc<=pc;
	end else if(branch_flag) pc<=branch_address;
	else pc<=pc+4;
end

/****************/
//assign LOG=Reg[2];
/***************/

endmodule