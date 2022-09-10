Program RoundRobin;

Uses sysutils,crt;

const 
    MAX = 10;
    Q = 4;

type

    Proceso = record
        ProcessID: char;
        TiempoServicio: integer;
    end;

    Resultado = record
        ProcessID: char;
        TiempoServicio: integer;
        R: integer;
    end;

var
    Procesos: array[1..MAX] of Proceso;
    Resultados: array[1..MAX] of Resultado;
    i,Reloj:integer;

function tiempoDeServicioTotal(): integer;
var 
    i,suma:integer;
begin
    suma := 0;
    for i := 1 to Length(Procesos) do 
        suma := suma + Procesos[i].TiempoServicio;
    tiempoDeServicioTotal := suma;
end;

procedure generarProcesos();
var
    i:integer;
begin
    Randomize;
    for i:= 1 to Length(Procesos) do begin
        Procesos[i].ProcessID := Chr(64 + i);
        Procesos[i].tiempoServicio := Random(15) + 1;
    end;


end;

Begin
    generarProcesos();
    Reloj := 0;  
    for i:= 1 to Length(Procesos) do begin
        WriteLn(Procesos[i].ProcessID + ' - ' + Procesos[i].tiempoServicio.ToString);
    end;
    WriteLn('Continuar');
    readkey;

    while tiempoDeServicioTotal() > 0 do begin
        for i:=1 to Length(Procesos) do begin
            if Procesos[i].tiempoServicio > Q then begin
                Procesos[i].tiempoServicio := Procesos[i].tiempoServicio - Q;
                Reloj := Reloj + Q;
            end
            else begin
                Reloj := Reloj + Procesos[i].tiempoServicio;
                Procesos[i].tiempoServicio := 0;
            end;
            Resultados[i].ProcessID := Procesos[i].ProcessID;
            Resultados[i].TiempoServicio := Procesos[i].tiempoServicio;
            Resultados[i].R := Reloj;
        end; 
    end;

   


End.