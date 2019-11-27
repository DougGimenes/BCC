unit BCC.Contas.View.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase, Data.DB,
  Vcl.ExtCtrls, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, BCC.Model.Contas,
  BCC.DAO.Contas;

type
  TFrmConsultaConta = class(TFrmConsultaBase)
    QryConsultaCodigo: TAutoIncField;
    QryConsultaNome: TStringField;
    QryConsultaVencimento: TDateTimeField;
  private
    FObjetoConsultado: TConta;

    { Private declarations }
    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TConta read FObjetoConsultado;
  end;

var
  FrmConsultaConta: TFrmConsultaConta;

implementation

{$R *.dfm}

{ TFrmConsultaConta }

procedure TFrmConsultaConta.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TDmContas.Create(Self).Selecionar(Self.QryConsultaCodigo.Value);
end;

function TFrmConsultaConta.FormarFiltro: String;
begin
  Result := '(Nome LIKE ''%' + Self.EdtConsulta.Text + '%'')';
end;

function TFrmConsultaConta.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Nome FROM Contas' + #13 +
            'WHERE Nome LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
