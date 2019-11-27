unit BCC.DAO.Mesa;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, BCC.Conexao.DAO.Dados,
  BCC.Model.Mesa, System.Generics.Collections, BCC.DAO.Produto, BCC.Model.Produto;

type
  TDmMesa = class(TDataModule)
    TbItem: TADOQuery;
    TbItemID_ItemVenda: TAutoIncField;
    TbItemID_Prod: TIntegerField;
    TbItemID_Servico: TIntegerField;
    TbItemID_Vendas: TIntegerField;
    TbItemValorUnitario: TFloatField;
    TbItemQtde_Prod: TFloatField;
    TbItemDescricao: TStringField;
    TbItemValorTotal: TFloatField;
    TbItemID_Jogo: TIntegerField;
    TbMesa: TADOQuery;
    TbMesaID_Vendas: TAutoIncField;
    TbMesaID_Cliente: TIntegerField;
    TbMesaIdentificacao: TStringField;
    TbMesaAberta: TBooleanField;
    TbMesaValor_Total: TFloatField;
    TbMesaFormaPag: TIntegerField;
    TbMesaCodCaixa: TIntegerField;
    TbMesaData: TDateTimeField;
    TbTitulo: TADOQuery;
    TbTituloCodigo: TAutoIncField;
    TbTituloCodVenda: TIntegerField;
    TbTituloValor: TFloatField;
    TbTituloPago: TFloatField;
    TbTituloTroco: TFloatField;
    TbTituloFormaPagto: TIntegerField;
  private
    { Private declarations }
    procedure ItemToData(AItem : TItemMesa);
    function  DataToItem() : TItemMesa;

    procedure MesaToData(AMesa : TMesa);
    function  DataToMesa() : TMesa;

    procedure TituloToData(ATitulo : TTitulo);
    function  DataToTitulo() : TTitulo;
  public
    { Public declarations }
    function  InserirItem(AItem : TItemMesa) : TItemMesa;
    function  SelecionarItem(ACodigo : Integer) : TItemMesa;
    function  SelecionarItemMesa(ACodMesa : Integer) : TObjectList<TItemMesa>;
    procedure EditarItem(AItem : TItemMesa);
    procedure RemoverItem(ACodItem : Integer);

    function InserirMesa(AMesa : TMesa) : TMesa;
    function SelecionarMesa(ACodigo : Integer) : TMesa;
    function EditarMesa(AMesa : TMesa) : TMesa;
    function SelecionarMesaIdentificacao(AIdentificacao : String) : TMesa;
    function ValidarIdentificacao(AIdentificacao : String) : Boolean;

    function InserirTitulo(ATitulo : TTitulo) : TTitulo;
  end;

var
  DmMesa: TDmMesa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmMesa }

function TDmMesa.DataToItem: TItemMesa;
begin
  Result := TItemMesa.Create();
  Result.Codigo        := Self.TbItemID_ItemVenda.Value;
  Result.CodMesa       := Self.TbItemID_Vendas.Value;
  Result.CodProduto    := Self.TbItemID_Prod.Value;
  Result.CodServico    := Self.TbItemID_Servico.Value;
  Result.PrecoUnitario := Self.TbItemValorUnitario.Value;
  Result.Descricao     := Self.TbItemDescricao.Value;
  Result.ValorTotal    := Self.TbItemValorTotal.Value;
  Result.Quantidade    := Self.TbItemQtde_Prod.Value;
  Result.CodJogo       := Self.TbItemID_Jogo.Value;
end;

function TDmMesa.DataToMesa: TMesa;
begin
  Result := TMesa.Create();
  Result.Codigo         := Self.TbMesaID_Vendas.Value;
  Result.Aberta         := Self.TbMesaAberta.Value;
  Result.ValorTotal     := Self.TbMesaValor_Total.Value;
  Result.CodCliente     := Self.TbMesaID_Cliente.Value;
  Result.CodCaixa       := Self.TbMesaCodCaixa.Value;
  Result.Itens          := Self.SelecionarItemMesa(Self.TbMesaID_Vendas.Value);
  Result.Identificacao  := Self.TbMesaIdentificacao.Value;
  Result.Data           := Self.TbMesaData.Value;
end;

