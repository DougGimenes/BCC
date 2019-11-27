unit BCC.Salas.View.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase, Data.DB,
  Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, BCC.Model.Sala,
  BCC.DAO.Sala;

type
  TFrmConsultaSala = class(TFrmConsultaBase)
    QryConsultaID_Sala: TAutoIncField;
    QryConsultaIdentifiacacao: TStringField;
    QryConsultaNum_Pessoas: TIntegerField;
    QryConsultaAtivo: TBooleanField;
  private
    FObjetoConsultado: TSala;
    { Private declarations }
    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TSala read FObjetoConsultado;
  end;

var
  FrmConsultaSala: TFrmConsultaSala;

implementation

{$R *.dfm}

procedure TFrmConsultaSala.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TDmSala.Create(Self).Selecionar(Self.QryConsultaID_Sala.Value);
end;

function TFrmConsultaSala.FormarFiltro: String;
begin
  Result := '(Identifiacacao LIKE ''%' + Self.EdtConsulta.Text + '%'')';

  if Self.SomenteAtivo then
  begin
    Result := Result + #13 + 'AND Ativo = 1';
  end;
end;

function TFrmConsultaSala.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Identifiacacao FROM Sala' + #13 +
            'WHERE Identifiacacao LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
