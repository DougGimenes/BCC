unit BCC.Funcionarios.View.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, BCC.View.FormBase, Math, BCC.Model.Funcionario,
  BCC.DAO.Funcionario, BCC.Model.Usuario, BCC.Model.Endereco, BCC.Funcionarios.View.Consulta,
  BCC.Principal.Funcional.Validacoes;

type
  TFrmCadastroFuncionarios = class(TFraBase)
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    LblFuncao: TLabel;
    CmbFuncao: TComboBox;
    LedNome: TLabeledEdit;
    LedSenha: TLabeledEdit;
    LedUsuario: TLabeledEdit;
    ChbUsuarioAtivo: TCheckBox;
    LblTitulo: TLabel;
    PnlConteudo: TPanel;
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnConsultar: TButton;
    LedCPF: TLabeledEdit;
    BtnDesativar: TButton;
    LedConfirmarSenha: TLabeledEdit;
    procedure FrameResize(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnDesativarClick(Sender: TObject);
  private
    { Private declarations }
    FuncionarioAtual : TFuncionario;

    procedure LimparTela();
    procedure PreencherTela(AFuncionario : TFuncionario);

    procedure TratarTela();
    function  GetFuncionario() : TFuncionario;
  public
    { Public declarations }
  end;

var
  FrmCadastroFuncionarios: TFrmCadastroFuncionarios;

implementation

{$R *.dfm}

procedure TFrmCadastroFuncionarios.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  try
    Self.PreencherTela(Self.FuncionarioAtual);
  except
    Self.LimparTela();
  end;
  Self.TratarTela();
end;

procedure TFrmCadastroFuncionarios.BtnConsultarClick(Sender: TObject);
var
  ConsultaFunc : TFrmConsultaFuncionario;
begin
  inherited;
  ConsultaFunc := TFrmConsultaFuncionario.Create(Self, False);
  try
    ConsultaFunc.ShowModal();
  finally
    if ConsultaFunc.Consultou then
    begin
      Self.FuncionarioAtual := ConsultaFunc.ObjetoConsultado;
      Self.PreencherTela(ConsultaFunc.ObjetoConsultado);
    end;
    FreeAndNil(ConsultaFunc);
  end;
end;

procedure TFrmCadastroFuncionarios.BtnDesativarClick(Sender: TObject);
begin
  inherited;
  Self.FuncionarioAtual.Ativo := not Self.FuncionarioAtual.Ativo;
  TDmFuncionario.Create(Self).Editar(Self.FuncionarioAtual);

  if Self.FuncionarioAtual.Ativo then
  begin
    Self.BtnDesativar.Caption := 'Desativar';
  end
  else
  begin
    Self.BtnDesativar.Caption := 'Ativar';
  end;
end;

procedure TFrmCadastroFuncionarios.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Self.TratarTela();
end;

procedure TFrmCadastroFuncionarios.BtnNovoClick(Sender: TObject);
begin
  inherited;
  if Self.FuncionarioAtual <> nil then
  begin
    FreeAndNil(Self.FuncionarioAtual);
  end;

  Self.FuncionarioAtual := TFuncionario.Create();
  Self.FuncionarioAtual.Usuario  := TUsuario.Create();

  Self.LimparTela();
  Self.TratarTela();
end;

procedure TFrmCadastroFuncionarios.BtnSalvarClick(Sender: TObject);
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
    raise Exception.Create('Nome precisa ser preenchido!');
  end;

  if not (Self.CmbFuncao.ItemIndex > -1) then
  begin
    raise Exception.Create('Função precisa ser selecionada!');
  end;

  if (Self.FuncionarioAtual.Usuario.Senha <> Self.LedSenha.Text) and (Self.LedSenha.Text <> Self.LedConfirmarSenha.Text) then
  begin
    Self.LedConfirmarSenha.Text := '';
    raise Exception.Create('Senhas não correspondem!');
  end;

  if Self.FuncionarioAtual.Codigo > 0 then
  begin
    TDmFuncionario.Create(Self).Editar(Self.GetFuncionario());
    Self.FuncionarioAtual := TDmFuncionario.Create(Self).Selecionar(Self.FuncionarioAtual.Codigo);
  end
  else
  begin
    Self.FuncionarioAtual := TDmFuncionario.Create(Self).Inserir(Self.GetFuncionario());
  end;

  Self.PreencherTela(Self.FuncionarioAtual);
  Self.TratarTela();
end;

procedure TFrmCadastroFuncionarios.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlConteudo.Top := Self.PnlBotoes.Height;
  Self.PnlConteudo.Left := Floor((Self.Width - Self.PnlConteudo.Width) / 2);
end;

function TFrmCadastroFuncionarios.GetFuncionario: TFuncionario;
begin
  Result := TFuncionario.Create();

  Result.Nome := Self.LedNome.Text;
  Result.Funcao := Self.CmbFuncao.ItemIndex;
  Result.CPF  := Self.LedCPF.Text;

  Result.Usuario := TUsuario.Create();
  Result.Usuario.Codigo := Self.FuncionarioAtual.Usuario.Codigo;
  Result.Usuario.Ativo := Self.ChbUsuarioAtivo.Checked;
  Result.Usuario.Login := Self.LedUsuario.Text;
  Result.Usuario.Senha := Self.LedSenha.Text;

  if Self.FuncionarioAtual.Codigo > 0 then
  begin
    Result.Codigo := Self.FuncionarioAtual.Codigo;
    Result.Ativo  := Self.FuncionarioAtual.Ativo;
    Result.Usuario.CodFunc := Self.FuncionarioAtual.Codigo;
  end
  else
  begin
    Result.Ativo := True;
  end;
end;

procedure TFrmCadastroFuncionarios.LimparTela;
begin
  Self.LedNome.Text        := '';
  Self.CmbFuncao.ItemIndex := -1;

  Self.ChbUsuarioAtivo.Checked := False;
  Self.LedUsuario.Text         := '';
  Self.LedSenha.Text           := '';

  Self.LedConfirmarSenha.Text := '';
end;

procedure TFrmCadastroFuncionarios.PreencherTela(AFuncionario: TFuncionario);
begin
  Self.LedNome.Text        := AFuncionario.Nome;
  Self.CmbFuncao.ItemIndex := AFuncionario.Funcao;

  Self.ChbUsuarioAtivo.Checked := AFuncionario.Usuario.Ativo;
  Self.LedUsuario.Text         := AFuncionario.Usuario.Login;
  Self.LedSenha.Text           := AFuncionario.Usuario.Senha;

  Self.BtnEditar.Enabled := (Self.FuncionarioAtual.Codigo > 0) and (not Self.PnlConteudo.Enabled);
  Self.BtnDesativar.Enabled := (Self.FuncionarioAtual.Codigo > 0) and (not Self.PnlConteudo.Enabled);

  if Self.FuncionarioAtual.Ativo then
  begin
    Self.BtnDesativar.Caption := 'Desativar';
  end
  else
  begin
    Self.BtnDesativar.Caption := 'Ativar';
  end;

  Self.LedConfirmarSenha.Text := '';
end;

procedure TFrmCadastroFuncionarios.TratarTela;
begin
  Self.PnlConteudo.Enabled  := not Self.PnlConteudo.Enabled;
  Self.BtnNovo.Enabled      := not Self.PnlConteudo.Enabled;
  Self.BtnEditar.Enabled    := (Self.FuncionarioAtual.Codigo > 0) and (not Self.PnlConteudo.Enabled);
  Self.BtnDesativar.Enabled := (Self.FuncionarioAtual.Codigo > 0) and (not Self.PnlConteudo.Enabled);
  Self.BtnConsultar.Enabled := not Self.PnlConteudo.Enabled;
end;

end.
