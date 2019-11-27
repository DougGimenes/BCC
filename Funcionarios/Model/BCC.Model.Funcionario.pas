unit BCC.Model.Funcionario;

interface

uses
  System.Classes, BCC.Model.Usuario, BCC.Model.Endereco;

type
  TFuncionario = class
    private
      FCodigo: Integer;
      FNome: String;
      FUsuario: TUsuario;
      FAtivo: Boolean;
      FFuncao: Integer;
      FCPF: String;
      //FNascimento: TDateTime;
      //FEndereco: TEndereco;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Nome: String read FNome write FNome;
      property Usuario: TUsuario read FUsuario write FUsuario;
      property Ativo: Boolean read FAtivo write FAtivo;
      property Funcao: Integer read FFuncao write FFuncao;
      property CPF: String read FCPF write FCPF;
      //property Nascimento: TDateTime read FNascimento write FNascimento;
      //property Endereco: TEndereco read FEndereco write FEndereco;
  end;

implementation

end.
