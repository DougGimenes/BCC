inherited FraRelBase: TFraRelBase
  Width = 988
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 988
    Height = 305
    DesignSize = (
      988
      305)
    object LblTitulo: TLabel
      Left = 303
      Top = 100
      Width = 119
      Height = 32
      Anchors = [akTop, akRight]
      Caption = 'LblTitulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DbgRelatorio: TDBGrid
      Left = 127
      Top = 160
      Width = 393
      Height = 102
      Anchors = [akLeft, akTop, akBottom]
      DataSource = DsRelatorio
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
    end
    object PnlFiltro: TPanel
      Left = 0
      Top = 0
      Width = 988
      Height = 64
      Align = alTop
      BevelOuter = bvNone
      Caption = 'PnlFiltro'
      ShowCaption = False
      TabOrder = 1
      ExplicitWidth = 451
      object BtnFiltrar: TButton
        Left = 280
        Top = 20
        Width = 142
        Height = 25
        Caption = 'Filtrar Relat'#243'rio'
        TabOrder = 0
        OnClick = BtnFiltrarClick
      end
      object BtnExcell: TButton
        Left = 428
        Top = 20
        Width = 117
        Height = 25
        Caption = 'Gerar XLS'
        TabOrder = 1
        OnClick = BtnExcellClick
      end
      object BtnGerarRelatorio: TButton
        Left = 551
        Top = 20
        Width = 138
        Height = 25
        Caption = 'Gerar Relat'#243'rio'
        TabOrder = 2
      end
    end
  end
  object QryRelatorio: TADOQuery
    Connection = DmDados.AcoConexao
    Parameters = <>
    Left = 96
    Top = 136
  end
  object DsRelatorio: TDataSource
    DataSet = QryRelatorio
    Left = 96
    Top = 184
  end
end
