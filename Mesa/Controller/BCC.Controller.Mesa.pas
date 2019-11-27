unit BCC.Controller.Mesa;

interface

uses
  System.Generics.Collections, BCC.Model.Jogo, BCC.Model.Produto, BCC.Model.Servico,
  BCC.Model.Mesa, BCC.DAO.Produto, BCC.DAO.Servico, BCC.Produto.Model.Promocao,
  BCC.Produto.DAO.Promocao, SysUtils, BCC.DAO.Mesa, BCC.Conexao.DAO.Dados,
  BCC.Caixa.DAO.Movimentacao, BCC.DAO.Jogo;

type
  TControllerMesa = class
    private
      MesaVazia : Boolean;
      FMesa: TMesa;

      function  ValidaRegra(ARegra : TRegraPromocao; AQuantidade : Double) : Boolean;
      procedure GravarVenda();
      procedure CalculaTotal();
    public
      procedure AddProduto(ACodProduto : Integer; AQuantidade : Double);
      procedure AddServico(ACodServico : Integer; AQuantidade : Double);
      procedure AddJogo(ACodJogo : Integer);

      procedure NovaVenda(AIdentificacao : String);
      procedure FinalizarVenda(ATitulos : TObjectList<TTitulo>);
      procedure SelecionarVenda(ACodigoMesa : Integer);
      procedure VincularCliente(ACodCliente : Integer);

      procedure RemoverItem(ACodItem : Integer);

      property Mesa: TMesa read FMesa;

      constructor Create();
  end;

implementation

{ TControllerMesa }

procedure TControllerMesa.AddJogo(ACodJogo: Integer);
var
  ItemMesa : TItemMesa;
begin
  ItemMesa := TItemMesa.Create();

  ItemMesa.Descricao  := TDmJogo.Create(nil).Selecionar(ACodJogo).Nome;
  ItemMesa.Quantidade := 1;
  ItemMesa.CodJogo    := ACodJogo;
  ItemMesa.PrecoUnitario := 0;
  ItemMesa.ValorTotal    := 0;
  Self.FMesa.Itens.Add(ItemMesa);
  Self.MesaVazia := False;
  Self.GravarVenda();
end;

procedure TControllerMesa.AddProduto(ACodProduto: Integer; AQuantidade : Double);
var
  Produto     : TProduto;
  ItemMesa    : TItemMesa;
  Promocoes   : TObjectList<TPromocao>;
  UsaPromo    : Boolean;
  PromoValida : TPromocao;
  EstoqueOK   : Boolean;
begin
  Produto   := TDmProduto.Create(nil).Selecionar(ACodProduto);
  Promocoes := TDmPromocao.Create(nil).SelecionarPromoProd(ACodProduto);
  ItemMesa  := TItemMesa.Create();
  UsaPromo  := False;

  if Produto.ControlaEstoque then
  begin
    EstoqueOK := (Produto.Estoque - AQuantidade) > 0;
  end
  else
  begin
    EstoqueOK := True;
  end;

  if EstoqueOK then
  begin
    ItemMesa.Descricao  := Produto.Nome;
    ItemMesa.Quantidade := AQuantidade;
    ItemMesa.CodProduto := Produto.Codigo;

    try
      for var Promocao in Promocoes do
      begin
        if Assigned(Promocao) then
        begin
          if ValidaRegra(Promocao.Regra, AQuantidade) then
          begin
            UsaPromo := True;
            PromoValida := TPromocao.Create();
            PromoValida := Promocao;
          end
          else
          begin
            UsaPromo := False;
          end;
        end
        else
        begin
          UsaPromo := False;
        end;
      end;
    except
      UsaPromo := False;
    end;

    if UsaPromo then
    begin
      ItemMesa.PrecoUnitario := PromoValida.PrecoPromocional;
      ItemMesa.ValorTotal := PromoValida.PrecoPromocional * AQuantidade;
      FreeAndNIl(PromoValida);
    end
    else
    begin
      ItemMesa.PrecoUnitario := Produto.PrecoVenda;
      ItemMesa.ValorTotal := Produto.PrecoVenda * AQuantidade;
    end;

    Self.FMesa.Itens.Add(ItemMesa);

    Self.MesaVazia := False;

    Self.GravarVenda();
  end
  else
  begin
    raise Exception.Create('Produto sem estoque!');
  end;
end;

procedure TControllerMesa.AddServico(ACodServico: Integer; AQuantidade : Double);
var
  Servico     : TServico;
  ItemMesa    : TItemMesa;
  Promocoes   : TObjectList<TPromocao>;
  PromoValida : TPromocao;
  UsaPromo    : Boolean;
