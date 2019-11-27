unit BCC.Relatorio.Report.FluxoCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB;

type
  TRelFluxoCaixa = class(TForm)
    RlrFluxoCaixa: TRLReport;
    RlbCabecalho: TRLBand;
    RllTitulo: TRLLabel;
    RllData: TRLLabel;
    RlConteudo: TRLBand;
    RdtTipo: TRLDBText;
    RldSeparador2: TRLDraw;
    RdtValor: TRLDBText;
    RlbTitulos: TRLBand;
    RllTipo: TRLLabel;
    RllValor: TRLLabel;
    RldSeparador1: TRLDraw;
    RLBand1: TRLBand;
    RdrVezes: TRLDBResult;
    RllValorFinal: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDataSource(ADataSource : TDataSource);
    procedure SetDataFiltro(ADataInicial, ADataFinal : TDate);
  end;

var
  RelFluxoCaixa: TRelFluxoCaixa;

implementation

{$R *.dfm}

{ TRelFluxoCaixa }

procedure TRelFluxoCaixa.SetDataFiltro(ADataInicial, ADataFinal: TDate);
begin
  Self.RllData.Caption := 'Relatório das datas de ' + DateToStr(ADataInicial) + ' a ' + DateToStr(ADataFinal);
end;

procedure TRelFluxoCaixa.SetDataSource(ADataSource: TDataSource);
begin
  Self.RlrFluxoCaixa.DataSource := ADataSource;
  Self.RdtTipo.DataSource := ADataSource;
  Self.RdtValor.DataSource := ADataSource;
  Self.RdrVezes.DataSource := ADataSource
end;

end.
