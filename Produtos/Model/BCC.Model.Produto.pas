unit BCC.Model.Produto;

interface

type
  TProduto = class
    private
      FCodigo: Integer;
      FNome: String;
      FPrecoVenda: Double;
      FPrecoCusto: Double;
      FEstoque: Double;
      FAtivo: Boolean;
      FCardapio: Boolean;
      FControlaEstoque: Boolean;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Nome: String read FNome write FNome;
      property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;
      property PrecoCusto: Double read FPrecoCusto write FPrecoCusto;
      property Estoque: Double read FEstoque write FEstoque;
      property Cardapio: Boolean read FCardapio write FCardapio;
      property Ativo: Boolean read FAtivo write FAtivo;
      property ControlaEstoque: Boolean read FControlaEstoque write FControlaEstoque;
  end;

implementation

end.
