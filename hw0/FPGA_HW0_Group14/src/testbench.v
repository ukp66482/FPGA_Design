`timescale 1ns/10ps

module testbench;

//----------Type declaration----------//
    reg clk;
    reg rst;
    reg en;
    reg [23:0] central;
    reg [11:0] radius;
    reg [1:0] mode;
    wire busy;
    wire valid;
    wire [7:0]candidate;
    
    integer i;
    integer counter;
    reg [23:0] central_mem [0:3];
    reg [11:0] radius_mem [0:3];
    reg [1:0] mode_mem [0:3];
    reg [7:0] answer_mem [0:3];
	
//----------Module instance----------//
    SET SET0(clk ,rst, en, central, radius, mode, busy, valid, candidate);
	
//----------Stimulus----------//
    //clock signal, period = 10ns
    always begin
        #5 clk = ~clk;
    end
	
    always begin
        if(counter == 10000) begin
            $display("Running is out of time...");
            $finish;
        end
        #10 counter = counter + 1;
    end

    // initial begin
    //     $fsdbDumpfile("SET.fsdb");
    //     $fsdbDumpvars(0);
    // end
	
    initial begin
        clk = 1'b1;
        rst = 1'b0;
        en = 1'b0;
        central = 24'd0;
        radius = 12'd0;
        mode = 2'd0;
        counter = 0;
        
        central_mem[0] = 24'h550000;
        central_mem[1] = 24'h553300;
        central_mem[2] = 24'h553300;
        central_mem[3] = 24'h553362;
        radius_mem[0] = 12'h300;
        radius_mem[1] = 12'h330;
        radius_mem[2] = 12'h330;
        radius_mem[3] = 12'h332;
        mode_mem[0] = 2'b00;
        mode_mem[1] = 2'b01;
        mode_mem[2] = 2'b10;
        mode_mem[3] = 2'b11;
        answer_mem[0] = 8'd29;
        answer_mem[1] = 8'd13;
        answer_mem[2] = 8'd30;
        answer_mem[3] = 8'd14;

        //reset the SET module
        #5 rst = 1'b1;
        #10 rst = 1'b0;
        
        for(i = 0 ; i < 4 ; i = i + 1) begin
            //transmit the signal about central, radius, and mode
            if(i == 0) #1;
            wait(busy == 1'b0) begin
                @(negedge clk) begin
                    en = 1'b1;
                    central = central_mem[i];
                    radius = radius_mem[i];
                    mode = mode_mem[i];
                end
            end
		
            #10 
            en = 1'b0;
            central = 24'd0;
            radius = 12'd0;
            mode = 2'd0;

            wait(valid == 1'b1) begin
                @(negedge clk) begin
                    if(candidate == answer_mem[i]) begin
                        $display("Mode %d is correct!", i);
                    end
                    else begin
                        $display("Mode %d is wrong...", i);
                    end
                end
            end

            if(i == 3) begin
                $finish;
            end
        end
    end
	
endmodule