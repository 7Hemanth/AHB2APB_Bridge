module top();
reg HCLK;
reg HRESETn=0;

wire [31:0]pwdata,prdata,paddr;
wire [2:0]psel;
wire pwrite,penable;
wire [31:0]HWDATA,HADDR,HRDATA;
wire HWRITE,HREADYin,HREADYout;
wire [1:0]HTRANS,HRESP;
wire [2:0]HSIZE;



ahb_master MASTER(.HCLK(HCLK),	.HRESETn(HRESETn), .HWRITE(HWRITE),
	.HREADYin(HREADYin), .HWDATA(HWDATA), .HADDR(HADDR),
	.HTRANS(HTRANS), .HREADYout(HREADYout), .HRESP(HRESP),
	.HRDATA(HRDATA), .HSIZE(HSIZE), .PRDATA(prdata));


top_rtl BRIDGE(.HADDR(HADDR), .HWDATA(HWDATA), .HTRANS(HTRANS),
	.HREADYin(HREADYin),	.HWRITE(HWRITE), .HRESP(HRESP),
	.HRDATA(HRDATA),	.HREADYout(HREADYout), .HSIZE(HSIZE),
	.HRESETn(HRESETn), .HCLK(HCLK), .PADDR(paddr),
	.PWDATA(pwdata),	.PSEL(psel), .PWRITE(pwrite),
	.PENABLE(penable), .PRDATA(prdata));


apb_int SLAVE(.PENABLE(penable), .PWRITE(pwrite), .PSEL(psel),
	.PADDR(paddr), .PWDATA(pwdata), .PRDATA(prdata), .HWDATA(HWDATA), .HRDATA(HRDATA));


always
begin
	HCLK=1'b1;
	#10;
	HCLK=~HCLK;
	#10;
end


task rst;
	begin
		@(negedge HCLK);
		HRESETn=1'b0;
		@(posedge HCLK);
		HRESETn=1'b1;
	end
endtask

initial
begin
	rst;
	#10000 $finish();
end

endmodule
