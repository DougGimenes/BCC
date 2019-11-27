unit BCC.Mesa.View.Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, Math,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls,
  Data.Win.ADODB, BCC.Conexao.DAO.Dados, BCC.Mesa.View.Consulta, BCC.Controller.Mesa,
  BCC.Produtos.View.Consulta, BCC.Servico.View.Consulta, BCC.Model.Mesa,
  BCC.Mesa.View.Identificacao, BCC.Clientes.View.Consulta, BCC.Jogos.View.Consulta,
  BCC.DAO.Cliente, BCC.Mesa.View.Fechamento, BCC.View.ManualBase, Vcl.Menus,
  Vcl.Imaging.pngimage, BCC.Manual.View.AbrirMesa, BCC.Manual.View.InserirProduto,
  BCC.Manual.View.InserirServico, BCC.Manual.View.InserirJogo, BCC.Manual.View.VincularCliente,
  BCC.Manual.View.FecharMesa;

type
  TFrmLancarPedidoMesa = class(TFraBase)
    PnlConteudo: TPanel;
    PnlBotoes: TPanel;
    BtnNovaMesa: TButton;
    DbgMesaItens: TDBGrid;
    LblTotal: TLabel;
    QryMesaItens: TADOQuery;
    QryMesaItensValorUnitario: TFloatField;
    QryMesaItensQtde_Prod: TFloatField;
    QryMesaItensValorTotal: TFloatField;
    DsMesaItens: TDataSource;
    LblQtde: TLabel;
    BtnConsultar: TButton;
    BtnInserirProduto: TButton;
    BtnInserirServico: TButton;
    LedQtdeProd: TLabeledEdit;
    LedQtdeServ: TLabeledEdit;
    BtnCliente: TButton;
    BtnInserirJogo: TButton;
    LblCliente: TLabel;
    BtnFecharMesa: TButton;
    BtnRemoverItem: TButton;
    QryMesaItensID_ItemVenda: TAutoIncField;
    QryMesaItensDescricao: TStringField;
    PumHelp: TPopupMenu;
    BimHelp: TImage;
    MinAbrirMesa: TMenuItem;
    MinInserirProduto: TMenuItem;
    MinInserirServico: TMenuItem;
    MinInserirJogo: TMenuItem;
    MinVincularCliente: TMenuItem;
    MinFecharMesa: TMenuItem;
    procedure BtnNovaMesaClick(Sender: TObject);
    procedure BtnInserirProdutoClick(Sender: TObject);
    procedure BtnInserirServicoClick(Sender: TObject);
    procedure BtnFecharMesaClick(Sender: TObject);
    procedure BtnConsultarClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure BtnClienteClick(Sender: TObject);
    procedure BtnInserirJogoClick(Sender: TObject);
    procedure BtnRemoverItemClick(Sender: TObject);
    procedure BimHelpClick(Sender: TObject);
    procedure MinAbrirMesaClick(Sender: TObject);
    procedure MinInserirProdutoClick(Sender: TObject);
    procedure MinInserirServicoClick(Sender: TObject);
    procedure MinInserirJogoClick(Sender: TObject);
    procedure MinVincularClienteClick(Sender: TObject);
    procedure MinFecharMesaClick(Sender: TObject);
  private
    { Private declarations }
    Mesa : TControllerMesa;
    SubTotal : Double;
    Help : TFrmManualBase;

    procedure SetTotais();
    procedure AbrirVenda();
    procedure LimparTela();
    procedure TratarTela(AEmEdicao : Boolean);

    procedure AbrirHelp(AHelp : TFrmManualBase);
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); overload;
  end;

var
  FrmLancarPedidoMesa: TFrmLancarPedidoMesa;

implementation

{$R *.dfm}

{ TFrmLancarPedidoMesa }

procedure TFrmLancarPedidoMesa.BimHelpClick(Sender: TObject);
begin
  inherited;
  Self.PumHelp.Popup(Self.BimHelp.Left + 20, Self.BimHelp.Top + 90);
end;

procedure TFrmLancarPedidoMesa.BtnClienteClick(Sender: TObject);
var
  FrmConsultaCliente : TFrmConsultaCliente;
begin
  inherited;
  FrmConsultaCliente := TFrmConsultaCliente.Create(Self);
  try
    FrmConsultaCliente.ShowModal();
    if FrmConsultaCliente.Consultou then
    begin
      Self.Mesa.VincularCliente(FrmConsultaCliente.ObjetoConsultado.Codigo);
    end;
  finally
    FreeAndNil(FrmConsultaCliente);
    Self.SetTotais();
  end;
