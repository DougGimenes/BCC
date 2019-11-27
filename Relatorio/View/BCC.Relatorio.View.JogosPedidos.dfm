inherited FraRelJogosSolicitados: TFraRelJogosSolicitados
  Width = 829
  inherited PnlMain: TPanel
    Width = 829
    inherited LblTitulo: TLabel
      Left = 474
      ExplicitLeft = 96
    end
    inherited DbgRelatorio: TDBGrid
      Left = 65
      Top = 138
      Width = 580
      Height = 362
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Vezes'
          Title.Alignment = taCenter
          Title.Caption = 'Vezes Solicitado'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Jogo'
          Width = 400
          Visible = True
        end>
    end
    inherited PnlFiltro: TPanel
      Width = 829
      object LblFinal: TLabel [0]
        Left = 260
        Top = 22
        Width = 9
        Height = 19
        Caption = 'e'
      end
      object LblPeriodo: TLabel [1]
        Left = 29
        Top = 22
        Width = 87
        Height = 19
        Caption = 'Filtrar entre'
      end
      inherited BtnFiltrar: TButton
        Left = 413
        ExplicitLeft = 413
      end
      inherited BtnExcell: TButton
        Left = 561
        TabOrder = 3
        ExplicitLeft = 561
      end
      object DtpFinal: TDateTimePicker [4]
        Left = 275
        Top = 20
        Width = 132
        Height = 27
        Date = 43757.000000000000000000
        Time = 0.593756331021722900
        TabOrder = 1
      end
      object DtpInicial: TDateTimePicker [5]
        Left = 122
        Top = 20
        Width = 132
        Height = 27
        Date = 43757.000000000000000000
        Time = 0.593756331021722900
        TabOrder = 2
      end
      inherited BtnGerarRelatorio: TButton
        Left = 684
        TabOrder = 4
        OnClick = BtnGerarRelatorioClick
        ExplicitLeft = 684
      end
    end
  end
  inherited QryRelatorio: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT'
      '  COUNT(i.ID_ItemVenda) as '#39'Vezes'#39','
      '  j.Identificacao AS '#39'Jogo'#39
      'FROM Vendas v'
      '  LEFT JOIN Itens_Venda i ON i.ID_Vendas = v.ID_Vendas'
      '  LEFT JOIN Jogos j ON j.ID_Jogo = i.ID_Jogo'
      'WHERE Data BETWEEN '#39'01/10/2019'#39' and '#39'19/10/2019'#39
      '  AND J.ID_Jogo IS NOT NULL'
      'GROUP BY j.Identificacao'
      'ORDER BY Vezes DESC')
    object QryRelatorioVezes: TIntegerField
      FieldName = 'Vezes'
      ReadOnly = True
    end
    object QryRelatorioJogo: TStringField
      FieldName = 'Jogo'
      Size = 100
    end
  end
end
