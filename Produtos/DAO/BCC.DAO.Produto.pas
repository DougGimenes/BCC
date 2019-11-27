unit BCC.DAO.Produto;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, BCC.Model.Produto,
  System.Generics.Collections;

type
  TDmProduto = class(TDataModule)
    TbProduto: TADOQuery;
    TbProdutoID_Prod: TAutoIncField;
    TbProdutoNome: TStringField;
    TbProdutoPreco_Custo: TFloatField;
    TbProdutoPreco_Venda: TFloatField;
    TbProdutoAtivo: TBooleanField;
    TbProdutoEstoque: TFloatField;
    TbProdutoCardapio: TBooleanField;
    TbProdutoControlaEstoque: TBooleanField;
  private
    { Private declarations }
    procedure ObjToData(AProduto : TProduto);
    function  DataToObj() : TProduto;
  public
    { Public declarations }
    function  Inserir(AProduto : TProduto) : TProduto;
    function  Selecionar(ACodigo : Integer) : TProduto;
    function  SelecionarTodos() : TObjectList<TProduto>;
    procedure Editar(AProduto : TProduto);
    procedure AjustarEstoque(ACodItem, AQuantidade: Integer);
  end;

var
  DmProduto: TDmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmProduto }

procedure TDmProduto.AjustarEstoque(ACodItem, AQuantidade: Integer);
var
  Produto : TProduto;
begin
  Produto := Self.Selecionar(ACodItem);
  Produto.Estoque := Produto.Estoque + AQuantidade;
  Self.Editar(Produto);
end;

function TDmProduto.DataToObj: TProduto;
begin
  Result := TProduto.Create();
  Result.Codigo          := Self.TbProdutoID_Prod.Value;
  Result.Nome            := Self.TbProdutoNome.Value;
  Result.PrecoVenda      := Self.TbProdutoPreco_Venda.Value;
  Result.PrecoCusto      := Self.TbProdutoPreco_Custo.Value;
  Result.Estoque         := Self.TbProdutoEstoque.Value;
  Result.Ativo           := Self.TbProdutoAtivo.Value;
  Result.Cardapio        := Self.TbProdutoCardapio.Value;
  Result.ControlaEstoque := Self.TbProdutoControlaEstoque.Value;
end;

procedure TDmProduto.Editar(AProduto: TProduto);
begin
  Self.Selecionar(AProduto.Codigo);
  Self.TbProduto.Edit();
  Self.ObjToData(AProduto);
  Self.TbProduto.Post();
end;

function TDmProduto.Inserir(AProduto: TProduto): TProduto;
begin
  Self.TbProduto.Close();
  Self.TbProduto.SQL.Clear();
  Self.TbProduto.SQL.Text := 'SELECT * FROM Produto' + #13 +
                             '  WHERE -1 = 1';
  Self.TbProduto.Open();
  Self.TbProduto.Append();
  Self.ObjToData(AProduto);
  Self.TbProduto.Post();

  Result := Self.DataToObj();
end;

procedure TDmProduto.ObjToData(AProduto: TProduto);
begin
  Self.TbProdutoNome.Value            := AProduto.Nome;
  Self.TbProdutoPreco_Venda.Value     := AProduto.PrecoVenda;
  Self.TbProdutoPreco_Custo.Value     := AProduto.PrecoCusto;
  Self.TbProdutoEstoque.Value         := AProduto.Estoque;
  Self.TbProdutoAtivo.Value           := AProduto.Ativo;
  Self.TbProdutoCardapio.Value        := AProduto.Cardapio;
  Self.TbProdutoControlaEstoque.Value := AProduto.ControlaEstoque;
end;

function TDmProduto.Selecionar(ACodigo: Integer): TProduto;
begin
  Self.TbProduto.Close();
  Self.TbProduto.SQL.Clear();
  Self.TbProduto.SQL.Text := 'SELECT * FROM Produto' + #13 +
                             '  WHERE ID_Prod = ' + ACodigo.ToString();
  Self.TbProduto.Open();

  Result := Self.DataToObj();
end;

function TDmProduto.SelecionarTodos: TObjectList<TProduto>;
var
  I: Integer;
begin
  Self.TbProduto.Close();
  Self.TbProduto.SQL.Clear();
  Self.TbProduto.SQL.Text := 'SELECT * FROM Produto';
  Self.TbProduto.Open();

  Result := TObjectList<TProduto>.Create(True);
  Self.TbProduto.First();
  for I := 0 to Self.TbProduto.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbProduto.Next();
  end;
end;

end.
