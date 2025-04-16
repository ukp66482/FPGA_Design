module rainbow_breathing (
    input clk,
    input rst,
    output reg R_out,
    output reg G_out,
    output reg B_out
);
    parameter 
    COLOR1_R = 8'hff, // #dc143c
    COLOR1_G = 8'h00,
    COLOR1_B = 8'h00,

    COLOR2_R = 8'hff, // #ff4500
    COLOR2_G = 8'h25,
    COLOR2_B = 8'h00,

    COLOR3_R = 8'hff, // #ffd700
    COLOR3_G = 8'hff,
    COLOR3_B = 8'h00,

    COLOR4_R = 8'h1e, // #1e90ff
    COLOR4_G = 8'h90,
    COLOR4_B = 8'hff,

    COLOR5_R = 8'h00, // #0000cd
    COLOR5_G = 8'h00,
    COLOR5_B = 8'hcd,

    COLOR6_R = 8'h94, // #9400d3
    COLOR6_G = 8'h00,
    COLOR6_B = 8'hd3;

    // PWM counters for each color channel
    reg [7:0] pwm_counter_R;
    reg [7:0] pwm_counter_G;
    reg [7:0] pwm_counter_B;

    // Breathing effect counter and direction
    reg [18:0] breath_counter;
    reg breath_direction; // 0: increasing, 1: decreasing

    reg [2:0] color_state;

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

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            color_state <= 3'b000; // Start with COLOR1
        end else if (pwm_counter_R == 8'hFF) begin
            if (breath_direction == 1'b1) begin
                if (breath_counter == 19'd0) begin
                    case (color_state)
                        3'b000: color_state <= 3'b001;
                        3'b001: color_state <= 3'b010;
                        3'b010: color_state <= 3'b011;
                        3'b011: color_state <= 3'b100;
                        3'b100: color_state <= 3'b101;
                        3'b101: color_state <= 3'b000;
                        default: color_state <= 3'b000;
                    endcase
                end
            end
        end
    end

    // Assign scaled breathing values based on switch position
    assign scaled_breath_R = (color_state == 3'b000) ? (COLOR1_R * breath_counter[18:11]) :
                             (color_state == 3'b001) ? (COLOR2_R * breath_counter[18:11]) :
                             (color_state == 3'b010) ? (COLOR3_R * breath_counter[18:11]) :
                             (color_state == 3'b011) ? (COLOR4_R * breath_counter[18:11]) :
                             (color_state == 3'b100) ? (COLOR5_R * breath_counter[18:11]) :
                             (color_state == 3'b101) ? (COLOR6_R * breath_counter[18:11]) :
                                                       (COLOR1_R * breath_counter[18:11]);

    assign scaled_breath_G = (color_state == 3'b000) ? (COLOR1_G * breath_counter[18:11]) :
                             (color_state == 3'b001) ? (COLOR2_G * breath_counter[18:11]) :
                             (color_state == 3'b010) ? (COLOR3_G * breath_counter[18:11]) :
                             (color_state == 3'b011) ? (COLOR4_G * breath_counter[18:11]) :
                             (color_state == 3'b100) ? (COLOR5_G * breath_counter[18:11]) :
                             (color_state == 3'b101) ? (COLOR6_G * breath_counter[18:11]) :
                                                       (COLOR1_G * breath_counter[18:11]);

    assign scaled_breath_B = (color_state == 3'b000) ? (COLOR1_B * breath_counter[18:11]) :
                             (color_state == 3'b001) ? (COLOR2_B * breath_counter[18:11]) :
                             (color_state == 3'b010) ? (COLOR3_B * breath_counter[18:11]) :
                             (color_state == 3'b011) ? (COLOR4_B * breath_counter[18:11]) :
                             (color_state == 3'b100) ? (COLOR5_B * breath_counter[18:11]) :
                             (color_state == 3'b101) ? (COLOR6_B * breath_counter[18:11]) :
                                                       (COLOR1_B * breath_counter[18:11]);

    // PWM output control for each color channel
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            R_out <= 1'b1;
            G_out <= 1'b1;
            B_out <= 1'b1;
        end else begin
            R_out <= (pwm_counter_R < scaled_breath_R[15:8]) ? 1'b1 : 1'b0;
            G_out <= (pwm_counter_G < scaled_breath_G[15:8]) ? 1'b1 : 1'b0;
            B_out <= (pwm_counter_B < scaled_breath_B[15:8]) ? 1'b1 : 1'b0;
        end
    end


endmodule