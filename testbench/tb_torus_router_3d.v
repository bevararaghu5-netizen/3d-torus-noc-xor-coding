`timescale 1ns/1ps 
module tb_torus_router_3d; 
reg [3:0] curr_x, curr_y, curr_z; 
reg [3:0] dest_x, dest_y, dest_z; 
reg [7:0] data_in1, data_in2; 
reg valid1, valid2; 
wire [2:0] direction; 
wire [7:0] data_out; 
// Instantiate 
torus_router_3d #(4,4,4) uut ( 
    .curr_x(curr_x), 
    .curr_y(curr_y), 
    .curr_z(curr_z), 
    .dest_x(dest_x), 
    .dest_y(dest_y), 
    .dest_z(dest_z), 
    .data_in1(data_in1), 
    .data_in2(data_in2), 
    .valid1(valid1), 

    .valid2(valid2), 
    .direction(direction), 
    .data_out(data_out) 
); 
initial begin 
    // ------------------------- 
    // Test 1: Wrap-around X 
    // ------------------------- 
    curr_x = 1; curr_y = 1; curr_z = 1; 
    dest_x = 3; dest_y = 1; dest_z = 1; 
    data_in1 = 8'b10101010; 
    data_in2 = 8'b11001100; 
    valid1 = 1; valid2 = 1; 
    #10; 
    $display("Test1 Direction=%d Data=%b", direction, data_out); 
    // ------------------------- 
    // Test 2: Normal Y routing 
    // ------------------------- 
    curr_x = 2; curr_y = 1; curr_z = 1; 
    dest_x = 2; dest_y = 3; dest_z = 1; 
    data_in1 = 8'b11110000; 
    data_in2 = 8'b00001111; 
    valid1 = 1; valid2 = 0; 
    #10; 
    $display("Test2 Direction=%d Data=%b", direction, data_out); 
    // ------------------------- 
    // Test 3: Wrap-around Z 
    // ------------------------- 
    curr_x = 2; curr_y = 2; curr_z = 0; 
    dest_x = 2; dest_y = 2; dest_z = 3; 
    data_in1 = 8'b00110011; 

    data_in2 = 8'b01010101; 
    valid1 = 0; valid2 = 1; 
    #10; 
    $display("Test3 Direction=%d Data=%b", direction, data_out); 
    // ------------------------- 
    // Test 4: Destination reached 
    // ------------------------- 
    curr_x = 1; curr_y = 1; curr_z = 1; 
    dest_x = 1; dest_y = 1; dest_z = 1; 
    valid1 = 0; valid2 = 0; 
    #10; 
    $display("Test4 Direction=%d Data=%b", direction, data_out); 
    $stop; 
end 
endmodule
