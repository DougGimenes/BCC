unit BCC.Contas.View.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, BCC.Model.Contas, BCC.DAO.Contas, Vcl.ComCtrls, Math, BCC.Contas.View.Consulta,
  BCC.Caixa.DAO.Movimentacao;

type
  TFrmContas = class(TFraBase)
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnConsultar: TButton;
    PnlConteudo: TPanel;
    LedNome: TLabeledEdit;
    DtpEmissao: TDateTimePicker;
    DtpVencimento: TDateTimePicker;
    LedValor: TLabeledEdit;
    LblTitulo: TLabel;
    LblVencimento: TLabel;
    LblEmissao: TLabel;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    BtnPagar: TButton;
    procedure FrameResize(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnPagarClick(Sender: TObject);
  private
    { Private declarations }
    ContaAtual : TConta;

    procedure LimparTela();
    procedure PreencherTela(AConta : TConta);

    procedure TratarTela(AEmEdicao : Boolean);
    function  GetConta() : TConta;
  public
    { Public declarations }
  end;

var
  FrmContas: TFrmContas;

implementation

{$R *.dfm}

{ TFrmContas }

procedure TFrmContas.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  if Self.ContaAtual.Codigo > 0 then
  begin
    Self.PreencherTela(Self.ContaAtual);
  end
  else
  begin
    Self.LimparTela();
  end;

  Self.TratarTela(False);
end;

procedure TFrmContas.BtnConsultarClick(Sender: TObject);
var
  Consulta : TFrmConsultaConta;
begin
  inherited;
  Consulta := TFrmConsultaConta.Create(Self);
  try
    Consulta.ShowModal();
    if Consulta.Consultou then
    begin
      Self.ContaAtual := Consulta.ObjetoConsultado;
      Self.PreencherTela(Self.ContaAtual);
      Self.TratarTela(False);
    end;
  finally
    FreeAndNil(Consulta);
  end;
end;

procedure TFrmContas.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Self.TratarTela(True);
end;

procedure TFrmContas.BtnNovoClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.ContaAtual);
  Self.ContaAtual := TConta.Create();
  Self.LimparTela();
  Self.TratarTela(True);
end;

procedure TFrmContas.BtnPagarClick(Sender: TObject);
begin
  inherited;
  Self.ContaAtual.Pagamento := Date();
  TDmContas.Create(Self).Editar(Self.ContaAtual);
  Self.TratarTela(False);

  TDmMovimentacao.Create(Self).AdicionarMovimentacao(Self.ContaAtual.Valor, Self.ContaAtual.Codigo, -1);
end;

procedure TFrmContas.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  if Self.ContaAtual.Codigo > 0 then
  begin
    TDmContas.Create(Self).Editar(Self.GetConta());
    Self.ContaAtual := Self.GetConta();
  end
  else
  begin
    Self.ContaAtual := TDmContas.Create(Self).Inserir(Self.GetConta());
  end;

  Self.PreencherTela(Self.ContaAtual);
  Self.TratarTela(False);
end;

procedure TFrmContas.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlConteudo.Top := Self.PnlBotoes.Height;
  Self.PnlConteudo.Left := Floor((Self.Width - Self.PnlConteudo.Width) / 2);
end;

function TFrmContas.GetConta: TConta;
begin
  Result := TConta.Create();
  if Self.ContaAtual.Codigo > 0 then
  begin
    Result.Codigo := Self.ContaAtual.Codigo;
  end;

  Result.Nome  := Self.LedNome.Text;
  Result.Valor := StrToFloat(Self.LedValor.Text);
  Result.Vencimento := Self.DtpVencimento.Date;
  Result.Emissao    := Self.DtpEmissao.Date;
end;

procedure TFrmContas.LimparTela;
begin
  Self.LedNome.Text := '';
  Self.LedValor.Text := '';
  Self.DtpEmissao.Date := Date();
  Self.DtpVencimento.Date := Date();
end;

procedure TFrmContas.PreencherTela(AConta: TConta);
begin
  Self.LedNome.Text := AConta.Nome;
  Self.LedValor.Text := FormatFloat('###0.00', AConta.Valor);
  Self.DtpEmissao.Date := AConta.Emissao;
  Self.DtpVencimento.Date := AConta.Vencimento;
end;

procedure TFrmContas.TratarTela(AEmEdicao: Boolean);
begin
  Self.BtnNovo.Enabled := not AEmEdicao;
  Self.BtnEditar.Enabled := (not AEmEdicao) and (Self.ContaAtual.Codigo > 0);
  Self.BtnConsultar.Enabled := not AEmEdicao;

  Self.PnlConteudo.Enabled := AEmEdicao;
  Self.BtnPagar.Enabled := (not AEmEdicao) and (Self.ContaAtual.Codigo > 0) and (Self.ContaAtual.Pagamento < Self.ContaAtual.Emissao);
end;

end.
