inherited FrmCadastroCliente: TFrmCadastroCliente
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 451
    Height = 305
    object PnlCampos: TPanel
      Left = 92
      Top = 65
      Width = 606
      Height = 563
      BevelOuter = bvNone
      Enabled = False
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        606
        563)
      object LblNascimento: TLabel
        Left = 63
        Top = 111
        Width = 91
        Height = 19
        Anchors = [akTop, akRight]
        Caption = 'Nascimento'
      end
      object LblTitulo: TLabel
        Left = 149
        Top = 24
        Width = 274
        Height = 32
        Anchors = [akTop, akRight]
        Caption = 'Cadastro de Clientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 328
      end
      object BtnCancelar: TButton
        Left = 158
        Top = 484
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Cancelar'
        TabOrder = 6
        OnClick = BtnCancelarClick
      end
      object BtnSalvar: TButton
        Left = 252
        Top = 484
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Salvar'
        TabOrder = 5
        OnClick = BtnSalvarClick
      end
      object ChbUsuarioAtivo: TCheckBox
        Left = 93
        Top = 362
        Width = 145
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Usu'#225'rio Ativo'
        TabOrder = 2
      end
      object DtpNascimento: TDateTimePicker
        Left = 157
        Top = 108
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        Date = 32874.000000000000000000
        MinDate = 2.000000000000000000
        TabOrder = 1
      end
      object LedNome: TLabeledEdit
        Left = 157
        Top = 75
        Width = 290
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 45
        EditLabel.Height = 19
        EditLabel.Caption = 'Nome'
        LabelPosition = lpLeft
        TabOrder = 0
      end
      object LedSenha: TLabeledEdit
        Left = 157
        Top = 418
        Width = 170
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 49
        EditLabel.Height = 19
        EditLabel.Caption = 'Senha'
        LabelPosition = lpLeft
        PasswordChar = '*'
        TabOrder = 4
      end
      object LedUsuario: TLabeledEdit
        Left = 157
        Top = 385
        Width = 170
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 60
        EditLabel.Height = 19
        EditLabel.Caption = 'Usu'#225'rio'
        LabelPosition = lpLeft
        TabOrder = 3
      end
      object LedCPF: TLabeledEdit
        Left = 157
        Top = 141
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 33
        EditLabel.Height = 19
        EditLabel.Caption = 'CPF'
        LabelPosition = lpLeft
        NumbersOnly = True
        TabOrder = 7
      end
      object LedTelefone: TLabeledEdit
        Left = 157
        Top = 174
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 65
        EditLabel.Height = 19
        EditLabel.Caption = 'Telefone'
        LabelPosition = lpLeft
        NumbersOnly = True
        TabOrder = 8
      end
      object LedEmail: TLabeledEdit
        Left = 157
        Top = 207
        Width = 290
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 42
        EditLabel.Height = 19
        EditLabel.Caption = 'Email'
        LabelPosition = lpLeft
        TabOrder = 9
      end
      object LedEndereco: TLabeledEdit
        Left = 157
        Top = 240
        Width = 290
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 74
        EditLabel.Height = 19
        EditLabel.Caption = 'Endere'#231'o'
        LabelPosition = lpLeft
        TabOrder = 10
      end
      object LedBairro: TLabeledEdit
        Left = 157
        Top = 273
        Width = 290
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 47
        EditLabel.Height = 19
        EditLabel.Caption = 'Bairro'
        LabelPosition = lpLeft
        TabOrder = 11
      end
      object LedNumero: TLabeledEdit
        Left = 157
        Top = 306
        Width = 145
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 61
        EditLabel.Height = 19
        EditLabel.Caption = 'N'#250'mero'
        LabelPosition = lpLeft
        TabOrder = 12
      end
      object LedConfirmaSenha: TLabeledEdit
        Left = 157
        Top = 451
        Width = 170
        Height = 27
        Anchors = [akTop, akRight]
        EditLabel.Width = 129
        EditLabel.Height = 19
        EditLabel.Caption = 'Confirmar Senha'
        LabelPosition = lpLeft
        PasswordChar = '*'
        TabOrder = 13
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
