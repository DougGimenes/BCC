unit BCC.Caixa.View.Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FormBase, Vcl.StdCtrls,
  Vcl.ExtCtrls, BCC.DAO.Caixa, BCC.Caixa.DAO.Movimentacao;

type
  TFrmMenuCaixa = class(TFrmBase)
    BtnSangria: TButton;
    BtnSuprimento: TButton;
    EdtSangria: TEdit;
    EdtSuprimento: TEdit;
    LblTitulo: TLabel;
    BtnFechar: TButton;
    procedure BtnSangriaClick(Sender: TObject);
    procedure BtnSuprimentoClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenuCaixa: TFrmMenuCaixa;

implementation

{$R *.dfm}

procedure TFrmMenuCaixa.BtnFecharClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox('Deseja finalizar o caixa?' + #13 + 'O sistema será finalizado ao fechar o caixa.', 'Board Café Control', MB_YESNO) = 6 then
  begin
    TDmCaixa.Create(Self).FecharCaixa();
    Application.Terminate();
  end;
end;

procedure TFrmMenuCaixa.BtnSangriaClick(Sender: TObject);
begin
  inherited;
  TDmMovimentacao.Create(Self).AdicionarMovimentacao(StrToFloat(Self.EdtSangria.Text) * -1);
  Self.EdtSangria.Text := '';
end;

procedure TFrmMenuCaixa.BtnSuprimentoClick(Sender: TObject);
begin
  inherited;
  TDmMovimentacao.Create(Self).AdicionarMovimentacao(StrToFloat(Self.EdtSuprimento.Text));
  Self.EdtSuprimento.Text := '';
end;

end.
