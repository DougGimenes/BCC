unit BCC.DAO.Caixa;

interface

uses
  System.SysUtils, System.Classes, BCC.Conexao.DAO.Dados, Data.DB, Data.Win.ADODB,
  BCC.Model.Caixa;

type
  TDmCaixa = class(TDataModule)
    TbCaixa: TADOQuery;
    TbCaixaCodigo: TAutoIncField;
    TbCaixaAbertura: TDateTimeField;
    TbCaixaFechamento: TDateTimeField;
    TbCaixaSaldoInicial: TFloatField;
    TbCaixaSaldaoFinal: TFloatField;
    TbCaixaAberto: TBooleanField;
    QryValorFinal: TADOQuery;
    QryValorFinalValorCaixa: TFloatField;
  private
    { Private declarations }
    procedure ObjToData(ACaixa : TCaixa);
    function  DataToObj() : TCaixa;
  public
    { Public declarations }
    function  GetNovoCaixa(ASaldoInicial : Double) : Integer;
    procedure FecharCaixa();
    function  GetCaixaAberto() : Integer;
  end;

var
  DmCaixa: TDmCaixa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmCaixa }

function TDmCaixa.GetCaixaAberto: Integer;
begin
  Result := -1;
  Self.TbCaixa.Close();
  Self.TbCaixa.SQL.Clear();
  Self.TbCaixa.SQL.Text := 'SELECT * FROM Caixa WHERE Aberto = 1';
  Self.TbCaixa.Open();
  if Self.TbCaixa.RecordCount > 0 then
  begin
    Result := Self.TbCaixaCodigo.Value;
  end;
end;

function TDmCaixa.GetNovoCaixa(ASaldoInicial: Double): Integer;
var
  Caixa : TCaixa;
begin
  Caixa := TCaixa.Create();
  Caixa.Abertura := Now();
  Caixa.Aberto := True;
  Caixa.ValorInicial := ASaldoInicial;

  Self.TbCaixa.Close();
  Self.TbCaixa.SQL.Clear();
  Self.TbCaixa.SQL.Text := 'SELECT * FROM Caixa WHERE -1 = 1';
  Self.TbCaixa.Open();

  Self.TbCaixa.Append();
  Self.ObjToData(Caixa);
  Self.TbCaixa.Post();

  Result := Self.TbCaixaCodigo.Value;
end;

function TDmCaixa.DataToObj: TCaixa;
begin
  Result := TCaixa.Create();
  Result.Codigo := Self.TbCaixaCodigo.Value;
  Result.Abertura := Self.TbCaixaAbertura.Value;
  Result.Fechamento := Self.TbCaixaFechamento.Value;
  Result.ValorInicial := Self.TbCaixaSaldoInicial.Value;
  Result.ValorFinal := Self.TbCaixaSaldaoFinal.Value;
  Result.Aberto := Self.TbCaixaAberto.Value;
end;

procedure TDmCaixa.FecharCaixa();
var
  Caixa : TCaixa;
begin
  Self.TbCaixa.Close();
  Self.TbCaixa.SQL.Clear();
  Self.TbCaixa.SQL.Text := 'SELECT * FROM Caixa WHERE Codigo = ' + DmDados.CodCaixa.ToString();
  Self.TbCaixa.Open();

  Self.QryValorFinal.Close();
  Self.QryValorFinal.SQL.Clear();
  Self.QryValorFinal.SQL.Text := 'SELECT'                           + #13 +
                                 '  SUM(Valor) AS ValorCaixa'       + #13 +
                                 'FROM MovimentacaoCaixa'           + #13 +
                                 'WHERE CodCaixa = ' + DmDados.CodCaixa.ToString();
  Self.QryValorFinal.Open();

  Caixa := Self.DataToObj();

  Caixa.Fechamento := Now();
  Caixa.Aberto := False;
  Caixa.ValorFinal := Self.QryValorFinalValorCaixa.Value + Caixa.ValorInicial;

  Self.TbCaixa.Edit();
  Self.ObjToData(Caixa);
  Self.TbCaixa.Post();
end;

procedure TDmCaixa.ObjToData(ACaixa: TCaixa);
begin
  Self.TbCaixaAbertura.Value := ACaixa.Abertura;
  Self.TbCaixaFechamento.Value := ACaixa.Fechamento;
  Self.TbCaixaSaldoInicial.Value := ACaixa.ValorInicial;
  Self.TbCaixaSaldaoFinal.Value := ACaixa.ValorFinal;
  Self.TbCaixaAberto.Value := ACaixa.Aberto;
end;

end.
