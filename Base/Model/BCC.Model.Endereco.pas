unit BCC.Model.Endereco;

interface

type
  TEndereco = class
    private
      FEndereco: String;
      FBairro: String;
      FNumero: String;
    public
      property Endereco: String read FEndereco write FEndereco;
      property Bairro: String read FBairro write FBairro;
      property Numero: String read FNumero write FNumero;
  end;

implementation

end.
