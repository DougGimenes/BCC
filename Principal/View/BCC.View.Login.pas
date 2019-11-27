unit BCC.View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, BCC.View.Menu, BCC.Model.Usuario, BCC.DAO.Usuario, BCC.Conexao.DAO.Dados;

type
  TFrmLogin = class(TForm)
    EdtLogin: TEdit;
    EdtSenha: TEdit;
    BtnLogin: TBitBtn;
    PnlMain: TPanel;
    procedure BtnLoginClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdtLoginKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
begin
  if Self.EdtLogin.Text <> '' then
  begin
    DmDados.Usuario := TDmUsuario.Create(Self).SelecionarPorLogin(Self.EdtLogin.Text);
    if DmDados.Usuario.Senha = Self.EdtSenha.Text then
    begin
      FrmMenu := TFrmMenu.Create(nil);
      try
        FrmMenu.ShowModal();
      except
        Application.MessageBox(PChar('Não foi possível inicializar o sistema!'), PChar('ERRO'));
      end;
      Self.EdtLogin.Text := '';
    end
    else
    begin
      Application.MessageBox(PChar('Usuário ou senha incorretos!'), PChar('ERRO'));
    end;
  end;
  Self.EdtSenha.Text := '';
  Self.EdtLogin.SetFocus();
end;

procedure TFrmLogin.EdtLoginKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
  begin
    SelectNext(ActiveControl as TWinControl, True, True );
  end;
end;

procedure TFrmLogin.EdtSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
  begin
    Self.BtnLogin.Click();
  end;
end;

procedure TFrmLogin.FormActivate(Sender: TObject);
begin
  Self.EdtLogin.SetFocus();
end;

end.
