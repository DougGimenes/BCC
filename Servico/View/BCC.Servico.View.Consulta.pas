unit BCC.Servico.View.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase, Data.DB,
  Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, BCC.Model.Servico,
  BCC.DAO.Servico;

type
  TFrmConsultaServico = class(TFrmConsultaBase)
    QryConsultaID_Servico: TAutoIncField;
    QryConsultaNome: TStringField;
    QryConsultaValor: TFloatField;
  private
    FObjetoConsultado: TServico;
    { Private declarations }
    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TServico read FObjetoConsultado;
  end;

var
  FrmConsultaServico: TFrmConsultaServico;

implementation

{$R *.dfm}

{ TFrmConsultaServico }

procedure TFrmConsultaServico.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TDmServico.Create(Self).Selecionar(Self.QryConsultaID_Servico.Value);
end;

function TFrmConsultaServico.FormarFiltro: String;
begin
  Result := '(Nome LIKE ''%' + Self.EdtConsulta.Text + '%'')';

  if Self.SomenteAtivo then
  begin
    Result := Result + #13 + 'AND Ativo = 1';
  end;
end;

function TFrmConsultaServico.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Nome FROM Servicos' + #13 +
            'WHERE Nome LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
