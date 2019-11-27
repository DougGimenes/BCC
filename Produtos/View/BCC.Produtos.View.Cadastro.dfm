inherited FrmCadastroProduto: TFrmCadastroProduto
  Width = 1039
  Height = 524
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 1039
    Height = 524
    object PnlConteudo: TPanel
      Left = 144
      Top = 49
      Width = 513
      Height = 528
      BevelOuter = bvNone
      Enabled = False
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        513
        528)
      object LblTitulo: TLabel
        Left = 144
        Top = 16
        Width = 288
        Height = 32
        Anchors = [akTop, akRight]
        Caption = 'Cadastro de Produtos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 150
      end
      object LedNome: TLabeledEdit
        Left = 216
        Top = 74
        Width = 290
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 45
        EditLabel.Height = 19
        EditLabel.Caption = 'Nome'
        LabelPosition = lpLeft
        TabOrder = 0
      end
      object LedPrecoVenda: TLabeledEdit
        Left = 216
        Top = 140
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 120
        EditLabel.Height = 19
        EditLabel.Caption = 'Pre'#231'o de Venda'
        LabelPosition = lpLeft
        TabOrder = 1
      end
      object LedPrecoCusto: TLabeledEdit
        Left = 216
        Top = 107
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 134
        EditLabel.Height = 19
        EditLabel.Caption = 'Custo de Compra'
        LabelPosition = lpLeft
        TabOrder = 2
      end
      object ChbCardapio: TCheckBox
        Left = 216
        Top = 229
        Width = 187
        Height = 17
        Caption = 'Faz parte do card'#225'pio'
        TabOrder = 3
      end
      object LedEstoque: TLabeledEdit
        Left = 216
        Top = 196
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 106
        EditLabel.Height = 19
        EditLabel.Caption = 'Estoque Atual'
        LabelPosition = lpLeft
        NumbersOnly = True
        TabOrder = 4
      end
      object ChbEstoque: TCheckBox
        Left = 216
        Top = 173
        Width = 187
        Height = 17
        Caption = 'Controla Estoque'
        TabOrder = 5
        OnClick = ChbEstoqueClick
      end
      object DbgPromocoes: TDBGrid
        Left = 0
        Top = 324
        Width = 513
        Height = 136
        DataSource = DsPromocoes
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 6
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
      object BtnInserir: TButton
        Left = 310
        Top = 262
        Width = 201
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Inserir Nova Promo'#231#227'o'
        TabOrder = 7
        OnClick = BtnInserirClick
      end
      object BtnRemover: TButton
        Left = 310
        Top = 293
        Width = 201
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Remover Promo'#231#227'o'
        TabOrder = 8
        OnClick = BtnRemoverClick
      end
      object LedValorPromo: TLabeledEdit
        Left = 159
        Top = 260
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 146
        EditLabel.Height = 19
        EditLabel.Caption = 'Pre'#231'o Promocional'
        LabelPosition = lpLeft
        TabOrder = 9
      end
      object BtnSalvar: TButton
        Left = 438
        Top = 466
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Salvar'
        TabOrder = 10
        OnClick = BtnSalvarClick
      end
      object BtnCancelar: TButton
        Left = 344
        Top = 466
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Cancelar'
        TabOrder = 11
        OnClick = BtnCancelarClick
      end
    end
    object PnlBotoes: TPanel
      Left = 0
      Top = 0
      Width = 1039
      Height = 59
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
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
      object BtnAjustarEstoque: TButton
        Left = 288
        Top = 18
        Width = 160
        Height = 25
        Caption = 'Ajustar Estoque'
        Enabled = False
        TabOrder = 3
        OnClick = BtnAjustarEstoqueClick
      end
      object BtnDesativar: TButton
        Left = 454
        Top = 18
        Width = 103
        Height = 25
        Caption = 'Desativar'
        Enabled = False
        TabOrder = 4
        OnClick = BtnDesativarClick
      end
    end
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
    Left = 176
    Top = 432
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
  object DsPromocoes: TDataSource
    DataSet = QryPromocoes
    Left = 256
    Top = 432
  end
end
