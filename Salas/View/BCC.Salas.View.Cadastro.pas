unit BCC.Salas.View.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Math, BCC.Model.Sala, BCC.DAO.Sala, BCC.Salas.View.Consulta;

type
  TFrmCadastroSala = class(TFraBase)
    PnlConteudo: TPanel;
    LblTitulo: TLabel;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    LedNome: TLabeledEdit;
    LedPessoas: TLabeledEdit;
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnConsultar: TButton;
    MemDescricao: TMemo;
    LblDescricao: TLabel;
    LedPreco: TLabeledEdit;
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
    SalaAtual : TSala;

    procedure LimparTela();
    procedure PreencherTela(ASala : TSala);

    procedure TratarTela(AEmEdicao : Boolean);
    function GetSala() : TSala;
  public
    { Public declarations }
  end;

var
  FrmCadastroSala: TFrmCadastroSala;

implementation

{$R *.dfm}

procedure TFrmCadastroSala.BtnCancelarClick(Sender: TObject);
begin
  inherited;

  if Self.SalaAtual.Codigo > 0 then
  begin
    Self.PreencherTela(Self.SalaAtual);
  end
  else
  begin
    Self.LimparTela();
  end;

  Self.TratarTela(False);
end;

procedure TFrmCadastroSala.BtnConsultarClick(Sender: TObject);
var
  ConsultaSalas : TFrmConsultaSala;
begin
  inherited;
  ConsultaSalas := TFrmConsultaSala.Create(Self, False);
  try
    ConsultaSalas.ShowModal();
  finally
    if ConsultaSalas.Consultou then
    begin
      Self.SalaAtual := ConsultaSalas.ObjetoConsultado;
      Self.PreencherTela(ConsultaSalas.ObjetoConsultado);
    end;
    FreeAndNil(ConsultaSalas);
  end;
  Self.TratarTela(False);
end;

procedure TFrmCadastroSala.BtnDesativarClick(Sender: TObject);
begin
  inherited;
  Self.SalaAtual.Ativo := not Self.SalaAtual.Ativo;
  TDmSala.Create(Self).Editar(Self.SalaAtual);

  Self.TratarTela(False);
end;

procedure TFrmCadastroSala.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Self.TratarTela(True);
end;

procedure TFrmCadastroSala.BtnNovoClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.SalaAtual);
  Self.SalaAtual := TSala.Create();
  Self.LimparTela();
  Self.TratarTela(True);
end;

procedure TFrmCadastroSala.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  if Self.SalaAtual.Codigo > 0 then
  begin
    TDmSala.Create(Self).Editar(Self.GetSala());
    Self.SalaAtual := Self.GetSala();
  end
  else
  begin
    Self.SalaAtual := TDmSala.Create(Self).Inserir(Self.GetSala());
  end;
  Self.PreencherTela(Self.SalaAtual);

  Self.TratarTela(False);
end;

procedure TFrmCadastroSala.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlConteudo.Top := Self.PnlBotoes.Height;
  Self.PnlConteudo.Left := Floor((Self.Width - Self.PnlConteudo.Width) / 2);
end;

function TFrmCadastroSala.GetSala: TSala;
begin
  Result := TSala.Create();
  Result.Descricao := Self.LedNome.Text;
  Result.MaxPessoas := StrToInt(Self.LedPessoas.Text);
  Result.ValorHora := StrToFloat(Self.LedPreco.Text);
  Result.Informacao := Self.MemDescricao.Text;

  if Self.SalaAtual.Codigo > 0 then
  begin
    Result.Codigo := Self.SalaAtual.Codigo;
    Result.Ativo  := Self.SalaAtual.Ativo;
  end
  else
  begin
    Result.Ativo  := True;
  end;
end;

procedure TFrmCadastroSala.LimparTela;
begin
  Self.LedNome.Text    := '';
  Self.LedPessoas.Text := '';
  Self.LedPreco.Text   := '';
  Self.MemDescricao.Clear();
end;

procedure TFrmCadastroSala.PreencherTela(ASala: TSala);
begin
  Self.LedNome.Text      := ASala.Descricao;
  Self.LedPessoas.Text   := ASala.MaxPessoas.ToString();
  Self.LedPreco.Text     := FormatFloat('###0.00', ASala.ValorHora);
  Self.MemDescricao.Text := ASala.Informacao;
end;

procedure TFrmCadastroSala.TratarTela(AEmEdicao : Boolean);
begin
  Self.BtnNovo.Enabled := not AEmEdicao;
  Self.BtnEditar.Enabled := (not AEmEdicao) and (Self.SalaAtual.Codigo > 0);
  Self.BtnConsultar.Enabled := not AEmEdicao;

  Self.PnlConteudo.Enabled := AEmEdicao;

  Self.BtnDesativar.Enabled := (not AEmEdicao) and (Self.SalaAtual.Codigo > 0);

  if Self.SalaAtual.Ativo then
  begin
    Self.BtnDesativar.Caption := 'Desativar';
  end
  else
  begin
    Self.BtnDesativar.Caption := 'Ativar';
  end;
end;

end.
