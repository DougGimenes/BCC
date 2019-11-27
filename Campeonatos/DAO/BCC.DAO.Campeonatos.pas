unit BCC.DAO.Campeonatos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, BCC.Model.Campeonato,
  BCC.Conexao.DAO.Dados, System.Generics.Collections;

type
  TDmCampeonato = class(TDataModule)
    TbCampeonato: TADOQuery;
    TbCampeonatoID_Campeonato: TAutoIncField;
    TbCampeonatoNum_Participantes: TIntegerField;
    TbCampeonatoFormato: TIntegerField;
    TbCampeonatoEstado: TIntegerField;
    TbCampeonatoIdentificacao: TStringField;
    TbCampeonatoID_Jogo: TIntegerField;
  private
    { Private declarations }
    function  DataToObj() : TCampeonato;
    procedure ObjToData(ACampeonato : TCampeonato);
  public
    { Public declarations }
    function  Inserir(ACampeonato : TCampeonato) : TCampeonato;
    function  Selecionar(ACodigo : Integer) : TCampeonato;
    function  SelecionarTodos() : TObjectList<TCampeonato>;
    function  SelecionarEmAberto() : TObjectList<TCampeonato>;
    procedure Editar(ACampeonato : TCampeonato);
  end;

var
  DmCampeonato: TDmCampeonato;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmCampeonato }

function TDmCampeonato.DataToObj: TCampeonato;
begin
  Result := TCampeonato.Create();
  Result.Codigo           := Self.TbCampeonatoID_Campeonato.Value;
  Result.Identificacao    := Self.TbCampeonatoIdentificacao.Value;
  Result.NumParticipantes := Self.TbCampeonatoNum_Participantes.Value;
  Result.CodJogo          := Self.TbCampeonatoID_Jogo.Value;
  Result.Formato          := EFormato(Self.TbCampeonatoFormato.Value);
  Result.Estado           := EEstado(Self.TbCampeonatoEstado.Value);
end;

procedure TDmCampeonato.Editar(ACampeonato: TCampeonato);
begin
  Self.Selecionar(ACampeonato.Codigo);
  Self.TbCampeonato.Edit();
  Self.ObjToData(ACampeonato);
  Self.TbCampeonato.Post();
end;

function TDmCampeonato.Inserir(ACampeonato: TCampeonato): TCampeonato;
begin
  Self.TbCampeonato.Close();
  Self.TbCampeonato.SQL.Clear();
  Self.TbCampeonato.SQL.Text := 'SELECT * FROM Campeonatos' + #13 +
                                '  WHERE -1 = 1';
  Self.TbCampeonato.Open();
  Self.TbCampeonato.Append();
  Self.ObjToData(ACampeonato);
  Self.TbCampeonato.Post();

  Result := Self.DataToObj();
end;

procedure TDmCampeonato.ObjToData(ACampeonato: TCampeonato);
begin
  Self.TbCampeonatoNum_Participantes.Value := ACampeonato.NumParticipantes;
  Self.TbCampeonatoFormato.Value           := Integer(ACampeonato.Formato);
  Self.TbCampeonatoEstado.Value            := Integer(ACampeonato.Estado);
  Self.TbCampeonatoIdentificacao.Value     := ACampeonato.Identificacao;
  Self.TbCampeonatoID_Jogo.Value           := ACampeonato.CodJogo;
end;

function TDmCampeonato.Selecionar(ACodigo: Integer): TCampeonato;
begin
  Self.TbCampeonato.Close();
  Self.TbCampeonato.SQL.Clear();
  Self.TbCampeonato.SQL.Text := 'SELECT * FROM Campeonatos' + #13 +
                                '  WHERE ID_Campeonato = ' + ACodigo.ToString();
  Self.TbCampeonato.Open();
  Result := Self.DataToObj();
end;

function TDmCampeonato.SelecionarEmAberto: TObjectList<TCampeonato>;
var
  I: Integer;
begin
  Self.TbCampeonato.Close();
  Self.TbCampeonato.SQL.Clear();
  Self.TbCampeonato.SQL.Text := 'SELECT * FROM Campeonatos' + #13 +
                                '  WHERE Estado = 0';
  Self.TbCampeonato.Open();

  Result := TObjectList<TCampeonato>.Create(True);
  Self.TbCampeonato.First();
  for I := 0 to Self.TbCampeonato.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbCampeonato.Next();
  end;
end;

function TDmCampeonato.SelecionarTodos: TObjectList<TCampeonato>;
var
  I: Integer;
begin
  Self.TbCampeonato.Close();
  Self.TbCampeonato.SQL.Clear();
  Self.TbCampeonato.SQL.Text := 'SELECT * FROM Campeonatos';
  Self.TbCampeonato.Open();

  Result := TObjectList<TCampeonato>.Create(True);
  Self.TbCampeonato.First();
  for I := 0 to Self.TbCampeonato.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbCampeonato.Next();
  end;
end;

end.
