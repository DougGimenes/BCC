unit BCC.Funcionarios.View.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase, Data.DB,
  Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  BCC.Model.Funcionario, BCC.DAO.Funcionario;

type
  TFrmConsultaFuncionario = class(TFrmConsultaBase)
    QryConsultaNome: TStringField;
    QryConsultaCPF: TStringField;
    QryConsultaID_Func: TAutoIncField;
  private
    { Private declarations }
    FObjetoConsultado : TFuncionario;

    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TFuncionario read FObjetoConsultado;
  end;

var
  FrmConsultaFuncionario: TFrmConsultaFuncionario;

implementation

{$R *.dfm}

{ TFrmConsultaFuncionario }

procedure TFrmConsultaFuncionario.FinalizarConsulta;
begin
  inherited;
  Self.FObjetoConsultado := TDmFuncionario.Create(Self).Selecionar(Self.QryConsultaID_Func.Value);
  Self.FConsultou := True;
end;

function TFrmConsultaFuncionario.FormarFiltro: String;
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

function TFrmConsultaFuncionario.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Nome FROM Funcionarios' + #13 +
            'WHERE Nome LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
