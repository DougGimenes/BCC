unit BCC.Model.Jogo;

interface

uses
  System.Classes;

type
  TJogo = class(TObject)
    private
      FCodigo: Integer;
      FNome: String;
      FMaxJogadores: Integer;
      FNumeroCopias: Integer;
      FAtivo: Boolean;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Nome: String read FNome write FNome;
      property MaxJogadores: Integer read FMaxJogadores write FMaxJogadores;
      property NumeroCopias: Integer read FNumeroCopias write FNumeroCopias;
      property Ativo: Boolean read FAtivo write FAtivo;
  end;

implementation

end.
