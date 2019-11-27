unit BCC.Model.Sala;

interface

type
  TSala = class
    private
      FCodigo: Integer;
      FDescricao: String;
      FMaxPessoas: Integer;
      FAtivo: Boolean;
      FInformacao: String;
      FValorHora: Double;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Descricao: String read FDescricao write FDescricao;
      property MaxPessoas: Integer read FMaxPessoas write FMaxPessoas;
      property Ativo: Boolean read FAtivo write FAtivo;
      property Informacao: String read FInformacao write FInformacao;
      property ValorHora: Double read FValorHora write FValorHora;
  end;

implementation

end.
