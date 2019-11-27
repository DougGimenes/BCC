unit BCC.Jogos.View.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Math, BCC.Model.Jogo, BCC.DAO.Jogo, BCC.Jogos.View.Consulta;

type
  TFrmCadastroJogo = class(TFraBase)
    PnlConteudo: TPanel;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    LedNome: TLabeledEdit;
    LedPessoas: TLabeledEdit;
    LedCopias: TLabeledEdit;
    LblTitulo: TLabel;
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnConsultar: TButton;
    BtnDesativar: TButton;
    procedure FrameResize(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnDesativarClick(Sender: TObject);
  private
    { Private declarations }
    JogoAtual : TJogo;

    procedure LimparTela();
    procedure PreencherTela(AJogo : TJogo);

    procedure TratarTela(AEmEdicao : Boolean);
    function GetJogo() : TJogo;
  public
    { Public declarations }
  end;

var
  FrmCadastroJogo: TFrmCadastroJogo;

implementation

{$R *.dfm}

procedure TFrmCadastroJogo.BtnCancelarClick(Sender: TObject);
begin
  inherited;

  if Self.JogoAtual.Codigo > 0 then
  begin
    Self.PreencherTela(Self.JogoAtual);
  end
  else
  begin
    Self.LimparTela();
  end;

  Self.TratarTela(False);
end;

procedure TFrmCadastroJogo.BtnConsultarClick(Sender: TObject);
var
  ConsultaJogo : TFrmConsultaJogo;
begin
  inherited;
  Self.JogoAtual := TJogo.Create();
  ConsultaJogo := TFrmConsultaJogo.Create(Self, False);
  try
    ConsultaJogo.ShowModal();
  finally
    if ConsultaJogo.Consultou then
    begin
      Self.JogoAtual := ConsultaJogo.ObjetoConsultado;
      Self.PreencherTela(ConsultaJogo.ObjetoConsultado);
    end;
    FreeAndNil(ConsultaJogo);
  end;
  Self.TratarTela(False);
end;

procedure TFrmCadastroJogo.BtnDesativarClick(Sender: TObject);
begin
  inherited;
  Self.JogoAtual.Ativo := not Self.JogoAtual.Ativo;
  TDmJogo.Create(Self).Editar(Self.JogoAtual);

  Self.TratarTela(False);
end;

procedure TFrmCadastroJogo.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Self.TratarTela(True);
end;

procedure TFrmCadastroJogo.BtnNovoClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.JogoAtual);
  Self.JogoAtual := TJogo.Create();
  Self.LimparTela();
  Self.TratarTela(True);
end;

procedure TFrmCadastroJogo.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  if Self.JogoAtual.Codigo > 0 then
  begin
    TDmJogo.Create(Self).Editar(Self.GetJogo());
    Self.JogoAtual := Self.GetJogo();
  end
  else
  begin
    Self.JogoAtual := TDmJogo.Create(Self).Inserir(Self.GetJogo());
  end;
  Self.PreencherTela(Self.JogoAtual);

  Self.TratarTela(False);
end;

procedure TFrmCadastroJogo.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlConteudo.Top := Self.PnlBotoes.Height;
  Self.PnlConteudo.Left := Floor((Self.Width - Self.PnlConteudo.Width) / 2);
end;

function TFrmCadastroJogo.GetJogo: TJogo;
begin
  Result := TJogo.Create();
  Result.Nome := Self.LedNome.Text;
  Result.MaxJogadores := StrToInt(Self.LedPessoas.Text);
  Result.NumeroCopias := StrToInt(Self.LedCopias.Text);

  if Self.JogoAtual.Codigo > 0 then
  begin
    Result.Codigo := Self.JogoAtual.Codigo;
    Result.Ativo  := Self.JogoAtual.Ativo;
  end
  else
  begin
    Result.Ativo  := True;
  end;
end;

procedure TFrmCadastroJogo.LimparTela;
begin
  Self.LedNome.Text    := '';
  Self.LedPessoas.Text := '';
  Self.LedCopias.Text  := '';
end;

procedure TFrmCadastroJogo.PreencherTela(AJogo: TJogo);
begin
  Self.LedNome.Text    := AJogo.Nome;
  Self.LedPessoas.Text := AJogo.MaxJogadores.ToString();
  Self.LedCopias.Text  := AJogo.NumeroCopias.ToString();
end;

procedure TFrmCadastroJogo.TratarTela(AEmEdicao: Boolean);
begin
  Self.BtnNovo.Enabled := not AEmEdicao;
  Self.BtnEditar.Enabled := (not AEmEdicao) and (Self.JogoAtual.Codigo > 0);
  Self.BtnConsultar.Enabled := not AEmEdicao;

  Self.PnlConteudo.Enabled := AEmEdicao;

  Self.BtnDesativar.Enabled := (not AEmEdicao) and (Self.JogoAtual.Codigo > 0);

  if Self.JogoAtual.Ativo then
  begin
    Self.BtnDesativar.Caption := 'Desativar';
  end
  else
  begin
    Self.BtnDesativar.Caption := 'Ativar';
  end;
end;

end.
