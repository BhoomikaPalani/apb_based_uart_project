class seq extends uvm_sequence#(xtn);

	`uvm_object_utils(seq)

	function new(string name="seq");
		super.new(name);
	endfunction

endclass


//--------------------FULL DUPLEX SEQUENCE------------------------------11111111111111111

class full_duplex_seq1 extends seq;

	`uvm_object_utils(full_duplex_seq1)

	function new(string name="full_duplex_seq1");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==32'h00;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==54;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'hc;pwdata==8'b00000011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h8;pwdata==8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h4;pwdata==8'b00000001;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h00;pwdata==5;});
		finish_item(req);
		
		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;})
		finish_item(req);
		get_response(req);

		if(req.IIR[3:0]==4)
			begin
				//RBR REGISTER
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;})
				finish_item(req);
			end
		if(req.IIR[3:0]==6)
			begin
				//LSR REGISTER
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;})
				finish_item(req);
			end

				

	endtask
endclass


class full_duplex_seq2 extends seq;

	`uvm_object_utils(full_duplex_seq2)

	function new(string name="full_duplex_seq2");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==8'd0;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==27;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'hc;pwdata==8'b00000011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h8;pwdata==8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h4;pwdata==8'b00000001;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h00;pwdata==10;});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end


	endtask
endclass
		
//--------------------HALF DUPLEX SEQUENCE--------------------------------------22222222222222222

class half_duplex_seq1 extends seq;

	`uvm_object_utils(half_duplex_seq1)

	function new(string name="half_duplex_seq1");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==32'h00;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==54;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'hc;pwdata==8'b00000011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h8;pwdata==8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h4;pwdata==8'b00000101;});
		finish_item(req);

		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0;pwdata inside{[1:255]};});
		finish_item(req);
			

	endtask
endclass


class half_duplex_seq2 extends seq;

	`uvm_object_utils(half_duplex_seq2)

	function new(string name="half_duplex_seq2");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==8'd00;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==27;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'hc;pwdata==8'b00000011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h8;pwdata==8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h4;pwdata==8'b00000101;});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end


		endtask	
endclass

//------------------------loop back---------------------------------------33333333333333

class loop_back_seq1 extends seq;

	`uvm_object_utils(loop_back_seq1)

	function new(string name="loop_back_seq1");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==32'h00;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==54;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'hc;pwdata==8'b00000011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h8;pwdata==8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h4;pwdata==8'b00000001;});
		finish_item(req);

		//MCR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h10;pwdata==8'b00010000;});
		finish_item(req);
		
		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0;pwdata inside{[0:255]};});
		finish_item(req);
		
		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end

	endtask
endclass


class loop_back_seq2 extends seq;

	`uvm_object_utils(loop_back_seq2)

	function new(string name="loop_back_seq2");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==8'd00;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==27;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'hc;pwdata==8'b00000011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h8;pwdata==8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h4;pwdata==8'b00000001;});
		finish_item(req);
		
		//MCR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h10;pwdata==8'b00010000;});
		finish_item(req);
		
		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0;pwdata inside{[0:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end


		endtask	
endclass

//------------------------Parity sequence---------------------------------------44444444444444444444


/*class parity_seq1 extends seq;

	`uvm_object_utils(parity_seq1)

	function new(string name="parity_seq1");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==32'h00;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==54;});
		finish_item(req);

		//LCR - NORMAL MODE 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'hC;pwdata==8'b00011011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h8;pwdata==8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h4;pwdata==8'b00000101;});
		finish_item(req);

		
		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0;pwdata inside{[1:255]};});
		finish_item(req);
		
		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end

	endtask
endclass


class parity_seq2 extends seq;

	`uvm_object_utils(parity_seq2)

	function new(string name="parity_seq2");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==8'd00;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==27;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'hC;pwdata==8'b00001011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h8;pwdata==8'b00000110;});
		finish_item(req);

		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h4;pwdata==8'b00000101;});
		finish_item(req);
	
		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0;pwdata inside{[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end


		endtask	
endclass*/

class parity_seq1 extends seq ;

`uvm_object_utils(parity_seq1)

function new(string name="parity_seq1");
    super.new(name);
endfunction

