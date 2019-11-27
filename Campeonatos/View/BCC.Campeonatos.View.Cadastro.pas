unit BCC.Campeonatos.View.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, Math, BCC.DAO.Campeonatos, BCC.Model.Campeonato, BCC.Campeonatos.View.Consulta,
  BCC.DAO.Jogo, BCC.Model.Jogo, System.Generics.Collections, BCC.Manual.View.CadastrarCampeonato,
  Vcl.Imaging.pngimage;

type
  TFrmCadastroCampeonato = class(TFraBase)
    PnlConteudo: TPanel;
    LedNumParticipantes: TLabeledEdit;
    BtnCancelar: TButton;
    BtnSalvar: TButton;
    LedIdentificacao: TLabeledEdit;
    LblJogo: TLabel;
    LblFormato: TLabel;
    CmbJogo: TComboBox;
    CmbFormato: TComboBox;
    LblTitulo: TLabel;
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnConsultar: TButton;
    CmbEstado: TComboBox;
    LblEstado: TLabel;
    BimHelp: TImage;
    procedure FrameResize(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BimHelpClick(Sender: TObject);
  private
    { Private declarations }
    CampeonatoAtual : TCampeonato;
    Help : TFrmManualCadastrarCampeonato;

    procedure LimparTela();
    procedure PreencherTela(ACampeonato : TCampeonato);

    function GetCampeonato() : TCampeonato;
    procedure TratarTela(AEmEdicao : Boolean);

    procedure PreencherJogos();
  public
    { Public declarations }
  end;

var
  FrmCadastroCampeonato: TFrmCadastroCampeonato;

implementation

{$R *.dfm}

procedure TFrmCadastroCampeonato.BimHelpClick(Sender: TObject);
begin
  inherited;
  if Self.Help <> nil then
  begin
    FreeAndNil(Self.Help);
  end;

  Self.Help := TFrmManualCadastrarCampeonato.Create(Self);
  Self.Help.Show();
end;

procedure TFrmCadastroCampeonato.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  if Self.CampeonatoAtual.Codigo > 0 then
  begin
    Self.PreencherTela(Self.CampeonatoAtual);
  end
  else
  begin
    Self.LimparTela();
  end;

  Self.TratarTela(False);
end;

procedure TFrmCadastroCampeonato.BtnConsultarClick(Sender: TObject);
var
  ConsultaCampeonato : TFrmConsultaCampeonato;
begin
  inherited;
  Self.CampeonatoAtual := TCampeonato.Create();
  ConsultaCampeonato := TFrmConsultaCampeonato.Create(Self, CmpTodos);
  try
    ConsultaCampeonato.ShowModal();
  finally
    if ConsultaCampeonato.Consultou then
    begin
      Self.CampeonatoAtual := ConsultaCampeonato.ObjetoConsultado;
      Self.PreencherTela(ConsultaCampeonato.ObjetoConsultado);
    end;
    FreeAndNil(ConsultaCampeonato);
  end;
  Self.TratarTela(False);
end;

procedure TFrmCadastroCampeonato.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Self.TratarTela(True);
end;

procedure TFrmCadastroCampeonato.BtnNovoClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.CampeonatoAtual);
  Self.CampeonatoAtual := TCampeonato.Create();
  Self.LimparTela();
  Self.TratarTela(True);
end;

procedure TFrmCadastroCampeonato.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  if Self.CampeonatoAtual.Codigo > 0 then
  begin
    TDmCampeonato.Create(Self).Editar(Self.GetCampeonato());
    Self.CampeonatoAtual := Self.GetCampeonato();
  end
  else
  begin
    Self.CampeonatoAtual := TDmCampeonato.Create(Self).Inserir(Self.GetCampeonato());
  end;
  Self.PreencherTela(Self.CampeonatoAtual);

  Self.TratarTela(False);
end;

procedure TFrmCadastroCampeonato.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlConteudo.Top := Self.PnlBotoes.Height;
  Self.PnlConteudo.Left := Floor((Self.Width - Self.PnlConteudo.Width) / 2);
end;

function TFrmCadastroCampeonato.GetCampeonato: TCampeonato;
begin
  Result := TCampeonato.Create();
  Result.Identificacao    := Self.LedIdentificacao.Text;
  Result.NumParticipantes := StrToInt(Self.LedNumParticipantes.Text);
  Result.CodJogo          := Integer(Self.CmbJogo.Items.Objects[Self.CmbJogo.ItemIndex]);
  Result.Formato          := EFormato(Self.CmbFormato.ItemIndex);
  Result.Estado           := EEstado(Self.CmbEstado.ItemIndex);

  if Self.CampeonatoAtual.Codigo > 0 then
  begin
    Result.Codigo := Self.CampeonatoAtual.Codigo;
  end;
end;

procedure TFrmCadastroCampeonato.LimparTela;
begin
  Self.LedNumParticipantes.Text := '';
  Self.LedIdentificacao.Text    := '';
  Self.CmbJogo.ItemIndex        := -1;
  Self.CmbFormato.ItemIndex     := -1;
  Self.CmbEstado.ItemIndex      := -1;
  Self.PreencherJogos();
end;

procedure TFrmCadastroCampeonato.PreencherJogos;
var
  Jogos : TObjectList<TJogo>;
  Jogo  : TJogo;
begin
  Self.CmbJogo.Items.Clear();
  Jogos := TDmJogo.Create(Self).SelecionarTodos();

  for Jogo in Jogos do
  begin
    Self.CmbJogo.Items.AddObject(Jogo.Nome, TObject(Jogo.Codigo));
  end;
end;

procedure TFrmCadastroCampeonato.PreencherTela(ACampeonato: TCampeonato);
begin
  Self.PreencherJogos();
  Self.LedNumParticipantes.Text := ACampeonato.NumParticipantes.ToString();
  Self.LedIdentificacao.Text    := ACampeonato.Identificacao;
  Self.CmbJogo.ItemIndex        := Self.CmbJogo.Items.IndexOf(TDmJogo.Create(Self).Selecionar(ACampeonato.CodJogo).Nome);
  Self.CmbFormato.ItemIndex     := Integer(ACampeonato.Formato);
  Self.CmbEstado.ItemIndex      := Integer(ACampeonato.Estado);
end;

procedure TFrmCadastroCampeonato.TratarTela(AEmEdicao : Boolean);
begin
  Self.BtnNovo.Enabled := not AEmEdicao;
  Self.BtnEditar.Enabled := (not AEmEdicao) and (Self.CampeonatoAtual.Codigo > 0);
  Self.BtnConsultar.Enabled := not AEmEdicao;

  Self.PnlConteudo.Enabled := AEmEdicao;
end;

end.
