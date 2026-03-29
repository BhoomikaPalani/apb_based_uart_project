class monitor extends uvm_monitor;

	`uvm_component_utils(monitor)
	
	virtual uart_if.MON_MP vif;
	xtn xtns;

	uvm_analysis_port #(xtn) mon_ap;

	agent_config agt_cfg;
	
	function new(string name="monitor",uvm_component parent);
		super.new(name,parent);
		mon_ap = new("mon_ap",this);
	endfunction

	function void build_phase(uvm_phase phase);

		if(!uvm_config_db#(agent_config)::get(this,"","agent_config",agt_cfg))
			`uvm_fatal("MONITOR","get() failed for agt_cfg");
	xtns=xtn::type_id::create("xtns");
			
	endfunction

	function void connect_phase(uvm_phase phase);
		vif=agt_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		
		forever
			begin
			collect_data();
			mon_ap.write(xtns);
			end
			
	endtask

//while(condition) -->until the condition is true, the next line of code is executed,if condition fails exits the while loop 

task collect_data();
	
	@(vif.mon_cb);

	while(vif.mon_cb.Psel!==1)
		@(vif.mon_cb);

	begin 
		while(vif.mon_cb.Pready!==1)
		@(vif.mon_cb);
      // xtns.presetn=vif.mon_cb.Presetn;
       xtns.paddr=vif.mon_cb.Paddr;
       xtns.pwdata=vif.mon_cb.Pwdata;
       xtns.pwrite=vif.mon_cb.Pwrite;
       xtns.prdata=vif.mon_cb.Prdata;
       //xtns.pslaverr=vif.mon_cb.Pslverr;
       xtns.psel=vif.mon_cb.Psel;
       xtns.penable=vif.mon_cb.Penable;
       xtns.IRQ=vif.mon_cb.IRQ;

	@(vif.mon_cb);

       //updating LCR
       if(xtns.paddr==32'hc  && xtns.pwrite == 1'b1 )  
         xtns.LCR = xtns.pwdata;

       //updating IER
       if(xtns.paddr==32'h4  && xtns.pwrite == 1'b1 ) 
         xtns.IER = xtns.pwdata;
       //updating FCR
       if(xtns.paddr==32'h8  && xtns.pwrite == 1'b1 ) 
         xtns.FCR = xtns.pwdata;
       //updating IIR
       if(xtns.paddr==32'h8  && xtns.pwrite == 1'b0 ) 
         begin
           while(vif.mon_cb.IRQ!==1)
				@(vif.mon_cb);
           xtns.IIR = vif.mon_cb.Prdata;

         end
       //updating MCR
       if(xtns.paddr==32'h10  && xtns.pwrite == 1'b1 ) 
         xtns.MCR = xtns.pwdata;

       //updating LSR
       if(xtns.paddr==32'h14  && xtns.pwrite == 1'b0 ) 
         xtns.LSR = xtns.prdata;

       //updating DIVISOR REGISTER 1
       if(xtns.paddr==32'h1c  && xtns.pwrite == 1'b1 ) 
             begin
           xtns.DIV1[7:0] = xtns.pwdata;
           xtns.d1_access=1'b1;
         end

      //updating DIVISOR REGISTER 2
      if(xtns.paddr==32'h20  && xtns.pwrite == 1'b1 ) 
        begin
          xtns.DIV1[15:8] = xtns.pwdata;
          xtns.d1_access=1'b1;
        end

      //updating THR
      if(xtns.paddr==32'h0  && xtns.pwrite == 1'b1  ) 
        begin
          xtns.data_in_thr=1'b1;
          xtns.THR.push_back(xtns.pwdata);

        end
      //updating RBR
      if(xtns.paddr==32'h0  && xtns.pwrite == 1'b0  ) 
        begin
          xtns.data_in_rbr=1'b1;
          xtns.RBR.push_back(xtns.prdata);
        end
    
 end
 	`uvm_info("APB MONITOR","PRINTING FROM MONITOR",UVM_LOW)
	//	xtns.print;
 		mon_ap.write(xtns);

endtask

/*
	task collect_data();

		
		@(vif.mon_cb);
		while(vif.mon_cb.Psel!==1)
			@(vif.mon_cb);
	
			while(vif.mon_cb.Pready!==1)
				@(vif.mon_cb);

			//xtns.presetn=vif.mon_cb.Presetn;
			xtns.paddr=vif.mon_cb.Paddr;
			xtns.pwdata=vif.mon_cb.Pwdata;
			xtns.pwrite=vif.mon_cb.Pwrite;
			xtns.prdata=vif.mon_cb.Prdata;
			xtns.pready=vif.mon_cb.Pready;
			xtns.pslaverr=vif.mon_cb.Pslverr;
			xtns.psel=vif.mon_cb.Psel;
			xtns.penable=vif.mon_cb.Penable;
			xtns.IRQ=vif.mon_cb.IRQ;
			@(vif.mon_cb);

		//update LCR 
		if(xtns.paddr==32'hc && xtns.pwrite==1'b1)
			begin
			xtns.LCR=xtns.pwdata;
			end

		//update IER
		if(xtns.paddr==32'h04 && xtns.pwrite==1'b1)
			begin
			xtns.IER=xtns.pwdata;
			end


		//update FCR
		if(xtns.paddr==32'h8 && xtns.pwrite==1'b1)
			begin
			xtns.FCR=xtns.pwdata;
			end

		//update IIR
		if(xtns.paddr==32'h8 && xtns.pwrite==1'b0)
			begin
				while(vif.mon_cb.IRQ!=1)
					@(vif.mon_cb);
				xtns.IIR=vif.mon_cb.Prdata;
			end

		//update MCR
		if(xtns.paddr==32'h10 && xtns.pwrite==1'b1)
			begin
			xtns.MCR=xtns.pwdata;
			end

		//update LSR
		if(xtns.paddr==32'h14 && xtns.pwrite== 1'b0)
			begin
			xtns.LSR=vif.mon_cb.Prdata;
			//$display("lllllllllllssssssssssssssssssssrrrrrrrrrrrrrrrrrr");
			end


		//update DIVISOR MSB 
		if(xtns.paddr==32'h20 && xtns.pwrite==1'b1)
			begin
			xtns.DIV1[7:0]=xtns.pwdata;
			xtns.d1_access=1'b1;
			end

		//update DIVISOR LSB 
		if(xtns.paddr==32'h1c && xtns.pwrite==1'b1)
			begin
			xtns.DIV1[15:8]=xtns.pwdata;
			xtns.d1_access=1'b1;
			end

			
		//update THR
		if(xtns.paddr==32'h0 && xtns.pwrite==1'b1)
			begin
				xtns.data_in_thr=1'b1;
				if(xtns.THR.size==0|| xtns.THR[0]!=vif.mon_cb.Pwdata)
				xtns.THR.push_back(vif.mon_cb.Pwdata);
			end
		
		//update RBR
		if(xtns.paddr==32'h0 && xtns.pwrite==1'b0)
			begin
				//$display("rrrrrrrrrrrrrrrrrrrrrrrbbbbbbbbbbbbbbbbbbbbbbbbbbbrrrrrrrrrrrrrrrrrrrrrrrrrrr");
				xtns.data_in_rbr=1'b1;
				if(vif.mon_cb.Prdata!=0)
				xtns.RBR.push_back(vif.mon_cb.Prdata);
			end


				
		`uvm_info("MONITOR",$sformatf("DATA FROM MONITOR \n %s",xtns.sprint()),UVM_LOW);


	endtask
*/



	
endclass
