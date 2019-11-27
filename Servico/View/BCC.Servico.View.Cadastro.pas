unit BCC.Servico.View.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  BCC.Model.Servico, BCC.DAO.Servico, Vcl.StdCtrls, Math, BCC.Servico.View.Consulta,
  Data.DB, Vcl.Grids, Vcl.DBGrids, BCC.Produto.Model.Promocao, BCC.Produto.DAO.Promocao,
  BCC.Produtos.View.ConsultaPromocao, Data.Win.ADODB;

type
  TFrmCadastroServico = class(TFraBase)
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnConsultar: TButton;
    PnlConteudo: TPanel;
    LblTitulo: TLabel;
    LedNome: TLabeledEdit;
    LedPreco: TLabeledEdit;
    BtnCancelar: TButton;
    BtnSalvar: TButton;
    MemDescricao: TMemo;
    LblDescricao: TLabel;
    DbgPromocoes: TDBGrid;
    LedValorPromo: TLabeledEdit;
    BtnInserir: TButton;
    BtnRemover: TButton;
    DsPromocoes: TDataSource;
    QryPromocoes: TADOQuery;
    QryPromocoesNome: TStringField;
    QryPromocoesCodigo: TAutoIncField;
    QryPromocoesPrecoPromocional: TFloatField;
    BtnDesativar: TButton;
    procedure FrameResize(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnRemoverClick(Sender: TObject);
    procedure BtnDesativarClick(Sender: TObject);
  private
    { Private declarations }
    ServicoAtual : TServico;

    procedure LimparTela();
    procedure PreencherTela(AServico : TServico);

    procedure TratarTela(AEmEdicao : Boolean);
    function  GetServico() : TServico;

    procedure CarregarPromos();
  public
    { Public declarations }
  end;

var
  FrmCadastroServico: TFrmCadastroServico;

implementation

{$R *.dfm}

{ TFrmCadastoServico }

procedure TFrmCadastroServico.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  if Self.ServicoAtual.Codigo > 0 then
  begin
    Self.PreencherTela(Self.ServicoAtual);
  end
  else
  begin
    Self.LimparTela();
  end;

  Self.TratarTela(False);
end;

procedure TFrmCadastroServico.BtnConsultarClick(Sender: TObject);
var
  ConsultaServico : TFrmConsultaServico;
begin
  inherited;
  ConsultaServico := TFrmConsultaServico.Create(Self, False);
  try
    ConsultaServico.ShowModal();
  finally
    if ConsultaServico.Consultou then
    begin
      Self.ServicoAtual := ConsultaServico.ObjetoConsultado;
      Self.PreencherTela(ConsultaServico.ObjetoConsultado);
      Self.TratarTela(False);
    end;
    FreeAndNil(ConsultaServico);
  end;
end;

procedure TFrmCadastroServico.BtnDesativarClick(Sender: TObject);
begin
  inherited;
  Self.ServicoAtual.Ativo := not Self.ServicoAtual.Ativo;
  TDmServico.Create(Self).Editar(Self.ServicoAtual);

  Self.TratarTela(False);
end;

procedure TFrmCadastroServico.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Self.TratarTela(True);
end;

procedure TFrmCadastroServico.BtnInserirClick(Sender: TObject);
var
  ConsultaPromo : TFrmConsultaRegraPromocao;
  DmPromocao    : TDmPromocao;
  Promocao      : TPromocao;
begin
  inherited;
  ConsultaPromo := TFrmConsultaRegraPromocao.Create(Self);
  try
    ConsultaPromo.ShowModal();
    if ConsultaPromo.Consultou then
    begin
      DmPromocao := TDmPromocao.Create(Self);
      Promocao := TPromocao.Create();
      Promocao.CodServico := Self.ServicoAtual.Codigo;
      Promocao.Regra := DmPromocao.SelecionarRegra(ConsultaPromo.ObjetoConsultado.Codigo);
      Promocao.PrecoPromocional := StrToFloat(Self.LedValorPromo.Text);
      DmPromocao.InserirPromocao(Promocao);

      FreeAndNil(Promocao);
      FreeAndNil(DmPromocao);
      Self.CarregarPromos();
    end;
  finally
    FreeAndNil(ConsultaPromo);
  end;
end;

procedure TFrmCadastroServico.BtnNovoClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.ServicoAtual);
  Self.ServicoAtual := TServico.Create();
  Self.LimparTela();
  Self.TratarTela(True);