task body();
                //transmit sequence
    
        begin
            req=xtn::type_id::create("req");

            //DIV1 MSB 
            start_item(req);
            assert(req.randomize with { paddr==32'h20;pwrite==1;pwdata==0;});
            finish_item(req);

            //DIV2 LSB 
            start_item(req);
            assert(req.randomize with { paddr==32'h1c;pwrite==1;pwdata==54;});
            finish_item(req);
  	    	
	    //NORMAL_MODE_LCR
            start_item(req);
            assert(req.randomize with { paddr==32'h0c;pwrite==1;pwdata==8'b00001011;});
            finish_item(req);
     
            //IER
            start_item(req);
            assert(req.randomize with { paddr==32'h04;pwrite==1;pwdata==8'b00000101;}); 
            finish_item(req);
            //FCR
            start_item(req);
            assert(req.randomize with { paddr==32'h08;pwrite==1;pwdata==8'b00000110;}); 
            finish_item(req);                         

            //THR
            start_item(req);
            assert(req.randomize with { paddr==32'h00;pwrite==1;pwdata inside {[1:255]};});
            finish_item(req);
            
            //IIR
            start_item(req);               
            assert(req.randomize with { paddr==32'h08;pwrite==0;});    
            finish_item(req);
            get_response(req);

       
            if(req.IIR[3:0] == 4)       
            	begin
            	start_item(req);
            	assert(req.randomize with { paddr==32'h00;pwrite==0;});
            	finish_item(req);
            	end 

            if(req.IIR[3:0] == 4'h6)
		begin
		start_item(req);
		assert(req.randomize with{paddr==32'h14; pwrite==0;});
		finish_item(req);
		end
	end
endtask
endclass


////////////////////////////////////////////////////////////////////////////////////
class parity_seq2 extends seq ;

`uvm_object_utils(parity_seq2)

function new(string name="parity_seq2");
    super.new(name);
endfunction

task body();
                        //receive sequence
    
        begin
            req=xtn::type_id::create("req");

            //DIV1 MSB            
	    start_item(req);
            assert(req.randomize with { paddr==32'h20;pwrite==1;pwdata==0;});
            finish_item(req);

            //DIV2 LSB 
            start_item(req);
            assert(req.randomize with { paddr==32'h1c;pwrite==1;pwdata==27;});
            finish_item(req);

            //NORMAL_MODE_LCR 
            start_item(req);
            assert(req.randomize with { paddr==32'h0c;pwrite==1;pwdata==8'b00011111;});
            finish_item(req);                                            
                    
                                            
            //IER
            start_item(req);
            assert(req.randomize with { paddr==32'h04;pwrite==1;pwdata==8'b00000101;}); 
            finish_item(req); 
                                                                                       
 	    //FCR
            start_item(req);
            assert(req.randomize with { paddr==32'h08;pwrite==1;pwdata==8'b00000110;});                                                           
	    finish_item(req);
                                                                                     
            //THR
            start_item(req);
            assert(req.randomize with { paddr==32'h00;pwrite==1;pwdata inside {[1:255]};});
            finish_item(req);
         
            //IIR
            start_item(req);               
            assert(req.randomize with { paddr==32'h08;pwrite==0;});    
            finish_item(req);
            get_response(req);

               
            if(req.IIR[3:0] == 4)       
            	begin
            	start_item(req);
            	assert(req.randomize with { paddr==32'h00;pwrite==0;});
            	finish_item(req);
    	    	end

            if(req.IIR[3:0] == 4'h6)
		begin
		start_item(req);
		assert(req.randomize with{paddr==32'h14; pwrite==0;});
		finish_item(req);
                end
         end
        
endtask
endclass



//------------------------Framing sequence---------------------------------------555555555555555


class framing_seq1 extends seq;

	`uvm_object_utils(framing_seq1)

	function new(string name="framing_seq1");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==32'h1;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==32'h46;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0c;pwdata==8'b01000011;});
		finish_item(req);

        //FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h08;pwdata==32'h6;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h04;pwdata==8'b00000100;});
		finish_item(req);

				
		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h00;pwdata inside{[1:255]};});
		finish_item(req);
		
		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end

	endtask
endclass


class framing_seq2 extends seq;

	`uvm_object_utils(framing_seq2)

	function new(string name="framing_seq2");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==32'h2;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==32'h8c;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0c;pwdata==8'b00000000;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h08;pwdata==32'h6;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h04;pwdata==8'b00000100;});
		finish_item(req);
		
		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h00;pwdata inside{[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end


		endtask	
endclass


//------------------------Overrun error sequence---------------------------------------66666666666666


class over_run_seq1 extends seq;

	`uvm_object_utils(over_run_seq1)

	function new(string name="over_run_seq1");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==0;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata== 54;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0c;pwdata==8'b00000011;});
		finish_item(req);

        	//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h08;pwdata==8'b11000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h04;pwdata==8'b00000100;});
		finish_item(req);

				
		//THR
		repeat(17)
		begin
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h00;});
		finish_item(req);
		end
		
		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end

	endtask
endclass


class over_run_seq2 extends seq;

	`uvm_object_utils(over_run_seq2)

	function new(string name="over_run_seq2");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==0;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==27;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0c;pwdata==8'b00000011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h08;pwdata==8'b11000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h04;pwdata==8'b00000100;});
		finish_item(req);
		
		//THR
		repeat(17)
		begin
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h00;});
		finish_item(req);
		end

		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end


		endtask	
endclass

//------------------------Break error sequence---------------------------------------777777777777


class break_error_seq1 extends seq;

	`uvm_object_utils(break_error_seq1)

	function new(string name="break_error_seq1");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==32'h1;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata== 32'h46;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0c;pwdata==8'b01000011;});
		finish_item(req);

        	//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h08;pwdata==32'h6;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h04;pwdata==8'b00000101;});
		finish_item(req);

				
		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h00;pwdata inside{[1:255]};});
		finish_item(req);
		
		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end

	endtask
endclass


class break_error_seq2 extends seq;

	`uvm_object_utils(break_error_seq2)

	function new(string name="break_error_seq2");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==32'h2;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==32'h8c;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0c;pwdata==8'b01000011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h08;pwdata==32'h6;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h04;pwdata==8'b00000101;});
		finish_item(req);
		
		//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h00;pwdata inside{[1:255]};});
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end


		endtask	
endclass


//------------------------THR EMPTY sequence---------------------------------------888888888888888


class thr_empty_seq1 extends seq;

	`uvm_object_utils(thr_empty_seq1)

	function new(string name="thr_empty_seq1");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==0;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata== 54;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0c;pwdata==8'b00000011;});
		finish_item(req);

        //FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h08;pwdata==8'b11000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h04;pwdata==8'b00000010;});
		finish_item(req);

				
	/*	//THR
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h00;});
		finish_item(req);
	*/	
		
		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end

	endtask
endclass


class thr_empty_seq2 extends seq;

	`uvm_object_utils(thr_empty_seq2)

	function new(string name="thr_empty_seq2");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==0;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==27;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0c;pwdata==8'b00000011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h08;pwdata==8'b11000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h04;pwdata==8'b00000010;});
		finish_item(req);
		
		
		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end


		endtask	
endclass


//------------------------Time-out error  sequence---------------------------------------99999999999999999


class timeout_seq1 extends seq;

	`uvm_object_utils(timeout_seq1)

	function new(string name="timeout_seq1");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==0;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata== 54;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0c;pwdata==8'b00001011;});
		finish_item(req);

        //FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h08;pwdata==8'b10000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h04;pwdata==8'b00000000;});
		finish_item(req);

				
		//THR
		start_item(req);
		repeat(17)
		begin
			assert(req.randomize() with {pwrite==1;paddr==32'h00;});
		end
		finish_item(req);
		
		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end

	endtask
endclass


class timeout_seq2 extends seq;

	`uvm_object_utils(timeout_seq2)

	function new(string name="timeout_seq2");
		super.new(name);
	endfunction

	task body();
		req=xtn::type_id::create("req");
		
		//DIV MSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h20;pwdata==0;});
		finish_item(req);

		//DIV LSB
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h1c;pwdata==27;});
		finish_item(req);

		//LCR - NORMAL MODE
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h0c;pwdata==8'b00001011;});
		finish_item(req);

		//FCR 
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h08;pwdata==8'b11000110;});
		finish_item(req);


		//IER
		start_item(req);
		assert(req.randomize() with {pwrite==1;paddr==32'h04;pwdata==8'b00000000;});
		finish_item(req);
		
		//THR
		start_item(req);
		repeat(17)
			begin
				assert(req.randomize() with {pwrite==1;paddr==32'h00;});
			end
		finish_item(req);

		//IIR
		start_item(req);
		assert(req.randomize() with {pwrite==0;paddr==32'h08;});
		finish_item(req);
		get_response(req);

		//RBR
		if(req.IIR[3:0]==4)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h00;});
				finish_item(req);
			end
	
		//LSR
		if(req.IIR[3:0]==6)
			begin
				start_item(req);
				assert(req.randomize() with {pwrite==0;paddr==32'h14;});
				finish_item(req);
			end


		endtask	
endclass


