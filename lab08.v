// programa 1
module Counter(input wire clk, reset, enable, load,  output reg[11:0] count);
//contador de 12 bits con entradas de clock, reset, enable y load

  //conteo en cada flanco de reloj
  always @ (posedge clk or posedge reset or posedge enable or posedge load) begin
    if(reset) begin
     count <= 12'd0; // si se resetea empieza en cero
    end
    else if(clk & enable & ~load) begin
        #2 count <= count + 12'd1; // si esta en enable cuenta el contador sino no cuenta
    end
    else if(clk & load & enable) begin
        #2 count <= 12'd34; //precargando el valor
    end
  end

endmodule

//programa 2
module Memory (input wire [11:0] address, output wire [7:0] word);//memoria rom
  reg [7:0] mem [0:4095];// creacion de arreglo de memoria
  initial begin
      $readmemb("memory.list", mem);//lectura del archivo de datos
  end
  assign word = mem[address];// resultado leido de la memoria
endmodule

// programa 3
module ALU(input wire [3:0] A, B, input wire [2:0] F, output reg [3:0] Resultado);//implementacion de la ALU

// parametros tabla 5.1 libro
  parameter AND1 = 3'd0;
  parameter OR1 = 3'd1;
  parameter ADD = 3'd2;
  parameter AND2 = 3'd4;
  parameter OR2 = 3'd5;
  parameter SUBTRACT = 3'd6;
  parameter SLT = 3'd7;

  always @(*) begin// operaciones a realizar con la ALU con un switch case
    case(F)
    AND1:  assign Resultado = (A & B);
    OR1:   assign Resultado = (A | B);
    ADD:  assign Resultado = A + B;
    AND2: assign Resultado = (A & ~B);
    OR2:  assign Resultado = (A | ~B);
    SUBTRACT: assign Resultado = A - B;
    SLT: assign Resultado = (A > B) ? 4'd0 : 4'd1;
    default: Resultado = 4'd0;
    endcase
  end

endmodule
