class test extends uvm_test;

	`uvm_component_utils(test)
	
	function new(string name="test",uvm_component parent);
		super.new(name,parent);
	endfunction

	env envh;

	env_config env_cfg;
	agent_config agt_cfg[];
	
	int no_of_agents=2;

	function void build_phase(uvm_phase phase);
		env_cfg=env_config::type_id::create("env_cfg");
		env_cfg.agt_cfg=new[no_of_agents];

		agt_cfg=new[no_of_agents];
	
		foreach(agt_cfg[i])
			begin
				agt_cfg[i]=agent_config::type_id::create($sformatf("agt_cfg[%0d]",i));
				if(!uvm_config_db#(virtual uart_if)::get(this,"",$sformatf("if%0d",i),agt_cfg[i].vif))
					`uvm_fatal("TEST","get() failed virtual interface");
				agt_cfg[i].is_active=UVM_ACTIVE;
		env_cfg.agt_cfg[i]=agt_cfg[i];
	
			end

	
		env_cfg.no_of_agents=no_of_agents;


		uvm_config_db#(env_config)::set(this,"*","env_config",env_cfg);
		
		envh=env::type_id::create("envh",this);
		
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
	
endclass

//--------------------half dulpex--------------------111111111111

class full_duplex_test extends test;

	`uvm_component_utils(full_duplex_test)

	function new(string name="full_duplex_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	full_duplex_seq1 seq1;
	full_duplex_seq2 seq2;

	task run_phase(uvm_phase phase);

		seq1=full_duplex_seq1::type_id::create("seq1");
		seq2=full_duplex_seq2::type_id::create("seq2");

		phase.raise_objection(this);

		fork
			seq1.start(envh.agt_top.agth[0].seqrh);
			seq2.start(envh.agt_top.agth[1].seqrh);

		join
		#100;
		phase.drop_objection(this);

	endtask
endclass

//--------------------half dulpex--------------------222222222222

class half_duplex_test extends test;

	`uvm_component_utils(half_duplex_test)

	function new(string name="half_duplex_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	half_duplex_seq1 seq3;
	half_duplex_seq2 seq4;

	task run_phase(uvm_phase phase);

		seq3=half_duplex_seq1::type_id::create("seq3");
		seq4=half_duplex_seq2::type_id::create("seq4");

		phase.raise_objection(this);

		fork
			seq3.start(envh.agt_top.agth[0].seqrh);
			seq4.start(envh.agt_top.agth[1].seqrh);

		join
		#100;
		phase.drop_objection(this);

	endtask
endclass

//----------------loop back mode-----------------------3333333333333333

class loop_back_test extends test;

	`uvm_component_utils(loop_back_test)

	function new(string name="loop_back_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	loop_back_seq1 seq5;
	loop_back_seq2 seq6;

	task run_phase(uvm_phase phase);

		seq5=loop_back_seq1::type_id::create("seq5");
		seq6=loop_back_seq2::type_id::create("seq6");

		phase.raise_objection(this);

		fork
			seq5.start(envh.agt_top.agth[0].seqrh);
			seq6.start(envh.agt_top.agth[1].seqrh);

		join
		#100;
		phase.drop_objection(this);

	endtask
endclass

//----------------parity error -----------------------444444444444444

class parity_error_test extends test;

	`uvm_component_utils(parity_error_test)

	function new(string name="parity_error_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	parity_seq1 seq7;
	parity_seq2 seq8;

	task run_phase(uvm_phase phase);

		seq7=parity_seq1::type_id::create("seq7");
		seq8=parity_seq2::type_id::create("seq8");

		phase.raise_objection(this);

		fork
			seq7.start(envh.agt_top.agth[0].seqrh);
			seq8.start(envh.agt_top.agth[1].seqrh);

		join
		#100;
		phase.drop_objection(this);

	endtask
endclass


//----------------Framing error -----------------------5555555555555

class framing_error_test extends test;

	`uvm_component_utils(framing_error_test)

	function new(string name="framing_error_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	framing_seq1 seq9;
	framing_seq2 seq10;

	task run_phase(uvm_phase phase);

		seq9=framing_seq1::type_id::create("seq9");
		seq10=framing_seq2::type_id::create("seq10");

		phase.raise_objection(this);

		fork
			seq9.start(envh.agt_top.agth[0].seqrh);
			seq10.start(envh.agt_top.agth[1].seqrh);

		join
		#100;
		phase.drop_objection(this);

	endtask
endclass

//----------------overrun error -----------------------666666666666666

class over_run_error_test extends test;

	`uvm_component_utils(over_run_error_test)

	function new(string name="over_run_error_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	over_run_seq1 seq11;
	over_run_seq2 seq12;

	task run_phase(uvm_phase phase);

		seq11=over_run_seq1::type_id::create("seq11");
		seq12=over_run_seq2::type_id::create("seq12");

		phase.raise_objection(this);

		fork
			seq11.start(envh.agt_top.agth[0].seqrh);
			seq12.start(envh.agt_top.agth[1].seqrh);

		join
		#100;
		phase.drop_objection(this);

	endtask
endclass


//----------------break error -----------------------777777777777777777

class break_error_test extends test;

	`uvm_component_utils(break_error_test)

	function new(string name="break_error_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	break_error_seq1 seq13;
	break_error_seq2 seq14;

	task run_phase(uvm_phase phase);

		seq13=break_error_seq1::type_id::create("seq13");
		seq14=break_error_seq2::type_id::create("seq14");

		phase.raise_objection(this);

		fork
			seq13.start(envh.agt_top.agth[0].seqrh);
			seq14.start(envh.agt_top.agth[1].seqrh);

		join
		#100;
		phase.drop_objection(this);

	endtask
endclass


//----------------THR EMPTY error -----------------------88888888888888

class thr_empty_test extends test;

	`uvm_component_utils(thr_empty_test)

	function new(string name="thr_empty_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	thr_empty_seq1 seq15;
	thr_empty_seq2 seq16;

	task run_phase(uvm_phase phase);

		seq15=thr_empty_seq1::type_id::create("seq15");
		seq16=thr_empty_seq2::type_id::create("seq16");

		phase.raise_objection(this);

		fork
			seq15.start(envh.agt_top.agth[0].seqrh);
			seq16.start(envh.agt_top.agth[1].seqrh);

		join
		#100;
		phase.drop_objection(this);

	endtask
endclass

//----------------Time out error -----------------------999999999999

class timeout_error_test extends test;

	`uvm_component_utils(timeout_error_test)

	function new(string name="timeout_error_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	timeout_seq1 seq17;
	timeout_seq2 seq18;

	task run_phase(uvm_phase phase);

		seq17=timeout_seq1::type_id::create("seq17");
		seq18=timeout_seq2::type_id::create("seq18");

		phase.raise_objection(this);

		fork
			seq17.start(envh.agt_top.agth[0].seqrh);
			seq18.start(envh.agt_top.agth[1].seqrh);

		join
		#100;
		phase.drop_objection(this);

	endtask
endclass



