inherited FrmCadastroServico: TFrmCadastroServico
  Width = 901
  Height = 543
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 901
    Height = 543
    object PnlBotoes: TPanel
      Left = 0
      Top = 0
      Width = 901
      Height = 59
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      ExplicitWidth = 451
      object BtnNovo: TButton
        Left = 17
        Top = 18
        Width = 75
        Height = 25
        Caption = 'Novo'
        TabOrder = 0
        OnClick = BtnNovoClick
      end
      object BtnEditar: TButton
        Left = 98
        Top = 18
        Width = 75
        Height = 25
        Caption = 'Editar'
        Enabled = False
        TabOrder = 1
        OnClick = BtnEditarClick
      end
      object BtnConsultar: TButton
        Left = 179
        Top = 18
        Width = 103
        Height = 25
        Caption = 'Consultar'
        TabOrder = 2
        OnClick = BtnConsultarClick
      end
      object BtnDesativar: TButton
        Left = 288
        Top = 18
        Width = 103
        Height = 25
        Caption = 'Desativar'
        Enabled = False
        TabOrder = 3
        OnClick = BtnDesativarClick
      end
    end
    object PnlConteudo: TPanel
      Left = 179
      Top = 81
      Width = 529
      Height = 505
      BevelOuter = bvNone
      Enabled = False
      ShowCaption = False
      TabOrder = 1
      DesignSize = (
        529
        505)
      object LblTitulo: TLabel
        Left = 117
        Top = 16
        Width = 281
        Height = 32
        Anchors = [akTop, akRight]
        Caption = 'Cadastro de Servi'#231'os'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LblDescricao: TLabel
        Left = 92
        Top = 148
        Width = 77
        Height = 19
        Anchors = [akTop, akRight]
        Caption = 'Descri'#231#227'o'
      end
      object LedNome: TLabeledEdit
        Left = 172
        Top = 79
        Width = 260
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 45
        EditLabel.Height = 19
        EditLabel.Caption = 'Nome'
        LabelPosition = lpLeft
        TabOrder = 0
      end
      object LedPreco: TLabeledEdit
        Left = 172
        Top = 112
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 45
        EditLabel.Height = 19
        EditLabel.Caption = 'Pre'#231'o'
        LabelPosition = lpLeft
        TabOrder = 1
      end
      object BtnCancelar: TButton
        Left = 355
        Top = 450
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Cancelar'
        TabOrder = 2
        OnClick = BtnCancelarClick
      end
      object BtnSalvar: TButton
        Left = 449
        Top = 450
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Salvar'
        TabOrder = 3
        OnClick = BtnSalvarClick
      end
      object MemDescricao: TMemo
        Left = 172
        Top = 145
        Width = 185
        Height = 89
        Anchors = [akTop, akRight]
        TabOrder = 4
      end
      object DbgPromocoes: TDBGrid
        Left = 11
        Top = 308
        Width = 513
        Height = 136
        DataSource = DsPromocoes
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 5
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 320
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PrecoPromocional'
            Title.Alignment = taCenter
            Title.Caption = 'Pre'#231'o Promocional'
            Width = 155
            Visible = True
          end>
      end
      object LedValorPromo: TLabeledEdit
        Left = 172
        Top = 245
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 146
        EditLabel.Height = 19
        EditLabel.Caption = 'Pre'#231'o Promocional'
        LabelPosition = lpLeft
        TabOrder = 6
      end
      object BtnInserir: TButton
        Left = 323
        Top = 246
        Width = 201
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Inserir Nova Promo'#231#227'o'
        TabOrder = 7
        OnClick = BtnInserirClick
      end
      object BtnRemover: TButton
        Left = 323
        Top = 277
        Width = 201
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Remover Promo'#231#227'o'
        TabOrder = 8
        OnClick = BtnRemoverClick
      end
    end
  end
  object DsPromocoes: TDataSource
    DataSet = QryPromocoes
    Left = 304
    Top = 448
  end
  object QryPromocoes: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      '  p.Codigo,'
      '  r.Nome,'
      '  p.PrecoPromocional'
      'FROM Promocao p'
      '  INNER JOIN Regras_Promocao r on r.Codigo = p.CodRegra'
      'WHERE p.CodProduto = 0')
    Left = 224
    Top = 448
    object QryPromocoesNome: TStringField
      FieldName = 'Nome'
      Size = 200
    end
    object QryPromocoesCodigo: TAutoIncField
      FieldName = 'Codigo'
      ReadOnly = True
    end
    object QryPromocoesPrecoPromocional: TFloatField
      FieldName = 'PrecoPromocional'
      DisplayFormat = '###0.00'
    end
  end
end
