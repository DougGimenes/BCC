inherited FrmCadastroSala: TFrmCadastroSala
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 451
    Height = 305
    object PnlConteudo: TPanel
      Left = 38
      Top = 65
      Width = 369
      Height = 525
      Anchors = [akTop]
      BevelOuter = bvNone
      Enabled = False
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        369
        525)
      object LblTitulo: TLabel
        Left = 51
        Top = 16
        Width = 238
        Height = 32
        Anchors = [akTop, akRight]
        Caption = 'Cadastro de Salas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 63
      end
      object LblDescricao: TLabel
        Left = 40
        Top = 180
        Width = 77
        Height = 19
        Anchors = [akTop, akRight]
        Caption = 'Descri'#231#227'o'
      end
      object BtnSalvar: TButton
        Left = 214
        Top = 272
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Salvar'
        TabOrder = 0
        OnClick = BtnSalvarClick
      end
      object BtnCancelar: TButton
        Left = 120
        Top = 272
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Cancelar'
        TabOrder = 1
        OnClick = BtnCancelarClick
      end
      object LedNome: TLabeledEdit
        Left = 120
        Top = 75
        Width = 248
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 45
        EditLabel.Height = 19
        EditLabel.Caption = 'Nome'
        LabelPosition = lpLeft
        TabOrder = 2
      end
      object LedPessoas: TLabeledEdit
        Left = 120
        Top = 108
        Width = 120
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 110
        EditLabel.Height = 19
        EditLabel.Caption = 'N'#250'm. Pessoas'
        LabelPosition = lpLeft
        NumbersOnly = True
        TabOrder = 3
      end
      object MemDescricao: TMemo
        Left = 120
        Top = 177
        Width = 185
        Height = 89
        Anchors = [akTop, akRight]
        TabOrder = 4
      end
      object LedPreco: TLabeledEdit
        Left = 120
        Top = 144
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 80
        EditLabel.Height = 19
        EditLabel.Caption = 'Valor Hora'
        LabelPosition = lpLeft
        TabOrder = 5
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
