class env_config extends uvm_object;

	`uvm_object_utils(env_config)
	
	function new(string name="env_config");
		super.new(name);
	endfunction
	
	bit has_sb=1;
	bit has_agent=1;
	uvm_active_passive_enum is_active=UVM_ACTIVE;
	int no_of_agents=2;

	agent_config agt_cfg[];
	
endclass
