`timescale 1ns/1ps 
module tb_torus_router_algo_3d; 
reg [3:0] curr_x, curr_y, curr_z; 
reg [3:0] dest_x1, dest_y1, dest_z1; 
reg [3:0] dest_x2, dest_y2, dest_z2; 
reg [7:0] data1, data2; 
reg valid1, valid2; 
wire [2:0] direction; 
wire [7:0] data_out; 
wire encode_flag; 
wire [7:0] hop_count; 
time start_time, end_time; 
torus_router_algo_3d #(4,4,4) uut ( 
    .curr_x(curr_x), .curr_y(curr_y), .curr_z(curr_z), 
    .dest_x1(dest_x1), .dest_y1(dest_y1), .dest_z1(dest_z1), 
    .dest_x2(dest_x2), .dest_y2(dest_y2), .dest_z2(dest_z2), 
    .data1(data1), .data2(data2), 
    .valid1(valid1), .valid2(valid2), 
    .direction(direction), 
    .data_out(data_out), 
    .encode_flag(encode_flag), 
    .hop_count(hop_count) 

); 
initial begin 
    // TEST 1: Wrap-around X 
    curr_x=0; curr_y=0; curr_z=0; 
    dest_x1=3; dest_y1=0; dest_z1=0; 
    valid1=1; valid2=0; 
    data1=8'b10101010; 
    start_time=$time; 
    #10; 
    end_time=$time; 
    $display("Test1 Direction=%d Hop=%d Latency=%0t", direction, hop_count, end_time - start_time); 
    // TEST 2: Y movement 
    curr_x=2; curr_y=1; curr_z=1; 
    dest_x1=2; dest_y1=3; dest_z1=1; 
    #10; 
    $display("Test2 Direction=%d Hop=%d", direction, hop_count); 
    // TEST 3: Z wrap 
    curr_x=2; curr_y=2; curr_z=0; 
    dest_x1=2; dest_y1=2; dest_z1=3; 
    #10; 
    $display("Test3 Direction=%d Hop=%d", direction, hop_count); 
    // TEST 4: XOR 
    valid1=1; valid2=1; 
    data1=8'b10101010; 
    data2=8'b11001100; 
    #10; 
    $display("Encoded Data=%b Flag=%d", data_out, encode_flag); 
    // TEST 5: Same node 
    curr_x=1; curr_y=1; curr_z=1; 

    dest_x1=1; dest_y1=1; dest_z1=1; 
    valid1=0; valid2=0; 
    #10; 
    $display("Test5 Direction=%d Hop=%d", direction, hop_count); 
    $stop; 
end 
endmodule
