inherited FraRelProdutosVendidos: TFraRelProdutosVendidos
  Width = 833
  inherited PnlMain: TPanel
    Width = 833
    inherited LblTitulo: TLabel
      Left = 652
      ExplicitLeft = 285
    end
    inherited DbgRelatorio: TDBGrid
      Left = 29
      Top = 154
      Width = 670
      Height = 194
      Columns = <
        item
          Expanded = False
          FieldName = 'Descricao'
          Title.Caption = 'Descri'#231#227'o'
          Width = 400
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'QtdeVendida'
          Title.Alignment = taCenter
          Title.Caption = 'Qtde Vendida'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorTotal'
          Title.Alignment = taCenter
          Title.Caption = 'Valor Total'
          Width = 120
          Visible = True
        end>
    end
    inherited PnlFiltro: TPanel
      Width = 833
      object LblFinal: TLabel [0]
        Left = 320
        Top = 22
        Width = 9
        Height = 19
        Caption = 'e'
      end
      object LblPeriodo: TLabel [1]
        Left = 29
        Top = 22
        Width = 147
        Height = 19
        Caption = 'Filtrar vendas entre'
      end
      inherited BtnFiltrar: TButton
        Left = 473
        ExplicitLeft = 473
      end
      inherited BtnExcell: TButton
        Left = 621
        TabOrder = 3
        ExplicitLeft = 621
      end
      inherited BtnGerarRelatorio: TButton
        Left = 744
        TabOrder = 4
        OnClick = BtnGerarRelatorioClick
        ExplicitLeft = 744
      end
      object DtpFinal: TDateTimePicker
        Left = 335
        Top = 20
        Width = 132
        Height = 27
        Date = 43757.000000000000000000
        Time = 0.593756331021722900
        TabOrder = 1
      end
      object DtpInicial: TDateTimePicker
        Left = 182
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
      '  i.Descricao,'
      '  SUM(i.Qtde_Prod) AS '#39'QtdeVendida'#39','
      '  SUM(i.ValorTotal) AS '#39'ValorTotal'#39
      'FROM Vendas v'
      '  LEFT JOIN Itens_Venda i ON i.ID_Vendas = v.ID_Vendas'
      'WHERE Data BETWEEN '#39'01/10/2019'#39' and '#39'19/10/2019'#39
      '  AND i.ID_Prod > 0'
      'GROUP BY i.Descricao')
    object QryRelatorioDescricao: TStringField
      FieldName = 'Descricao'
      Size = 200
    end
    object QryRelatorioQtdeVendida: TFloatField
      FieldName = 'QtdeVendida'
      ReadOnly = True
    end
    object QryRelatorioValorTotal: TFloatField
      FieldName = 'ValorTotal'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
  end
end
