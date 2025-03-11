module normal(
input clk,
input rst,
input [3:0] R_G_time,
input [3:0] R_Y_time,
input [3:0] R_R_time,
output reg [2:0] T1,
output reg [2:0] T2,
output reg [3:0] remain);


parameter T1_G_T2_R = 3'b000;
parameter T1_Y_T2_R = 3'b001;
parameter T1_R_T2_R = 3'b010;
parameter T1_R_T2_G = 3'b011;
parameter T1_R_T2_Y = 3'b100;
parameter T1_R_T2_R_rst = 3'b101;

parameter Red = 3'b100;
parameter Green = 3'b010;
parameter Yellow = 3'b110;

reg [2:0] curr_state,next_state;
reg [3:0] counter;

always @(posedge clk or posedge rst)
    if(rst)
        counter <= 0;
    else
        case(curr_state)
            T1_G_T2_R : if(counter==R_G_time)
                            counter <= 0;
                        else
                            counter <= counter + 3'd1;
            T1_Y_T2_R : if(counter==R_Y_time)
                            counter <= 0;
                        else
                            counter <= counter + 3'd1;
            T1_R_T2_R : if(counter==R_R_time)
                            counter <= 0;
                        else
                            counter <= counter + 3'd1;                     
            T1_R_T2_G : if(counter==R_G_time)
                            counter <= 0;
                        else
                            counter <= counter + 3'd1;
            T1_R_T2_Y : if(counter==R_Y_time)
                            counter <= 0;
                        else
                            counter <= counter + 3'd1;
            T1_R_T2_R_rst : if(counter==R_R_time)
                                counter <= 0;
                            else
                                counter <= counter + 3'd1;                                 
            default : counter <= 0;
            
            endcase


//FSM
always @(posedge clk or posedge rst)
    if(rst)
        curr_state <= T1_G_T2_R;
    else
        curr_state <= next_state;
        
//next_state_logic        
always @(*)
    if(rst)
        next_state = 0;
    else
        case(curr_state)
            T1_G_T2_R : if(counter==R_G_time)
                            next_state = T1_Y_T2_R;
                        else
                            next_state = T1_G_T2_R;
            T1_Y_T2_R : if(counter==R_Y_time)
                            next_state = T1_R_T2_R;
                        else
                            next_state = T1_Y_T2_R;
            T1_R_T2_R : if(counter==R_R_time)
                            next_state = T1_R_T2_G ;
                        else
                            next_state = T1_R_T2_R;                     
            T1_R_T2_G : if(counter==R_G_time)
                            next_state = T1_R_T2_Y ;
                        else
                            next_state = T1_R_T2_G ;
            T1_R_T2_Y : if(counter==R_Y_time)
                            next_state = T1_R_T2_R_rst;
                        else
                            next_state = T1_R_T2_Y;
            T1_R_T2_R_rst : if(counter==R_R_time)
                                next_state = T1_G_T2_R;
                            else
                                next_state = T1_R_T2_R_rst;                                 
            default : next_state = T1_G_T2_R;
            
            endcase
        
//output T1_T2
always @(*)
    if(rst)
        T1 = 3'b111;
    else
        case(curr_state)
            T1_G_T2_R : T1 = Green;
            T1_Y_T2_R : T1 = Yellow;
            T1_R_T2_R : T1 = Red;            
            T1_R_T2_G : T1 = Red; 
            T1_R_T2_Y : T1 = Red; 
            T1_R_T2_R_rst : T1 = Red;                       
            default : T1 = 3'b111;
            endcase


always @(*)
    if(rst)
        T2 = 3'b111;
    else
        case(curr_state)
            T1_G_T2_R : T2 = Red;
            T1_Y_T2_R : T2 = Red;
            T1_R_T2_R : T2 = Red;            
            T1_R_T2_G : T2 = Green; 
            T1_R_T2_Y : T2 = Yellow; 
            T1_R_T2_R_rst : T2 = Red;                       
            default : T2 = 3'b111;
            endcase

//remain
always @(*)
    if(rst)
        remain = 4'b1111;
    else
        case(curr_state)
            T1_G_T2_R : remain = R_G_time - counter;
            T1_Y_T2_R : remain = R_Y_time - counter;
            T1_R_T2_R : remain = R_R_time - counter;            
            T1_R_T2_G : remain = R_G_time - counter; 
            T1_R_T2_Y : remain = R_Y_time - counter; 
            T1_R_T2_R_rst : remain = R_R_time - counter;                       
            default : remain = 4'b1111;
            endcase

endmodule