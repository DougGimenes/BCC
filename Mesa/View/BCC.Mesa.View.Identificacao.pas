unit BCC.Mesa.View.Identificacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FormBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, BCC.DAO.Mesa;

type
  TFrmIdentificacaoMesa = class(TFrmBase)
    LedIdentificacao: TLabeledEdit;
    BtnAbrirMesa: TButton;
    LblAlerta: TLabel;
    procedure BtnAbrirMesaClick(Sender: TObject);
    procedure LedIdentificacaoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FIdentificacao: String;
    { Private declarations }
    procedure ValidarId();
  public
    { Public declarations }
    property Identificacao: String read FIdentificacao;
  end;

var
  FrmIdentificacaoMesa: TFrmIdentificacaoMesa;

implementation

{$R *.dfm}

{ TFrmIdentificacaoMesa }

procedure TFrmIdentificacaoMesa.BtnAbrirMesaClick(Sender: TObject);
begin
  inherited;
  Self.FIdentificacao := Self.LedIdentificacao.Text;
  Self.Close();
end;

procedure TFrmIdentificacaoMesa.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FIdentificacao := '';
end;

procedure TFrmIdentificacaoMesa.LedIdentificacaoChange(Sender: TObject);
begin
  inherited;
  Self.ValidarId();
end;

procedure TFrmIdentificacaoMesa.ValidarId;
begin
  if TDmMesa.Create(Self).ValidarIdentificacao(Self.LedIdentificacao.Text) then
  begin
    Self.BtnAbrirMesa.Enabled := True;
    Self.LblAlerta.Visible := False;
  end
  else
  begin
    Self.BtnAbrirMesa.Enabled := False;
    Self.LblAlerta.Visible := True;
  end;
end;

end.
