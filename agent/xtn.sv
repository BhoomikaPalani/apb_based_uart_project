
class xtn extends uvm_sequence_item;

	`uvm_object_utils(xtn)

	function new(string name="xtn");
		super.new(name);
	endfunction

	//APB SIGNALS

	bit presetn;
	rand bit[31:0] paddr;
	bit psel;
	rand bit pwrite;
	bit penable;
	rand bit[31:0] pwdata;
	bit[31:0] prdata;
	bit pready;
	bit pslaverr;

	bit data_in_thr;
	bit data_in_rbr;

	bit d1_access;
//	bit d2_access;

	//Registers

	bit[7:0] THR[$]; //Transmitter Holding Register
	bit[7:0] RBR[$]; //Receiver Buffer Register
	bit[7:0] IER; //interrupt enable register
	bit[7:0] IIR; //interrupt identifaction register
	bit[7:0] FCR; //FIFO control register
	bit[7:0] LCR; //line control register
	bit[7:0] MCR; //modem control register
	bit[7:0] LSR; //Line status register
	bit[7:0] MSR; //modem status register
	bit[15:0] DIV1; //DIV1 LSB
//	bit[7:0] DIV2; //DIV2 MSB

	bit[7:0] IRQ;//uart function signal-->Interrupt request
	
	function void do_print(uvm_printer printer);
	
		printer.print_field("paddr",this.paddr,32,UVM_HEX);
		printer.print_field("presetn",this.presetn,1,UVM_DEC);
		printer.print_field("pwdata",this.pwdata,32,UVM_DEC);
		printer.print_field("prdata",this.prdata,32,UVM_DEC);
		printer.print_field("psel",this.psel,1,UVM_DEC);
		printer.print_field("pwrite",this.pwrite,1,UVM_DEC);
		printer.print_field("penable",this.penable,1,UVM_DEC);
		printer.print_field("pready",this.pready,1,UVM_DEC);
		printer.print_field("pslaverr",this.pslaverr,1,UVM_DEC);

		printer.print_field("FCR",this.FCR,8,UVM_DEC);
		printer.print_field("LCR",this.LCR,8,UVM_DEC);
		printer.print_field("DIV1",this.DIV1,8,UVM_DEC);
	//	printer.print_field("DIV2",this.DIV2,8,UVM_DEC);
		printer.print_field("IER",this.IER,8,UVM_DEC);
		printer.print_field("MSR",this.MSR,8,UVM_DEC);
		printer.print_field("IIR",this.IIR,8,UVM_BIN);
		printer.print_field("IRQ",this.IRQ,8,UVM_DEC);
		printer.print_field("MCR",this.MCR,8,UVM_BIN);
		printer.print_field("LSR",this.LSR,8,UVM_BIN);

		foreach(THR[i])
				begin
				printer.print_field($sformatf("THR[%0d]",i), this.THR[i], $bits(THR[i]), UVM_DEC);
				end
		foreach(RBR[i])
				begin
				printer.print_field($sformatf("RBR[%0d]",i), this.RBR[i], $bits(RBR[i]), UVM_DEC);
				end

		printer.print_field("data_in_thr",this.data_in_thr,1,UVM_DEC);
		printer.print_field("data_in_rbr",this.data_in_rbr,1,UVM_DEC);
		printer.print_field("d1_access",this.d1_access,1,UVM_DEC);
	//	printer.print_field("d2_access",this.d2_access,1,UVM_DEC);
	



	endfunction




	

endclass
