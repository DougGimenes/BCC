inherited FrmInscricaoCampeonato: TFrmInscricaoCampeonato
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 451
    Height = 305
    object PnlConteudo: TPanel
      Left = 69
      Top = 0
      Width = 312
      Height = 252
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Caption = 'PnlConteudo'
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        312
        252)
      object LblTitulo: TLabel
        Left = -10
        Top = 37
        Width = 337
        Height = 32
        Anchors = [akTop]
        Caption = 'Inscri'#231#227'o de Campeonato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 116
      end
      object BtnInscrever: TButton
        Left = 163
        Top = 203
        Width = 109
        Height = 27
        Anchors = [akRight, akBottom]
        Caption = 'Inscrever-se'
        TabOrder = 0
        OnClick = BtnInscreverClick
      end
      object BtnPesquisar: TButton
        Left = 54
        Top = 203
        Width = 103
        Height = 27
        Anchors = [akRight, akBottom]
        Caption = 'Pesquisar'
        TabOrder = 1
        OnClick = BtnPesquisarClick
      end
      object DbgCampeonatos: TDBGrid
        Left = 27
        Top = 88
        Width = 245
        Height = 109
        TabStop = False
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = DsCampeonatos
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_Campeonato'
            Title.Caption = 'Num. Campeonato'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Campeonato'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Jogo'
            Width = 200
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Formato'
            Title.Alignment = taCenter
            Visible = True
          end>
      end
      object EdtPesquisa: TEdit
        Left = 27
        Top = 203
        Width = 21
        Height = 27
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 3
        TextHint = 'Pesquisa'
      end
    end
  end
  object DsCampeonatos: TDataSource
    DataSet = QryInscricao
    Left = 208
    Top = 152
  end
  object QryInscricao: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      '  c.ID_Campeonato,'
      '  c.Identificacao AS Campeonato,'
      '  j.ID_Jogo,'
      '  j.Identificacao AS Jogo,'
      '  (CASE'
      '    WHEN c.Formato = 0 THEN '#39'Pontos Corridos'#39
      '    WHEN c.Formato = 1 THEN '#39'Eliminatoria'#39
      '  END) AS Formato'
      'FROM Campeonatos c'
      '  INNER JOIN Jogos j'
      '    ON c.ID_Jogo = j.ID_Jogo'
      'WHERE c.Estado = 0')
    Left = 208
    Top = 208
    object QryInscricaoID_Campeonato: TAutoIncField
      FieldName = 'ID_Campeonato'
      ReadOnly = True
    end
    object QryInscricaoCampeonato: TStringField
      FieldName = 'Campeonato'
      Size = 100
    end
    object QryInscricaoID_Jogo: TAutoIncField
      FieldName = 'ID_Jogo'
      ReadOnly = True
    end
    object QryInscricaoJogo: TStringField
      FieldName = 'Jogo'
      Size = 100
    end
    object QryInscricaoFormato: TStringField
      FieldName = 'Formato'
      ReadOnly = True
      Size = 15
    end
  end
end
