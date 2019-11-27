inherited FrmCadastroFuncionarios: TFrmCadastroFuncionarios
  Width = 758
  Height = 523
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 758
    Height = 523
    object PnlConteudo: TPanel
      Left = 208
      Top = 57
      Width = 442
      Height = 497
      BevelOuter = bvNone
      Enabled = False
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        442
        497)
      object LblFuncao: TLabel
        Left = 78
        Top = 165
        Width = 58
        Height = 19
        Anchors = [akTop, akRight]
        Caption = 'Fun'#231#227'o'
        ExplicitLeft = 14
      end
      object LblTitulo: TLabel
        Left = 56
        Top = 29
        Width = 341
        Height = 32
        Anchors = [akTop, akRight]
        Caption = 'Cadastro de Funcion'#225'rios'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object BtnCancelar: TButton
        Left = 139
        Top = 325
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Cancelar'
        TabOrder = 6
        OnClick = BtnCancelarClick
        ExplicitLeft = 75
      end
      object BtnSalvar: TButton
        Left = 233
        Top = 325
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Salvar'
        TabOrder = 5
        OnClick = BtnSalvarClick
        ExplicitLeft = 169
      end
      object ChbUsuarioAtivo: TCheckBox
        Left = 75
        Top = 203
        Width = 145
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Usu'#225'rio Ativo'
        TabOrder = 2
        ExplicitLeft = 11
      end
      object CmbFuncao: TComboBox
        Left = 139
        Top = 162
        Width = 145
        Height = 27
        Style = csDropDownList
        Anchors = [akTop, akRight]
        TabOrder = 1
        Items.Strings = (
          'Caixa'
          'Cozinheiro'
          'Gerente')
        ExplicitLeft = 75
      end
      object LedNome: TLabeledEdit
        Left = 138
        Top = 96
        Width = 290
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 45
        EditLabel.Height = 19
        EditLabel.Caption = 'Nome'
        LabelPosition = lpLeft
        TabOrder = 0
        ExplicitLeft = 74
      end
      object LedSenha: TLabeledEdit
        Left = 139
        Top = 259
        Width = 170
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 49
        EditLabel.Height = 19
        EditLabel.Caption = 'Senha'
        LabelPosition = lpLeft
        PasswordChar = '*'
        TabOrder = 4
        ExplicitLeft = 75
      end
      object LedUsuario: TLabeledEdit
        Left = 139
        Top = 226
        Width = 170
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 60
        EditLabel.Height = 19
        EditLabel.Caption = 'Usu'#225'rio'
        LabelPosition = lpLeft
        TabOrder = 3
        ExplicitLeft = 75
      end
      object LedCPF: TLabeledEdit
        Left = 139
        Top = 129
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 33
        EditLabel.Height = 19
        EditLabel.Caption = 'CPF'
        LabelPosition = lpLeft
        NumbersOnly = True
        TabOrder = 7
        ExplicitLeft = 75
      end
      object LedConfirmarSenha: TLabeledEdit
        Left = 139
        Top = 292
        Width = 170
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 129
        EditLabel.Height = 19
        EditLabel.Caption = 'Confirmar Senha'
        LabelPosition = lpLeft
        PasswordChar = '*'
        TabOrder = 8
        ExplicitLeft = 75
      end
    end
    object PnlBotoes: TPanel
      Left = 0
      Top = 0
      Width = 758
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
