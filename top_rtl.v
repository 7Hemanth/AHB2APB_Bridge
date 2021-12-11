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

module top_rtl(HADDR,HWDATA,HTRANS,HREADYin,HWRITE,HRESP,
	HRDATA,HREADYout,HSIZE,HRESETn,HCLK,PADDR,
	PWDATA,PSEL,PWRITE,PENABLE,PRDATA);

input	[31:0]HADDR,
	HWDATA,
	PRDATA;

input	[1:0]HTRANS;
input	HREADYin,
	HWRITE,
	HRESETn,
	HCLK;

input	[2:0]HSIZE;

output	[31:0]PADDR,
	PWDATA,
	HRDATA;

output	[1:0]HRESP;

output	PWRITE,
	PENABLE,
	HREADYout;

output	[2:0]PSEL;


wire	[31:0]ADDR_1,ADDR_2,ADDR_3,
	DATA_1,DATA_2,DATA_3;

wire	w_reg,vld;
wire [2:0]tmp_sel;


ahb_slave SLAVE(.HADDR(HADDR),	  	.HWDATA(HWDATA),	.HTRANS(HTRANS),
	.HREADYin(HREADYin),	.HWRITE(HWRITE),	.HRESP(HRESP), 
	.HRDATA(HRDATA),	.HSIZE(HSIZE),		.HCLK(HCLK),
	.HRESETn(HRESETn),	.PRDATA(PRDATA),	.HADDR_1(ADDR_1),
	.HWDATA_1(DATA_1),	.HADDR_2(ADDR_2),	.HWDATA_2(DATA_2),
	.HADDR_3(ADDR_3),	.HWDATA_3(DATA_3),	.HWRITEreg(w_reg),
	.valid(vld),		.TEMP_SEL(tmp_sel));


fsm FSM(.HADDR_1(ADDR_1),		.HADDR_2(ADDR_2),	.HADDR_3(ADDR_3),
	.HWDATA_1(DATA_1),		.HWDATA_2(DATA_2),	.HWDATA_3(DATA_3),
	.HWRITE(HWRITE),		.HWRITEreg(w_reg),	.HSIZE(HSIZE),
	.TEMP_SEL(tmp_sel),		.valid(vld),		.PADDR(PADDR),
	.PWDATA(PWDATA),		.PSEL(PSEL),		.PWRITE(PWRITE),
	.PENABLE(PENABLE),		.HCLK(HCLK),		.HRESETn(HRESETn),
	.HTRANS(HTRANS),		.HREADYout(HREADYout));


endmodule
