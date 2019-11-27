unit BCC.Relatorio.View.VendasDia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.Relatorio.View.RelBase, Data.DB,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls;

type
  TFraRelVendasDia = class(TFraRelBase)
    DtpInicial: TDateTimePicker;
    QryRelatorioID_Vendas: TAutoIncField;
    QryRelatorioIdentificacao: TStringField;
    QryRelatorioValor_Total: TFloatField;
    LblPeriodo: TLabel;
    LblFinal: TLabel;
    DtpFinal: TDateTimePicker;
  private
    { Private declarations }
    procedure AbrirConsulta(); override;
    procedure TratarTela(); override;
  public
    { Public declarations }
  end;

var
  FraRelVendasDia: TFraRelVendasDia;

implementation

{$R *.dfm}

{ TFraRelVendasDia }

procedure TFraRelVendasDia.AbrirConsulta;
begin
  inherited;
  Self.QryRelatorio.Close();
  Self.QryRelatorio.SQL.Text := 'SELECT'                                  + #13 +
                                '  ID_Vendas,'                            + #13 +
                                '  Identificacao,'                        + #13 +
                                '  Valor_Total'                           + #13 +
                                'FROM Vendas'                             + #13 +
                                '  WHERE Data BETWEEN ' + QuotedStr(DateToStr(Self.DtpInicial.Date)) + ' and ' + QuotedStr(DateToStr(Self.DtpFinal.Date));
  Self.QryRelatorio.Open();
end;

procedure TFraRelVendasDia.TratarTela;
begin
  inherited;
  Self.DtpInicial.Date := Date();
  Self.DtpFinal.Date := Date();
  Self.Titulo := 'Relatório de vendas';
  Self.SubTitulo := 'Entre ' + DateToStr(Self.DtpInicial.Date) + ' e ' + DateToStr(Self.DtpFinal.Date);
end;

end.
