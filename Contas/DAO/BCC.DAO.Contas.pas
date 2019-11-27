unit BCC.DAO.Contas;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, BCC.Model.Contas,
  BCC.Conexao.DAO.Dados, DateUtils;

type
  TDmContas = class(TDataModule)
    TbContas: TADOQuery;
    TbContasCodigo: TAutoIncField;
    TbContasNome: TStringField;
    TbContasValor: TFloatField;
    TbContasVencimento: TDateTimeField;
    TbContasEmissao: TDateTimeField;
    TbContasPagamento: TDateTimeField;
  private
    { Private declarations }
    procedure ObjToData(AConta : TConta);
    function  DataToObj() : TConta;
  public
    { Public declarations }
    function Inserir(AConta : TConta) : TConta;
    function Selecionar(ACodConta : Integer) : TConta;
    procedure Editar(AConta : TConta);
  end;

var
  DmContas: TDmContas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmContas }

procedure TDmContas.ObjToData(AConta: TConta);
begin
  Self.TbContasNome.Value := AConta.Nome;
  Self.TbContasValor.Value := AConta.Valor;
  Self.TbContasVencimento.Value := AConta.Vencimento;
  Self.TbContasEmissao.Value := AConta.Emissao;
  Self.TbContasPagamento.Value := AConta.Pagamento;
end;

procedure TDmContas.Editar(AConta: TConta);
begin
  Self.Selecionar(AConta.Codigo);
  Self.TbContas.Edit();
  Self.ObjToData(AConta);
  Self.TbContas.Post();
end;

function TDmContas.Inserir(AConta: TConta): TConta;
begin
  Self.TbContas.Close();
  Self.TbContas.SQL.Text := 'SELECT * FROM Contas WHERE -1 = 1';
  Self.TbContas.Open();

  Self.TbContas.Append();
  Self.ObjToData(AConta);
  Self.TbContas.Post();

  Result := DataToObj();
end;

function TDmContas.DataToObj: TConta;
begin
  Result := TConta.Create();
  Result.Codigo := Self.TbContasCodigo.Value;
  Result.Nome   := Self.TbContasNome.Value;
  Result.Valor  := Self.TbContasValor.Value;
  Result.Vencimento := DateOf(Self.TbContasVencimento.Value);
  Result.Emissao    := DateOf(Self.TbContasEmissao.Value);
  Result.Pagamento  := DateOf(Self.TbContasPagamento.Value);
end;

function TDmContas.Selecionar(ACodConta: Integer): TConta;
begin
  Self.TbContas.Close();
  Self.TbContas.SQL.Text := 'SELECT * FROM Contas WHERE Codigo = ' + ACodConta.ToString();
  Self.TbContas.Open();

  Result := Self.DataToObj();
end;

end.
