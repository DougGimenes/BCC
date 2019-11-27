unit BCC.DAO.Servico;

interface

uses
  System.SysUtils, System.Classes, BCC.Conexao.DAO.Dados, Data.DB, Data.Win.ADODB,
  BCC.Model.Servico, System.Generics.Collections;

type
  TDmServico = class(TDataModule)
    TbServico: TADOQuery;
    TbServicoID_Servico: TAutoIncField;
    TbServicoNome: TStringField;
    TbServicoValor: TFloatField;
    TbServicoAtivo: TBooleanField;
    TbServicoDescricao: TStringField;
  private
    { Private declarations }
    procedure ObjToData(AServico : TServico);
    function  DataToObj() : TServico;
  public
    { Public declarations }
    function  Inserir(AServico : TServico) : TServico;
    function  Selecionar(ACodigo : Integer) : TServico;
    function  SelecionarTodos() : TObjectList<TServico>;
    procedure Editar(AServico : TServico);
  end;

var
  DmServico: TDmServico;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmServico }

function TDmServico.DataToObj: TServico;
begin
  Result := TServico.Create();
  Result.Codigo     := Self.TbServicoID_Servico.Value;
  Result.Nome       := Self.TbServicoNome.Value;
  Result.Valor      := Self.TbServicoValor.Value;
  Result.Ativo      := Self.TbServicoAtivo.Value;
  Result.Descricao  := Self.TbServicoDescricao.Value;
end;

procedure TDmServico.Editar(AServico: TServico);
begin
  Self.Selecionar(AServico.Codigo);
  Self.TbServico.Edit();
  Self.ObjToData(AServico);
  Self.TbServico.Post();
end;

function TDmServico.Inserir(AServico: TServico): TServico;
begin
  Self.TbServico.Close();
  Self.TbServico.SQL.Clear();
  Self.TbServico.SQL.Text := 'SELECT * FROM Servicos' + #13 +
                             '  WHERE -1 = 1';
  Self.TbServico.Open();
  Self.TbServico.Append();
  Self.ObjToData(AServico);
  Self.TbServico.Post();

  Result := Self.DataToObj();
end;

procedure TDmServico.ObjToData(AServico: TServico);
begin
  Self.TbServicoNome.Value  := AServico.Nome;
  Self.TbServicoValor.Value := AServico.Valor;
  Self.TbServicoAtivo.Value := AServico.Ativo;
  Self.TbServicoDescricao.Value := AServico.Descricao;
end;

function TDmServico.Selecionar(ACodigo: Integer): TServico;
begin
  Self.TbServico.Close();
  Self.TbServico.SQL.Clear();
  Self.TbServico.SQL.Text := 'SELECT * FROM Servicos' + #13 +
                             '  WHERE ID_Servico = ' + ACodigo.ToString();
  Self.TbServico.Open();

  Result := Self.DataToObj();
end;

function TDmServico.SelecionarTodos: TObjectList<TServico>;
var
  I: Integer;
begin
  Self.TbServico.Close();
  Self.TbServico.SQL.Clear();
  Self.TbServico.SQL.Text := 'SELECT * FROM Servicos';
  Self.TbServico.Open();

  Result := TObjectList<TServico>.Create(True);
  Self.TbServico.First();
  for I := 0 to Self.TbServico.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbServico.Next();
  end;
end;

end.
