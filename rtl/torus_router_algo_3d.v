`timescale 1ns/1ps 
module torus_router_algo_3d #( 
    parameter NX = 4, 
    parameter NY = 4, 
    parameter NZ = 4 
) 
( 
    input [3:0] curr_x, curr_y, curr_z, 
    input [3:0] dest_x1, dest_y1, dest_z1, 
    input [3:0] dest_x2, dest_y2, dest_z2, 
    input [7:0] data1, data2, 
    input valid1, valid2, 
    output reg [2:0] direction, 
    output reg [7:0] data_out, 
    output reg encode_flag, 
    output reg [7:0] hop_count   // NEW PARAMETER 
); 
// Direction encoding 
localparam EAST=0, WEST=1, NORTH=2, SOUTH=3, UP=4, DOWN=5; 
// Distance variables 
integer dx, dy, dz; 
integer dx_t, dy_t, dz_t; 
always @(*) begin 
    // ------------------------------- 
    // TORUS DISTANCE CALCULATION 
    // ------------------------------- 
    dx = (dest_x1 > curr_x) ? (dest_x1 - curr_x) : (curr_x - dest_x1); 
    dy = (dest_y1 > curr_y) ? (dest_y1 - curr_y) : (curr_y - dest_y1); 

    dz = (dest_z1 > curr_z) ? (dest_z1 - curr_z) : (curr_z - dest_z1); 
 
    dx_t = (dx < (NX - dx)) ? dx : (NX - dx); 
    dy_t = (dy < (NY - dy)) ? dy : (NY - dy); 
    dz_t = (dz < (NZ - dz)) ? dz : (NZ - dz); 
    // Hop count 
    hop_count = dx_t + dy_t + dz_t; 
    // ------------------------------- 
    // ROUTING (Torus DOR) 
    // ------------------------------- 
    if (curr_x != dest_x1) 
        direction = ((dest_x1 - curr_x + NX) % NX <= (curr_x - dest_x1 + NX) % NX) ? EAST : WEST; 
    else if (curr_y != dest_y1) 
        direction = ((dest_y1 - curr_y + NY) % NY <= (curr_y - dest_y1 + NY) % NY) ? NORTH : SOUTH; 
    else if (curr_z != dest_z1) 
        direction = ((dest_z1 - curr_z + NZ) % NZ <= (curr_z - dest_z1 + NZ) % NZ) ? UP : DOWN; 
    else 
        direction = 3'd7; 
    // ------------------------------- 
    // XOR NETWORK CODING 
    // ------------------------------- 
    if (valid1 && valid2) begin 
        encode_flag = 1; 
        data_out = data1 ^ data2; 
    end 
    else begin 
        encode_flag = 0; 
        if (valid1) 
            data_out = data1; 
        else if (valid2) 
            data_out = data2; 

        else 
            data_out = 8'd0; 
    end 
end 
endmodule
