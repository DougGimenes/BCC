unit BCC.Campeonatos.View.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase, Data.DB,
  Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, BCC.Model.Campeonato,
  BCC.DAO.Campeonatos;

type
  TFrmConsultaCampeonato = class(TFrmConsultaBase)
    QryConsultaID_Campeonato: TAutoIncField;
    QryConsultaEstado: TIntegerField;
    QryConsultaJogo: TStringField;
    QryConsultaCampeonato: TStringField;
  private
    { Private declarations }
    FObjetoConsultado : TCampeonato;
    Estado : EEstado;

    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent; AEstado : EEstado); overload;

    property ObjetoConsultado: TCampeonato read FObjetoConsultado;
  end;

var
  FrmConsultaCampeonato: TFrmConsultaCampeonato;

implementation

{$R *.dfm}
{$D+}

{ TFrmConsultaCampeonato }

constructor TFrmConsultaCampeonato.Create(AOwner: TComponent; AEstado: EEstado);
begin
  inherited Create(AOwner);
  Self.Estado := AEstado;
end;

procedure TFrmConsultaCampeonato.FinalizarConsulta;
begin
  Self.FObjetoConsultado := TDmCampeonato.Create(Self).Selecionar(Self.QryConsultaID_Campeonato.Value);
  Self.FConsultou := True;
end;

function TFrmConsultaCampeonato.FormarFiltro: String;
begin
  Result := '(Campeonato LIKE ''%' + Self.EdtConsulta.Text + '%''' +  #13 +
            'OR Jogo LIKE ''%' + Self.EdtConsulta.Text + '%'')';

  if Self.Estado <> CmpTodos then
  begin
    Result := Result + #13 + '(AND Estado != ''2'')';
  end;
end;

function TFrmConsultaCampeonato.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Identificacao FROM Campeonatos' + #13 +
            'WHERE Identificacao LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
