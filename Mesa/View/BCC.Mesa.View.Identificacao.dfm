inherited FrmIdentificacaoMesa: TFrmIdentificacaoMesa
  Caption = 'Board Caf'#233' Control'
  ClientHeight = 128
  ClientWidth = 300
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  ExplicitWidth = 316
  ExplicitHeight = 167
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    Width = 300
    Height = 128
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 300
    ExplicitHeight = 128
    object LblAlerta: TLabel
      Left = 69
      Top = 65
      Width = 182
      Height = 16
      Caption = 'NOME INV'#193'LIDO OU EM USO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 213
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object LedIdentificacao: TLabeledEdit
      Left = 15
      Top = 38
      Width = 270
      Height = 27
      CharCase = ecUpperCase
      EditLabel.Width = 267
      EditLabel.Height = 19
      EditLabel.Caption = 'Insira a Identifica'#231#227'o da Nova Mesa'
      TabOrder = 0
      OnChange = LedIdentificacaoChange
    end
    object BtnAbrirMesa: TButton
      Left = 15
      Top = 80
      Width = 270
      Height = 33
      Caption = 'Abrir Mesa'
      Enabled = False
      TabOrder = 1
      OnClick = BtnAbrirMesaClick
    end
  end
end
