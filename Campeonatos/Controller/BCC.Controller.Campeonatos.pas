unit BCC.Controller.Campeonatos;

interface

uses
  BCC.DAO.Cliente, BCC.DAO.Campeonatos, BCC.DAO.Competidores, BCC.Model.Cliente,
  BCC.Model.Campeonato, BCC.Model.Competidores, System.Generics.Collections;

type
  EResultado = (cmpVitoria, cmpDerrota, cmpEmpate);
  
  TControllerCampeonatos = class
    private
    public
      class function InscreverCliente(ACodCliente, ACodCampeonato : Integer) : Boolean;
      class function AumentarPontuacao(ACodCompetidor, APontosGanhos : Integer) : Boolean;
      class function AdicionarPartida(ACodCompetidor : Integer; AResultado : EResultado) : Boolean;
      class function EncerrarCampeonato(ACodCampeonato : Integer) : Boolean;
      class function IniciarCampeonato(ACodCampeonato : Integer) : Boolean;
  end;

implementation

{ TControllerCampeonatos }

class function TControllerCampeonatos.AdicionarPartida(ACodCompetidor: Integer;
  AResultado: EResultado): Boolean;
var
  Competidor : TCompetidor;
  DmCompetidor : TDmCompetidores;
begin
  try
    DmCompetidor := TDmCompetidores.Create(nil);
    Competidor := DmCompetidor.Selecionar(ACodCompetidor);
    Competidor.Partidas := Competidor.Partidas + 1;

    case AResultado of
      cmpVitoria : Competidor.Vitorias := Competidor.Vitorias + 1;
      cmpDerrota : Competidor.Derrotas := Competidor.Derrotas + 1;
      cmpEmpate  : Competidor.Empates  := Competidor.Empates  + 1;
    end;

    DmCompetidor.Editar(Competidor);
    Result := True;
  except
    Result := False;
  end;
end;

class function TControllerCampeonatos.AumentarPontuacao(ACodCompetidor,
  APontosGanhos: Integer): Boolean;
var
  Competidor : TCompetidor;
  DmCompetidor : TDmCompetidores;
begin
  Result := False;
  try
    DmCompetidor := TDmCompetidores.Create(nil);
    Competidor := DmCompetidor.Selecionar(ACodCompetidor);
    Competidor.Pontuacao := Competidor.Pontuacao + APontosGanhos;
    DmCompetidor.Editar(Competidor);
    Result := True;
  except
    Result := False;
  end;
end;

class function TControllerCampeonatos.EncerrarCampeonato(
  ACodCampeonato: Integer): Boolean;
var
  DmCampeoanto : TDmCampeonato;
  Campeonato : TCampeonato;
begin
  Result := False;
  try
    DmCampeoanto := TDmCampeonato.Create(nil);
    Campeonato := DmCampeoanto.Selecionar(ACodCampeonato);
    Campeonato.Estado := EEstado.CmpFinalizado;
    DmCampeoanto.Editar(Campeonato);
    Result := True;
  except
    Result := False;
  end;
end;

class function TControllerCampeonatos.IniciarCampeonato(
  ACodCampeonato: Integer): Boolean;
var
  DmCampeoanto : TDmCampeonato;
  Campeonato : TCampeonato;
begin
  Result := False;
  try
    DmCampeoanto := TDmCampeonato.Create(nil);
    Campeonato := DmCampeoanto.Selecionar(ACodCampeonato);
    Campeonato.Estado := EEstado.CmpIniciado;
    DmCampeoanto.Editar(Campeonato);
    Result := True;
  except
    Result := False;
  end;
end;

class function TControllerCampeonatos.InscreverCliente(ACodCliente,
  ACodCampeonato: Integer): Boolean;
var
  Competidor : TCompetidor;
  Competidores : TObjectList<TCompetidor>;
  DmCompetidores : TDmCompetidores;
begin
  Result := False;
  try
    Competidor := TCompetidor.Create();
    Competidor.CodCliente    := ACodCliente;
    Competidor.CodCampeonato := ACodCampeonato;
    Competidor.Pontuacao     := 0;
    Competidor.Partidas      := 0;
    Competidor.Vitorias      := 0;
    Competidor.Derrotas      := 0;
    Competidor.Empates       := 0;

    DmCompetidores := TDmCompetidores.Create(nil);

    Competidores := DmCompetidores.SelecionarCampeonato(ACodCampeonato);
    for var CompetidorInscrito in Competidores do
    begin
      if CompetidorInscrito.Codigo = Competidor.Codigo then
      begin
        Result := True;
        Exit();
      end;
    end;

    if TDmCampeonato.Create(nil).Selecionar(ACodCampeonato).NumParticipantes < Competidores.Count then
    begin
      DmCompetidores.Inserir(Competidor);
      Result := True;
    end;
  except
    Result := False;
  end;
end;

end.
