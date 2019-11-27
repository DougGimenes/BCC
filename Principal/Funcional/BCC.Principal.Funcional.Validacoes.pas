unit BCC.Principal.Funcional.Validacoes;

interface

uses
  SysUtils;

type
  TValidador = class
    public
      class function ValidarCPF(ACPF : String) : Boolean;
  end;

implementation

{ TValidador }

class function TValidador.ValidarCPF(ACPF: String): Boolean;
var 
  CPFRepetido : Boolean;
  I : integer;
  Digito1, Digito2 : Integer;
begin
  Result := False;

  if length(ACPF) <> 11 then
  begin
    Exit();
  end;

  CPFRepetido := True;
  for I := 2 to length(ACPF) do
  begin
    if ACPF[1] <> ACPF[I] then
    begin
      CPFRepetido := False;
      Break;
    end;
  end;
  
  if (CPFRepetido) then
  begin
    Exit();
  end;

  Digito1 := 0;
  for I := 1 to 9 do
  begin
    Digito1 := Digito1 + (StrToInt(ACPF[10 - I]) * (I + 1));
  end;
  
  Digito1 := ((11 - (Digito1 mod 11)) mod 11) mod 10;
  if IntToStr(Digito1) <> ACPF[10] then
  begin
    Exit();
  end;

  Digito2 := 0;
  for I := 1 to 10 do
  begin
    Digito2 := Digito2 + (StrToInt(ACPF[11 - I]) * (I + 1));
  end;
  
  Digito2 := ((11 - (Digito2 mod 11)) mod 11) mod 10;
  if IntToStr(Digito2) <> ACPF[11] then
  begin
    Exit();
  end;

  Result := True;
end;

end.
