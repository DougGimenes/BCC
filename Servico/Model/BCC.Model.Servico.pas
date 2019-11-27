unit BCC.Model.Servico;

interface

type
  TServico = class
    private
      FNome: String;
      FCodigo: Integer;
      FValor: Double;
      FAtivo: Boolean;
      FDescricao: WideString;
    public
      property Nome: String read FNome write FNome;
      property Codigo: Integer read FCodigo write FCodigo;
      property Valor: Double read FValor write FValor;
      property Ativo: Boolean read FAtivo write FAtivo;
      property Descricao: WideString read FDescricao write FDescricao;
  end;

implementation

end.
