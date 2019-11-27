unit BCC.Caixa.DAO.Movimentacao;

interface

uses
  System.SysUtils, System.Classes, BCC.Conexao.DAO.Dados, Data.DB, Data.Win.ADODB,
  BCC.Caixa.Model.Movimentacao;

type
  TDmMovimentacao = class(TDataModule)
    TbMovimentacaoCaixa: TADOQuery;
    TbMovimentacaoCaixaCodigo: TAutoIncField;
    TbMovimentacaoCaixaCodCaixa: TIntegerField;
    TbMovimentacaoCaixaValor: TFloatField;
    TbMovimentacaoCaixaCodConta: TIntegerField;
    TbMovimentacaoCaixaCodTitulo: TIntegerField;
  private
    { Private declarations }
    procedure ObjToData(AMovimentacao : TMovimentacao);
  public
    { Public declarations }
    procedure AdicionarMovimentacao(AValor : Double; ACodConta: Integer =  -1; ACodTitulo : Integer =  -1);
  end;

var
  DmMovimentacao: TDmMovimentacao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmMovimentacao }

procedure TDmMovimentacao.AdicionarMovimentacao(AValor: Double; ACodConta, ACodTitulo : Integer);
var
  Movimentacao : TMovimentacao;
begin
  Self.TbMovimentacaoCaixa.Close();
  Self.TbMovimentacaoCaixa.Open();

  Movimentacao := TMovimentacao.Create();
  Movimentacao.CodCaixa := DmDados.CodCaixa;
  Movimentacao.Valor := AValor;
  Movimentacao.CodConta := ACodConta;
  Movimentacao.CodTitulo := ACodTitulo;

  Self.TbMovimentacaoCaixa.Append();
  Self.ObjToData(Movimentacao);
  Self.TbMovimentacaoCaixa.Post();
end;

procedure TDmMovimentacao.ObjToData(AMovimentacao: TMovimentacao);
begin
  Self.TbMovimentacaoCaixaCodCaixa.Value  := AMovimentacao.CodCaixa;
  Self.TbMovimentacaoCaixaValor.Value     := AMovimentacao.Valor;

  if not (AMovimentacao.CodConta = AMovimentacao.CodTitulo) then
  begin
    if AMovimentacao.CodConta > 0 then
    begin
      Self.TbMovimentacaoCaixaCodConta.Value  := AMovimentacao.CodConta;
      Self.TbMovimentacaoCaixaCodTitulo.Clear();
    end
    else
    begin
      Self.TbMovimentacaoCaixaCodTitulo.Value := AMovimentacao.CodTitulo;
      Self.TbMovimentacaoCaixaCodConta.Clear();
    end;
  end
  else
  begin
    Self.TbMovimentacaoCaixaCodConta.Clear();
    Self.TbMovimentacaoCaixaCodTitulo.Clear();
  end;
end;

end.
