class sb extends uvm_scoreboard;

	`uvm_component_utils(sb)
	
	uvm_tlm_analysis_fifo #(xtn) sb_fifo_0; 
	uvm_tlm_analysis_fifo #(xtn) sb_fifo_1; 


	xtn xtn0, xtn1;

	
	function new(string name="sb",uvm_component parent);
		super.new(name,parent);
		sb_fifo_0 = new("sb_fifo_0");
		sb_fifo_1 = new("sb_fifo_1");

	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		xtn0 = xtn::type_id::create("xtn0");
		xtn1 = xtn::type_id::create("xtn1");
	endfunction
		
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever 
			fork
				begin 
	
					sb_fifo_0.get(xtn0);
					//`uvm_info("SCOREBOARD","Printing from SEQ1",UVM_LOW);

					//xtn0.print();
				end
				begin 
					sb_fifo_1.get(xtn1);
					//`uvm_info("SCOREBOARD","Printing from SEQ2",UVM_LOW);
					
					//xtn1.print();
				end
			join

	endtask
	
	function void check_phase(uvm_phase phase);
		$display("uart1 THR size : %d",xtn0.THR.size);
		$display("uart2 RBR size : %d",xtn1.RBR.size);

		$display("uart2 THR size : %d",xtn1.THR.size);
		$display("uart1 RBR size : %d",xtn0.RBR.size);
		

		$display("uart1 THR : %p",xtn0.THR);
		$display("uart2 RBR : %p",xtn1.RBR);

		$display("uart2 THR : %p",xtn1.THR);
		$display("uart1 RBR : %p",xtn0.RBR);
		
		$display("IIR xtn 1 --------------  %b",xtn0.IIR[3:0]);
		$display("IIR xtn 2--------------  %b",xtn1.IIR[3:0]);
		
		$display("LSR xtn 1---------------%b",xtn0.LSR);
		$display("LSR xtn 2---------------%b",xtn1.LSR);
		
				
		if((xtn0.IIR[3:0] == 4'b0100) || (xtn1.IIR[3:0] == 4'b0100))
			begin 
				if ((xtn0.MCR[4] == 1) || (xtn1.MCR[4] ==1))
					begin 
						if(((xtn0.THR.size > 0) && (xtn0.RBR.size > 0)) || ((xtn1.THR.size > 0) && (xtn1.RBR.size > 0)))
							begin 
								if((xtn0.THR == xtn0.RBR)  || (xtn1.THR ==xtn1.RBR))
									begin 
										`uvm_info(get_type_name(),"\n COMPARISION PASSED FOR LOOP BACK ",UVM_LOW);
									end
								else
									begin 
										`uvm_info(get_type_name(),"\n COMPARISION FAILED FOR LOOP BACK ",UVM_LOW);
									
									end
				
							end
					end

				else if((xtn0.MCR[4] == 0) || (xtn1.MCR[4] == 0))
					begin 
						if(((xtn0.THR.size == 0) || (xtn1.THR.size == 0)) && ((xtn0.RBR.size == 0) || (xtn1.RBR.size == 0)))
							begin 
								if((xtn0.THR == xtn1.RBR) || (xtn1.THR == xtn0.RBR))
									begin 
										`uvm_info(get_type_name(),"\n COMPARISION PASSED FOR HALF DUPLEX",UVM_LOW);
									end
								else
									begin 
										`uvm_info(get_type_name(),"\n COMPARISION FAILED FOR HALF DUPLEX",UVM_LOW);
									end
							end
						else
							begin
								if((xtn0.THR == xtn1.RBR) && (xtn1.THR == xtn0.RBR))
									begin
										`uvm_info(get_type_name(),"\n COMPARISION PASSED FOR FULL DUPLEX",UVM_LOW);
									end
								else
									begin
										`uvm_info(get_type_name(),"\n COMPARISION FAILED FOR FULL DUPLEX",UVM_LOW);
									end

							end
					end
			end
		else if((xtn0.IIR[3:1] ==3 ) || (xtn1.IIR[3:1] == 3))
			begin 
				if((xtn0.LSR[2] == 1) || (xtn1.LSR[2] == 1))
							begin 
									`uvm_info(get_type_name(),"\n COMPARISION PASSED FOR PARITY ERROR ",UVM_LOW);
							end
				else
							begin 
									`uvm_info(get_type_name(),"\n COMPARISION FAILED FOR PARITY ERROR",UVM_LOW);
							end
			

				if((xtn0.LSR[3] == 1)||(xtn1.LSR[3] == 1))
							begin 
									`uvm_info(get_type_name(),"\n\n COMPARISION PASSED FOR FRAMING ERROR",UVM_LOW);
							end
				else
							begin
									`uvm_info(get_type_name(),"\n\n COMPARISION FAILED FOR FRAMING ERROR",UVM_LOW);
							end
				if((xtn0.LSR[4] == 1)||(xtn1.LSR[4] == 1))
							begin 
									`uvm_info(get_type_name(),"\n\n BREAK INTERRUPT OCCURED",UVM_LOW);
							end
				else
							begin
									`uvm_info(get_type_name(),"\n\n BREAK INTERRUPT NOT OCCURED",UVM_LOW);
							end

				if((xtn0.LSR[1] == 1)||(xtn1.LSR[1] == 1))
							begin 
									`uvm_info(get_type_name(),"\n\n OVERRUN ERROR OCCURED",UVM_LOW);
							end
				else
							begin
									`uvm_info(get_type_name(),"\n\n OVERRUN ERROR NOT OCCURED",UVM_LOW);
							end

			end

					
		else if((xtn0.IIR[3:1] == 3'b110) || (xtn1.IIR[3:1] == 3'b110))
			begin 
				//if((xtn0.IIR[3:0] == 4'b1100) || (xtn1.IIR[3:0] == 4'b1100))
					begin 
						`uvm_info(get_type_name(),"\n\n TIMEOUT ERROR OCCURED",UVM_LOW);
					end
				/*else
					begin 	
						`uvm_info(get_type_name(),"\n\n TIMEOUT ERROR NOT OCCURED",UVM_LOW);
					end*/
			end


		else if((xtn0.IIR[3:1] == 1) || (xtn1.IIR[3:1] == 1))
			
					begin
						`uvm_info(get_type_name(),"\n\n THR FIFO EMPTY OCCURED",UVM_LOW);
					end

				
	//if((xtn0.THR.size==0)&&(xtn1.THR.size==0)) $display("NO DATA IN THR1 AND THR2. SOMETHING WENT WRONG. \n");



	endfunction 



endclass



