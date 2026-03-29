module top();

	import uvm_pkg::*;
	import pkg::*;
	
	`include "uvm_macros.svh"

	bit clk1;
	bit clk2;
	
	always #5 clk1=~clk1;
	always #10 clk2=~clk2;

	uart_if if0(clk1);
	uart_if if1(clk2);

	wire TXD;
	wire RXD;

	uart_16550 UART1(.PCLK(clk1),
  			.PRESETn(if0.Presetn),
  			.PADDR(if0.Paddr),
  			.PWDATA(if0.Pwdata),
  			.PRDATA(if0.Prdata),
  			.PWRITE(if0.Pwrite),
  			.PENABLE(if0.Penable),
  			.PSEL(if0.Psel),
  			.PREADY(if0.Pready),
  			.PSLVERR(if0.Pslverr),
			.IRQ(if0.IRQ),
   			.TXD(TXD),
  			.RXD(RXD),
  			.baud_o(if0.baud_o));

	uart_16550 UART2(.PCLK(clk2),
  			.PRESETn(if1.Presetn),
  			.PADDR(if1.Paddr),
  			.PWDATA(if1.Pwdata),
  			.PRDATA(if1.Prdata),
  			.PWRITE(if1.Pwrite),
  			.PENABLE(if1.Penable),
  			.PSEL(if1.Psel),
  			.PREADY(if1.Pready),
  			.PSLVERR(if1.Pslverr),
			.IRQ(if1.IRQ),
   			.TXD(RXD),
  			.RXD(TXD),
  			.baud_o(if1.baud_o));


	
	initial 
		begin

			`ifdef VCS
        	 	$fsdbDumpvars(0, top);
        		`endif

			uvm_config_db#(virtual uart_if)::set(null,"*","if0",if0);
			uvm_config_db#(virtual uart_if)::set(null,"*","if1",if1);

			run_test();
		end
		
endmodule
