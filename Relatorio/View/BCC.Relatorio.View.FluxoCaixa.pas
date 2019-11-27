unit BCC.Relatorio.View.FluxoCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.Relatorio.View.RelBase,
  Data.DB, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.ComCtrls, BCC.Relatorio.Report.FluxoCaixa;

type
  TFraRelFluxoCaixa = class(TFraRelBase)
    LblPeriodo: TLabel;
    DtpInicial: TDateTimePicker;
    LblFinal: TLabel;
    DtpFinal: TDateTimePicker;
    QryRelatorioTipo: TStringField;
    QryRelatorioValor: TFloatField;
    procedure BtnGerarRelatorioClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirConsulta(); override;
    procedure TratarTela(); override;
  public
    { Public declarations }
  end;

var
  FraRelFluxoCaixa: TFraRelFluxoCaixa;

implementation

{$R *.dfm}

{ TFraRelBase1 }

procedure TFraRelFluxoCaixa.AbrirConsulta;
begin
  inherited;
  Self.QryRelatorio.Close();
  Self.QryRelatorio.SQL.Text := 'SELECT' + #13 +
                                '  CASE' + #13 +
                                '    WHEN m.CodTitulo IS NOT NULL THEN ''Titulo de Recebimento''' + #13 +
                                '    ELSE ''Conta Paga'''  + #13 +
                                '  END AS Tipo,'           + #13 +
                                '  ISNULL(tit.Valor, C.Valor * -1) AS Valor' + #13 +
                                'FROM MovimentacaoCaixa m' + #13 +
                                '  INNER JOIN Caixa ON Caixa.Codigo = m.CodCaixa' + #13 +
                                '  LEFT JOIN Contas c ON m.CodConta = c.Codigo' + #13 +
                                '  LEFT JOIN Titulos tit ON m.CodTitulo = tit.Codigo' + #13 +
                                'WHERE (Caixa.Abertura BETWEEN ' + QuotedStr(DateToStr(Self.DtpInicial.Date) + ' 00:00:00') + ' AND ' + QuotedStr(DateToStr(Self.DtpFinal.Date) + ' 23:59:59') + #13 +
                                '  OR Caixa.Fechamento BETWEEN ' + QuotedStr(DateToStr(Self.DtpInicial.Date) + ' 00:00:00') + ' AND ' + QuotedStr(DateToStr(Self.DtpFinal.Date) + ' 23:59:59') + ')' + #13 +
                                '  AND (NOT (m.CodTitulo IS NULL AND m.CodConta IS NULL))';
  Self.QryRelatorio.Open();
end;

procedure TFraRelFluxoCaixa.BtnGerarRelatorioClick(Sender: TObject);
var
  Relatorio : TRelFluxoCaixa;
begin
  inherited;
  Relatorio := TRelFluxoCaixa.Create(Self);
  try
    Relatorio.SetDataSource(Self.DsRelatorio);
    Relatorio.SetDataFiltro(Self.DtpInicial.Date, Self.DtpFinal.Date);
    Relatorio.RlrFluxoCaixa.PreviewModal();
  finally
    FreeAndNil(Relatorio);
  end;
end;

procedure TFraRelFluxoCaixa.TratarTela;
begin
  inherited;
  Self.DtpInicial.Date := Date();
  Self.DtpFinal.Date := Date();
  Self.Titulo := 'Relatório de fluxo de caixa';
  Self.SubTitulo := 'Entre ' + DateToStr(Self.DtpInicial.Date) + ' e ' + DateToStr(Self.DtpFinal.Date);
end;

end.
