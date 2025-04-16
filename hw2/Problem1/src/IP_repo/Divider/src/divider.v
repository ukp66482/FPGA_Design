module divider (
    input clk,
    input rst,
    output reg clk_div
);

    reg [8:0] counter; // 9-bit counter to count to 488

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 9'd0;
            clk_div <= 1'b0;
        end else if (counter == 9'd487) begin
            counter <= 9'd0;
            clk_div <= ~clk_div;
        end else begin
            counter <= counter + 9'd1;
        end
    end

endmodule

