unit BCC.Clientes.View.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase, Data.DB,
  Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, BCC.Model.Cliente,
  BCC.DAO.Cliente, BCC.Conexao.DAO.Dados;

type
  TFrmConsultaCliente = class(TFrmConsultaBase)
    QryConsultaID_Cliente: TAutoIncField;
    QryConsultaNome: TStringField;
    QryConsultaCPF: TStringField;
    QryConsultaAtivo: TBooleanField;
  private
    FObjetoConsultado: TCliente;
    { Private declarations }
    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TCliente read FObjetoConsultado;
  end;

var
  FrmConsultaCliente: TFrmConsultaCliente;

implementation

{$R *.dfm}

{ TFrmConsultaCliente }

procedure TFrmConsultaCliente.FinalizarConsulta;
begin
  Self.FConsultou := True;
  Self.FObjetoConsultado := TDmCliente.Create(Self).SelecionarCliente(Self.QryConsultaID_Cliente.Value);
end;

function TFrmConsultaCliente.FormarFiltro() : String;
begin
  Result := '(Nome LIKE ''%' + Self.EdtConsulta.Text + '%''';

  if Self.SomenteAtivo then
  begin
    Result := Result + #13 + ' AND Ativo = 1';
  end;

  Result := Result + ')' + #13 + 'OR (CPF LIKE ''%' + Self.EdtConsulta.Text + '%''';

  if Self.SomenteAtivo then
  begin
    Result := Result + #13 + ' AND Ativo = 1';
  end;

  Result := Result + ')';
end;

function TFrmConsultaCliente.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Nome FROM Cliente' + #13 +
            'WHERE Nome LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
