unit BCC.Produtos.View.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, Math, BCC.Model.Produto, BCC.DAO.Produto, BCC.Produtos.View.Consulta,
  Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, BCC.Conexao.DAO.Dados,
  BCC.Produtos.View.ConsultaPromocao, BCC.Produto.Model.Promocao, BCC.Produto.DAO.Promocao,
  BCC.Produtos.View.LancaEstoque;

type
  TFrmCadastroProduto = class(TFraBase)
    PnlConteudo: TPanel;
    LblTitulo: TLabel;
    LedNome: TLabeledEdit;
    LedPrecoVenda: TLabeledEdit;
    LedPrecoCusto: TLabeledEdit;
    PnlBotoes: TPanel;
    BtnNovo: TButton;
    BtnEditar: TButton;
    BtnConsultar: TButton;
    ChbCardapio: TCheckBox;
    LedEstoque: TLabeledEdit;
    ChbEstoque: TCheckBox;
    QryPromocoes: TADOQuery;
    DsPromocoes: TDataSource;
    QryPromocoesNome: TStringField;
    DbgPromocoes: TDBGrid;
    BtnInserir: TButton;
    BtnRemover: TButton;
    LedValorPromo: TLabeledEdit;
    QryPromocoesCodigo: TAutoIncField;
    QryPromocoesPrecoPromocional: TFloatField;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    BtnAjustarEstoque: TButton;
    BtnDesativar: TButton;
    procedure FrameResize(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure ChbEstoqueClick(Sender: TObject);
    procedure BtnInserirClick(Sender: TObject);
    procedure BtnRemoverClick(Sender: TObject);
    procedure BtnAjustarEstoqueClick(Sender: TObject);
    procedure BtnDesativarClick(Sender: TObject);
  private
    { Private declarations }
    ProdutoAtual : TProduto;

    procedure LimparTela();
    procedure PreencherTela(AProduto : TProduto);

    procedure TratarTela(AEmEdicao : Boolean);
    function  GetProduto() : TProduto;

    procedure CarregarPromos();
  public
    { Public declarations }
  end;

var
  FrmCadastroProduto: TFrmCadastroProduto;

implementation

{$R *.dfm}

procedure TFrmCadastroProduto.BtnAjustarEstoqueClick(Sender: TObject);
var
  FrmLancaEstoque : TFrmLancaEstoque;
begin
  inherited;
  FrmLancaEstoque := TFrmLancaEstoque.Create(Self, Self.ProdutoAtual.Codigo);
  try
    FrmLancaEstoque.ShowModal();
  finally
    FreeAndNil(FrmLancaEstoque);
  end;
  Self.ProdutoAtual := TDmProduto.Create(Self).Selecionar(Self.ProdutoAtual.Codigo);
  Self.PreencherTela(ProdutoAtual);
end;

procedure TFrmCadastroProduto.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  if Self.ProdutoAtual.Codigo > 0 then
  begin
    Self.PreencherTela(Self.ProdutoAtual);
  end
  else
  begin
    Self.LimparTela();
  end;

  Self.TratarTela(False);
end;

procedure TFrmCadastroProduto.BtnConsultarClick(Sender: TObject);
var
  ConsultaProduto : TFrmConsultaProduto;
begin
  inherited;
  ConsultaProduto := TFrmConsultaProduto.Create(Self, False, False);
  try
    ConsultaProduto.ShowModal();
  finally
    if ConsultaProduto.Consultou then
    begin
      Self.ProdutoAtual := ConsultaProduto.ObjetoConsultado;
      Self.PreencherTela(ConsultaProduto.ObjetoConsultado);
      Self.TratarTela(False);
    end;
    FreeAndNil(ConsultaProduto);
  end;
end;

procedure TFrmCadastroProduto.BtnDesativarClick(Sender: TObject);
begin
  inherited;
  Self.ProdutoAtual.Ativo := not Self.ProdutoAtual.Ativo;
  TDmProduto.Create(Self).Editar(Self.ProdutoAtual);

  Self.TratarTela(False);
end;

procedure TFrmCadastroProduto.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Self.TratarTela(True);
end;

procedure TFrmCadastroProduto.BtnInserirClick(Sender: TObject);
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
      Promocao.CodProduto := Self.ProdutoAtual.Codigo;
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

procedure TFrmCadastroProduto.BtnNovoClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.ProdutoAtual);
  Self.ProdutoAtual := TProduto.Create();
  Self.LimparTela();
  Self.TratarTela(True);
end;

procedure TFrmCadastroProduto.BtnRemoverClick(Sender: TObject);
begin
  inherited;
  TDmPromocao.Create(Self).DeletarPromocao(Self.QryPromocoesCodigo.Value);
  Self.CarregarPromos();
end;

procedure TFrmCadastroProduto.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  if Self.ProdutoAtual.Codigo > 0 then
  begin
    TDmProduto.Create(Self).Editar(Self.GetProduto());
    Self.ProdutoAtual := Self.GetProduto();
  end
  else
  begin
    Self.ProdutoAtual := TDmProduto.Create(Self).Inserir(Self.GetProduto());
  end;
  Self.PreencherTela(Self.ProdutoAtual);

  Self.TratarTela(False);
