module divider(
  input clk,
  input rst,
  output reg clk_div
);

  reg [26:0] cnt;

  always@(posedge clk or posedge rst) begin
    if (rst) begin
      cnt <= 27'd0;
      clk_div <= 'b0;
    end
    else begin
      if (cnt == 125000000 - 1) cnt <= 27'd0;
      else cnt <= cnt + 1;

      if (cnt < 62500000) clk_div <= 'b0;
      else clk_div <= 'b1;
    end
  end

endmodule
