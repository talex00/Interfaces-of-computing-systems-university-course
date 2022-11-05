module man_decode(coded_data, decode_enable, invert_clk, decode_buffer, decoded_value, result);
parameter BUFFER_SIZE = 46;
parameter ENCODED_DATA_SIZE = 23;
integer read_enable = 0;
integer i = 0;
input invert_clk;
input decode_enable;
input [BUFFER_SIZE-1:0] coded_data;
output reg [1:0] decode_buffer;
output reg decoded_value;
output reg [ENCODED_DATA_SIZE:0] result;
initial
begin
decode_buffer = 2'b0;
decoded_value = 0;
result = 23'b0;
end

always @(invert_clk) begin
if (decode_enable) begin
    if (read_enable != 2) begin
        decode_buffer[1 - read_enable] = coded_data[BUFFER_SIZE - 1 - i];
        i = i + 1;
        read_enable = read_enable + 1;
    end else begin
        case(decode_buffer)
            2'b01: decoded_value = 0;
            2'b10: decoded_value = 1;
        endcase
        result[ENCODED_DATA_SIZE - i/2] = decoded_value;
        read_enable = 0;
        decode_buffer = 2'b0;
        decode_buffer[1 - read_enable] = coded_data[BUFFER_SIZE - 1 - i];
        i = i + 1;
        read_enable = read_enable + 1;       
    end
end
end
endmodule