unit BCC.Produtos.View.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase, Data.DB,
  Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, BCC.Model.Produto,
  BCC.DAO.Produto;

type
  TFrmConsultaProduto = class(TFrmConsultaBase)
    QryConsultaNome: TStringField;
    QryConsultaPreco_Custo: TFloatField;
    QryConsultaPreco_Venda: TFloatField;
    QryConsultaEstoque: TFloatField;
    QryConsultaID_Prod: TAutoIncField;
  private
    FObjetoConsultado: TProduto;
    Cardapio : Boolean;
    { Private declarations }
    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
    function  FormarSQLAutoComplete() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado : TProduto read FObjetoConsultado;
    constructor Create(AOwner : TComponent; AAtivo : Boolean = True; ACardapio : Boolean = True); overload;
  end;

var
  FrmConsultaProduto: TFrmConsultaProduto;

implementation

{$R *.dfm}

{ TFrmConsultaProduto }

constructor TFrmConsultaProduto.Create(AOwner: TComponent; AAtivo,
  ACardapio: Boolean);
begin
  inherited Create(AOwner, AAtivo);
  Self.Cardapio := ACardapio;
end;

procedure TFrmConsultaProduto.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TDmProduto.Create(Self).Selecionar(Self.QryConsultaID_Prod.Value);
end;

function TFrmConsultaProduto.FormarFiltro: String;
begin
  Result := '(Nome LIKE ''%' + Self.EdtConsulta.Text + '%'')';

  if Self.SomenteAtivo then
  begin
    Result := Result + #13 + 'AND Ativo = 1';
  end;

  if Self.Cardapio then
  begin
    Result := Result + #13 + 'AND Cardapio = 1';
  end;
end;

function TFrmConsultaProduto.FormarSQLAutoComplete: String;
begin
  Result := 'SELECT TOP 1 NOME FROM Produto' + #13 +
            'WHERE Nome LIKE ' + QuotedStr(Self.EdtConsulta.Text + '%');
end;

end.
