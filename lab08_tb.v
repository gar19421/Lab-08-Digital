module testbench();
reg clock, reset, enable, load;//variables para el contador
wire [11:0] salida;

wire [7:0]word;
reg  [11:0]address;//variables para la memoria
integer i;

reg [2:0] F;
reg [3:0] A, B;
wire [3:0] salida_2;//variables para el ALU

always//instanciacion del clock
  begin
    clock <= 1;
    #1 clock <= ~clock;// se realiza el cambio del reloj
    #1;
end

Counter Contador(clock, reset, enable, load, salida);
Memory  Memoria(address, word);
ALU     ALU1(A, B, F, salida_2);// instanciacion de los modulos de cada ejercicio

initial begin// test de contador
  $display("Contador\n");
  $display("CLK Reset | Enable Load | Contador");
  $display("----------|-------------|--------------");
  $monitor("%b     %b   |    %b     %b  | %b", clock,reset,enable,load,salida);
  #2 reset = 1;
  #2 enable = 0; load = 0; reset = 0;
  #2; #2;
  #2 enable = 1; load = 0;
  #2; #2; #2; #2;
  #2 load = 1;
  #2 load = 0 ;
  #2; #2; #2;
  #2 enable = 0;
  #2; #2; #2;

end

initial begin//test de memoria
  #38
  $display(" Memoria ROM ");
  $display("Address       |    Word   ");
  $display("--------------|-------------");
  $monitor("%b  |   %b", address, word);

  for (i = 0; i < 10; i++) begin// lectura de los 10 primeros datos de la memoria ROM
    #2 address =  i;
  end
end

initial begin//test del ALU
    #60
    $display(" \nALU ");
    $display(" A        B    | F   |  Y ");
    $display(" ----------------------------");
    $monitor(" %b    %b  | %b |  %b ", A, B, F, salida_2);

    A[3] = 0; A[2] = 0; A[1] = 1; A[0] = 0; B[3] = 0; B[2] = 1; B[1] = 0; B[0] = 1;
    #2  F[2] = 0; F[1] = 0; F[0] = 0;
    #2  F[2] = 0; F[1] = 0; F[0] = 1;
    #2  F[2] = 0; F[1] = 1; F[0] = 0;
    #2  F[2] = 1; F[1] = 0; F[0] = 0;
    #2  F[2] = 1; F[1] = 0; F[0] = 1;
    #2  F[2] = 1; F[1] = 1; F[0] = 0;
    #2  F[2] = 1; F[1] = 1; F[0] = 1;
    #1  F[2] = 0; F[1] = 0; F[0] = 0;
    #2  A[3] = 1; A[2] = 0; A[1] = 1; A[0] = 0;
    #2  F[2] = 1; F[1] = 1; F[0] = 1;
    #2 $finish;
  end

  initial begin//ejecutar GTKWave para diagramas de timing.
    $dumpfile("lab08_tb.vcd");
    $dumpvars(0, testbench);
  end

endmodule
