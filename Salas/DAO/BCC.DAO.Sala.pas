unit BCC.DAO.Sala;

interface

uses
  System.SysUtils, System.Classes, BCC.Conexao.DAO.Dados, Data.DB, Data.Win.ADODB,
  BCC.Model.Sala, System.Generics.Collections;

type
  TDmSala = class(TDataModule)
    TbSala: TADOQuery;
    TbSalaID_Sala: TAutoIncField;
    TbSalaNum_Pessoas: TIntegerField;
    TbSalaAtivo: TBooleanField;
    TbSalaIdentifiacacao: TStringField;
    TbSalaValorHora: TFloatField;
    TbSalaDescricao: TMemoField;
  private
    { Private declarations }
    procedure ObjToData(ASala : TSala);
    function  DataToObj() : TSala;
  public
    { Public declarations }
    function  Inserir(ASala : TSala) : TSala;
    function  Selecionar(ACodigo : Integer) : TSala;
    function  SelecionarTodos() : TObjectList<TSala>;
    procedure Editar(ASala: TSala);
  end;

var
  DmSala: TDmSala;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmSala }

function TDmSala.DataToObj: TSala;
begin
  Result := TSala.Create();
  Result.Codigo     := Self.TbSalaID_Sala.Value;
  Result.Descricao  := Self.TbSalaIdentifiacacao.Value;
  Result.MaxPessoas := Self.TbSalaNum_Pessoas.Value;
  Result.Ativo      := Self.TbSalaAtivo.Value;
  Result.ValorHora  := Self.TbSalaValorHora.Value;
  Result.Informacao := Self.TbSalaDescricao.Value
end;

procedure TDmSala.Editar(ASala: TSala);
begin
  Self.Selecionar(ASala.Codigo);
  Self.TbSala.Edit();
  Self.ObjToData(ASala);
  Self.TbSala.Post();
end;

function TDmSala.Inserir(ASala: TSala): TSala;
begin
  Self.TbSala.Close();
  Self.TbSala.SQL.Clear();
  Self.TbSala.SQL.Text := 'SELECT * FROM Sala' + #13 +
                          '  WHERE -1 = 1';
  Self.TbSala.Open();
  Self.TbSala.Append();
  Self.ObjToData(ASala);
  Self.TbSala.Post();

  Result := Self.DataToObj();
end;

procedure TDmSala.ObjToData(ASala: TSala);
begin
  Self.TbSalaIdentifiacacao.Value := ASala.Descricao;
  Self.TbSalaNum_Pessoas.Value    := ASala.MaxPessoas;
  Self.TbSalaAtivo.Value          := ASala.Ativo;
  Self.TbSalaValorHora.Value      := ASala.ValorHora;
  Self.TbSalaDescricao.Value      := ASala.Informacao;
end;

function TDmSala.Selecionar(ACodigo: Integer): TSala;
begin
  Self.TbSala.Close();
  Self.TbSala.SQL.Clear();
  Self.TbSala.SQL.Text := 'SELECT * FROM Sala' + #13 +
                          '  WHERE ID_Sala = ' + ACodigo.ToString();
  Self.TbSala.Open();

  Result := Self.DataToObj();
end;

function TDmSala.SelecionarTodos: TObjectList<TSala>;
var
  I: Integer;
begin
  Self.TbSala.Close();
  Self.TbSala.SQL.Clear();
  Self.TbSala.SQL.Text := 'SELECT * FROM Sala';
  Self.TbSala.Open();

  Result := TObjectList<TSala>.Create(True);
  Self.TbSala.First();
  for I := 0 to Self.TbSala.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbSala.Next();
  end;
end;

end.
