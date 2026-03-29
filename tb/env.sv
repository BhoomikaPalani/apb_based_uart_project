class env extends uvm_env;

	`uvm_component_utils(env);
	
	function new(string name="env",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	agent_top agt_top;
	env_config env_cfg;
	sb sbh;
	
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal("ENV","get() failed for env_config");
			
		if(env_cfg.has_agent)
			agt_top=agent_top::type_id::create("agt_top",this);

		if(env_cfg.has_sb)
			sbh=sb::type_id::create("sbh",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		agt_top.agth[0].monh.mon_ap.connect(sbh.sb_fifo_0.analysis_export);
		agt_top.agth[1].monh.mon_ap.connect(sbh.sb_fifo_1.analysis_export);
	endfunction
	
endclass
	
