inherited FrmAdicionaPartida: TFrmAdicionaPartida
  ClientHeight = 291
  ClientWidth = 430
  ExplicitWidth = 436
  ExplicitHeight = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    Width = 430
    Height = 291
    ExplicitWidth = 430
    ExplicitHeight = 291
    object LblVs: TLabel
      Left = 202
      Top = 91
      Width = 26
      Height = 19
      Caption = 'VS.'
    end
    object LblVencedor: TLabel
      Left = 32
      Top = 211
      Width = 79
      Height = 19
      Caption = 'Vencedor:'
    end
    object LblCompetidor1: TLabel
      Left = 32
      Top = 79
      Width = 103
      Height = 19
      Caption = 'Competidor 1'
    end
    object LblCompetidor2: TLabel
      Left = 238
      Top = 79
      Width = 103
      Height = 19
      Caption = 'Competidor 2'
    end
    object LblTitulo: TLabel
      Left = 80
      Top = 16
      Width = 253
      Height = 32
      Anchors = [akTop]
      Caption = 'Registro de Partida'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 74
    end
    object LblPontuacao1: TLabel
      Left = 32
      Top = 137
      Width = 160
      Height = 19
      Caption = 'Adicionar Pontua'#231#227'o'
    end
    object LblPontuacao2: TLabel
      Left = 238
      Top = 137
      Width = 160
      Height = 19
      Caption = 'Adicionar Pontua'#231#227'o'
    end
    object CmbCompetidor1: TComboBox
      Left = 32
      Top = 104
      Width = 160
      Height = 27
      Style = csDropDownList
      TabOrder = 0
      OnChange = CmbCompetidor1Change
    end
    object CmbCompetidor2: TComboBox
      Left = 238
      Top = 104
      Width = 160
      Height = 27
      Style = csDropDownList
      Enabled = False
      TabOrder = 1
      OnChange = CmbCompetidor2Change
    end
    object CmbVencedor: TComboBox
      Left = 117
      Top = 208
      Width = 145
      Height = 27
      Style = csDropDownList
      Enabled = False
      TabOrder = 2
      OnChange = CmbVencedorChange
      Items.Strings = (
        'Competidor 1'
        'Competidor 2'
        'Empate')
    end
    object SedPonto2: TSpinEdit
      Left = 238
      Top = 162
      Width = 121
      Height = 29
      Enabled = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object SedPonto1: TSpinEdit
      Left = 32
      Top = 162
      Width = 121
      Height = 29
      Enabled = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
    object BtnRegistrarPartida: TButton
      Left = 32
      Top = 248
      Width = 366
      Height = 30
      Caption = 'Registrar Partida'
      Enabled = False
      TabOrder = 5
      OnClick = BtnRegistrarPartidaClick
    end
  end
  object QryCompetidores: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      '  cli.Nome AS Cliente,'
      '  comp.ID_Comp'
      'FROM Competidores_Campeonato comp'
      '  LEFT JOIN Cliente cli ON cli.ID_Cliente = comp.ID_Cliente')
    Left = 360
    Top = 16
    object QryCompetidoresCliente: TStringField
      FieldName = 'Cliente'
      Size = 100
    end
    object QryCompetidoresID_Comp: TAutoIncField
      FieldName = 'ID_Comp'
      ReadOnly = True
    end
  end
end