end;

procedure TFrmCadastroServico.BtnRemoverClick(Sender: TObject);
begin
  inherited;
  TDmPromocao.Create(Self).DeletarPromocao(Self.QryPromocoesCodigo.Value);
  Self.CarregarPromos();
end;

procedure TFrmCadastroServico.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  if Self.ServicoAtual.Codigo > 0 then
  begin
    TDmServico.Create(Self).Editar(Self.GetServico());
    Self.ServicoAtual := Self.GetServico();
  end
  else
  begin
    Self.ServicoAtual := TDmServico.Create(Self).Inserir(Self.GetServico());
  end;
  Self.PreencherTela(Self.ServicoAtual);

  Self.TratarTela(False);
end;

procedure TFrmCadastroServico.CarregarPromos;
begin
  Self.QryPromocoes.Close();
  Self.QryPromocoes.SQL.Clear();
  Self.QryPromocoes.SQL.Text  := 'SELECT'               + #13 +
                                 '  p.Codigo,'          + #13 +
                                 '  r.Nome,'            + #13 +
                                 '  p.PrecoPromocional' + #13 +
                                 'FROM Promocao p'      + #13 +
                                 '  INNER JOIN Regras_Promocao r on r.Codigo = p.CodRegra' + #13 +
                                 'WHERE p.CodServico = ' + Self.ServicoAtual.Codigo.ToString();
  Self.QryPromocoes.Open();
end;

procedure TFrmCadastroServico.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlConteudo.Top := Self.PnlBotoes.Height;
  Self.PnlConteudo.Left := Floor((Self.Width - Self.PnlConteudo.Width) / 2);
end;

function TFrmCadastroServico.GetServico: TServico;
begin
  Result := TServico.Create();
  if Self.ServicoAtual.Codigo > 0 then
  begin
    Result.Codigo := Self.ServicoAtual.Codigo;
    Result.Ativo  := Self.ServicoAtual.Ativo;
  end
  else
  begin
    Result.Codigo := 0;
    Result.Ativo := True;
  end;

  Result.Nome  := Self.LedNome.Text;
  Result.Valor := StrToFloat(Self.LedPreco.Text);
  Result.Descricao := Self.MemDescricao.Text;
end;

procedure TFrmCadastroServico.LimparTela;
begin
  Self.LedNome.Text  := '';
  Self.LedPreco.Text := '';
  Self.MemDescricao.Text := '';
  Self.LedValorPromo.Text := '';
  Self.QryPromocoes.Close();
end;

procedure TFrmCadastroServico.PreencherTela(AServico: TServico);
begin
  Self.LedNome.Text  := AServico.Nome;
  Self.LedPreco.Text := FormatFloat('###0.00', AServico.Valor);
  Self.MemDescricao.Text := AServico.Descricao;

  Self.CarregarPromos();
end;

procedure TFrmCadastroServico.TratarTela(AEmEdicao: Boolean);
begin
  Self.BtnNovo.Enabled := not AEmEdicao;
  Self.BtnEditar.Enabled := (not AEmEdicao) and (Self.ServicoAtual.Codigo > 0);
  Self.BtnConsultar.Enabled := not AEmEdicao;

  Self.PnlConteudo.Enabled := AEmEdicao;

  Self.DbgPromocoes.Enabled := Self.ServicoAtual.Codigo > 0;
  Self.BtnInserir.Enabled := Self.ServicoAtual.Codigo > 0;
  Self.BtnRemover.Enabled := Self.ServicoAtual.Codigo > 0;

  Self.BtnDesativar.Enabled := (not AEmEdicao) and (Self.ServicoAtual.Codigo > 0);

  if Self.ServicoAtual.Ativo then
  begin
    Self.BtnDesativar.Caption := 'Desativar';
  end
  else
  begin
    Self.BtnDesativar.Caption := 'Ativar';
  end;
end;

end.
