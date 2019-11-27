unit BCC.Caixa.Model.Movimentacao;

interface

type
  TMovimentacao = class
    private
      FCodigo: Integer;
      FCodCaixa: Integer;
      FValor: Double;
      FCodConta: Integer;
      FCodTitulo: Integer;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property CodCaixa: Integer read FCodCaixa write FCodCaixa;
      property Valor: Double read FValor write FValor;
      property CodConta: Integer read FCodConta write FCodConta;
      property CodTitulo: Integer read FCodTitulo write FCodTitulo;
  end;

implementation

end.
