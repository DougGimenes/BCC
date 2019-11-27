unit BCC.View.ManualBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FormBase, Vcl.ExtCtrls,
  Vcl.MPlayer, Math;

type
  TFrmManualBase = class(TFrmBase)
    PnlVideo: TPanel;
    PnlBotoes: TPanel;
    MdpVideo: TMediaPlayer;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmManualBase: TFrmManualBase;

implementation

{$R *.dfm}

procedure TFrmManualBase.FormCreate(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Help';
end;

procedure TFrmManualBase.FormResize(Sender: TObject);
begin
  inherited;
  Self.MdpVideo.Left := Floor((Self.PnlBotoes.Width - Self.MdpVideo.Width) / 2);

  Self.MdpVideo.DisplayRect := Self.PnlVideo.ClientRect;
end;

end.
