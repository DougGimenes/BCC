unit BCC.Relatorio.View.RelBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, BCC.Conexao.DAO.Dados, Math,
  Vcl.StdCtrls, BCC.Relatorios.Controller.Excell;

type
  TFraRelBase = class(TFraBase)
    DbgRelatorio: TDBGrid;
    QryRelatorio: TADOQuery;
    DsRelatorio: TDataSource;
    PnlFiltro: TPanel;
    BtnFiltrar: TButton;
    BtnExcell: TButton;
    BtnGerarRelatorio: TButton;
    LblTitulo: TLabel;
    procedure FrameResize(Sender: TObject);
    procedure BtnFiltrarClick(Sender: TObject);
    procedure BtnExcellClick(Sender: TObject);
  private
    { Private declarations }
  protected
    Titulo : String;
    SubTitulo : String;

    procedure AbrirConsulta(); virtual; abstract;
    procedure TratarTela(); virtual; abstract;
  public
    { Public declarations }
  end;

var
  FraRelBase: TFraRelBase;

implementation

{$R *.dfm}

procedure TFraRelBase.BtnExcellClick(Sender: TObject);
begin
  inherited;
  Self.BtnFiltrar.Click();
  TExcel.Create().DadosParaExcel(Self.QryRelatorio, True, Self.Titulo, Self.SubTitulo);
end;

procedure TFraRelBase.BtnFiltrarClick(Sender: TObject);
begin
  inherited;
  Self.AbrirConsulta();
end;

procedure TFraRelBase.FrameResize(Sender: TObject);
begin
  inherited;
  Self.DbgRelatorio.Left := Floor((Self.Width - Self.DbgRelatorio.Width) / 2);
  Self.DbgRelatorio.Top  := Self.LblTitulo.Top + Self.LblTitulo.Height + 20;
  Self.DbgRelatorio.Height := Floor((Self.Height - Self.DbgRelatorio.Top) - 20);

  Self.LblTitulo.Caption := Self.Titulo;
  Self.LblTitulo.Left := Floor((Self.Width - Self.LblTitulo.Width) / 2);
  Self.LblTitulo.Top := Self.PnlFiltro.Height + 20;
  Self.TratarTela();
end;

end.
