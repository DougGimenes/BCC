unit BCC.Relatorio.Report.ProdutosVendidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB;

type
  TRelProdutosVendidos = class(TForm)
    RlrFluxoCaixa: TRLReport;
    RlbCabecalho: TRLBand;
    RllTitulo: TRLLabel;
    RllData: TRLLabel;
    RlConteudo: TRLBand;
    RdtDescricao: TRLDBText;
    RldSeparador2: TRLDraw;
    RdtValor: TRLDBText;
    RlbTitulos: TRLBand;
    RllDescricao: TRLLabel;
    RllValor: TRLLabel;
    RldSeparador1: TRLDraw;
    RLBand1: TRLBand;
    RdrVezes: TRLDBResult;
    RLDraw1: TRLDraw;
    RllQtdeVendida: TRLLabel;
    RLDraw2: TRLDraw;
    RdtQtde: TRLDBText;
    RdrQtde: TRLDBResult;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetDataSource(ADataSource : TDataSource);
    procedure SetDataFiltro(ADataInicial, ADataFinal : TDate);
  end;

var
  RelProdutosVendidos: TRelProdutosVendidos;

implementation

{$R *.dfm}

{ TForm1 }

procedure TRelProdutosVendidos.SetDataFiltro(ADataInicial, ADataFinal: TDate);
begin
  Self.RllData.Caption := 'Relatório das datas de ' + DateToStr(ADataInicial) + ' a ' + DateToStr(ADataFinal);
end;

procedure TRelProdutosVendidos.SetDataSource(ADataSource: TDataSource);
begin
  Self.RlrFluxoCaixa.DataSource := ADataSource;
  Self.RdtDescricao.DataSource := ADataSource;
  Self.RdtValor.DataSource := ADataSource;
  Self.RdtQtde.DataSource := ADataSource;
  Self.RdrVezes.DataSource := ADataSource;
  Self.RdrQtde.DataSource := ADataSource;
end;

end.
