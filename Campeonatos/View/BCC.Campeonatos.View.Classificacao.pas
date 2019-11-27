unit BCC.Campeonatos.View.Classificacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids;

type
  TFrmClassificacaoCampeonato = class(TFraBase)
    LblTitulo: TLabel;
    DBGrid1: TDBGrid;
    MtbClassificacao: TFDMemTable;
    DsClassificacao: TDataSource;
    MtbClassificacaoNome: TStringField;
    MtbClassificacaoPontuacao: TIntegerField;
    MtbClassificacaoPatidas: TIntegerField;
    MtbClassificacaoVitorias: TIntegerField;
    MtbClassificacaoEmpates: TIntegerField;
    MtbClassificacaoDerrotas: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmClassificacaoCampeonato: TFrmClassificacaoCampeonato;

implementation

{$R *.dfm}

end.
