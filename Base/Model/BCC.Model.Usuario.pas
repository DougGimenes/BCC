unit BCC.Model.Usuario;

interface

type
  TUsuario = class
    private
      FLogin: String;
      FSenha: String;
      FAtivo: Boolean;
      FCodigo: Integer;
      FCodFunc: Integer;
      FCodCli: Integer;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Login: String read FLogin write FLogin;
      property Senha: String read FSenha write FSenha;
      property Ativo: Boolean read FAtivo write FAtivo;
      property CodFunc: Integer read FCodFunc write FCodFunc;
      property CodCli: Integer read FCodCli write FCodCli;
  end;

implementation

end.
