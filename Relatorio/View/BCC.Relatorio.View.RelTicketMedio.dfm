inherited FraRelTicketMedio: TFraRelTicketMedio
  Width = 762
  inherited PnlMain: TPanel
    Width = 762
    inherited LblTitulo: TLabel
      Left = 353
      Top = 92
      ExplicitLeft = 42
      ExplicitTop = 92
    end
    inherited DbgRelatorio: TDBGrid
      Left = 32
      Width = 673
      Height = 374
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Title.Caption = 'Cliente'
          Width = 400
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Vendas'
          Title.Alignment = taCenter
          Title.Caption = 'N'#250'm. Vendas'
          Width = 120
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Media'
          Title.Alignment = taCenter
          Title.Caption = 'Valor M'#233'dio'
          Width = 120
          Visible = True
        end>
    end
    inherited PnlFiltro: TPanel
      Width = 762
      object LblPeriodo: TLabel [0]
        Left = 29
        Top = 22
        Width = 87
        Height = 19
        Caption = 'Filtrar entre'
      end
      object LblFinal: TLabel [1]
        Left = 260
        Top = 22
        Width = 9
        Height = 19
        Caption = 'e'
      end
      inherited BtnFiltrar: TButton
        Left = 413
        ExplicitLeft = 413
      end
      inherited BtnExcell: TButton
        Left = 561
        ExplicitLeft = 561
      end
      inherited BtnGerarRelatorio: TButton
        Left = 684
        OnClick = BtnGerarRelatorioClick
        ExplicitLeft = 684
      end
      object DtpInicial: TDateTimePicker
        Left = 122
        Top = 20
        Width = 132
        Height = 27
        Date = 43757.000000000000000000
        Time = 0.593756331021722900
        TabOrder = 3
      end
      object DtpFinal: TDateTimePicker
        Left = 275
        Top = 20
        Width = 132
        Height = 27
        Date = 43757.000000000000000000
        Time = 0.593756331021722900
        TabOrder = 4
      end
    end
  end
  inherited QryRelatorio: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT'
      '  c.Nome,'
      '  COUNT(v.ID_Vendas) Vendas,'
      '  SUM(v.Valor_Total) / COUNT(v.ID_Vendas) AS Media,'
      '  SUM(V.Valor_Total) AS ValorTotal'
      'FROM Vendas v'
      '  LEFT JOIN Cliente c on v.ID_Cliente = c.ID_Cliente'
      'GROUP BY c.Nome ')
    Left = 240
    Top = 216
    object QryRelatorioNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object QryRelatorioVendas: TIntegerField
      FieldName = 'Vendas'
      ReadOnly = True
    end
    object QryRelatorioMedia: TFloatField
      FieldName = 'Media'
      ReadOnly = True
      DisplayFormat = '###0.00'
    end
    object QryRelatorioValorTotal: TFloatField
      FieldName = 'ValorTotal'
      ReadOnly = True
      DisplayFormat = '###0.00'
    end
  end
  inherited DsRelatorio: TDataSource
    Left = 240
    Top = 264
  end
end
