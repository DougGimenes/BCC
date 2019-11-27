inherited FraRelVendasDia: TFraRelVendasDia
  Width = 899
  inherited PnlMain: TPanel
    Width = 899
    inherited LblTitulo: TLabel
      Left = 214
    end
    inherited DbgRelatorio: TDBGrid
      Left = 29
      Top = 96
      Width = 644
      Height = 177
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ID_Vendas'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Identificacao'
          Title.Caption = 'Identifica'#231#227'o'
          Width = 400
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor_Total'
          Title.Alignment = taCenter
          Title.Caption = 'Valor Total'
          Width = 120
          Visible = True
        end>
    end
    inherited PnlFiltro: TPanel
      Width = 899
      object LblPeriodo: TLabel [0]
        Left = 29
        Top = 22
        Width = 147
        Height = 19
        Caption = 'Filtrar vendas entre'
      end
      object LblFinal: TLabel [1]
        Left = 320
        Top = 22
        Width = 9
        Height = 19
        Caption = 'e'
      end
      object DtpInicial: TDateTimePicker [2]
        Left = 182
        Top = 20
        Width = 132
        Height = 27
        Date = 43757.000000000000000000
        Time = 0.593756331021722900
        TabOrder = 0
      end
      inherited BtnFiltrar: TButton
        Left = 473
        TabOrder = 3
        ExplicitLeft = 473
      end
      inherited BtnExcell: TButton
        Left = 621
        ExplicitLeft = 621
      end
      inherited BtnGerarRelatorio: TButton
        Left = 744
        TabOrder = 4
        ExplicitLeft = 744
      end
      object DtpFinal: TDateTimePicker
        Left = 335
        Top = 20
        Width = 132
        Height = 27
        Date = 43757.000000000000000000
        Time = 0.593756331021722900
        TabOrder = 2
      end
    end
  end
  inherited QryRelatorio: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT'
      '  ID_Vendas,'
      '  Identificacao,'
      '  Valor_Tota'
      'FROM Vendas')
    object QryRelatorioID_Vendas: TAutoIncField
      FieldName = 'ID_Vendas'
      ReadOnly = True
    end
    object QryRelatorioIdentificacao: TStringField
      FieldName = 'Identificacao'
      Size = 100
    end
    object QryRelatorioValor_Total: TFloatField
      FieldName = 'Valor_Total'
      DisplayFormat = '#,##0.00'
    end
  end
end
