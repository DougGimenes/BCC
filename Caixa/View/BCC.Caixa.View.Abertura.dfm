inherited FrmAbreCaixa: TFrmAbreCaixa
  Caption = 'Board Caf'#233' Control'
  ClientHeight = 154
  ClientWidth = 270
  Position = poOwnerFormCenter
  ExplicitWidth = 286
  ExplicitHeight = 193
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    Width = 270
    Height = 154
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 270
    ExplicitHeight = 154
    object LedValorCaixa: TLabeledEdit
      Left = 55
      Top = 56
      Width = 160
      Height = 27
      Anchors = [akTop]
      EditLabel.Width = 158
      EditLabel.Height = 19
      EditLabel.Caption = 'Valor Inicial do Caixa'
      TabOrder = 0
    end
    object BtnAbreCaixa: TButton
      Left = 55
      Top = 89
      Width = 160
      Height = 32
      Anchors = [akTop]
      Caption = 'Abrir Caixa'
      TabOrder = 1
      OnClick = BtnAbreCaixaClick
    end
  end
end
