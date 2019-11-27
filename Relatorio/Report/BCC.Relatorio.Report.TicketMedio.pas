unit BCC.Relatorio.Report.TicketMedio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB,
  RLParser;

type
  TRelTicketMedio = class(TForm)
    RlrFluxoCaixa: TRLReport;
    RlbCabecalho: TRLBand;
    RllTitulo: TRLLabel;
    RllData: TRLLabel;
    RlConteudo: TRLBand;
    RdtNome: TRLDBText;
    RldSeparador2: TRLDraw;
    RdtMedia: TRLDBText;
    RLDraw2: TRLDraw;
    RdtQtde: TRLDBText;
    RlbTitulos: TRLBand;
    RllCliente: TRLLabel;
    RllValor: TRLLabel;
    RldSeparador1: TRLDraw;
    RLDraw1: TRLDraw;
    RllQtdeVendida: TRLLabel;
    RLBand1: TRLBand;
    RdrQtde: TRLDBResult;
    RllMediaFinal: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDataSource(ADataSource : TDataSource);
    procedure SetDataFiltro(ADataInicial, ADataFinal : TDate);
    procedure SetValorMedioFinal(AValorMedio : Double);
  end;

var
  RelTicketMedio: TRelTicketMedio;

implementation

{$R *.dfm}

{ TRelTicketMedio }

procedure TRelTicketMedio.SetDataFiltro(ADataInicial, ADataFinal: TDate);
begin
  Self.RllData.Caption := 'Relatório das datas de ' + DateToStr(ADataInicial) + ' a ' + DateToStr(ADataFinal);
end;

procedure TRelTicketMedio.SetDataSource(ADataSource: TDataSource);
begin
  Self.RlrFluxoCaixa.DataSource := ADataSource;
  Self.RdrQtde.DataSource := ADataSource;
  Self.RdtNome.DataSource := ADataSource;
  Self.RdtMedia.DataSource := ADataSource;
  Self.RdtQtde.DataSource := ADataSource;
end;

procedure TRelTicketMedio.SetValorMedioFinal(AValorMedio: Double);
begin
  Self.RllMediaFinal.Caption := FormatFloat('###0.00', AValorMedio);
end;

end.
