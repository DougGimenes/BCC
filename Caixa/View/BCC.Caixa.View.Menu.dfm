inherited FrmMenuCaixa: TFrmMenuCaixa
  ClientHeight = 208
  ClientWidth = 382
  ExplicitWidth = 388
  ExplicitHeight = 237
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    Width = 382
    Height = 208
    ExplicitWidth = 382
    ExplicitHeight = 208
    object LblTitulo: TLabel
      Left = 80
      Top = 21
      Width = 221
      Height = 32
      Anchors = [akTop, akRight]
      Caption = 'Op'#231#245'es de Caixa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnSangria: TButton
      Left = 164
      Top = 78
      Width = 198
      Height = 27
      Caption = 'Realizar Sangria'
      TabOrder = 0
      OnClick = BtnSangriaClick
    end
    object BtnSuprimento: TButton
      Left = 164
      Top = 111
      Width = 198
      Height = 27
      Caption = 'Adicionar Suprimento'
      TabOrder = 1
      OnClick = BtnSuprimentoClick
    end
    object EdtSangria: TEdit
      Left = 20
      Top = 78
      Width = 138
      Height = 27
      TabOrder = 2
    end
    object EdtSuprimento: TEdit
      Left = 20
      Top = 111
      Width = 138
      Height = 27
      TabOrder = 3
    end
    object BtnFechar: TButton
      Left = 102
      Top = 159
      Width = 178
      Height = 27
      Caption = 'Fechar Caixa'
      TabOrder = 4
      OnClick = BtnFecharClick
    end
  end
end
