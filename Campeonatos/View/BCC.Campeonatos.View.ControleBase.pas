unit BCC.Campeonatos.View.ControleBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, BCC.Conexao.DAO.Dados,
  Math;

type
  TFraControleCampeonato = class(TFraBase)
    QryCompetidores: TADOQuery;
    DsCompetidores: TDataSource;
    DbgCompetidores: TDBGrid;
    EdtFiltro: TEdit;
    procedure EdtFiltroChange(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbrirConsulta(ACodCampeonato : Integer); virtual; abstract;
  end;

var
  FraControleCampeonato: TFraControleCampeonato;

implementation

{$R *.dfm}

procedure TFraControleCampeonato.EdtFiltroChange(Sender: TObject);
begin
  inherited;
  Self.QryCompetidores.DisableControls();
  Self.QryCompetidores.Filtered := False;

  if Self.EdtFiltro.Text <> '' then
  begin
    Self.QryCompetidores.Filter := 'Cliente LIKE ' + QuotedStr('%' + Self.EdtFiltro.Text + '%');
    Self.QryCompetidores.Filtered := True;
  end;
  Self.QryCompetidores.EnableControls();
end;

procedure TFraControleCampeonato.FrameResize(Sender: TObject);
begin
  inherited;
  Self.DbgCompetidores.Left := Floor((Self.Width - Self.DbgCompetidores.Width) / 2);
  Self.EdtFiltro.Left := Self.DbgCompetidores.Left;

  Self.EdtFiltro.Top := Self.DbgCompetidores.Top + Self.DbgCompetidores.Height + 10;
end;

end.
