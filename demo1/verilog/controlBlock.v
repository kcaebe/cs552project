module controlBlock(opCode, func, halt, sign, pcOffSel, regWrt, memWrt, memToReg, memEn, jump, invA, invB, aluSrc, err,
    regDst, regWrtSrc, aluOp, return);
    input [4:0] opCode;
    input [1:0] func;

    output reg halt, sign, regWrt, pcOffSel, memWrt, memToReg, memEn, jump, 
    			invA, invB, err, return;
    output reg [1:0] regDst;
    output reg [2:0] aluSrc, regWrtSrc, aluOp;
    // output [2:0] 
    


    // I1
    localparam ADDI = 5'b01000;
    localparam SUBI = 5'b01001;
    localparam XORI = 5'b01010;
    localparam ANDI = 5'b01011;
    localparam ROLI = 5'b01100;
    localparam SLLI = 5'b01101;
    localparam RORI = 5'b01110;
    localparam SRLI = 5'b01111;
    localparam ST = 5'b10000;
    localparam LD = 5'b10001;
    localparam STU = 5'b10011;
    
    //R
    localparam BTR = 5'b11001;
    localparam ALU_OP1 = 5'b11011;
    localparam ALU_OP2 = 5'b11010;
    localparam SEQ = 5'b11100;
    localparam SLT = 5'b11101;
    localparam SLE = 5'b11110;
    localparam SCO = 5'b11111;


    // I2
    localparam LBI = 5'b11000;
    localparam SLBI = 5'b10010;
    localparam JR = 5'b00101;
    localparam JALR = 5'b00111;
    localparam BEQZ = 5'b01100;
    localparam BNEZ = 5'b01101;
    localparam BLTZ = 5'b01110;
    localparam BGEZ = 5'b01111;
    //J
    localparam J = 5'b00100;
    localparam JAL = 5'b00110;
    // SP
    localparam SIIC = 5'b00010;
    localparam RTI = 5'b00011;
    localparam HALT = 5'b00000;
    localparam NOP = 5'b00001;





    // determine which format the instruction is
   	// is it even worth though? 
   	// better to just have huge case statement for each opcode/function
   	// and assign control sigs for there
    // fmtDecode fmt(.opCode(opCode), .fmt(format));

    always@(opCode, func) begin
    	halt = 0;
    	sign = 1'hx;
    	pcOffSel = 1'hx;
    	regWrt = 0;
    	memWrt = 0;
    	memToReg = 0; // needed?
    	memEn = 0;
    	jump = 0;
    	return  = 0;
    	invA = 0;
    	invB = 0;
    	regDst = 0;
    	regWrtSrc = 0;
    	aluOp = 0;
    	err = 0;

    	casex({opCode,func})
            {LBI,2'hxx}: begin
                regWrt = 1'h1;
                regDst = 2'h1;
                regWrtSrc = 3'h4;
            end
    		{SLBI,2'hxx}: begin
    			regWrt = 1'h1;
    			regDst = 2'h1;
    			regWrtSrc = 3'h5;
    		end
            {HALT,2'hxx}: begin
                halt = 1;
            end

    		default: err = 1;
    	endcase

    end


endmodule