unit BCC.DAO.Cliente;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, BCC.Conexao.DAO.Dados,
  BCC.Model.Cliente, BCC.DAO.Usuario, BCC.Model.Endereco, System.Generics.Collections;

type
  TDmCliente = class(TDataModule)
    TbCliente: TADOQuery;
    TbClienteID_Cliente: TIntegerField;
    TbClienteNome: TStringField;
    TbClienteNascimento: TDateTimeField;
    TbClienteAtivo: TBooleanField;
    TbClienteCPF: TStringField;
    TbClienteEndereco: TStringField;
    TbClienteBairro: TStringField;
    TbClienteNumero: TStringField;
    TbClienteTelefone: TStringField;
    TbClienteEmail: TStringField;
  private
    { Private declarations }
    function DataToObj(): TCliente;
    procedure ObjToData(ACliente : TCliente);
  public
    { Public declarations }
    function  Inserir(ACliente : TCliente) : TCliente;
    function  SelecionarCliente(ACodigo : Integer) : TCliente;
    function  SelecionarTodos() : TObjectList<TCliente>;
    procedure Editar(ACliente : TCliente);
  end;

var
  DmCliente: TDmCliente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmCliente }

function TDmCliente.DataToObj: TCliente;
begin
  Result := TCliente.Create();
  Result.Codigo     := Self.TbClienteID_Cliente.Value;
  Result.Nome       := Self.TbClienteNome.Value;
  Result.CPF        := Self.TbClienteCPF.Value;
  Result.Nascimento := Self.TbClienteNascimento.Value;
  Result.Usuario    := TDmUsuario.Create(Self).SelecionarPorCliente(Self.TbClienteID_Cliente.Value);
  Result.Ativo      := Self.TbClienteAtivo.Value;
  Result.Endereco   := TEndereco.Create();
  Result.Endereco.Endereco := Self.TbClienteEndereco.Value;
  Result.Endereco.Bairro   := Self.TbClienteBairro.Value;
  Result.Endereco.Numero   := Self.TbClienteNumero.Value;
  Result.Telefone := Self.TbClienteTelefone.Value;
  Result.Email    := Self.TbClienteEmail.Value;
end;

procedure TDmCliente.Editar(ACliente: TCliente);
begin
  Self.SelecionarCliente(ACliente.Codigo);
  Self.TbCliente.Edit();
  Self.ObjToData(ACliente);
  Self.TbCliente.Post();

  if ACliente.Usuario.Login <> '' then
  begin
    if ACliente.Usuario.Codigo > 0 then
    begin
      TDmUsuario.Create(Self).Alterar(ACliente.Usuario);
    end
    else
    begin
      ACliente.Usuario.CodCli := ACliente.Codigo;
      TDmUsuario.Create(Self).Inserir(ACliente.Usuario);
    end;
  end;
end;

function TDmCliente.Inserir(ACliente: TCliente): TCliente;
begin
  Self.TbCliente.Close();
  Self.TbCliente.SQL.Clear();
  Self.TbCliente.SQL.Text := 'SELECT * FROM Cliente' + #13 +
                             '  WHERE -1 = 1';
  Self.TbCliente.Open();
  Self.TbCliente.Append();

  Self.ObjToData(ACliente);

  Self.TbCliente.Post();

  if ACliente.Usuario.Login <> '' then
  begin
    ACliente.Usuario.CodCli := Self.TbClienteID_Cliente.Value;
    TDmUsuario.Create(Self).Inserir(ACliente.Usuario);
  end;

  Result := Self.DataToObj();
end;

procedure TDmCliente.ObjToData(ACliente: TCliente);
begin
  Self.TbClienteNome.Value       := ACliente.Nome;
  Self.TbClienteCPF.Value        := ACliente.CPF;
  Self.TbClienteNascimento.Value := ACliente.Nascimento;
  Self.TbClienteAtivo.Value      := ACliente.Ativo;
  Self.TbClienteEndereco.Value   := ACliente.Endereco.Endereco;
  Self.TbClienteBairro.Value     := ACliente.Endereco.Bairro;
  Self.TbClienteNumero.Value     := ACliente.Endereco.Numero;
  Self.TbClienteTelefone.Value   := ACliente.Telefone;
  Self.TbClienteEmail.Value      := ACliente.Email;
end;

function TDmCliente.SelecionarCliente(ACodigo: Integer): TCliente;
begin
  Self.TbCliente.Close();
  Self.TbCliente.SQL.Text := 'SELECT * FROM Cliente' + #13 +
                             '  WHERE ID_Cliente = ' + ACodigo.ToString();
  Self.TbCliente.Open();
  Result := Self.DataToObj();
end;

function TDmCliente.SelecionarTodos: TObjectList<TCliente>;
var
  I: Integer;
begin
  Self.TbCliente.Close();
  Self.TbCliente.SQL.Text := 'SELECT * FROM Cliente';
  Self.TbCliente.Open();

  Result := TObjectList<TCliente>.Create(True);
  for I := 0 to Self.TbCliente.RecordCount - 1 do
  begin
    Result.Add(Self.DataToObj());
  end;
end;

end.
