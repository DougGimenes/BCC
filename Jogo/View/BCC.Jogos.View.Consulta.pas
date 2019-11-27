unit BCC.Jogos.View.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase, Data.DB,
  Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, BCC.Model.Jogo,
  BCC.DAO.Jogo;

type
  TFrmConsultaJogo = class(TFrmConsultaBase)
    QryConsultaID_Jogo: TAutoIncField;
    QryConsultaIdentificacao: TStringField;
    QryConsultaNum_Copias: TIntegerField;
    QryConsultaAtivo: TBooleanField;
    QryConsultaNum_Pessoas: TIntegerField;
    QryAutoCompleteIdentificacao: TStringField;
  private
    FObjetoConsultado: TJogo;
    Apagando : Boolean;
    { Private declarations }
    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TJogo read FObjetoConsultado;
  end;

var
  FrmConsultaJogo: TFrmConsultaJogo;

implementation

{$R *.dfm}

{ TFrmConsultaJogo }

procedure TFrmConsultaJogo.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TDmJogo.Create(Self).Selecionar(Self.QryConsultaID_Jogo.Value);
end;

function TFrmConsultaJogo.FormarFiltro: String;
begin
  Result := '(Identificacao LIKE ''%' + Self.EdtConsulta.Text + '%'')';

  if Self.SomenteAtivo then
  begin
    Result := Result + #13 + 'AND Ativo = 1';
  end;
end;

function TFrmConsultaJogo.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Identificacao FROM Jogos' + #13 +
            'WHERE Identificacao LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
