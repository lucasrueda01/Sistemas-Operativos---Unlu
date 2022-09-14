Program RoundRobin;

Uses sysutils,crt;

const 
    MAX = 5;
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
    i,j,Reloj,ronda,sumaRetorno,sumaEspera:integer;
    

function tiempoDeServicioTotal(): integer;
var 
    i,suma:integer;
begin
    suma := 0;
    for i := 1 to Length(Procesos) do 
        suma := suma + Resultados[i].TiempoServicio;
    tiempoDeServicioTotal := suma;
end;

procedure inicializarProcesos();
var
    i,n:integer;
begin
    Randomize;
    for i:= 1 to Length(Procesos) do begin
        Procesos[i].ProcessID := Chr(64 + i);
        Resultados[i].ProcessID := Chr(64 + i);
        n := Random(15) + 1;
        Procesos[i].TiempoServicio := n;
        Resultados[i].TiempoServicio := n;
    end;
end;


Begin

    WriteLn('PIDs y su Tiempo de servicio:');
    inicializarProcesos();
    for i:= 1 to Length(Procesos) do begin
        WriteLn(Procesos[i].ProcessID + ' - ' + Procesos[i].tiempoServicio.ToString);
    end;
    WriteLn('Utilizar RoundRobin');
    readkey;
    Reloj := 0;  
    ronda := 1;
    sumaRetorno := 0;
    sumaEspera := 0;

    while tiempoDeServicioTotal() > 0 do begin

        for i:=1 to Length(Procesos) do begin
            if Resultados[i].TiempoServicio > Q then begin
                Resultados[i].TiempoServicio := Resultados[i].TiempoServicio - Q;
                Reloj := Reloj + Q;
            end
            else begin
                Reloj := Reloj + Resultados[i].TiempoServicio;  
                if Resultados[i].TiempoServicio > 0 then begin
                    Resultados[i].TiempoServicio := 0; 
                    sumaRetorno := sumaRetorno + Reloj;  
                    sumaEspera := sumaEspera + (Reloj - Procesos[i].TiempoServicio);
                end; 
            end;
            Resultados[i].R := Reloj;
        end; 

        //mostrar resultados
        WriteLn('----------Ronda ' + ronda.ToString +  '----------');
        WriteLn('PID - Tiempo de Servicio restante - Reloj - (Q = ' + Q.ToString + ')');
        for j:=1 to Length(Resultados) do begin
            WriteLn(Resultados[j].ProcessID + ' - ' + Resultados[j].TiempoServicio.ToString + ' - ' + Resultados[j].R.ToString);
            readkey;
        end;
        WriteLn('');
        if tiempoDeServicioTotal() > 0 then
            WriteLn('Continuar a la siguiente ronda...')
        else begin
            WriteLn('RoundRobin finalizado');
            WriteLn('Tiempo de retorno promedio: ' + (sumaRetorno/Length(Procesos)).ToString);
            WriteLn('Tiempo de espera promedio: ' + (sumaEspera/Length(Procesos)).ToString);
            Break;
        end;
        Writeln('');
        readkey;
        inc(ronda);

    end;

End.