unit BCC.Campeonatos.View.Controle;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FrameBase, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, BCC.Conexao.DAO.Dados, Data.Win.ADODB, Math,
  Vcl.StdCtrls, Vcl.Samples.Spin, BCC.Model.Campeonato, BCC.Campeonatos.View.Consulta,
  BCC.Controller.Campeonatos, BCC.Campeonatos.View.AdicionaPartida,
  BCC.Campeonatos.View.ControleBase, BCC.Campeonatos.View.ControlePontos,
  BCC.Campeonatos.View.ControleEliminatoria, Vcl.Imaging.pngimage, Vcl.Menus,
  BCC.View.ManualBase, BCC.Manual.View.IniciarCampeonato, BCC.Manual.View.EncerrarCampeonato,
  BCC.Manual.View.RegistrarPartida;

type
  TFrmControleCampeonato = class(TFraBase)
    PnlBotoes: TPanel;
    BtnConsultar: TButton;
    BtnEncerrar: TButton;
    PnlConteudo: TPanel;
    BtnIniciar: TButton;
    BtnPartida: TButton;
    BimHelp: TImage;
    PumHelp: TPopupMenu;
    MinIniciarCampeonato: TMenuItem;
    MinRegistrarPartida: TMenuItem;
    MinEncerrarCampeonato: TMenuItem;
    procedure BtnConsultarClick(Sender: TObject);
    procedure BtnEncerrarClick(Sender: TObject);
    procedure BtnPartidaClick(Sender: TObject);
    procedure BtnIniciarClick(Sender: TObject);
    procedure BimHelpClick(Sender: TObject);
    procedure MinIniciarCampeonatoClick(Sender: TObject);
    procedure MinRegistrarPartidaClick(Sender: TObject);
    procedure MinEncerrarCampeonatoClick(Sender: TObject);
  private
    { Private declarations }
    Campeonato : TCampeonato;
    Frame : TFraControleCampeonato;
    Help : TFrmManualBase;

    procedure TratarTela();
    procedure LimparTela();

    procedure AbrirFrame(AFrame : TFraControleCampeonato);

    procedure AbrirHelp(AHelp : TFrmManualBase);
  public
    { Public declarations }
  end;

var
  FrmControleCampeonato: TFrmControleCampeonato;

implementation

{$R *.dfm}

{ TFraBase1 }

procedure TFrmControleCampeonato.AbrirFrame(AFrame : TFraControleCampeonato);
begin
  if Self.Frame <> nil then
  begin
    FreeAndNil(Self.Frame);
  end;

  Self.Frame := AFrame;
  Self.Frame.Parent := Self.PnlConteudo;
  Self.Frame.Name := 'Frame';
end;

procedure TFrmControleCampeonato.AbrirHelp(AHelp: TFrmManualBase);
begin
  if Self.Help <> nil then
  begin
    FreeAndNil(Self.Help);
  end;

  Self.Help := AHelp;
  Self.Help.Show();
end;

procedure TFrmControleCampeonato.BimHelpClick(Sender: TObject);
begin
  inherited;
  Self.PumHelp.Popup(Self.BimHelp.Left + 20, Self.BimHelp.Top + 90);
end;

procedure TFrmControleCampeonato.BtnConsultarClick(Sender: TObject);
var
  Consulta : TFrmConsultaCampeonato;
begin
  inherited;
  Consulta := TFrmConsultaCampeonato.Create(Self, CmpTodos);
  try
    Consulta.ShowModal();
    if Consulta.Consultou then
    begin
      Self.Campeonato := Consulta.ObjetoConsultado;

      if Self.Campeonato.Formato = EFormato.CmpPontosCorridos then
      begin
        Self.AbrirFrame(TFraControleCampeonatoPontos.Create(Self));
      end
      else
      begin
        Self.AbrirFrame(TFraControleCampeonatoEliminatoria.Create(Self));
      end;

      Self.Frame.AbrirConsulta(Self.Campeonato.Codigo);
      Self.TratarTela();
    end;
  finally
    FreeAndNil(Consulta);
  end;
end;

procedure TFrmControleCampeonato.BtnEncerrarClick(Sender: TObject);
begin
  inherited;
  TControllerCampeonatos.EncerrarCampeonato(Self.Campeonato.Codigo);
  Self.Campeonato.Estado := EEstado.CmpFinalizado;
  Self.TratarTela();
end;

procedure TFrmControleCampeonato.BtnIniciarClick(Sender: TObject);
begin
  inherited;
  TControllerCampeonatos.IniciarCampeonato(Self.Campeonato.Codigo);
  Self.Campeonato.Estado := EEstado.CmpIniciado;
  Self.TratarTela();
end;

procedure TFrmControleCampeonato.BtnPartidaClick(Sender: TObject);
var
  FrmAddPartida : TFrmAdicionaPartida;
begin
  inherited;
  FrmAddPartida := TFrmAdicionaPartida.Create(Self, Self.Campeonato.Codigo);
  try
    FrmAddPartida.ShowModal();
  finally
    FreeAndNil(FrmAddPartida);
  end;

  Self.Frame.AbrirConsulta(Self.Campeonato.Codigo);
end;

procedure TFrmControleCampeonato.LimparTela;
begin
  Self.Frame.QryCompetidores.Close();
end;

procedure TFrmControleCampeonato.MinEncerrarCampeonatoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirHelp(TFrmManualEncerrarCampeonato.Create(Self));
end;

procedure TFrmControleCampeonato.MinIniciarCampeonatoClick(Sender: TObject);
begin
  inherited;
  Self.AbrirHelp(TFrmManualIniciarCampeonato.Create(Self));
end;

procedure TFrmControleCampeonato.MinRegistrarPartidaClick(Sender: TObject);
begin
  inherited;
  Self.AbrirHelp(TFrmManualRegistrarPartida.Create(Self));
end;

procedure TFrmControleCampeonato.TratarTela;
begin
  Self.BtnEncerrar.Visible := Self.Campeonato.Estado = EEstado.CmpIniciado;
  Self.PnlConteudo.Enabled := Self.Campeonato.Estado = EEstado.CmpIniciado;
  Self.BtnIniciar.Visible  := Self.Campeonato.Estado = EEstado.CmpEspera;
  Self.BtnPartida.Visible  := Self.Campeonato.Estado = EEstado.CmpIniciado;
end;

end.


