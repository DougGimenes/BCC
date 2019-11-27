unit BCC.Caixa.View.Abertura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FormBase, Vcl.StdCtrls,
  Vcl.ExtCtrls, BCC.DAO.Caixa, BCC.Conexao.DAO.Dados;

type
  TFrmAbreCaixa = class(TFrmBase)
    LedValorCaixa: TLabeledEdit;
    BtnAbreCaixa: TButton;
    procedure BtnAbreCaixaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAbreCaixa: TFrmAbreCaixa;

implementation

{$R *.dfm}

procedure TFrmAbreCaixa.BtnAbreCaixaClick(Sender: TObject);
begin
  inherited;
  DmDados.CodCaixa := TDmCaixa.Create(Self).GetNovoCaixa(StrToFloat(Self.LedValorCaixa.Text));
  Self.Close();
end;

end.
