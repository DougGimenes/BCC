unit BCC.Model.Mesa;

interface

uses
  System.Generics.Collections, BCC.Model.Jogo, BCC.Model.Produto, BCC.Model.Servico;

type
  EFormaPagamento = (FpgVista, FpgDebito, FpgCredito);

  TItemMesa = class
    private
      FCodigo: Integer;
      FDescricao: String;
      FQuantidade: Double;
      FCodProduto: Integer;
      FCodServico: Integer;
      FPrecoUnitario: Double;
      FValorTotal: Double;
      FCodMesa: Integer;
      FCodJogo: Integer;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property CodMesa: Integer read FCodMesa write FCodMesa;
      property Descricao: String read FDescricao write FDescricao;
      property Quantidade: Double read FQuantidade write FQuantidade;
      property CodProduto: Integer read FCodProduto write FCodProduto;
      property CodServico: Integer read FCodServico write FCodServico;
      property PrecoUnitario: Double read FPrecoUnitario write FPrecoUnitario;
      property ValorTotal: Double read FValorTotal write FValorTotal;
      property CodJogo: Integer read FCodJogo write FCodJogo;
  end;

  TMesa = class
    private
      FCodigo: Integer;
      FItens: TObjectList<TItemMesa>;
      FAberta: Boolean;
      FCodCliente: Integer;
      FValorTotal: Double;
      FIdentificacao: String;
      FCodCaixa: integer;
      FFormaPagamento : EFormaPagamento;
      FData: TDate;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Identificacao: String read FIdentificacao write FIdentificacao;
      property Itens: TObjectList<TItemMesa> read FItens write FItens;
      property Aberta: Boolean read FAberta write FAberta;
      property CodCliente: Integer read FCodCliente write FCodCliente;
      property ValorTotal: Double read FValorTotal write FValorTotal;
      property CodCaixa: integer read FCodCaixa write FCodCaixa;
      property FormaPagamento: EFormaPagamento read FFormaPagamento write FFormaPagamento;
      property Data: TDate read FData write FData;

      constructor Create();
  end;

  TTitulo = class
    private
      FCodigo: Integer;
      FCodVenda: Integer;
      FValor: Double;
      FPago: Double;
      FTroco: Double;
      FFormaPagto: EFormaPagamento;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property CodVenda: Integer read FCodVenda write FCodVenda;
      property Valor: Double read FValor write FValor;
      property Pago: Double read FPago write FPago;
      property Troco: Double read FTroco write FTroco;
      property FormaPagto: EFormaPagamento read FFormaPagto write FFormaPagto;
  end;

implementation

{ TMesa }

constructor TMesa.Create;
begin
  Self.Itens := TobjectList<TItemMesa>.Create(True);
end;

end.
