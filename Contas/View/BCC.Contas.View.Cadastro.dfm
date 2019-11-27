inherited FrmContas: TFrmContas
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 451
    Height = 305
    object PnlBotoes: TPanel
      Left = 0
      Top = 0
      Width = 451
      Height = 59
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object BtnNovo: TButton
        Left = 17
        Top = 18
        Width = 120
        Height = 25
        Caption = 'Nova Conta'
        TabOrder = 0
        OnClick = BtnNovoClick
      end
      object BtnEditar: TButton
        Left = 143
        Top = 18
        Width = 75
        Height = 25
        Caption = 'Editar'
        Enabled = False
        TabOrder = 1
        OnClick = BtnEditarClick
      end
      object BtnConsultar: TButton
        Left = 224
        Top = 18
        Width = 103
        Height = 25
        Caption = 'Consultar'
        TabOrder = 2
        OnClick = BtnConsultarClick
      end
      object BtnPagar: TButton
        Left = 333
        Top = 18
        Width = 116
        Height = 25
        Caption = 'Pagar Conta'
        Enabled = False
        TabOrder = 3
        OnClick = BtnPagarClick
      end
    end
    object PnlConteudo: TPanel
      Left = 120
      Top = 65
      Width = 321
      Height = 373
      BevelOuter = bvNone
      Caption = 'PnlConteudo'
      ShowCaption = False
      TabOrder = 1
      DesignSize = (
        321
        373)
      object LblTitulo: TLabel
        Left = 23
        Top = 18
        Width = 260
        Height = 32
        Caption = 'Cadastro de Contas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LblVencimento: TLabel
        Left = 12
        Top = 192
        Width = 90
        Height = 19
        Caption = 'Vencimento'
      end
      object LblEmissao: TLabel
        Left = 36
        Top = 157
        Width = 66
        Height = 19
        Caption = 'Emiss'#227'o'
      end
      object LedNome: TLabeledEdit
        Left = 104
        Top = 88
        Width = 200
        Height = 27
        EditLabel.Width = 45
        EditLabel.Height = 19
        EditLabel.Caption = 'Nome'
        LabelPosition = lpLeft
        TabOrder = 0
      end
      object DtpEmissao: TDateTimePicker
        Left = 104
        Top = 154
        Width = 127
        Height = 27
        Date = 43761.000000000000000000
        Time = 0.840402858797460800
        TabOrder = 1
      end
      object DtpVencimento: TDateTimePicker
        Left = 104
        Top = 187
        Width = 127
        Height = 27
        Date = 43761.000000000000000000
        Time = 0.840402858797460800
        TabOrder = 2
      end
      object LedValor: TLabeledEdit
        Left = 104
        Top = 121
        Width = 121
        Height = 27
        EditLabel.Width = 39
        EditLabel.Height = 19
        EditLabel.Caption = 'Valor'
        LabelPosition = lpLeft
        TabOrder = 3
      end
      object BtnSalvar: TButton
        Left = 198
        Top = 220
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Salvar'
        TabOrder = 4
        OnClick = BtnSalvarClick
      end
      object BtnCancelar: TButton
        Left = 104
        Top = 220
        Width = 88
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Cancelar'
        TabOrder = 5
        OnClick = BtnCancelarClick
      end
    end
  end
end
