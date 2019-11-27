unit BCC.Produtos.View.ConsultaPromocao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase,
  Data.DB, Vcl.ExtCtrls, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  BCC.Produto.Model.Promocao, BCC.Produto.DAO.Promocao;

type
  TFrmConsultaRegraPromocao = class(TFrmConsultaBase)
    QryConsultaCodigo: TAutoIncField;
    QryConsultaNome: TStringField;
    QryAutoCompleteNome: TStringField;
    QryConsultaTipo: TStringField;
  private
    FObjetoConsultado: TRegraPromocao;
    { Private declarations }

    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TRegraPromocao read FObjetoConsultado;
  end;

var
  FrmConsultaRegraPromocao: TFrmConsultaRegraPromocao;

implementation

{$R *.dfm}

{ TFrmConsultaRegraPromocao }

procedure TFrmConsultaRegraPromocao.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TDmPromocao.Create(Self).SelecionarRegra(Self.QryConsultaCodigo.Value);
end;

function TFrmConsultaRegraPromocao.FormarFiltro: String;
begin
  Result := '(Nome LIKE ''%' + Self.EdtConsulta.Text + '%'')';
end;

function TFrmConsultaRegraPromocao.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 NOME FROM Regras_Promocao' + #13 +
            'WHERE Nome LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