begin
  Servico   := TDmServico.Create(nil).Selecionar(ACodServico);
  Promocoes := TDmPromocao.Create(nil).SelecionarPromoServ(ACodServico);
  ItemMesa  := TItemMesa.Create();
  UsaPromo := False;

  ItemMesa.Descricao  := Servico.Nome;
  ItemMesa.Quantidade := AQuantidade;
  ItemMesa.CodServico := Servico.Codigo;

  try
    for var Promocao in Promocoes do
    begin
      if Assigned(Promocao) then
      begin
        if ValidaRegra(Promocao.Regra, AQuantidade) then
        begin
          UsaPromo := True;
          PromoValida.Create();
          PromoValida := Promocao;
        end
        else
        begin
          UsaPromo := False;
        end;
      end
      else
      begin
        UsaPromo := False;
      end;
    end;
  except
    UsaPromo := False;
  end;

  if UsaPromo then
  begin
    ItemMesa.PrecoUnitario := PromoValida.PrecoPromocional;
    ItemMesa.ValorTotal := PromoValida.PrecoPromocional * AQuantidade;
    FreeAndNil(PromoValida);
  end
  else
  begin
    ItemMesa.PrecoUnitario := Servico.Valor;
    ItemMesa.ValorTotal := Servico.Valor * AQuantidade;
  end;

  Self.FMesa.Itens.Add(ItemMesa);

  Self.MesaVazia := False;

  Self.GravarVenda();
end;

procedure TControllerMesa.CalculaTotal;
begin
  Self.FMesa.ValorTotal := 0;
  for var I := 0 to Self.FMesa.Itens.Count - 1 do
  begin
    Self.FMesa.ValorTotal := Self.FMesa.ValorTotal + Self.FMesa.Itens[I].ValorTotal;
  end;
end;

constructor TControllerMesa.Create;
begin
  Self.FMesa := TMesa.Create();
  Self.MesaVazia := True;
end;

procedure TControllerMesa.NovaVenda(AIdentificacao : String);
begin
  if TDmMesa.Create(nil).ValidarIdentificacao(AIdentificacao) then
  begin
    if not Self.MesaVazia then
    begin
      Self.GravarVenda();
    end;
    FreeAndNil(Self.FMesa);
    Self.FMesa := TMesa.Create();
    Self.FMesa.Aberta := True;
    Self.FMesa.Identificacao := AIdentificacao;
    Self.MesaVazia := True;
  end
  else
  begin
    raise Exception.Create('Já existe uma mesa aberta com essa identificação!');
  end;
end;

procedure TControllerMesa.RemoverItem(ACodItem: Integer);
begin
  TDmMesa.Create(nil).RemoverItem(ACodItem);
end;

procedure TControllerMesa.FinalizarVenda(ATitulos : TObjectList<TTitulo>);
var
  DmMesa : TDmMesa;
  DmMovimentacao : TDmMovimentacao;
begin
  if not Self.MesaVazia then
  begin
    Self.FMesa.Aberta := False;
    Self.FMesa.CodCaixa := DmDados.CodCaixa;
    Self.FMesa.Data := Date();
    Self.CalculaTotal();

    DmMesa := TDmMesa.Create(nil);
    DmMovimentacao := TDmMovimentacao.Create(nil);
    for var Titulo in ATitulos do
    begin
      Titulo.CodVenda := Self.Mesa.Codigo;
      Titulo.Codigo := DmMesa.InserirTitulo(Titulo).Codigo;

      DmMovimentacao.AdicionarMovimentacao(Titulo.Valor, -1, Titulo.Codigo);
    end;
    FreeAndNil(DmMesa);
    FreeAndNil(DmMovimentacao);

    Self.GravarVenda();
  end;
end;

procedure TControllerMesa.GravarVenda;
begin
  if Self.FMesa.Codigo > 0 then
  begin
    Self.FMesa := TDmMesa.Create(nil).EditarMesa(Self.FMesa);
  end
  else
  begin
    Self.FMesa := TDmMesa.Create(nil).InserirMesa(Self.FMesa);
  end;
end;

procedure TControllerMesa.SelecionarVenda(ACodigoMesa : Integer);
begin
  if not Self.MesaVazia then
  begin
    Self.GravarVenda();
  end;
  FreeAndNil(Self.FMesa);
  Self.FMesa := TDmMesa.Create(nil).SelecionarMesa(ACodigoMesa);
  Self.MesaVazia := False;
end;

function TControllerMesa.ValidaRegra(ARegra: TRegraPromocao; AQuantidade: Double): Boolean;
begin
  case ARegra.Tipo of
    PrmDiaSemana:
    begin
      Result := DayOfWeek(Date()) = Integer(ARegra.DiaSemana);
    end;
    PrdData: 
    begin
      Result := (ARegra.DataInicial <= Date()) and (ARegra.DataFinal >= Date());
    end;
    PrdQuantidade: 
    begin
      Result := AQuantidade >= ARegra.QuantidadeMinima;
    end;
  end;

end;

procedure TControllerMesa.VincularCliente(ACodCliente: Integer);
begin
  Self.FMesa.CodCliente := ACodCliente;
  Self.GravarVenda();
end;

end.
