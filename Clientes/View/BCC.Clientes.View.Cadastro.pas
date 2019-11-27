unit BCC.Clientes.View.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, BCC.Model.Cliente, BCC.DAO.Cliente, BCC.Model.Usuario,
  BCC.Model.Endereco, Math, BCC.Clientes.View.Consulta, BCC.Principal.Funcional.Validacoes;

type
  TFrmCadastroCliente = class(TFraBase)
    LedNome: TLabeledEdit;
    LedSenha: TLabeledEdit;
    LedUsuario: TLabeledEdit;
    LblNascimento: TLabel;
    DtpNascimento: TDateTimePicker;
    ChbUsuarioAtivo: TCheckBox;
    LblTitulo: TLabel;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    PnlCampos: TPanel;
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnConsultar: TButton;
    LedCPF: TLabeledEdit;
    LedTelefone: TLabeledEdit;
    LedEmail: TLabeledEdit;
    LedEndereco: TLabeledEdit;
    LedBairro: TLabeledEdit;
    LedNumero: TLabeledEdit;
    BtnDesativar: TButton;
    LedConfirmaSenha: TLabeledEdit;
    procedure BtnSalvarClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnDesativarClick(Sender: TObject);
  private
    { Private declarations }
    ClienteAtual : TCliente;

    procedure PreencherTela(ACliente : TCliente);
    procedure LimparTela();

    procedure TratarTela();
    procedure ConsultarCliente();

    function GetCliente() : TCliente;
  public
    { Public declarations }
  end;

var
  FrmCadastroCliente: TFrmCadastroCliente;

implementation

{$R *.dfm}

procedure TFrmCadastroCliente.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  try
    Self.PreencherTela(Self.ClienteAtual);
  except
    Self.LimparTela();
  end;
  Self.TratarTela();
end;

procedure TFrmCadastroCliente.BtnConsultarClick(Sender: TObject);
begin
  inherited;
  Self.ConsultarCliente();
end;

procedure TFrmCadastroCliente.BtnDesativarClick(Sender: TObject);
begin
  inherited;
  Self.ClienteAtual.Ativo := not Self.ClienteAtual.Ativo;

  TDmCliente.Create(Self).Editar(Self.ClienteAtual);

  if Self.ClienteAtual.Ativo then
  begin
    Self.BtnDesativar.Caption := 'Desativar';
  end
  else
  begin
    Self.BtnDesativar.Caption := 'Ativar';
  end;
end;

procedure TFrmCadastroCliente.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Self.TratarTela();
end;

procedure TFrmCadastroCliente.BtnNovoClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.ClienteAtual);
  Self.ClienteAtual := TCliente.Create();
  Self.ClienteAtual.Usuario := TUsuario.Create();
  Self.LimparTela();
  Self.TratarTela();
end;

procedure TFrmCadastroCliente.BtnSalvarClick(Sender: TObject);
var
  Cliente : TCliente;
