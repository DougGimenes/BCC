unit BCC.DAO.Usuario;

interface

uses
  System.SysUtils, System.Classes, BCC.Conexao.DAO.Dados, Data.DB, Data.Win.ADODB,
  BCC.Model.Usuario;

type
  TDmUsuario = class(TDataModule)
    TbUsuario: TADOQuery;
    TbUsuarioID_User: TAutoIncField;
    TbUsuarioID_Func: TIntegerField;
    TbUsuarioID_Cliente: TIntegerField;
    TbUsuarioUsuario: TStringField;
    TbUsuarioSenha: TStringField;
    TbUsuarioAtivo: TBooleanField;
  private
    { Private declarations }
    function  DataToObj() : TUsuario;
    procedure ObjToData(AUsuario : TUsuario);
  public
    { Public declarations }
    function Selecionar(ACodigo : Integer) : TUsuario;
    function SelecionarPorLogin(ALogin : String) : TUsuario;
    function SelecionarPorCliente(ACodCli : Integer) : TUsuario;
    function SelecionarPorFuncionario(ACodFunc : Integer) : TUsuario;

    function Inserir(AUsuario : TUsuario) : TUsuario;
    procedure Alterar(AUsuario : TUsuario);
  end;

var
  DmUsuario: TDmUsuario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmUsuario }

procedure TDmUsuario.Alterar(AUsuario: TUsuario);
begin
  Self.Selecionar(AUsuario.Codigo);
  Self.TbUsuario.Edit();
  Self.ObjToData(AUsuario);
  Self.TbUsuario.Post();
end;

function TDmUsuario.DataToObj: TUsuario;
begin
  Result := TUsuario.Create();
  Result.Codigo  := Self.TbUsuarioID_User.Value;
  Result.Login   := Self.TbUsuarioUsuario.Value;
  Result.Senha   := Self.TbUsuarioSenha.Value;
  Result.Ativo   := Self.TbUsuarioAtivo.Value;
  Result.CodFunc := Self.TbUsuarioID_Func.Value;
  Result.CodCli  := Self.TbUsuarioID_Cliente.Value;
end;

function TDmUsuario.Inserir(AUsuario: TUsuario): TUsuario;
begin
  Self.TbUsuario.Close();
  Self.TbUsuario.SQL.Clear();

  Self.SelecionarPorLogin(AUsuario.Login);
  if Self.TbUsuario.RecordCount > 0 then
  begin
    raise Exception.Create('Esse usuário já existe!');
  end;

  Self.TbUsuario.SQL.Text := 'SELECT * FROM Usuarios' + #13 +
                             '  WHERE -1 = 1';
  Self.TbUsuario.Open();
  Self.TbUsuario.Append();

  Self.ObjToData(AUsuario);

  Self.TbUsuario.Post();

  Result := Self.DataToObj();
end;

procedure TDmUsuario.ObjToData(AUsuario: TUsuario);
begin
  if not (AUsuario.Senha.Length >= 5) then
  begin
    raise Exception.Create('Senha inválida! A Senha deve ter ao menos 5 caracteres!');
  end;

  Self.TbUsuarioUsuario.Value := AUsuario.Login;
  Self.TbUsuarioSenha.Value   := AUsuario.Senha;
  Self.TbUsuarioAtivo.Value   := AUsuario.Ativo;

  if AUsuario.CodFunc > 0 then
  begin
    Self.TbUsuarioID_Func.Value := AUsuario.CodFunc;
  end
  else
  begin
    Self.TbUsuarioID_Func.Clear();
  end;

  if AUsuario.CodCli > 0 then
  begin
    Self.TbUsuarioID_Cliente.Value := AUsuario.CodCli;
  end
  else
  begin
    Self.TbUsuarioID_Cliente.Clear();
  end;

end;

function TDmUsuario.Selecionar(ACodigo: Integer): TUsuario;
begin
  Self.TbUsuario.Close();
  Self.TbUsuario.SQL.Clear();
  Self.TbUsuario.SQL.Text := 'SELECT * FROM Usuarios' + #13 +
                             '  WHERE Id_User = 0' + ACodigo.ToString();
  Self.TbUsuario.Open();
  Result := Self.DataToObj();
end;

function TDmUsuario.SelecionarPorCliente(ACodCli: Integer): TUsuario;
begin
  Self.TbUsuario.Close();
  Self.TbUsuario.SQL.Clear();
  Self.TbUsuario.SQL.Text := 'SELECT * FROM Usuarios' + #13 +
                             '  WHERE Id_Cliente = 0' + ACodCli.ToString();
  Self.TbUsuario.Open();
  Result := Self.DataToObj();
end;

function TDmUsuario.SelecionarPorFuncionario(ACodFunc: Integer): TUsuario;
begin
  Self.TbUsuario.Close();
  Self.TbUsuario.SQL.Clear();
  Self.TbUsuario.SQL.Text := 'SELECT * FROM Usuarios' + #13 +
                             '  WHERE Id_Func = 0' + ACodFunc.ToString();
  Self.TbUsuario.Open();
  Result := Self.DataToObj();
end;

function TDmUsuario.SelecionarPorLogin(ALogin: String): TUsuario;
begin
  Self.TbUsuario.Close();
  Self.TbUsuario.SQL.Clear();
  Self.TbUsuario.SQL.Text := 'SELECT * FROM Usuarios' + #13 +
                             '  WHERE Usuario LIKE ' + QuotedStr(ALogin);
  Self.TbUsuario.Open();
  Result := Self.DataToObj();
end;

end.
