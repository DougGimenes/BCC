unit BCC.Relatorio.View.JogosPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.Relatorio.View.RelBase,
  Data.DB, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.ComCtrls, BCC.Relatorio.Report.JogosPedidos;

type
  TFraRelJogosSolicitados = class(TFraRelBase)
    QryRelatorioVezes: TIntegerField;
    QryRelatorioJogo: TStringField;
    DtpFinal: TDateTimePicker;
    LblFinal: TLabel;
    DtpInicial: TDateTimePicker;
    LblPeriodo: TLabel;
    procedure BtnGerarRelatorioClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirConsulta(); override;
    procedure TratarTela(); override;
  public
    { Public declarations }
  end;

var
  FraRelJogosSolicitados: TFraRelJogosSolicitados;

implementation

{$R *.dfm}

{ TFraRelBase1 }

procedure TFraRelJogosSolicitados.AbrirConsulta;
begin
  inherited;
  Self.QryRelatorio.Close();
  Self.QryRelatorio.SQL.Text := 'SELECT' + #13 +
                                '  j.ID_Jogo,' + #13 +
                                '  COUNT(i.ID_ItemVenda) as ''Vezes'',' + #13 +
                                '  j.Identificacao AS ''Jogo''' + #13 +
                                'FROM Vendas v' + #13 +
                                '  LEFT JOIN Itens_Venda i ON i.ID_Vendas = v.ID_Vendas' + #13 +
                                '  LEFT JOIN Jogos j ON j.ID_Jogo = i.ID_Jogo' + #13 +
                                'WHERE Data BETWEEN ' + QuotedStr(DateToStr(Self.DtpInicial.Date)) + ' and ' + QuotedStr(DateToStr(Self.DtpFinal.Date)) + #13 +
                                '  AND J.ID_Jogo IS NOT NULL' + #13 +
                                'GROUP BY j.ID_Jogo, j.Identificacao' + #13 +
                                'ORDER BY Vezes DESC';
  Self.QryRelatorio.Open();
end;

procedure TFraRelJogosSolicitados.BtnGerarRelatorioClick(Sender: TObject);
var
  Relatorio : TRelJogoSolicitado;
begin
  inherited;
  Relatorio := TRelJogoSolicitado.Create(Self);
  try
    Relatorio.SetDataSource(Self.DsRelatorio);
    Relatorio.SetDataFiltro(Self.DtpInicial.Date, Self.DtpFinal.Date);
    Relatorio.RlrJogosSolicitados.PreviewModal();
  finally
    FreeAndNil(Relatorio);
  end;

end;

procedure TFraRelJogosSolicitados.TratarTela;
begin
  inherited;
  Self.DtpInicial.Date := Date();
  Self.DtpFinal.Date := Date();
  Self.Titulo := 'Relatório de jogos mais solicitados';
  Self.SubTitulo := 'Entre ' + DateToStr(Self.DtpInicial.Date) + ' e ' + DateToStr(Self.DtpFinal.Date);
end;

end.
