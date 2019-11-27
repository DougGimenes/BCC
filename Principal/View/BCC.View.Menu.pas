unit BCC.View.Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FormBase, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, BCC.Clientes.View.Cadastro, BCC.View.FrameBase, BCC.Caixa.View.Menu,
  BCC.Funcionarios.View.Cadastro, BCC.Salas.View.Cadastro, BCC.Jogos.View.Cadastro,
  BCC.Mesa.View.Pedido, BCC.Produtos.View.Cadastro, BCC.Campeonatos.View.Cadastro,
  BCC.Salas.View.Reserva, BCC.Campeonatos.View.Classificacao, BCC.Model.Funcionario,
  BCC.Campeonatos.View.Inscricao, BCC.Conexao.DAO.Dados, BCC.DAO.Funcionario,
  Vcl.StdCtrls, Vcl.Menus, BCC.Campeonatos.View.Controle, BCC.Servico.View.Cadastro,
  BCC.Produtos.View.CadastroPromocao, BCC.DAO.Caixa, BCC.Caixa.View.Abertura,
  BCC.Relatorio.View.JogosPedidos, BCC.Relatorio.View.ProdutosVendidos,
  BCC.Contas.View.Cadastro, BCC.Relatorio.View.RelTicketMedio, BCC.Relatorio.View.FluxoCaixa;

type
  TFrmMenu = class(TFrmBase)
    PnlLista: TPanel;
    BimMesa: TImage;
    BimCliente: TImage;
    BimFuncionario: TImage;
    BimProduto: TImage;
    BimReserva: TImage;
    BimSala: TImage;
    BimCampeonato: TImage;
    BimJogo: TImage;
    BimRelatorio: TImage;
    PnlDivisoria1: TPanel;
    PnlFrame: TPanel;
    LblMesa: TLabel;
    LblClientes: TLabel;
    LblProdutos: TLabel;
    LblFuncionarios: TLabel;
    LblReservas: TLabel;
    LblSalas: TLabel;
    LblCampeonatos: TLabel;
    LblJogos: TLabel;
    LblRelatorios: TLabel;
    PumCampeonatos: TPopupMenu;
    MniCadastroCampeonato: TMenuItem;
    MniJogadores: TMenuItem;
    BimServico: TImage;
    LblServico: TLabel;
    BimPromocao: TImage;
    LblPromocao: TLabel;
    BimCaixa: TImage;
    LblCaixa: TLabel;
    PumRelatorios: TPopupMenu;
    RelJogoPeriodo: TMenuItem;
    RelProdutosVendidos: TMenuItem;
    BimContas: TImage;
    LblContas: TLabel;
    RelTicketMedio: TMenuItem;
    RelFluxoCaixa: TMenuItem;
    procedure BimClienteClick(Sender: TObject);
    procedure BimFuncionarioClick(Sender: TObject);
    procedure BimMesaClick(Sender: TObject);
    procedure BimProdutoClick(Sender: TObject);
    procedure BimJogoClick(Sender: TObject);
    procedure BimCampeonatoClick(Sender: TObject);
    procedure BimSalaClick(Sender: TObject);
    procedure BimReservaClick(Sender: TObject);
    procedure BimRelatorioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MniCadastroCampeonatoClick(Sender: TObject);
    procedure MniJogadoresClick(Sender: TObject);
    procedure BimServicoClick(Sender: TObject);
    procedure BimPromocaoClick(Sender: TObject);
    procedure BimCaixaClick(Sender: TObject);
    procedure RelJogoPeriodoClick(Sender: TObject);
    procedure RelProdutosVendidosClick(Sender: TObject);
    procedure BimContasClick(Sender: TObject);
    procedure RelTicketMedioClick(Sender: TObject);
    procedure RelFluxoCaixaClick(Sender: TObject);
  private
    { Private declarations }
    Frame : TFraBase;

    procedure AbrirFrame(AFrame : TFraBase);
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

{ TFrmMenu }

procedure TFrmMenu.AbrirFrame(AFrame: TFraBase);
begin
  if Self.Frame <> nil then
  begin
    FreeAndNil(Self.Frame);
  end;

  Self.Frame := AFrame;
  Self.Frame.Parent := Self.PnlFrame;
  Self.Frame.Name := 'Frame';
