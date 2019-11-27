unit BCC.Model.Cliente;

interface

uses
  BCC.Model.Usuario, System.Classes, BCC.Model.Endereco;

type
  TCliente = class
    private
      FCodigo: Integer;
      FNome: String;
      FNascimento: TDateTime;
      FUsuario: TUsuario;
      FAtivo: Boolean;
      FCPF: String;
      FEndereco: TEndereco;
      FTelefone: String;
      FEmail: String;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Nome: String read FNome write FNome;
      property Nascimento: TDateTime read FNascimento write FNascimento;
      property Usuario: TUsuario read FUsuario write FUsuario;
      property Ativo: Boolean read FAtivo write FAtivo;
      property CPF: String read FCPF write FCPF;
      property Endereco: TEndereco read FEndereco write FEndereco;
      property Telefone: String read FTelefone write FTelefone;
      property Email: String read FEmail write FEmail;
  end;

implementation

{ Cliente }

end.