end;

procedure TFrmLancarPedidoMesa.BtnConsultarClick(Sender: TObject);
var
  ConsultaMesas : TFrmConsultaMesa;
begin
  inherited;
  ConsultaMesas := TFrmConsultaMesa.Create(Self, True);
  try
    ConsultaMesas.ShowModal();
    if ConsultaMesas.Consultou then
    begin
      Self.Mesa.SelecionarVenda(ConsultaMesas.ObjetoConsultado.Codigo);
      Self.AbrirVenda();
      Self.TratarTela(True);
    end;
  finally
    FreeAndNil(ConsultaMesas);
  end;
end;

procedure TFrmLancarPedidoMesa.BtnFecharMesaClick(Sender: TObject);
var
  FrmFechamento : TFrmFechaMesa;
begin
  inherited;
  FrmFechamento := TFrmFechaMesa.Create(Self, Self.SubTotal);
  try
    FrmFechamento.ShowModal();
    if FrmFechamento.Finalizou then
    begin
      Self.Mesa.FinalizarVenda(FrmFechamento.TitulosGerados);
      Self.TratarTela(False);
    end;
  finally
    FreeAndNil(FrmFechamento);
  end;
end;

procedure TFrmLancarPedidoMesa.BtnInserirJogoClick(Sender: TObject);
var
  FrmConsultaJogo : TFrmConsultaJogo;
begin
  inherited;
  FrmConsultaJogo := TFrmConsultaJogo.Create(Self);
  try
    FrmConsultaJogo.ShowModal();
    if FrmConsultaJogo.Consultou then
    begin
      Self.Mesa.AddJogo(FrmConsultaJogo.ObjetoConsultado.Codigo);
    end;
  finally
    FreeAndNil(FrmConsultaJogo);
  end;

  Self.AbrirVenda();
  Self.TratarTela(True);
end;

procedure TFrmLancarPedidoMesa.BtnInserirProdutoClick(Sender: TObject);
var
  ConsultaProduto : TFrmConsultaProduto;
begin
  inherited;
  ConsultaProduto := TFrmConsultaProduto.Create(Self, True, True);
  try
    ConsultaProduto.ShowModal();

    if ConsultaProduto.Consultou then
    begin
      Self.Mesa.AddProduto(ConsultaProduto.ObjetoConsultado.Codigo, StrToFloat(Self.LedQtdeProd.Text));
    end;
  finally
    FreeAndNil(ConsultaProduto);
  end;
  Self.AbrirVenda();
  Self.TratarTela(True);
end;

procedure TFrmLancarPedidoMesa.BtnInserirServicoClick(Sender: TObject);
var
  ConsultaServico : TFrmConsultaServico;
begin
  inherited;
  ConsultaServico := TFrmConsultaServico.Create(Self);
  try
    ConsultaServico.ShowModal();

    if ConsultaServico.Consultou then
    begin
      Self.Mesa.AddServico(ConsultaServico.ObjetoConsultado.Codigo, StrToFloat(Self.LedQtdeServ.Text));
    end;
  finally
    FreeAndNil(ConsultaServico);
  end;
  Self.AbrirVenda();
  Self.TratarTela(True);
end;

procedure TFrmLancarPedidoMesa.BtnNovaMesaClick(Sender: TObject);
var
  TelaIdentificacao : TFrmIdentificacaoMesa;
begin
  inherited;
  TelaIdentificacao := TFrmIdentificacaoMesa.Create(Self);
  try
    TelaIdentificacao.ShowModal();

    if TelaIdentificacao.Identificacao <> '' then
    begin
      Self.Mesa.NovaVenda(TelaIdentificacao.Identificacao);
      Self.LimparTela();
      Self.TratarTela(True);
    end;
  finally
    FreeAndNil(TelaIdentificacao);
  end;

end;

procedure TFrmLancarPedidoMesa.BtnRemoverItemClick(Sender: TObject);
begin
  inherited;
  Self.Mesa.RemoverItem(Self.QryMesaItensID_ItemVenda.Value);
  Self.AbrirVenda();
  Self.TratarTela(True);
end;

procedure TFrmLancarPedidoMesa.AbrirHelp(AHelp : TFrmManualBase);
begin
  if Self.Help <> nil then
  begin
    FreeAndNil(Self.Help);
  end;

  Self.Help := AHelp;
  Self.Help.Show();