function TDmMesa.DataToTitulo: TTitulo;
begin
  Result := TTitulo.Create();
  Result.Codigo     := Self.TbTituloCodigo.Value;
  Result.CodVenda   := Self.TbTituloCodVenda.Value;
  Result.Valor      := Self.TbTituloValor.Value;
  Result.Pago       := Self.TbTituloPago.Value;
  Result.Troco      := Self.TbTituloTroco.Value;
  Result.FormaPagto := EFormaPagamento(Self.TbTituloFormaPagto.Value);
end;

procedure TDmMesa.EditarItem(AItem: TItemMesa);
begin
  Self.SelecionarItem(AItem.Codigo);
  Self.TbItem.Edit();
  Self.ItemToData(AItem);
  Self.TbItem.Post();
end;

function TDmMesa.EditarMesa(AMesa: TMesa) : TMesa;
begin
  Self.SelecionarMesa(AMesa.Codigo);
  Self.TbMesa.Edit();
  Self.MesaToData(AMesa);
  Self.TbMesa.Post();

  for var Item in AMesa.Itens do
  begin
    Item.CodMesa := Self.TbMesaID_Vendas.Value;
    if Item.Codigo > 0 then
    begin
      Self.EditarItem(Item);
    end
    else
    begin
      Self.InserirItem(Item);
    end;
  end;

  Result := Self.SelecionarMesa(AMesa.Codigo);
end;

function TDmMesa.InserirItem(AItem: TItemMesa): TItemMesa;
var
  EstoqueOk : Boolean;
  DmProduto : TDmProduto;
  Produto   : TProduto;
begin
  if AItem.CodProduto > 0 then
  begin
    DmProduto := TDmProduto.Create(Self);
    Produto := DmProduto.Selecionar(AItem.CodProduto);

    if Produto.ControlaEstoque then
    begin
      if Produto.Estoque - AItem.Quantidade >= 0 then
      begin
        Produto.Estoque := Produto.Estoque - AItem.Quantidade;
        DmProduto.Editar(Produto);
        EstoqueOk := True;
      end
      else
      begin
        EstoqueOk := False;
      end;
    end
    else
    begin
      EstoqueOk := True;
    end;
  end
  else
  begin
    EstoqueOk := True;
  end;

  if EstoqueOk then
  begin
    Self.TbItem.Close();
    Self.TbItem.SQL.Clear();
    Self.TbItem.SQL.Text := 'SELECT * FROM Itens_Venda WHERE -1 = 1';
    Self.TbItem.Open();

    Self.TbItem.Append();
    Self.ItemToData(AItem);
    Self.TbItem.Post();

    Result := Self.DataToItem();
  end
  else
  begin
    raise Exception.Create('Produto sem estoque!');
  end;
end;

function TDmMesa.InserirMesa(AMesa: TMesa): TMesa;
begin
  Self.TbMesa.Close();
  Self.TbMesa.SQL.Clear();
  Self.TbMesa.SQL.Text := 'SELECT * FROM Vendas WHERE -1 = 1';
  Self.TbMesa.Open();

  Self.TbMesa.Append();
  Self.MesaToData(AMesa);
  Self.TbMesa.Post();

  for var Item in AMesa.Itens do
  begin
    Item.CodMesa := Self.TbMesaID_Vendas.Value;

    Self.InserirItem(Item);
  end;

  Result := Self.DataToMesa();
end;

function TDmMesa.InserirTitulo(ATitulo: TTitulo): TTitulo;
begin
  Self.TbTitulo.Close();
  Self.TbTitulo.SQL.Text := 'SELECT * FROM Titulos WHERE -1 = 1';
  Self.TbTitulo.Open();

  Self.TbTitulo.Append();
  Self.TituloToData(ATitulo);
  Self.TbTitulo.Post();

  Result := Self.DataToTitulo();
end;