end;

procedure TFrmCadastroProduto.CarregarPromos;
begin
  Self.QryPromocoes.Close();
  Self.QryPromocoes.SQL.Clear();
  Self.QryPromocoes.SQL.Text  := 'SELECT'               + #13 +
                                 '  p.Codigo,'          + #13 +
                                 '  r.Nome,'            + #13 +
                                 '  p.PrecoPromocional' + #13 +
                                 'FROM Promocao p'      + #13 +
                                 '  INNER JOIN Regras_Promocao r on r.Codigo = p.CodRegra' + #13 +
                                 'WHERE p.CodProduto = ' + Self.ProdutoAtual.Codigo.ToString();
  Self.QryPromocoes.Open();
end;

procedure TFrmCadastroProduto.ChbEstoqueClick(Sender: TObject);
begin
  inherited;
  Self.LedEstoque.Enabled := Self.ChbEstoque.Checked;

  if not (Self.ChbEstoque.Checked) then
  begin
    Self.LedEstoque.Text := '';
  end
  else
  begin
    Self.LedEstoque.Text := '0';
  end;
end;

procedure TFrmCadastroProduto.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlConteudo.Top := Self.PnlBotoes.Height;
  Self.PnlConteudo.Left := Floor((Self.Width - Self.PnlConteudo.Width) / 2);
end;

function TFrmCadastroProduto.GetProduto: TProduto;
begin
  Result := TProduto.Create;

  if Self.ProdutoAtual.Codigo > 0 then
  begin
    Result.Codigo := Self.ProdutoAtual.Codigo;
    Result.Ativo  := Self.ProdutoAtual.Ativo;
  end
  else
  begin
    Result.Ativo := True;
  end;

  Result.Nome := Self.LedNome.Text;

  if Self.LedPrecoVenda.Text <> '' then
  begin
    Result.PrecoVenda := StrToFloat(Self.LedPrecoVenda.Text);
  end
  else
  begin
    Result.PrecoVenda := 0;
  end;

  if Self.LedPrecoCusto.Text <> '' then
  begin
    Result.PrecoCusto := StrToFloat(Self.LedPrecoCusto.Text);
  end
  else
  begin
    Result.PrecoCusto := 0;
  end;

  if Self.LedEstoque.Text <> '' then
  begin
    Result.Estoque := StrToFloat(Self.LedEstoque.Text);
  end
  else
  begin
    Result.Estoque := 0;
  end;

  Result.Cardapio        := Self.ChbCardapio.Checked;
  Result.ControlaEstoque := Self.ChbEstoque.Checked;
end;

procedure TFrmCadastroProduto.LimparTela;
begin
  Self.LedNome.Text        := '';
  Self.LedPrecoVenda.Text  := '';
  Self.LedPrecoCusto.Text  := '';
  Self.ChbCardapio.Checked := False;
  Self.ChbEstoque.Checked  := False;
  Self.QryPromocoes.Close();
end;

procedure TFrmCadastroProduto.PreencherTela(AProduto: TProduto);
begin
  Self.LedNome.Text := AProduto.Nome;
  Self.LedPrecoVenda.Text  := FormatFloat('###0.00', AProduto.PrecoVenda);
  Self.LedPrecoCusto.Text  := FormatFloat('###0.00', AProduto.PrecoCusto);
  Self.ChbCardapio.Checked := AProduto.Cardapio;
  Self.LedEstoque.Text     := AProduto.Estoque.ToString();
  Self.ChbEstoque.Checked  := AProduto.ControlaEstoque;
  Self.CarregarPromos();
end;

procedure TFrmCadastroProduto.TratarTela(AEmEdicao: Boolean);
begin
  Self.BtnNovo.Enabled := not AEmEdicao;
  Self.BtnEditar.Enabled := (not AEmEdicao) and (Self.ProdutoAtual.Codigo > 0);
  Self.BtnConsultar.Enabled := not AEmEdicao;
  Self.BtnAjustarEstoque.Enabled := (Self.ProdutoAtual.Codigo > 0) and (Self.ChbEstoque.Checked);

  Self.PnlConteudo.Enabled := AEmEdicao;

  if Self.ChbEstoque.Checked then
  begin
    Self.LedEstoque.Enabled := True
  end
  else
  begin
    Self.LedEstoque.Enabled := False;
    Self.LedEstoque.Text := '0';
  end;

  Self.DbgPromocoes.Enabled := Self.ProdutoAtual.Codigo > 0;
  Self.BtnInserir.Enabled := Self.ProdutoAtual.Codigo > 0;
  Self.BtnRemover.Enabled := Self.ProdutoAtual.Codigo > 0;

  Self.BtnDesativar.Enabled := (not AEmEdicao) and (Self.ProdutoAtual.Codigo > 0);

  if Self.ProdutoAtual.Ativo then
  begin
    Self.BtnDesativar.Caption := 'Desativar';
  end
  else
  begin
    Self.BtnDesativar.Caption := 'Ativar';
  end;
end;

end.
