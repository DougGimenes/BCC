unit BCC.Campeonatos.View.ControlePontos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.Campeonatos.View.ControleBase,
  Data.DB, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFraControleCampeonatoPontos = class(TFraControleCampeonato)
    QryCompetidoresCliente: TStringField;
    QryCompetidoresID_Cliente: TAutoIncField;
    QryCompetidoresPontuacao: TIntegerField;
    QryCompetidoresPartidas: TIntegerField;
    QryCompetidoresVitorias: TIntegerField;
    QryCompetidoresEmpates: TIntegerField;
    QryCompetidoresDerrotas: TIntegerField;
    QryCompetidoresID_Comp: TAutoIncField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbrirConsulta(ACodCampeonato : Integer); override;
  end;

var
  FraControleCampeonatoPontos: TFraControleCampeonatoPontos;

implementation

{$R *.dfm}

{ TFraControleCampeonatoPontos }

procedure TFraControleCampeonatoPontos.AbrirConsulta(ACodCampeonato: Integer);
begin
  inherited;
  Self.QryCompetidores.Close();
  Self.QryCompetidores.SQL.Clear();
  Self.QryCompetidores.SQL.Text := 'SELECT' + #13 +
                                   '  cli.Nome AS Cliente,' + #13 +
                                   '  cli.ID_Cliente,' + #13 +
                                   '  comp.Pontuacao,' + #13 +
                                   '  comp.Partidas,' + #13 +
                                   '  comp.Vitorias,' + #13 +
                                   '  comp.Empates,' + #13 +
                                   '  comp.Derrotas,' + #13 +
                                   '  comp.ID_Comp' + #13 +
                                   'FROM Competidores_Campeonato comp' + #13 +
                                   '  LEFT JOIN Cliente cli ON cli.ID_Cliente = comp.ID_Cliente' + #13 +
                                   'WHERE comp.ID_Campeonato = 0' + ACodCampeonato.ToString();
  Self.QryCompetidores.Open();
end;

end.
