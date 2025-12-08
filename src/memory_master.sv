module memory_master #(
    parameter int LENGTH = 32
)(
    input  logic [LENGTH-1:0] Address,
    input  logic [LENGTH-1:0] Write_Data,
    input  logic              write_en,
    input  logic [LENGTH-1:0] HRData1,
    input  logic [LENGTH-1:0] HRData2, 

    output logic [LENGTH-1:0] HWData,
    output logic [LENGTH-1:0] HAddress,
    output logic [LENGTH-1:0] Mem_Data,
    output logic              write_data_en
);

    logic [1:0] add_decoder, selector;

    // First step of decoding the address 
    always_comb begin
        if (Address >= 32'h10_010_000 && Address < 32'h10_040_000) begin
            // UART
            if (Address >= 32'h10_010_020 && Address <= 32'h10_010_038) begin
                add_decoder = 2'b10;
            end
            else begin
                add_decoder = 2'b01;
            end
        end 
        else if (Address >= 32'h10_040_000 && Address < 32'h7fff_effc) begin
            add_decoder = 2'b11;
        end 
        else begin
            add_decoder = 2'b01;
        end
    end

    // Decoder mapping
    always_comb begin
        unique case (add_decoder)
            2'b01: begin  // RAM
                HAddress      = (Address + (~32'h10_010_000 + 1'b1)) >> 2'h2;
                HWData        = Write_Data;
                write_data_en = write_en;
                selector      = 2'b01;
            end	
            2'b10: begin  // GPIO
                HAddress      = (Address + (~32'h10_010_020 + 1'b1)) >> 2'h2;
                HWData        = Write_Data;
                write_data_en = write_en;
                selector      = 2'b10;
            end	
            2'b11: begin  // STACK
                HAddress      = (Address - 32'h7fff_effc + 32'hD4) >> 2'h2; 
                HWData        = Write_Data;
                write_data_en = write_en;
                selector      = 2'b01;
            end			
            default: begin 
                HAddress      = Address;
                HWData        = Write_Data;
                write_data_en = 1'b0;
                selector      = 2'b00;
            end	
        endcase
    end		

    // Mux de datos
    mux4_1 #(.WIDTH(LENGTH)) muxData (
        .Data0 (32'h0),
        .Data1 (HRData1),
        .Data2 (HRData2),      
        .Data3 (32'h0), 
        .sel   (selector),     
        .Data_o(Mem_Data)      
    );

endmodule