end;

procedure TFrmMenu.BimCaixaClick(Sender: TObject);
var
  FrmMenuCaixa : TFrmMenuCaixa;
begin
  inherited;
  FrmMenuCaixa := TFrmMenuCaixa.Create(Self);
  try
    FrmMenuCaixa.ShowModal();
  finally
    FreeAndNil(FrmMenuCaixa);
  end;
end;

procedure TFrmMenu.BimCampeonatoClick(Sender: TObject);
begin
  inherited;
  if DmDados.Usuario.CodCli > 0 then
  begin
    Self.AbrirFrame(TFrmInscricaoCampeonato.Create(Self));
  end
  else
  begin
    Self.PumCampeonatos.Popup(Self.LblCampeonatos.Left + 20, Self.LblCampeonatos.Top);
  end;
end;

procedure TFrmMenu.BimClienteClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmCadastroCliente.Create(Self));
end;

procedure TFrmMenu.BimContasClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmContas.Create(Self));
end;

procedure TFrmMenu.BimFuncionarioClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmCadastroFuncionarios.Create(Self));
end;

procedure TFrmMenu.BimJogoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmCadastroJogo.Create(Self));
end;

procedure TFrmMenu.BimMesaClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmLancarPedidoMesa.Create(Self));
end;

procedure TFrmMenu.BimProdutoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmCadastroProduto.Create(Self));
end;

procedure TFrmMenu.BimPromocaoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmPromocao.Create(Self));
end;

procedure TFrmMenu.BimRelatorioClick(Sender: TObject);
begin
  inherited;
  Self.PumRelatorios.Popup(Self.LblRelatorios.Left + 20, Self.LblRelatorios.Top);
end;

procedure TFrmMenu.BimReservaClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmReservaSala.Create(Self));
end;

procedure TFrmMenu.BimSalaClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmCadastroSala.Create(Self));
end;

procedure TFrmMenu.FormCreate(Sender: TObject);
var
  DmCaixa   : TDmCaixa;
  CodCaixa  : Integer;
  AbreCaixa : TFrmAbreCaixa;
begin
  inherited;
  if DmDados.Usuario.CodCli > 0 then
  begin
    Self.BimCampeonatoClick(Sender);
    Self.PnlLista.Visible := False;
  end
  else if DmDados.Usuario.CodFunc > 0 then
  begin
    DmCaixa := TDmCaixa.Create(Self);
    CodCaixa := DmCaixa.GetCaixaAberto();
    if CodCaixa > -1 then
    begin
      DmDados.CodCaixa := CodCaixa;
    end
    else
    begin
      DmDados.CodCaixa := -1;

      AbreCaixa := TFrmAbreCaixa.Create(Self);
      try
        AbreCaixa.ShowModal();
      finally
        FreeAndNil(AbreCaixa);
      end;

      if DmDados.CodCaixa < 0 then
      begin
        Self.Free();
        Exit();
      end;
    end;

    if TDmFuncionario.Create(Self).Selecionar(DmDados.Usuario.CodFunc).Funcao < 2 then
    begin
      Self.BimFuncionario.Enabled := False;
      Self.BimProduto.Enabled := False;
      Self.BimRelatorio.Enabled := False;
    end;
  end;
end;

procedure TFrmMenu.BimServicoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmCadastroServico.Create(Self));
end;

procedure TFrmMenu.MniCadastroCampeonatoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmCadastroCampeonato.Create(Self));
end;

procedure TFrmMenu.MniJogadoresClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFrmControleCampeonato.Create(Self));
end;

procedure TFrmMenu.RelFluxoCaixaClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFraRelFluxoCaixa.Create(Self));
end;

procedure TFrmMenu.RelJogoPeriodoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFraRelJogosSolicitados.Create(Self));
end;

procedure TFrmMenu.RelProdutosVendidosClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFraRelProdutosVendidos.Create(Self));
end;

procedure TFrmMenu.RelTicketMedioClick(Sender: TObject);
begin
  inherited;
  Self.AbrirFrame(TFraRelTicketMedio.Create(Self))
end;

end.
