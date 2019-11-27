unit BCC.Campeonatos.View.ControleEliminatoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.Campeonatos.View.ControleBase,
  Data.DB, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFraControleCampeonatoEliminatoria = class(TFraControleCampeonato)
    QryCompetidoresCliente: TStringField;
    QryCompetidoresID_Cliente: TAutoIncField;
    QryCompetidoresPartidas: TIntegerField;
    QryCompetidoresEstado: TStringField;
    QryCompetidoresID_Comp: TAutoIncField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbrirConsulta(ACodCampeonato : Integer); override;
  end;

var
  FraControleCampeonatoEliminatoria: TFraControleCampeonatoEliminatoria;

implementation

{$R *.dfm}

{ TFraControleCampeonatoEliminatoria }

procedure TFraControleCampeonatoEliminatoria.AbrirConsulta(ACodCampeonato: Integer);
begin
  Self.QryCompetidores.Close();
  Self.QryCompetidores.SQL.Clear();
  Self.QryCompetidores.SQL.Text := 'SELECT' + #13 +
                                   '  cli.Nome AS Cliente,' + #13 +
                                   '  cli.ID_Cliente,' + #13 +
                                   '  comp.Partidas,' + #13 +
                                   '  CASE' + #13 +
                                   '    WHEN (comp.Derrotas > 0) THEN ''Eliminado''' + #13 +
                                   '    ELSE ''Competindo''' + #13 +
                                   '  END AS Estado,' + #13 +
                                   '  comp.ID_Comp' + #13 +
                                   'FROM Competidores_Campeonato comp' + #13 +
                                   '  LEFT JOIN Cliente cli ON cli.ID_Cliente = comp.ID_Cliente' + #13 +
                                   'WHERE comp.ID_Campeonato = 0' + ACodCampeonato.ToString();
  Self.QryCompetidores.Open();
end;

end.