procedure TDmMesa.ItemToData(AItem: TItemMesa);
begin
  Self.TbItemID_Vendas.Value     := AItem.CodMesa;

  if AItem.CodProduto > 0 then
  begin
    Self.TbItemID_Prod.Value := AItem.CodProduto;
  end
  else
  begin
    Self.TbItemID_Prod.Clear()
  end;

  if AItem.CodServico > 0 then
  begin
    Self.TbItemID_Servico.Value := AItem.CodServico;
  end
  else
  begin
    Self.TbItemID_Servico.Clear();
  end;

  if AItem.CodJogo > 0 then
  begin
    Self.TbItemID_Jogo.Value := AItem.CodJogo;
  end
  else
  begin
    Self.TbItemID_Jogo.Clear();
  end;

  Self.TbItemValorUnitario.Value := AItem.PrecoUnitario;
  Self.TbItemDescricao.Value     := AItem.Descricao;
  Self.TbItemValorTotal.Value    := AItem.ValorTotal;
  Self.TbItemQtde_Prod.Value     := AItem.Quantidade;

end;

procedure TDmMesa.MesaToData(AMesa: TMesa);
begin
  if AMesa.CodCliente > 0 then
  begin
    Self.TbMesaID_Cliente.Value := AMesa.CodCliente;
  end
  else
  begin
    Self.TbMesaID_Cliente.Clear();
  end;
  Self.TbMesaAberta.Value        := AMesa.Aberta;
  Self.TbMesaValor_Total.Value   := AMesa.ValorTotal;
  Self.TbMesaIdentificacao.Value := AMesa.Identificacao;
  Self.TbMesaCodCaixa.Value      := AMesa.CodCaixa;
  Self.TbMesaData.Value          := AMesa.Data;
end;

procedure TDmMesa.RemoverItem(ACodItem: Integer);
begin
  Self.SelecionarItem(ACodItem);
  if Self.TbItem.RecordCount > 0 then
  begin
    Self.TbItem.Delete();
  end;
end;

function TDmMesa.SelecionarItem(ACodigo: Integer): TItemMesa;
begin
  Self.TbItem.Close();
  Self.TbItem.SQL.Clear();
  Self.TbItem.SQL.Text := 'SELECT * FROM Itens_Venda WHERE ID_ItemVenda = ' + ACodigo.ToString();
  Self.TbItem.Open();

  Result := Self.DataToItem();
end;

function TDmMesa.SelecionarItemMesa(ACodMesa: Integer): TObjectList<TItemMesa>;
begin
  Self.TbItem.Close();
  Self.TbItem.SQL.Clear();
  Self.TbItem.SQL.Text := 'SELECT * FROM Itens_Venda WHERE ID_Vendas = ' + ACodMesa.ToString();
  Self.TbItem.Open();

  Result := TObjectList<TItemMesa>.Create(True);
  for var I := 0 to Self.TbItem.RecordCount - 1 do
  begin
    Result.Add(Self.DataToItem());
  end;
end;

function TDmMesa.SelecionarMesa(ACodigo: Integer): TMesa;
begin
  Self.TbMesa.Close();
  Self.TbMesa.SQL.Clear();
  Self.TbMesa.SQL.Text := 'SELECT * FROM Vendas WHERE ID_Vendas = ' + ACodigo.ToString();
  Self.TbMesa.Open();

  Result := Self.DataToMesa();
end;

function TDmMesa.SelecionarMesaIdentificacao(AIdentificacao: String): TMesa;
begin
  Self.TbMesa.Close();
  Self.TbMesa.SQL.Clear();
  Self.TbMesa.SQL.Text := 'SELECT * FROM Vendas WHERE Identificacao = ' + QuotedStr(AIdentificacao) + #13 +
                          'AND Aberta = 1';
  Self.TbMesa.Open();

  Result := Self.DataToMesa();
end;

procedure TDmMesa.TituloToData(ATitulo: TTitulo);
begin
  Self.TbTituloCodVenda.Value   := ATitulo.CodVenda;
  Self.TbTituloValor.Value      := ATitulo.Valor;
  Self.TbTituloPago.Value       := ATitulo.Pago;
  Self.TbTituloTroco.Value      := ATitulo.Troco;
  Self.TbTituloFormaPagto.Value := Integer(ATitulo.FormaPagto);
end;

function TDmMesa.ValidarIdentificacao(AIdentificacao: String): Boolean;
begin
  Self.TbMesa.Close();
  Self.TbMesa.SQL.Clear();
  Self.TbMesa.SQL.Text := 'SELECT * FROM Vendas WHERE Identificacao = ' + QuotedStr(AIdentificacao) + #13 +
                          'AND Aberta = 1';
  Self.TbMesa.Open();

  Result := not (Self.TbMesa.RecordCount > 0)
end;

end.
