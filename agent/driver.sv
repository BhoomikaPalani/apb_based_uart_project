class driver extends uvm_driver#(xtn);

	`uvm_component_utils(driver)

	virtual uart_if.DRV_MP vif;

	agent_config agt_cfg;
	
	function new(string name="driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(agent_config)::get(this,"","agent_config",agt_cfg))
			`uvm_fatal("DRIVER","get() failed for agt_cfg");
	//$display("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa %p",agt_cfg);
	endfunction

	function void connect_phase(uvm_phase phase);
		vif=agt_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);

	@(vif.drv_cb);
	vif.drv_cb.Presetn<=1'b0;
	@(vif.drv_cb);
	vif.drv_cb.Presetn<=1'b1;

		forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
				

			end
	endtask

	task send_to_dut(xtn req);
		
			@(vif.drv_cb);
			vif.drv_cb.Paddr<=req.paddr;
			vif.drv_cb.Pwdata<=req.pwdata;
			vif.drv_cb.Pwrite<=req.pwrite;
			vif.drv_cb.Psel<=1'b1;
			vif.drv_cb.Penable<=1'b0;
			
			@(vif.drv_cb);
			vif.drv_cb.Penable<=1'b1;
			
			while(vif.drv_cb.Pready!==1'b1)
				@(vif.drv_cb);
				
			if(req.paddr==32'h8 && req.pwrite==0)//IIR
				begin
				
					while(vif.drv_cb.IRQ!==1)
					@(vif.drv_cb);
				
					req.IIR=vif.drv_cb.Prdata;
					seq_item_port.put_response(req);
				end
			@(vif.drv_cb);
    			vif.drv_cb.Psel<=1'b0;

		`uvm_info("DRIVER",$sformatf("DATA FROM DRIVER \n %s",req.sprint()),UVM_LOW);

	endtask

endclass



