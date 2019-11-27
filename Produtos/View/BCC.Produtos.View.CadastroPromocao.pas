unit BCC.Produtos.View.CadastroPromocao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Math, BCC.Produto.Model.Promocao, BCC.Produto.DAO.Promocao,
  BCC.Produtos.View.ConsultaPromocao;

type
  TFrmPromocao = class(TFraBase)
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnConsultar: TButton;
    PnlConteudo: TPanel;
    CmbTipo: TComboBox;
    LedNome: TLabeledEdit;
    LblTitulo: TLabel;
    LblTipo: TLabel;
    DtpDataInicial: TDateTimePicker;
    DtpDataFinal: TDateTimePicker;
    LblDataInicial: TLabel;
    LblDataFinal: TLabel;
    CmbDiaSemana: TComboBox;
    LblSemana: TLabel;
    LedQtde: TLabeledEdit;
    MemDescricao: TMemo;
    LblDescricao: TLabel;
    BtnCancelar: TButton;
    BtnSalvar: TButton;
    procedure FrameResize(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure CmbTipoChange(Sender: TObject);
  private
    { Private declarations }
    RegraAtual : TRegraPromocao;

    procedure LimparTela();
    procedure PreencherTela(ARegra : TRegraPromocao);

    procedure TratarTela(AEmEdicao : Boolean);
    function GetRegra() : TRegraPromocao;
  public
    { Public declarations }
  end;

var
  FrmPromocao: TFrmPromocao;

implementation

{$R *.dfm}

procedure TFrmPromocao.BtnCancelarClick(Sender: TObject);
begin
  inherited;

  if Self.RegraAtual.Codigo > 0 then
  begin
    Self.PreencherTela(Self.RegraAtual);
  end
  else
  begin
    Self.LimparTela();
  end;

  Self.TratarTela(False);
end;

procedure TFrmPromocao.BtnConsultarClick(Sender: TObject);
var
  ConsultaProduto : TFrmConsultaRegraPromocao;
begin
  inherited;
  ConsultaProduto := TFrmConsultaRegraPromocao.Create(Self);
  try
    ConsultaProduto.ShowModal();
  finally
    if ConsultaProduto.Consultou then
    begin
      Self.RegraAtual := ConsultaProduto.ObjetoConsultado;
      Self.PreencherTela(ConsultaProduto.ObjetoConsultado);
      Self.TratarTela(False);
    end;
    FreeAndNil(ConsultaProduto);
  end;
end;

procedure TFrmPromocao.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Self.TratarTela(True);
end;

procedure TFrmPromocao.BtnNovoClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.RegraAtual);
  Self.RegraAtual := TRegraPromocao.Create();
  Self.LimparTela();
  Self.TratarTela(True);
end;

procedure TFrmPromocao.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  if Self.RegraAtual.Codigo > 0 then
  begin
    TDmPromocao.Create(Self).EditarRegra(Self.GetRegra());
    Self.RegraAtual := Self.GetRegra();
  end
  else
  begin
    Self.RegraAtual := TDmPromocao.Create(Self).InserirRegra(Self.GetRegra());
  end;
  Self.PreencherTela(Self.RegraAtual);

  Self.TratarTela(False);
end;

procedure TFrmPromocao.CmbTipoChange(Sender: TObject);
begin
  inherited;
  Self.CmbDiaSemana.Enabled   := Self.CmbTipo.ItemIndex = 0;
  Self.LblSemana.Enabled      := Self.CmbTipo.ItemIndex = 0;
  Self.CmbDiaSemana.ItemIndex := -1;

  Self.LblDataInicial.Enabled := Self.CmbTipo.ItemIndex = 1;
  Self.LblDataFinal.Enabled   := Self.CmbTipo.ItemIndex = 1;
  Self.DtpDataInicial.Enabled := Self.CmbTipo.ItemIndex = 1;
  Self.DtpDataFinal.Enabled   := Self.CmbTipo.ItemIndex = 1;
  Self.DtpDataInicial.Date    := Date();
  Self.DtpDataFinal.Date      := Date();

  Self.LedQtde.Enabled := Self.CmbTipo.ItemIndex = 2;
  Self.LedQtde.Text    := '';
end;

procedure TFrmPromocao.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlConteudo.Top := Self.PnlBotoes.Height;
  Self.PnlConteudo.Left := Floor((Self.Width - Self.PnlConteudo.Width) / 2);
end;

function TFrmPromocao.GetRegra: TRegraPromocao;
begin
  Result := TRegraPromocao.Create();

  if Self.RegraAtual.Codigo > 0 then
  begin
    Result.Codigo := Self.RegraAtual.Codigo;
  end;

  Result.Nome             := Self.LedNome.Text;
  Result.Descricao        := Self.MemDescricao.Text;
  Result.Tipo             := ETipoPromocao(Self.CmbTipo.ItemIndex);
  Result.DataInicial      := Self.DtpDataInicial.Date;
  Result.DataFinal        := Self.DtpDataFinal.Date;
  if Self.LedQtde.Text <> '' then
  begin
    Result.QuantidadeMinima := StrToFloat(Self.LedQtde.Text);
  end
  else
  begin
    Result.QuantidadeMinima := 0;
  end;
  Result.DiaSemana        := EDiaSemana(Self.CmbDiaSemana.ItemIndex + 1);
end;

procedure TFrmPromocao.LimparTela;
begin
  Self.LedNome.Text := '';
  Self.LedQtde.Text := '';
  Self.DtpDataInicial.Date := Date();
  Self.DtpDataFinal.Date   := Date();
  Self.CmbTipo.ItemIndex      := -1;
  Self.CmbDiaSemana.ItemIndex := -1;
  Self.MemDescricao.Text := '';
end;

procedure TFrmPromocao.PreencherTela(ARegra: TRegraPromocao);
begin
  Self.LedNome.Text := ARegra.Nome;
  Self.LedQtde.Text := ARegra.QuantidadeMinima.ToString();
  Self.DtpDataInicial.Date := ARegra.DataInicial;
  Self.DtpDataFinal.Date   := ARegra.DataFinal;
  Self.CmbTipo.ItemIndex      := Integer(ARegra.Tipo);
  Self.CmbDiaSemana.ItemIndex := Integer(ARegra.DiaSemana) - 1;
  Self.MemDescricao.Text := ARegra.Descricao;
end;

procedure TFrmPromocao.TratarTela(AEmEdicao: Boolean);
begin
  Self.BtnNovo.Enabled := not AEmEdicao;
  Self.BtnEditar.Enabled := (not AEmEdicao) and (Self.RegraAtual.Codigo > 0);
  Self.BtnConsultar.Enabled := not AEmEdicao;

  Self.PnlConteudo.Enabled := AEmEdicao;

  Self.CmbDiaSemana.Enabled   := Self.CmbTipo.ItemIndex = 0;
  Self.LblSemana.Enabled      := Self.CmbTipo.ItemIndex = 0;

  Self.LblDataInicial.Enabled := Self.CmbTipo.ItemIndex = 1;
  Self.LblDataFinal.Enabled   := Self.CmbTipo.ItemIndex = 1;
  Self.DtpDataInicial.Enabled := Self.CmbTipo.ItemIndex = 1;
  Self.DtpDataFinal.Enabled   := Self.CmbTipo.ItemIndex = 1;

  Self.LedQtde.Enabled := Self.CmbTipo.ItemIndex = 2;
end;

end.
