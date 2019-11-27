unit BCC.Relatorio.View.ProdutosVendidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.Relatorio.View.RelBase,
  Data.DB, Vcl.StdCtrls, Vcl.ComCtrls, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, BCC.Relatorio.Report.ProdutosVendidos;

type
  TFraRelProdutosVendidos = class(TFraRelBase)
    DtpFinal: TDateTimePicker;
    LblFinal: TLabel;
    DtpInicial: TDateTimePicker;
    LblPeriodo: TLabel;
    QryRelatorioDescricao: TStringField;
    QryRelatorioQtdeVendida: TFloatField;
    QryRelatorioValorTotal: TFloatField;
    procedure BtnGerarRelatorioClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirConsulta(); override;
    procedure TratarTela(); override;
  public
    { Public declarations }
  end;

var
  FraRelProdutosVendidos: TFraRelProdutosVendidos;

implementation

{$R *.dfm}

{ TFraRelProdutosVendidos }

procedure TFraRelProdutosVendidos.AbrirConsulta;
begin
  inherited;
  Self.QryRelatorio.Close();
  Self.QryRelatorio.SQL.Text := 'SELECT' + #13 +
                                '  i.Descricao,' + #13 +
                                '  SUM(i.Qtde_Prod) AS ''QtdeVendida'',' + #13 +
                                '  SUM(i.ValorTotal) AS ''ValorTotal''' + #13 +
                                'FROM Vendas v' + #13 +
                                '  LEFT JOIN Itens_Venda i ON i.ID_Vendas = v.ID_Vendas' + #13 +
                                'WHERE Data BETWEEN ' + QuotedStr(DateToStr(Self.DtpInicial.Date) + ' 00:00:00') + ' and ' + QuotedStr(DateToStr(Self.DtpFinal.Date) + ' 23:59:59') + #13 +
                                '  AND i.ID_Prod > 0' + #13 +
                                'GROUP BY i.Descricao';
  Self.QryRelatorio.Open();
end;

procedure TFraRelProdutosVendidos.BtnGerarRelatorioClick(Sender: TObject);
var
  Relatorio : TRelProdutosVendidos;
begin
  inherited;
  Relatorio := TRelProdutosVendidos.Create(Self);
  try
    Relatorio.SetDataSource(Self.DsRelatorio);
    Relatorio.SetDataFiltro(Self.DtpInicial.Date, Self.DtpFinal.Date);
    Relatorio.RlrFluxoCaixa.PreviewModal();
  finally
    FreeAndNil(Relatorio);
  end;
end;

procedure TFraRelProdutosVendidos.TratarTela;
begin
  inherited;
  Self.DtpInicial.Date := Date();
  Self.DtpFinal.Date := Date();
  Self.Titulo := 'Relatório de produtos vendidos';
  Self.SubTitulo := 'Entre ' + DateToStr(Self.DtpInicial.Date) + ' e ' + DateToStr(Self.DtpFinal.Date);
end;

end.
