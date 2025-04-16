module rgb_fsm (
    input clk,
    input rst,
    input [1:0] sw,
    output reg R_continuous,
    output reg G_continuous,
    output reg B_continuous
);

    reg [7:0] counter;
    reg [7:0] red_duty_long;   // Red channel duty cycle
    reg [7:0] green_duty_long; // Green channel duty cycle
    reg [7:0] blue_duty_long;   // Blue channel duty cycle

    always @( * ) begin
        case (sw)
            2'b00: begin // Dark Violet #9400D3
                red_duty_long   = 8'h94;
                green_duty_long = 8'd0;
                blue_duty_long  = 8'hD3;
            end
            2'b01: begin // Medium Blue #0000CD
                red_duty_long   = 8'd0;
                green_duty_long = 8'd0;
                blue_duty_long  = 8'hCD;
            end
            2'b10: begin // Goldenrod #DAA520
                red_duty_long    = 8'hDA;
                green_duty_long  = 8'hA5;
                blue_duty_long   = 8'h20;
            end
            2'b11: begin // Orange Red #FF4500
                red_duty_long   = 8'hFF;
                green_duty_long = 8'h45;
                blue_duty_long  = 8'd0;
            end
            default: begin
                red_duty_long   = 8'd255;
                green_duty_long = 8'd255;
                blue_duty_long  = 8'd255;
            end
        endcase
    end

    always @ (posedge clk or posedge rst) begin
        if(rst) begin
            counter <= 8'd0;
        end else begin
            counter <= counter + 8'd1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            R_continuous <= 1'b1;
            G_continuous <= 1'b1;
            B_continuous <= 1'b1;
        end else begin
            R_continuous <= (counter < red_duty_long) ? 1'b1 : 1'b0;
            G_continuous <= (counter < green_duty_long) ? 1'b1 : 1'b0;
            B_continuous <= (counter < blue_duty_long) ? 1'b1 : 1'b0;
        end
    end

endmodule
