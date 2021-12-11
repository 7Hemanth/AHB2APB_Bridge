/*

MIT License

Copyright (c) 2021 7Hemanth

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/

module ahb_master(HCLK,HRESETn,HWRITE,HREADYin,HWDATA,HADDR,HTRANS,
	HREADYout,HRESP,HRDATA,HSIZE,PRDATA);

input HCLK,HRESETn,HREADYout;
input [1:0]HRESP;
input [31:0]HRDATA;
output reg HREADYin=1,HWRITE;
output reg[31:0]HWDATA,HADDR,PRDATA;
reg [31:0] HADDRreg;
output reg[2:0]HSIZE;
output reg[1:0]HTRANS;


reg [2:0]HBURST;

parameter EIGHT=3'b000,
	SIXTEEN=3'b001,
	THIRTY_TWO=3'b010;

parameter  
SINGLE=3'b000,
	INCR=3'b001,
	WRAP_4=3'b010,
	INCR_4=3'b011,
	WRAP_8=3'b100,
	INC_8=3'b101,
	WRAP_16=3'b110,
	INC_16=3'b111,

	NONSEQ=2'b00,
	SEQ=2'b01;


task burst_32;
	begin
		case(HBURST)
			SINGLE:begin

				begin  
				@(posedge HCLK);
				HTRANS=NONSEQ;
				@(posedge HCLK);
				HWRITE=1'b1;
				HADDR=32'h8400_0000;
				@(posedge HCLK);
				if(HWRITE)
					HWDATA<={$random}%255;
				else
					HWDATA=32'bx;
				@(posedge HCLK);
				HWRITE=1'b0;
				HADDR=32'h8400_0000;
				@(posedge HCLK);
				HADDR=0;
				@(posedge HCLK);
				HADDR=32'h8400_0000;
				@(posedge HCLK);
				@(posedge HCLK);
				@(posedge HCLK);
				if(~HWRITE)
					PRDATA<={$random}%1000;
				else
					PRDATA=32'bx;
				HWRITE=1'b1;
				HADDR=0;
				@(posedge HCLK);
				HADDR=0;
				#20;

			end
		end

	endcase
end
endtask



initial
begin
	if(~HRESETn)
	begin
		HADDR=0;
		HWRITE=0;
		HWDATA=0;
		HSIZE=0;
		HTRANS=0;
		HBURST=0;
		PRDATA=0;
	end


	else
	begin
		HBURST=SINGLE;
		HSIZE=3'b010;
		case(HSIZE)
			THIRTY_TWO:burst_32;
		endcase
	end
	#1000 $finish();
end

initial 
	$monitor("HCLK=%b,HRESETn=%b,HWRITE=%b,HREADYin=%b,HWDATA=%b,HADDR=%b,HTRANS=%b,HREADYout=%b,HRESP=%b,HRDATA=%b,HSIZE=%b,PRDATA=%b", HCLK,HRESETn,HWRITE,HREADYin,HWDATA,HADDR,HTRANS,HREADYout,HRESP,HRDATA,HSIZE,PRDATA);

endmodule
