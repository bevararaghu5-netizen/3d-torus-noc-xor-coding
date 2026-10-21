`timescale 1ns/1ps 
module mesh_router_3d ( 
    input [3:0] curr_x, curr_y, curr_z, 
    input [3:0] dest_x, dest_y, dest_z, 
    input [7:0] data_in1, 
    input [7:0] data_in2, 
    input valid1, 
    input valid2, 
    output reg [2:0] direction,   // 0:E,1:W,2:N,3:S,4:U,5:D 
    output reg [7:0] data_out 
); 
// Direction encoding 
parameter EAST  = 3'd0; 
parameter WEST  = 3'd1; 
parameter NORTH = 3'd2; 
parameter SOUTH = 3'd3; 
parameter UP    = 3'd4; 
parameter DOWN  = 3'd5; 
always @(*) begin 
    // ------------------------- 
    // Routing Logic (3D Mesh DOR) 
    // ------------------------- 
    if (dest_x > curr_x) 
        direction = EAST; 
    else if (dest_x < curr_x) 
        direction = WEST; 
    else if (dest_y > curr_y) 
        direction = NORTH; 

    else if (dest_y < curr_y) 
        direction = SOUTH; 
    else if (dest_z > curr_z) 
        direction = UP; 
    else if (dest_z < curr_z) 
        direction = DOWN; 
    else 
        direction = 3'd7; // reached destination 
    // ------------------------- 
    // XOR Network Coding 
    // ------------------------- 
    if (valid1 && valid2) 
        data_out = data_in1 ^ data_in2;  // XOR coding 
    else if (valid1) 
        data_out = data_in1; 
    else if (valid2) 
        data_out = data_in2; 
    else 
        data_out = 8'd0; 
end 
endmodule
