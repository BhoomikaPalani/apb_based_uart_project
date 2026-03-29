class agent_top extends uvm_env;

	`uvm_component_utils(agent_top)

	agent agth[]; 

	env_config env_cfg;
	agent_config agt_cfg[];

	function new(string name="agent_top",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(env_config)::get(this,"","env_config",env_cfg))
			`uvm_fatal("ENV","get() failed for env_config");

		agth=new[env_cfg.no_of_agents];
				
			foreach(agth[i])
				begin
					agth[i]=agent::type_id::create($sformatf("agth[%0d]",i),this);
					agt_cfg[i]=agent_config::type_id::create($sformatf("agt_config[%0d]",i));
					uvm_config_db#(agent_config)::set(this,$sformatf("agth[%0d]*",i),"agent_config",env_cfg.agt_cfg[i]);
				end
	endfunction

endclass

				


	


