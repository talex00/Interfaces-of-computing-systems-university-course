module man_code(clk, invert_clk, data, enable, reset, sign, value, prev_value, coded_data);
    parameter BUFFER_SIZE = 23;
    integer i = 0;
    integer write_position = 0;
    input clk;
    input invert_clk;
    input [BUFFER_SIZE-1:0] data;
    input enable;
    input reset;
    output reg sign;
    output reg value;
    output reg prev_value;
    output reg [BUFFER_SIZE*2 -1 :0] coded_data;
initial begin
    sign = 0;
    value = data[BUFFER_SIZE-1];
    prev_value = data[BUFFER_SIZE-1];
    coded_data = 46'b0;
end

always @(clk or invert_clk)
begin
if (enable) begin
    if (invert_clk) begin
        sign = ~sign;
        coded_data[45 - write_position] = sign;
        write_position = write_position + 1;
    end else begin
        value = data[22-i];
        if (value == prev_value) sign = ~sign;
        prev_value = value;
        coded_data[45 - write_position] = sign;
        write_position = write_position + 1;
        i = i + 1;   
    end
end
end


endmodule