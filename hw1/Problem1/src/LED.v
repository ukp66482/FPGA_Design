
module LED(
    input   clk ,
    input   rst ,
    input   [1:0] sw    ,
    output  reg     [2:0] led
    );
    
    always@(posedge clk or posedge rst)begin
        if(rst) begin
            led <= 3'b111;
        end
        else begin
            case(sw)
                2'b00:  led <= 3'b111;
                2'b01:  led <= 3'b100;
                2'b10:  led <= 3'b010;
                2'b11:  led <= 3'b110;
                default : led <= 3'b111;
            endcase
        end
    end 
    
endmodule
