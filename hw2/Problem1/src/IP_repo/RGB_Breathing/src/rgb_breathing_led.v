module rgb_breathing_led (
    input clk,
    input rst,
    input [1:0] sw,
    output reg R_breathing,
    output reg G_breathing,
    output reg B_breathing
);
    parameter 
    COLOR1_R = 8'd148, // Dark Violet #9400D3
    COLOR1_G = 8'd0,
    COLOR1_B = 8'd211,

    COLOR2_R = 8'd0,   // Medium Blue #0000CD
    COLOR2_G = 8'd0,
    COLOR2_B = 8'd205,

    COLOR3_R = 8'd218, // Goldenrod #DAA520
    COLOR3_G = 8'd165,
    COLOR3_B = 8'd32,

    COLOR4_R = 8'd255, // Orange Red #FF4500
    COLOR4_G = 8'd69,
    COLOR4_B = 8'd0;

    // PWM counters for each color channel
    reg [7:0] pwm_counter_R;
    reg [7:0] pwm_counter_G;
    reg [7:0] pwm_counter_B;

    // Breathing effect counter and direction
    reg [18:0] breath_counter;
    reg breath_direction; // 0: increasing, 1: decreasing

    // Wires to hold scaled breathing values for each color channel
    wire [15:0] scaled_breath_R;
    wire [15:0] scaled_breath_G;
    wire [15:0] scaled_breath_B;

    // Red channel PWM counter
    always @(posedge clk or posedge rst) begin
        if (rst)
            pwm_counter_R <= 8'd0;
        else
            pwm_counter_R <= pwm_counter_R + 8'd1;
    end

    // Green channel PWM counter
    always @(posedge clk or posedge rst) begin
        if (rst)
            pwm_counter_G <= 8'd0;
        else
            pwm_counter_G <= pwm_counter_G + 8'd1;
    end

    // Blue channel PWM counter
    always @(posedge clk or posedge rst) begin
        if (rst)
            pwm_counter_B <= 8'd0;
        else
            pwm_counter_B <= pwm_counter_B + 8'd1;
    end

    // Breathing counter logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            breath_counter <= 19'd0;
            breath_direction <= 1'b0; // Start with increasing
        end else if (pwm_counter_R == 8'hFF) begin
            if (breath_direction == 1'b0) begin
                if (breath_counter == 19'h7FFFF) begin
                    breath_direction <= 1'b1; // Change to decreasing
                    breath_counter <= breath_counter - 19'd1;
                end else begin
                    breath_counter <= breath_counter + 19'd1;
                end
            end else begin
                if (breath_counter == 19'd0) begin
                    breath_direction <= 1'b0; // Change to increasing
                    breath_counter <= breath_counter + 19'd1;
                end else begin
                    breath_counter <= breath_counter - 19'd1;
                end
            end
        end
    end

    // Assign scaled breathing values based on switch position
    assign scaled_breath_R = (sw == 2'b00) ? (COLOR1_R * breath_counter[18:11]) :
                             (sw == 2'b01) ? (COLOR2_R * breath_counter[18:11]) :
                             (sw == 2'b10) ? (COLOR3_R * breath_counter[18:11]) :
                                             (COLOR4_R * breath_counter[18:11]);

    assign scaled_breath_G = (sw == 2'b00) ? (COLOR1_G * breath_counter[18:11]) :
                             (sw == 2'b01) ? (COLOR2_G * breath_counter[18:11]) :
                             (sw == 2'b10) ? (COLOR3_G * breath_counter[18:11]) :
                                             (COLOR4_G * breath_counter[18:11]);

    assign scaled_breath_B = (sw == 2'b00) ? (COLOR1_B * breath_counter[18:11]) :
                             (sw == 2'b01) ? (COLOR2_B * breath_counter[18:11]) :
                             (sw == 2'b10) ? (COLOR3_B * breath_counter[18:11]) :
                                             (COLOR4_B * breath_counter[18:11]);

    // PWM output control for each color channel
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            R_breathing <= 1'b1;
            G_breathing <= 1'b1;
            B_breathing <= 1'b1;
        end else begin
            R_breathing <= (pwm_counter_R < scaled_breath_R[15:8]) ? 1'b1 : 1'b0;
            G_breathing <= (pwm_counter_G < scaled_breath_G[15:8]) ? 1'b1 : 1'b0;
            B_breathing <= (pwm_counter_B < scaled_breath_B[15:8]) ? 1'b1 : 1'b0;
        end
    end

endmodule
