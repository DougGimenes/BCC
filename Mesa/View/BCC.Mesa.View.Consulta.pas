unit BCC.Mesa.View.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase, Data.DB,
  Vcl.ExtCtrls, Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, BCC.Model.Mesa,
  BCC.DAO.Mesa;

type
  TFrmConsultaMesa = class(TFrmConsultaBase)
    QryAutoCompleteIdentificacao: TStringField;
    QryConsultaId_Vendas: TAutoIncField;
    QryConsultaIdentificacao: TStringField;
    QryConsultaCliente: TStringField;
    QryConsultaValorTotal: TFloatField;
    QryConsultaAberta: TBooleanField;
    procedure FormCreate(Sender: TObject);
  private
    FObjetoConsultado: TMesa;
    { Private declarations }
    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TMesa read FObjetoConsultado write FObjetoConsultado;
  end;

var
  FrmConsultaMesa: TFrmConsultaMesa;

implementation

{$R *.dfm}

{ TFrmConsultaMesa }

procedure TFrmConsultaMesa.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TDmMesa.Create(Self).SelecionarMesa(Self.QryConsultaId_Vendas.Value);
end;

function TFrmConsultaMesa.FormarFiltro: String;
begin
  if Self.EdtConsulta.Text <> '' then
  begin
    Result := '(Identificacao LIKE ''%' + Self.EdtConsulta.Text + '%'')';

    if Self.SomenteAtivo then
    begin
      Result := Result + #13 + 'AND Aberta = 1';
    end;
  end
  else
  begin
    if Self.SomenteAtivo then
    begin
      Result := 'Aberta = 1';
    end;
  end;
end;

function TFrmConsultaMesa.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 Identificacao FROM Vendas' + #13 +
            'WHERE Identificacao LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

procedure TFrmConsultaMesa.FormCreate(Sender: TObject);
begin
  inherited;
  Self.Filtrar();
end;

end.
