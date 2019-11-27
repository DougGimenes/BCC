unit BCC.Model.Caixa;

interface

type
  TCaixa = class
    private
      FCodigo: Integer;
      FAbertura: TDateTime;
      FFechamento: TDateTime;
      FAberto: Boolean;
      FValorInicial: Double;
      FValorFinal: Double;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Abertura: TDateTime read FAbertura write FAbertura;
      property Fechamento: TDateTime read FFechamento write FFechamento;
      property Aberto: Boolean read FAberto write FAberto;
      property ValorInicial: Double read FValorInicial write FValorInicial;
      property ValorFinal: Double read FValorFinal write FValorFinal;
  end;

implementation

end.
