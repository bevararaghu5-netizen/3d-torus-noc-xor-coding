module torus_router_3d #( 
    parameter NX = 4, 
    parameter NY = 4, 
    parameter NZ = 4 
) 
( 
    input [3:0] curr_x, curr_y, curr_z, 
    input [3:0] dest_x, dest_y, dest_z, 
    input [7:0] data_in1, 
    input [7:0] data_in2, 
    input valid1, 
    input valid2, 
    output reg [2:0] direction, 
    output reg [7:0] data_out 
); 
//   Use localparam (better practice) 
localparam EAST  = 3'd0; 
localparam WEST  = 3'd1; 
localparam NORTH = 3'd2; 
localparam SOUTH = 3'd3; 
localparam UP    = 3'd4; 
localparam DOWN  = 3'd5; 
// Distance variables 
integer dx_pos, dx_neg; 
integer dy_pos, dy_neg; 
integer dz_pos, dz_neg; 
always @(*) begin 

    // TORUS DISTANCE CALCULATION 
    dx_pos = (dest_x - curr_x + NX) % NX; 
    dx_neg = (curr_x - dest_x + NX) % NX; 
    dy_pos = (dest_y - curr_y + NY) % NY; 
    dy_neg = (curr_y - dest_y + NY) % NY; 
    dz_pos = (dest_z - curr_z + NZ) % NZ; 
    dz_neg = (curr_z - dest_z + NZ) % NZ; 
    // ROUTING LOGIC  
    if (curr_x != dest_x) begin 
        if (dx_pos <= dx_neg) 
            direction = EAST; 
        else 
            direction = WEST; 
    end 
    else if (curr_y != dest_y) begin 
        if (dy_pos <= dy_neg) 
            direction = NORTH; 
        else 
            direction = SOUTH; 
    end 
    else if (curr_z != dest_z) begin 
        if (dz_pos <= dz_neg) 
            direction = UP; 
        else 
            direction = DOWN; 
    end 
    else begin 
        direction = 3'd7; // destination reached 
    end 
    // XOR NETWORK CODING 
    if (valid1 && valid2) 

        data_out = data_in1 ^ data_in2; 
    else if (valid1) 
        data_out = data_in1; 
    else if (valid2) 
        data_out = data_in2; 
    else 
        data_out = 8'd0; 
end 
endmodule
