module SET ( clk , rst, en, central, radius, mode, busy, valid, candidate );

    input clk, rst;
    input en;
    input [23:0] central;
    input [11:0] radius;
    input [1:0] mode;
    output busy;
    output valid;
    output reg [7:0] candidate;

    reg [1:0] state;
    reg [1:0] next_state;
    reg signed [4:0] x, y, x1, y1, x2, y2, x3, y3, r1, r2, r3;
    reg [1:0] mode_reg;

    wire In_1, In_2, In_3;

    assign In_1 = (((x)-(x1)) * ((x)-(x1)) + ((y)-(y1)) * ((y)-(y1)) - r1 * r1) <= $signed(0) ? 1 : 0;
    assign In_2 = (((x)-(x2)) * ((x)-(x2)) + ((y)-(y2)) * ((y)-(y2)) - r2 * r2) <= $signed(0) ? 1 : 0;
    assign In_3 = (((x)-(x3)) * ((x)-(x3)) + ((y)-(y3)) * ((y)-(y3)) - r3 * r3) <= $signed(0) ? 1 : 0;

    parameter 
    IDLE = 2'd0,
    INPUT = 2'd1,
    CALCULATE = 2'd2,
    OUTPUT = 2'd3;

    always @(posedge clk or posedge rst) begin //state
        if(rst) state <= IDLE;
        else state <= next_state;
    end

    always @(*) begin //next_state
        case(state)
            IDLE: next_state = INPUT;
            INPUT: next_state = CALCULATE;
            CALCULATE:begin
                if(x == 5'sd8 && y == 5'sd8) next_state = OUTPUT;
                else next_state = CALCULATE;
            end
            OUTPUT: next_state = INPUT;
        endcase
    end

    always @(posedge clk) begin //x1 y1 x2 y2 x3 y3 mode
        if(state == INPUT && en)begin
            x1 <= central[23:20];
            y1 <= central[19:16];
            x2 <= central[15:12];
            y2 <= central[11:8];
            x3 <= central[7:4];
            y3 <= central[3:0];
            mode_reg <= mode;
            r1 <= radius[11:8];
            r2 <= radius[7:4];
            r3 <= radius[3:0];
        end
    end

    always @(posedge clk) begin //x y
        case(state)
            INPUT:begin
                x <= 5'sd1;
                y <= 5'sd1;
            end
            CALCULATE:begin
                if(x == 5'sd8)begin
                    x <= 5'sd1;
                    y <= y + 5'sd1;
                end else begin
                    x <= x + 5'sd1;
                end
            end
        endcase
    end

    always @(posedge clk) begin //candidate
        case(state)
            INPUT: candidate <= 0;
            CALCULATE:begin
                case(mode_reg)
                    2'b00:begin
                        if(In_1) candidate <= candidate + 1;
                    end
                    2'b01:begin
                        if(In_1 && In_2) candidate <= candidate + 1;
                    end                   
                    2'b10:begin
                        if((In_1 && !In_2) || (!In_1 && In_2)) candidate <= candidate + 1;
                    end
                    2'b11:begin
                        if(((In_1 && In_2) || (In_2 && In_3) || (In_1 && In_3)) && !(In_1 && In_2 && In_3)) candidate <= candidate + 1;
                    end
                endcase
            end
        endcase
    end

    assign valid = (state == OUTPUT); //valid

    assign busy = (state != INPUT); //busy


endmodule