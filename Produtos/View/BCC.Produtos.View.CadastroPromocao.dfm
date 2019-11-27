inherited FrmPromocao: TFrmPromocao
  Width = 677
  Height = 455
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 677
    Height = 455
    object PnlBotoes: TPanel
      Left = 0
      Top = 0
      Width = 677
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
    end
    object PnlConteudo: TPanel
      Left = 80
      Top = 49
      Width = 393
      Height = 433
      BevelOuter = bvNone
      Caption = 'PnlConteudo'
      Color = clWhite
      Enabled = False
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      DesignSize = (
        393
        433)
      object LblTitulo: TLabel
        Left = 50
        Top = 16
        Width = 318
        Height = 32
        Caption = 'Cadastro de Promo'#231#245'es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LblTipo: TLabel
        Left = 116
        Top = 205
        Width = 34
        Height = 19
        Caption = 'Tipo'
      end
      object LblDataInicial: TLabel
        Left = 67
        Top = 272
        Width = 83
        Height = 19
        Caption = 'Data Inicial'
        Enabled = False
      end
      object LblDataFinal: TLabel
        Left = 74
        Top = 305
        Width = 76
        Height = 19
        Caption = 'Data Final'
        Enabled = False
      end
      object LblSemana: TLabel
        Left = 36
        Top = 238
        Width = 114
        Height = 19
        Caption = 'Dia da Semana'
        Enabled = False
      end
      object LblDescricao: TLabel
        Left = 73
        Top = 115
        Width = 77
        Height = 19
        Caption = 'Descri'#231#227'o'
      end
      object CmbTipo: TComboBox
        Left = 152
        Top = 202
        Width = 193
        Height = 27
        Style = csDropDownList
        TabOrder = 0
        OnChange = CmbTipoChange
        Items.Strings = (
          'Dia da Semana'
          'Data'
          'Quantidade Minima')
      end
      object LedNome: TLabeledEdit
        Left = 152
        Top = 79
        Width = 240
        Height = 27
        EditLabel.Width = 45
        EditLabel.Height = 19
        EditLabel.Caption = 'Nome'
        LabelPosition = lpLeft
        TabOrder = 1
      end
      object DtpDataInicial: TDateTimePicker
        Left = 152
        Top = 268
        Width = 131
        Height = 27
        Date = 43738.000000000000000000
        Time = 0.786361446756927800
        Enabled = False
        TabOrder = 2
      end
      object DtpDataFinal: TDateTimePicker
        Left = 152
        Top = 301
        Width = 131
        Height = 27
        Date = 43738.000000000000000000
        Time = 0.786361446756927800
        Enabled = False
        TabOrder = 3
      end
      object CmbDiaSemana: TComboBox
        Left = 152
        Top = 235
        Width = 193
        Height = 27
        Style = csDropDownList
        Enabled = False
        TabOrder = 4
        Items.Strings = (
          'Domingo'
          'Segunda-Feira'
          'Ter'#231'a-Feira'
          'Quarta-Feira'
          'Quinta-Feira'
          'Sexta-Feira'
          'Sabado')
      end
      object LedQtde: TLabeledEdit
        Left = 152
        Top = 334
        Width = 131
        Height = 27
        EditLabel.Width = 146
        EditLabel.Height = 19
        EditLabel.Caption = 'Quantidade M'#237'nima'
        Enabled = False
        LabelPosition = lpLeft
        NumbersOnly = True
        TabOrder = 5
      end
      object MemDescricao: TMemo
        Left = 152
        Top = 112
        Width = 240
        Height = 84
        TabOrder = 6
      end
      object BtnCancelar: TButton
        Left = 129
        Top = 367
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Cancelar'
        TabOrder = 7
        OnClick = BtnCancelarClick
      end
      object BtnSalvar: TButton
        Left = 223
        Top = 367
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Salvar'
        TabOrder = 8
        OnClick = BtnSalvarClick
      end
    end
  end
end