begin
  inherited;
  if Self.LedCPF.Text <> '' then
  begin
    if not TValidador.ValidarCPF(Self.LedCPF.Text) then
    begin
      raise Exception.Create('CPF inválido!' + #13 + 'Caso não deseje informar o CPF deixe o campo em branco!');
    end;
  end;

  if not (Self.LedNome.Text <> '') then
  begin
    raise Exception.Create('Nome do cliente precisa ser preenchido!');
  end;

  if (not (Self.LedEmail.Text <> '')) and (not (Self.LedTelefone.Text <> '')) then
  begin
    raise Exception.Create('Email ou telefone precisam ser preenchidos!');
  end;

  if (Self.ClienteAtual.Usuario.Senha <> Self.LedSenha.Text) and (Self.LedSenha.Text <> Self.LedConfirmaSenha.Text) then
  begin
    Self.LedConfirmaSenha.Text := '';
    raise Exception.Create('Senhas não correspondem!');
  end;

  Cliente := TCliente.Create();
  Cliente.Nome := Self.LedNome.Text;
  Cliente.Nascimento := Self.DtpNascimento.DateTime;

  Cliente.CPF := Self.LedCPF.Text;

  Cliente.Usuario := TUsuario.Create();
  Cliente.Usuario.Login := Self.LedUsuario.Text;
  Cliente.Usuario.Senha := Self.LedSenha.Text;
  Cliente.Usuario.Ativo := Self.ChbUsuarioAtivo.Checked;

  Cliente.Telefone := Self.LedTelefone.Text;
  Cliente.Email    := Self.LedEmail.Text;

  Cliente.Endereco := TEndereco.Create();
  Cliente.Endereco.Endereco := Self.LedEndereco.Text;
  Cliente.Endereco.Bairro   := Self.LedBairro.Text;
  Cliente.Endereco.Numero   := Self.LedNumero.Text;

  try
    if Self.ClienteAtual.Usuario.Codigo > 0 then
    begin
      Cliente.Usuario.Codigo := Self.ClienteAtual.Usuario.Codigo;
    end
    else
    begin
      Cliente.Usuario.Codigo := 0;
    end;
  except
    Cliente.Ativo := True;
  end;

  if Self.ClienteAtual.Codigo > 0 then
  begin
    Cliente.Codigo := Self.ClienteAtual.Codigo;
    Cliente.Ativo := Self.ClienteAtual.Ativo;
    Cliente.Usuario.CodCli := Cliente.Codigo;
    TDmCliente.Create(Self).Editar(Cliente);
    Self.ClienteAtual := Cliente
  end
  else
  begin
    Cliente.Ativo := True;
    Self.ClienteAtual := TDmCliente.Create(Self).Inserir(Cliente);
  end;

  Self.PreencherTela(Self.ClienteAtual);

  Self.TratarTela();
end;

procedure TFrmCadastroCliente.ConsultarCliente;
var
  Consulta : TFrmConsultaCliente;
begin
  Consulta := TFrmConsultaCliente.Create(Self, False);
  try
    Consulta.ShowModal();
  finally
    if Consulta.Consultou then
    begin
      Self.ClienteAtual := Consulta.ObjetoConsultado;
      Self.PreencherTela(Consulta.ObjetoConsultado);
    end;
    FreeAndNil(Consulta);
  end;
end;

procedure TFrmCadastroCliente.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlCampos.Top := Self.PnlBotoes.Height;
  Self.PnlCampos.Left := Floor((Self.Width - Self.PnlCampos.Width) / 2);
end;

function TFrmCadastroCliente.GetCliente: TCliente;
begin
  Result := TCliente.Create();
  Result.Nome := Self.LedNome.Text;
  Result.Nascimento := Self.DtpNascimento.DateTime;

  Result.CPF := Self.LedCPF.Text;

  Result.Usuario := TUsuario.Create();
  Result.Usuario.Login := Self.LedUsuario.Text;
  Result.Usuario.Senha := Self.LedSenha.Text;
  Result.Usuario.Ativo := Self.ChbUsuarioAtivo.Checked;

  Result.Telefone := Self.LedTelefone.Text;
  Result.Email    := Self.LedEmail.Text;

  Result.Endereco := TEndereco.Create();
  Result.Endereco.Endereco := Self.LedEndereco.Text;
  Result.Endereco.Bairro   := Self.LedBairro.Text;
  Result.Endereco.Numero   := Self.LedNumero.Text;

  if Self.ClienteAtual.Codigo > 0 then
  begin
    Result.Codigo := Self.ClienteAtual.Codigo;
    Result.Ativo := Self.ClienteAtual.Ativo;

    if Self.ClienteAtual.Usuario.Codigo > 0 then
    begin
      Result.Usuario.Codigo := Self.ClienteAtual.Usuario.Codigo;
    end
    else
    begin
      Result.Usuario.Codigo := 0;
    end;
  end
  else
  begin
    Result.Codigo := 0;
    Result.Usuario.Codigo := 0;
    Result.Ativo := True;
  end;
end;

procedure TFrmCadastroCliente.LimparTela;
begin
  Self.LedCPF.Text            := '';
  Self.DtpNascimento.DateTime := Now();

  Self.LedUsuario.Text         := '';
  Self.LedSenha.Text           := '';
  Self.ChbUsuarioAtivo.Checked := False;

  Self.LedEndereco.Text := '';
  Self.LedBairro.Text   := '';
  Self.LedNumero.Text   := '';

  Self.LedTelefone.Text := '';
  Self.LedEmail.Text    := '';

  Self.LedNome.Text := '';

  Self.LedConfirmaSenha.Text := '';
end;

procedure TFrmCadastroCliente.PreencherTela(ACliente: TCliente);
begin
  Self.LedNome.Text           := ACliente.Nome;
  Self.LedCPF.Text            := ACliente.CPF;
  Self.DtpNascimento.DateTime := ACliente.Nascimento;

  Self.LedUsuario.Text         := ACliente.Usuario.Login;
  Self.LedSenha.Text           := ACliente.Usuario.Senha;
  Self.ChbUsuarioAtivo.Checked := ACliente.Usuario.Ativo;

  Self.LedEndereco.Text := ACliente.Endereco.Endereco;
  Self.LedBairro.Text   := ACliente.Endereco.Bairro;
  Self.LedNumero.Text   := ACliente.Endereco.Numero;

  Self.LedTelefone.Text := ACliente.Telefone;
  Self.LedEmail.Text    := ACliente.Email;

  Self.BtnEditar.Enabled := (Self.ClienteAtual.Codigo > 0) and (not Self.PnlCampos.Enabled);
  Self.BtnDesativar.Enabled := (Self.ClienteAtual.Codigo > 0) and (not Self.PnlCampos.Enabled);

  if Self.ClienteAtual.Ativo then
  begin
    Self.BtnDesativar.Caption := 'Desativar';
  end
  else
  begin
    Self.BtnDesativar.Caption := 'Ativar';
  end;

  Self.LedConfirmaSenha.Text := '';
end;

procedure TFrmCadastroCliente.TratarTela;
begin
  Self.PnlCampos.Enabled    := not Self.PnlCampos.Enabled;
  Self.BtnNovo.Enabled      := not Self.PnlCampos.Enabled;
  Self.BtnEditar.Enabled    := (Self.ClienteAtual.Codigo > 0) and (not Self.PnlCampos.Enabled);
  Self.BtnConsultar.Enabled := not Self.PnlCampos.Enabled;
  Self.BtnDesativar.Enabled := (Self.ClienteAtual.Codigo > 0) and (not Self.PnlCampos.Enabled);
end;

end.
