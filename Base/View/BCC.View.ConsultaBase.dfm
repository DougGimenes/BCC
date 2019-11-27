inherited FrmConsultaBase: TFrmConsultaBase
  Caption = 'Consulta'
  ClientHeight = 501
  ClientWidth = 884
  Position = poMainFormCenter
  OnCreate = FormCreate
  ExplicitWidth = 890
  ExplicitHeight = 530
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    Width = 884
    Height = 501
    ExplicitWidth = 884
    ExplicitHeight = 501
    DesignSize = (
      884
      501)
    object DbgConsulta: TDBGrid
      Left = 10
      Top = 56
      Width = 863
      Height = 426
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DsConsulta
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      OnDblClick = DbgConsultaDblClick
      OnKeyDown = DbgConsultaKeyDown
    end
    object EdtConsulta: TEdit
      Left = 10
      Top = 16
      Width = 863
      Height = 27
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 1
      TextHint = 'Consulta'
      OnChange = EdtConsultaChange
      OnKeyDown = EdtConsultaKeyDown
    end
  end
  object QryConsulta: TADOQuery
    Connection = DmDados.AcoConexao
    Parameters = <>
    Left = 40
    Top = 128
  end
  object DsConsulta: TDataSource
    DataSet = QryConsulta
    Left = 40
    Top = 176
  end
  object TimConsulta: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = TimConsultaTimer
    Left = 40
    Top = 224
  end
  object QryAutoComplete: TADOQuery
    Connection = DmDados.AcoConexao
    Parameters = <>
    Left = 120
    Top = 128
  end
end