end;

procedure TFrmLancarPedidoMesa.AbrirVenda();
begin
  Self.QryMesaItens.Close();
  Self.QryMesaItens.SQL.Clear();
  Self.QryMesaItens.SQL.Text := 'SELECT'           + #13 +
                                '  ID_ItemVenda,'  + #13 +
                                '  Descricao,'     + #13 +
                                '  ValorUnitario,' + #13 +
                                '  Qtde_Prod,'     + #13 +
                                '  ValorTotal'     + #13 +
                                'FROM Itens_Venda' + #13 +
                                'WHERE ID_Vendas = ' + Self.Mesa.Mesa.Codigo.ToString();
  Self.QryMesaItens.Open();
  Self.SetTotais();
end;

constructor TFrmLancarPedidoMesa.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  Self.Mesa := TControllerMesa.Create();
end;

procedure TFrmLancarPedidoMesa.FrameResize(Sender: TObject);
begin
  inherited;
  Self.PnlConteudo.Top := Self.PnlBotoes.Height;
  Self.PnlConteudo.Left := Floor((Self.Width - Self.PnlConteudo.Width) / 2);
end;

procedure TFrmLancarPedidoMesa.LimparTela;
begin
  Self.QryMesaItens.Close();
  Self.QryMesaItens.SQL.Clear();
  Self.QryMesaItens.SQL.Text := 'SELECT'           + #13 +
                                '  ID_ItemVenda,'   + #13 +
                                '  Descricao,'     + #13 +
                                '  ValorUnitario,' + #13 +
                                '  Qtde_Prod,'     + #13 +
                                '  ValorTotal'     + #13 +
                                'FROM Itens_Venda' + #13 +
                                'WHERE -1 = 1';
  Self.QryMesaItens.Open();
  Self.SetTotais();
end;

procedure TFrmLancarPedidoMesa.MinAbrirMesaClick(Sender: TObject);
begin
  inherited;
  Self.AbrirHelp(TFrmManualAbrirMesa.Create(Self));
end;

procedure TFrmLancarPedidoMesa.MinFecharMesaClick(Sender: TObject);
begin
  inherited;
  Self.AbrirHelp(TFrmManualFecharMesa.Create(Self));
end;

procedure TFrmLancarPedidoMesa.MinInserirJogoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirHelp(TFrmManualInserirJogo.Create(Self));
end;

procedure TFrmLancarPedidoMesa.MinInserirProdutoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirHelp(TFrmManualInserirProduto.Create(Self));
end;

procedure TFrmLancarPedidoMesa.MinInserirServicoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirHelp(TFrmManualInserirServico.Create(Self));
end;

procedure TFrmLancarPedidoMesa.MinVincularClienteClick(Sender: TObject);
begin
  inherited;
  Self.AbrirHelp(TFrmManualVincularCliente.Create(Self));
end;

procedure TFrmLancarPedidoMesa.SetTotais;
var
  ValorTotal : Double;
  QtdeTotal  : Double;
begin
  ValorTotal := 0;
  QtdeTotal  := 0;

  Self.QryMesaItens.First();
  for var I := 0 to Self.QryMesaItens.RecordCount - 1 do
  begin
    ValorTotal := ValorTotal + Self.QryMesaItensValorTotal.Value;
    QtdeTotal  := QtdeTotal  + Self.QryMesaItensQtde_Prod.Value;

    Self.QryMesaItens.Next();
  end;

  Self.LblTotal.Caption := 'Valor Total: ' + FormatFloat('###0.00', ValorTotal);
  Self.LblQtde.Caption  := 'Quantidade Total: ' + QtdeTotal.ToString();
  Self.LblCliente.Caption := 'Cliente: ' + TDmCliente.Create(Self).SelecionarCliente(Self.Mesa.Mesa.CodCliente).Nome;
  Self.SubTotal := ValorTotal;
end;

procedure TFrmLancarPedidoMesa.TratarTela(AEmEdicao: Boolean);
begin
  Self.PnlConteudo.Enabled := AEmEdicao;
  Self.BtnFecharMesa.Enabled := ((Self.QryMesaItens.RecordCount > 0) and Self.Mesa.Mesa.Aberta) and AEmEdicao;
  Self.LedQtdeProd.Text := '';
  Self.LedQtdeServ.Text := '';
  Self.BtnCliente.Enabled := AEmEdicao;
end;

end.
