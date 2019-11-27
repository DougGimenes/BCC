unit BCC.Model.Contas;

interface

type
  TConta = class
    private
      FCodigo: Integer;
      FValor: Double;
      FNome: String;
      FVencimento: TDate;
      FEmissao: TDate;
      FPagamento: TDate;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Valor: Double read FValor write FValor;
      property Nome: String read FNome write FNome;
      property Vencimento: TDate read FVencimento write FVencimento;
      property Emissao: TDate read FEmissao write FEmissao;
      property Pagamento: TDate read FPagamento write FPagamento;
  end;

implementation

end.
