unit BCC.DAO.Funcionario;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, BCC.Conexao.DAO.Dados,
  BCC.Model.Funcionario, BCC.Model.Endereco, BCC.DAO.Usuario, BCC.Model.Usuario,
  System.Generics.Collections;

type
  TDmFuncionario = class(TDataModule)
    TbFuncionario: TADOQuery;
    TbFuncionarioID_Func: TAutoIncField;
    TbFuncionarioNome: TStringField;
    TbFuncionarioCPF: TStringField;
    TbFuncionarioFunção: TIntegerField;
    TbFuncionarioAtivo: TBooleanField;
  private
    { Private declarations }
    procedure ObjToData(AFuncionario : TFuncionario);
    function  DataToObj() : TFuncionario;
  public
    { Public declarations }
    function  Inserir(AFuncionario : TFuncionario) : TFuncionario;
    function  Selecionar(ACodigo : Integer) : TFuncionario;
    function  SelecionarTodos() : TObjectList<TFuncionario>;
    procedure Editar(AFuncionario : TFuncionario);
  end;

var
  DmFuncionario: TDmFuncionario;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmFuncionario }

function TDmFuncionario.DataToObj: TFuncionario;
begin
  Result := TFuncionario.Create();
  Result.Codigo := Self.TbFuncionarioID_Func.Value;
  Result.Nome   := Self.TbFuncionarioNome.Value;

  Result.Funcao := Self.TbFuncionarioFunção.Value;
  Result.Ativo  := Self.TbFuncionarioAtivo.Value;

  Result.Usuario := TDmUsuario.Create(Self).SelecionarPorFuncionario(Self.TbFuncionarioID_Func.Value);
  Result.CPF    := Self.TbFuncionarioCPF.Value;

//  Result.Nascimento := Self.TbFuncionarioNascimento.Value;
//  Result.Endereco := TEndereco.Create();
//  Result.Endereco.Endereco := Self.TbFuncionarioEndereço.Value;
//  Result.Endereco.Bairro   := Self.TbFuncionarioBairro.Value;
//  Result.Endereco.Numero   := Self.TbFuncionarioNumero.Value;
end;

procedure TDmFuncionario.Editar(AFuncionario : TFuncionario);
begin
  Self.Selecionar(AFuncionario.Codigo);
  Self.TbFuncionario.Edit();
  Self.ObjToData(AFuncionario);
  Self.TbFuncionario.Post();

  if AFuncionario.Usuario.Login <> '' then
  begin
    if AFuncionario.Usuario.Codigo > 0 then
    begin
      TDmUsuario.Create(Self).Alterar(AFuncionario.Usuario);
    end
    else
    begin
      AFuncionario.Usuario.CodFunc := AFuncionario.Codigo;
      TDmUsuario.Create(Self).Inserir(AFuncionario.Usuario);
    end;
  end;
end;

function TDmFuncionario.Inserir(AFuncionario: TFuncionario): TFuncionario;
begin
  Self.TbFuncionario.Close();
  Self.TbFuncionario.SQL.Clear();
  Self.TbFuncionario.SQL.Text := 'SELECT * FROM Funcionarios' + #13 +
                                 '  WHERE -1 = 1';
  Self.TbFuncionario.Open();
  Self.TbFuncionario.Append();
  Self.ObjToData(AFuncionario);
  Self.TbFuncionario.Post();

  if AFuncionario.Usuario.Login <> '' then
  begin
    AFuncionario.Usuario.CodFunc := Self.TbFuncionarioID_Func.Value;
    TDmUsuario.Create(Self).Inserir(AFuncionario.Usuario);
  end;

  Result := Self.DataToObj();
end;

procedure TDmFuncionario.ObjToData(AFuncionario: TFuncionario);
begin
  Self.TbFuncionarioNome.Value := AFuncionario.Nome;
  Self.TbFuncionarioCPF.Value  := AFuncionario.CPF;

//  Self.TbFuncionarioNascimento.Value := AFuncionario.Nascimento;
//  Self.TbFuncionarioEndereço.Value := AFuncionario.Endereco.Endereco;
//  Self.TbFuncionarioBairro.Value   := AFuncionario.Endereco.Bairro;
//  Self.TbFuncionarioNumero.Value   := AFuncionario.Endereco.Numero;

  Self.TbFuncionarioFunção.Value := AFuncionario.Funcao;
  Self.TbFuncionarioAtivo.Value  := AFuncionario.Ativo;
end;

function TDmFuncionario.Selecionar(ACodigo: Integer): TFuncionario;
begin
  Self.TbFuncionario.Close();
  Self.TbFuncionario.SQL.Clear();
  Self.TbFuncionario.SQL.Text := 'SELECT * FROM Funcionarios' + #13 +
                                 '  WHERE ID_Func = ' + ACodigo.ToString();
  Self.TbFuncionario.Open();

  Result := Self.DataToObj();
end;

function TDmFuncionario.SelecionarTodos: TObjectList<TFuncionario>;
var
  I: Integer;
begin
  Self.TbFuncionario.Close();
  Self.TbFuncionario.SQL.Clear();
  Self.TbFuncionario.SQL.Text := 'SELECT * FROM Funcionarios';
  Self.TbFuncionario.Open();

  Result := TObjectList<TFuncionario>.Create(True);
  Self.TbFuncionario.First();
  for I := 0 to Self.TbFuncionario.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
    Self.TbFuncionario.Next();
  end;
end;

end.
