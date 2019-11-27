inherited FraControleCampeonato: TFraControleCampeonato
  Width = 839
  Height = 404
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 839
    Height = 404
    DesignSize = (
      839
      404)
    object DbgCompetidores: TDBGrid
      Left = 31
      Top = 6
      Width = 780
      Height = 294
      Anchors = [akTop, akBottom]
      DataSource = DsCompetidores
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
    end
    object EdtFiltro: TEdit
      Left = 31
      Top = 306
      Width = 780
      Height = 27
      TabOrder = 1
      TextHint = 'Competidor'
      OnChange = EdtFiltroChange
    end
  end
  object QryCompetidores: TADOQuery
    Connection = DmDados.AcoConexao
    Parameters = <>
    Left = 96
    Top = 88
  end
  object DsCompetidores: TDataSource
    DataSet = QryCompetidores
    Left = 96
    Top = 144
  end
end
