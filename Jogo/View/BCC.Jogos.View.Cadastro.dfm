inherited FrmCadastroJogo: TFrmCadastroJogo
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 451
    Height = 305
    object PnlConteudo: TPanel
      Left = -32
      Top = 49
      Width = 414
      Height = 525
      Anchors = [akTop]
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        414
        525)
      object LblTitulo: TLabel
        Left = 96
        Top = 16
        Width = 248
        Height = 32
        Anchors = [akTop, akRight]
        Caption = 'Cadastro de Jogos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 183
      end
      object BtnSalvar: TButton
        Left = 248
        Top = 190
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Salvar'
        TabOrder = 0
        OnClick = BtnSalvarClick
      end
      object BtnCancelar: TButton
        Left = 154
        Top = 190
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Cancelar'
        TabOrder = 1
        OnClick = BtnCancelarClick
      end
      object LedNome: TLabeledEdit
        Left = 154
        Top = 91
        Width = 260
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 45
        EditLabel.Height = 19
        EditLabel.Caption = 'Nome'
        LabelPosition = lpLeft
        TabOrder = 2
      end
      object LedPessoas: TLabeledEdit
        Left = 154
        Top = 124
        Width = 131
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 110
        EditLabel.Height = 19
        EditLabel.Caption = 'N'#250'm. Pessoas'
        LabelPosition = lpLeft
        NumbersOnly = True
        TabOrder = 3
      end
      object LedCopias: TLabeledEdit
        Left = 154
        Top = 157
        Width = 131
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 98
        EditLabel.Height = 19
        EditLabel.Caption = 'N'#250'm. C'#243'pias'
        LabelPosition = lpLeft
        NumbersOnly = True
        TabOrder = 4
      end
    end
    object PnlBotoes: TPanel
      Left = 0
      Top = 0
      Width = 451
      Height = 59
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
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
  end
end
