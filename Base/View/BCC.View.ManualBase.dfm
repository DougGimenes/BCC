inherited FrmManualBase: TFrmManualBase
  BorderStyle = bsSizeable
  Caption = 'Help'
  ClientHeight = 503
  ClientWidth = 951
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    Width = 951
    Height = 503
    object PnlVideo: TPanel
      Left = 0
      Top = 0
      Width = 951
      Height = 462
      Align = alClient
      BevelOuter = bvNone
      Caption = 'PnlVideo'
      ShowCaption = False
      TabOrder = 0
      ExplicitLeft = 392
      ExplicitTop = 240
      ExplicitWidth = 185
      ExplicitHeight = 41
    end
    object PnlBotoes: TPanel
      Left = 0
      Top = 462
      Width = 951
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'PnlBotoes'
      ShowCaption = False
      TabOrder = 1
      ExplicitTop = 468
      ExplicitWidth = 957
      object MdpVideo: TMediaPlayer
        Left = 344
        Top = 6
        Width = 253
        Height = 30
        ColoredButtons = [btPlay, btPause, btStop, btNext, btPrev, btStep, btBack]
        EnabledButtons = [btPlay, btPause, btStop, btNext, btPrev, btStep, btBack]
        AutoOpen = True
        DoubleBuffered = True
        Display = PnlVideo
        ParentDoubleBuffered = False
        TabOrder = 0
      end
    end
  end
end
