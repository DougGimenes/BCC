unit BCC.DAO.Competidores;

interface

uses
  System.SysUtils, System.Classes, BCC.Conexao.DAO.Dados, Data.DB, Data.Win.ADODB,
  BCC.Model.Competidores, System.Generics.Collections;

type
  TDmCompetidores = class(TDataModule)
    TbCompetidores: TADOQuery;
    TbCompetidoresID_Comp: TAutoIncField;
    TbCompetidoresPontuacao: TIntegerField;
    TbCompetidoresPartidas: TIntegerField;
    TbCompetidoresVitorias: TIntegerField;
    TbCompetidoresDerrotas: TIntegerField;
    TbCompetidoresEmpates: TIntegerField;
    TbCompetidoresID_Campeonato: TIntegerField;
    TbCompetidoresID_Cliente: TIntegerField;
  private
    { Private declarations }
    procedure ObjToData(ACompetidor : TCompetidor);
    function  DataToObj() : TCompetidor;
  public
    { Public declarations }
    function  Inserir(ACompetidor : TCompetidor) : TCompetidor;
    function  Selecionar(ACodigo : Integer) : TCompetidor;
    function  SelecionarTodos() : TObjectList<TCompetidor>;
    function  SelecionarCampeonato(ACodCampeonato : Integer) : TObjectList<TCompetidor>;
    procedure Editar(ACompetidor : TCompetidor);
  end;

var
  DmCompetidores: TDmCompetidores;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmCompetidores }

function TDmCompetidores.DataToObj: TCompetidor;
begin
  Result := TCompetidor.Create();
  Result.Codigo        := Self.TbCompetidoresID_Comp.Value;
  Result.CodCliente    := Self.TbCompetidoresID_Cliente.Value;
  Result.CodCampeonato := Self.TbCompetidoresID_Campeonato.Value;
  Result.Partidas      := Self.TbCompetidoresPartidas.Value;
  Result.Pontuacao     := Self.TbCompetidoresPontuacao.Value;
  Result.Vitorias      := Self.TbCompetidoresVitorias.Value;
  Result.Derrotas      := Self.TbCompetidoresDerrotas.Value;
  Result.Empates       := Self.TbCompetidoresEmpates.Value;
end;

procedure TDmCompetidores.Editar(ACompetidor: TCompetidor);
begin
  Self.Selecionar(ACompetidor.Codigo);
  Self.TbCompetidores.Edit();
  Self.ObjToData(ACompetidor);
  Self.TbCompetidores.Post();
end;

function TDmCompetidores.Inserir(ACompetidor: TCompetidor): TCompetidor;
begin
  Self.TbCompetidores.Close();
  Self.TbCompetidores.SQL.Clear();
  Self.TbCompetidores.SQL.Text := 'SELECT * FROM Competidores_Campeonato' + #13 +
                                  '  WHERE -1 = 1';
  Self.TbCompetidores.Open();
  Self.TbCompetidores.Append();
  Self.ObjToData(ACompetidor);
  Self.TbCompetidores.Post();

  Result := Self.DataToObj();
end;

procedure TDmCompetidores.ObjToData(ACompetidor: TCompetidor);
begin
  Self.TbCompetidoresID_Cliente.Value    := ACompetidor.CodCliente;
  Self.TbCompetidoresID_Campeonato.Value := ACompetidor.CodCampeonato;
  Self.TbCompetidoresPartidas.Value      := ACompetidor.Partidas;
  Self.TbCompetidoresPontuacao.Value     := ACompetidor.Pontuacao;
  Self.TbCompetidoresVitorias.Value      := ACompetidor.Vitorias;
  Self.TbCompetidoresDerrotas.Value      := ACompetidor.Derrotas;
  Self.TbCompetidoresEmpates.Value       := ACompetidor.Empates;
end;

function TDmCompetidores.Selecionar(ACodigo: Integer): TCompetidor;
begin
  Self.TbCompetidores.Close();
  Self.TbCompetidores.SQL.Clear();
  Self.TbCompetidores.SQL.Text := 'SELECT * FROM Competidores_Campeonato' + #13 +
                                  '  WHERE ID_Comp = ' + ACodigo.ToString();
  Self.TbCompetidores.Open();

  Result := Self.DataToObj();
end;

function TDmCompetidores.SelecionarCampeonato(
  ACodCampeonato: Integer): TObjectList<TCompetidor>;
var
  I: Integer;
begin
  Self.TbCompetidores.Close();
  Self.TbCompetidores.SQL.Clear();
  Self.TbCompetidores.SQL.Text := 'SELECT * FROM Competidores_Campeonato' + #13 +
                                  '  WHERE ID_Campeonato = 0' + ACodCampeonato.ToString();
  Self.TbCompetidores.Open();

  Result := TObjectList<TCompetidor>.Create(True);
  Self.TbCompetidores.First();
  for I := 0 to Self.TbCompetidores.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbCompetidores.Next();
  end;
end;

function TDmCompetidores.SelecionarTodos: TObjectList<TCompetidor>;
var
  I: Integer;
begin
  Self.TbCompetidores.Close();
  Self.TbCompetidores.SQL.Clear();
  Self.TbCompetidores.SQL.Text := 'SELECT * FROM Competidores_Campeonato';
  Self.TbCompetidores.Open();

  Result := TObjectList<TCompetidor>.Create(True);
  Self.TbCompetidores.First();
  for I := 0 to Self.TbCompetidores.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbCompetidores.Next();
  end;
end;

end.
