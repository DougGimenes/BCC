unit BCC.Relatorio.Report.VendasDia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport;

type
  TRelVendasDia = class(TForm)
    RlrFluxoCaixa: TRLReport;
    RlbCabecalho: TRLBand;
    RllTitulo: TRLLabel;
    RllData: TRLLabel;
    RlConteudo: TRLBand;
    RdtCodigo: TRLDBText;
    RldSeparador2: TRLDraw;
    RdtMedia: TRLDBText;
    RLDraw2: TRLDraw;
    RdtIdentificacao: TRLDBText;
    RlbTitulos: TRLBand;
    RllCodigo: TRLLabel;
    RllValor: TRLLabel;
    RldSeparador1: TRLDraw;
    RLDraw1: TRLDraw;
    RllIdentificacao: TRLLabel;
    RLBand1: TRLBand;
    RdrQtde: TRLDBResult;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RelVendasDia: TRelVendasDia;

implementation

{$R *.dfm}

end.
