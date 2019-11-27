unit BCC.Relatorio.Report.JogosPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB;

type
  TRelJogoSolicitado = class(TForm)
    RlrJogosSolicitados: TRLReport;
    RlbCabecalho: TRLBand;
    RllTitulo: TRLLabel;
    RllData: TRLLabel;
    RlConteudo: TRLBand;
    RlbTitulos: TRLBand;
    RllJogo: TRLLabel;
    RdtJogo: TRLDBText;
    RllQuantidade: TRLLabel;
    RldSeparador1: TRLDraw;
    RldSeparador2: TRLDraw;
    RdtVezes: TRLDBText;
    RLBand1: TRLBand;
    RdrVezes: TRLDBResult;
    RllCount: TRLLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDataSource(ADataSource : TDataSource);
    procedure SetDataFiltro(ADataInicial, ADataFinal : TDate);
  end;

var
  RelJogoSolicitado: TRelJogoSolicitado;

implementation

{$R *.dfm}

{ TRelJogoSolicitado }

procedure TRelJogoSolicitado.SetDataFiltro(ADataInicial, ADataFinal: TDate);
begin
  Self.RllData.Caption := 'Relatório das datas de ' + DateToStr(ADataInicial) + ' a ' + DateToStr(ADataFinal);
end;

procedure TRelJogoSolicitado.SetDataSource(ADataSource : TDataSource);
begin
  Self.RlrJogosSolicitados.DataSource := ADataSource;
  Self.RdtJogo.DataSource := ADataSource;
  Self.RdtVezes.DataSource := ADataSource;
  Self.RdrVezes.DataSource := ADataSource;
end;

end.
