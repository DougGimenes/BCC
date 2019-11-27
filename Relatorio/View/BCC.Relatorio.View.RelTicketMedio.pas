unit BCC.Relatorio.View.RelTicketMedio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.Relatorio.View.RelBase,
  Data.DB, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.ComCtrls, BCC.Relatorio.Report.TicketMedio;

type
  TFraRelTicketMedio = class(TFraRelBase)
    QryRelatorioNome: TStringField;
    QryRelatorioVendas: TIntegerField;
    QryRelatorioMedia: TFloatField;
    LblPeriodo: TLabel;
    DtpInicial: TDateTimePicker;
    LblFinal: TLabel;
    DtpFinal: TDateTimePicker;
    QryRelatorioValorTotal: TFloatField;
    procedure BtnGerarRelatorioClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirConsulta(); override;
    procedure TratarTela(); override;

    function GetMedia() : Double;
  public
    { Public declarations }
  end;

var
  FraRelTicketMedio: TFraRelTicketMedio;

implementation

{$R *.dfm}

{ TFraRelTicketMedio }

procedure TFraRelTicketMedio.AbrirConsulta;
begin
  inherited;
  Self.QryRelatorio.Close();
  Self.QryRelatorio.SQL.Text := 'SELECT' + #13 +
                                '  ISNULL(c.Nome, ''Não identificado'') Nome,' + #13 +
                                '  COUNT(v.ID_Vendas) ''Vendas'',' + #13 +
                                '  SUM(v.Valor_Total) / COUNT(v.ID_Vendas) AS Media,' + #13 +
                                '  SUM(V.Valor_Total) AS ValorTotal' + #13 +
                                'FROM Vendas v' + #13 +
                                '  LEFT JOIN Cliente c on v.ID_Cliente = c.ID_Cliente' + #13 +
                                'WHERE v.Data BETWEEN ' + QuotedStr(DateToStr(Self.DtpInicial.Date) + ' 00:00:00') + ' and ' + QuotedStr(DateToStr(Self.DtpFinal.Date) + ' 23:59:59') + #13 +
                                'GROUP BY c.Nome' + #13 +
                                'ORDER BY c.Nome';
  Self.QryRelatorio.Open();
end;

procedure TFraRelTicketMedio.BtnGerarRelatorioClick(Sender: TObject);
var
  Relatorio : TRelTicketMedio;
begin
  inherited;
  Relatorio := TRelTicketMedio.Create(Self);
  try
    Relatorio.SetDataSource(Self.DsRelatorio);
    Relatorio.SetDataFiltro(Self.DtpInicial.Date, Self.DtpFinal.Date);
    Relatorio.SetValorMedioFinal(Self.GetMedia());
    Relatorio.RlrFluxoCaixa.PreviewModal();
  finally
    FreeAndNil(Relatorio);
  end;
end;

function TFraRelTicketMedio.GetMedia: Double;
var
  I: Integer;
  Valor : Double;
  Qtde  : Integer;
begin
  Self.QryRelatorio.First();
  Valor := 0;
  Qtde := 0;
  for I := 0 to Self.QryRelatorio.RecordCount - 1 do
  begin
    Valor := Valor + Self.QryRelatorioValorTotal.Value;
    Qtde := Qtde + Self.QryRelatorioVendas.Value;
    Self.QryRelatorio.Next();
  end;

  Result := Valor / Qtde;
end;

procedure TFraRelTicketMedio.TratarTela;
begin
  inherited;
  Self.DtpInicial.Date := Date();
  Self.DtpFinal.Date := Date();
  Self.Titulo := 'Relatório de ticket médio';
  Self.SubTitulo := 'Entre ' + DateToStr(Self.DtpInicial.Date) + ' e ' + DateToStr(Self.DtpFinal.Date);
end;

end.
