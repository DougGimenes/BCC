inherited FrmLancaEstoque: TFrmLancaEstoque
  Caption = 'Board Caf'#233' Control'
  ClientHeight = 155
  ClientWidth = 284
  Position = poMainFormCenter
  ExplicitWidth = 300
  ExplicitHeight = 194
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    Width = 284
    Height = 155
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 951
    ExplicitHeight = 503
    object LblEstoque: TLabel
      Left = 32
      Top = 40
      Width = 94
      Height = 19
      Caption = 'Quantidade:'
    end
    object SedEstoque: TSpinEdit
      Left = 132
      Top = 37
      Width = 120
      Height = 29
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object BtnAdicionar: TButton
      Left = 32
      Top = 86
      Width = 220
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Adicionar Quantidade'
      TabOrder = 1
      OnClick = BtnAdicionarClick
    end
    object BtnRemover: TButton
      Left = 32
      Top = 117
      Width = 220
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Remover Quantidade'
      TabOrder = 2
      OnClick = BtnRemoverClick
    end
  end
end
