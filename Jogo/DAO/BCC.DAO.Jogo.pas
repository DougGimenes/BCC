unit BCC.DAO.Jogo;

interface

uses
  System.SysUtils, System.Classes, BCC.Conexao.DAO.Dados, Data.DB, Data.Win.ADODB,
  BCC.Model.Jogo, System.Generics.Collections;

type
  TDmJogo = class(TDataModule)
    TbJogos: TADOQuery;
    TbJogosID_Jogo: TAutoIncField;
    TbJogosIdentificacao: TStringField;
    TbJogosNum_Copias: TIntegerField;
    TbJogosAtivo: TBooleanField;
    TbJogosNum_Pessoas: TIntegerField;
  private
    { Private declarations }
    procedure ObjToData(AJogo : TJogo);
    function  DataToObj() : TJogo;
  public
    { Public declarations }
    function  Inserir(AJogo : TJogo) : TJogo;
    function  Selecionar(ACodigo : Integer) : TJogo;
    function  SelecionarTodos() : TObjectList<TJogo>;
    procedure Editar(AJogo : TJogo);
  end;

var
  DmJogo: TDmJogo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmJogos }

function TDmJogo.DataToObj: TJogo;
begin
  Result := TJogo.Create();
  Result.Codigo := Self.TbJogosID_Jogo.Value;
  Result.Nome   := Self.TbJogosIdentificacao.Value;
  Result.MaxJogadores := Self.TbJogosNum_Pessoas.Value;
  Result.NumeroCopias := Self.TbJogosNum_Copias.Value;
  Result.Ativo := Self.TbJogosAtivo.Value;
end;

procedure TDmJogo.Editar(AJogo: TJogo);
begin
  Self.Selecionar(AJogo.Codigo);
  Self.TbJogos.Edit();
  Self.ObjToData(AJogo);
  Self.TbJogos.Post();
end;

function TDmJogo.Inserir(AJogo: TJogo): TJogo;
begin
  Self.TbJogos.Close();
  Self.TbJogos.SQL.Clear();
  Self.TbJogos.SQL.Text := 'SELECT * FROM Jogos' + #13 +
                           '  WHERE -1 = 1';
  Self.TbJogos.Open();
  Self.TbJogos.Append();
  Self.ObjToData(AJogo);
  Self.TbJogos.Post();

  Result := Self.DataToObj();
end;

procedure TDmJogo.ObjToData(AJogo: TJogo);
begin
  Self.TbJogosIdentificacao.Value := AJogo.Nome;
  Self.TbJogosNum_Copias.Value    := AJogo.NumeroCopias;
  Self.TbJogosNum_Pessoas.Value   := AJogo.MaxJogadores;
  Self.TbJogosAtivo.Value         := AJogo.Ativo;
end;

function TDmJogo.Selecionar(ACodigo: Integer): TJogo;
begin
  Self.TbJogos.Close();
  Self.TbJogos.SQL.Clear();
  Self.TbJogos.SQL.Text := 'SELECT * FROM Jogos' + #13 +
                          '  WHERE ID_Jogo = ' + ACodigo.ToString();
  Self.TbJogos.Open();

  Result := Self.DataToObj();
end;

function TDmJogo.SelecionarTodos: TObjectList<TJogo>;
var
  I: Integer;
begin
  Self.TbJogos.Close();
  Self.TbJogos.SQL.Clear();
  Self.TbJogos.SQL.Text := 'SELECT * FROM Jogos';
  Self.TbJogos.Open();

  Result := TObjectList<TJogo>.Create(True);
  Self.TbJogos.First();
  for I := 0 to Self.TbJogos.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbJogos.Next();
  end;
end;

end.
