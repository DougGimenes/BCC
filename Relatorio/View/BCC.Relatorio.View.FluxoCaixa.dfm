inherited FraRelFluxoCaixa: TFraRelFluxoCaixa
  Width = 786
  Height = 464
  inherited PnlMain: TPanel
    Width = 786
    Height = 464
    inherited LblTitulo: TLabel
      Left = 150
      ExplicitLeft = 150
    end
    inherited DbgRelatorio: TDBGrid
      Left = 150
      Top = 138
      Width = 485
      Height = 200
      Columns = <
        item
          Expanded = False
          FieldName = 'Tipo'
          Title.Caption = 'Natureza da opera'#231#227'o'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor'
          Title.Alignment = taCenter
          Width = 150
          Visible = True
        end>
    end
    inherited PnlFiltro: TPanel
      Width = 786
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
      '  CASE '
      '    WHEN m.CodTitulo IS NOT NULL THEN '#39'Titulo de Recebimento'#39
      '    ELSE '#39'Conta Paga'#39
      '  END AS Tipo,'
      '  ISNULL(tit.Valor, C.Valor * -1) AS Valor'
      'FROM MovimentacaoCaixa m'
      '  INNER JOIN Caixa ON Caixa.Codigo = m.CodCaixa'
      '  LEFT JOIN Contas c ON m.CodConta = c.Codigo'
      '  LEFT JOIN Titulos tit ON m.CodTitulo = tit.Codigo'
      
        'WHERE (Caixa.Abertura BETWEEN '#39'28/10/2019 00:00:00'#39' AND '#39'05/11/2' +
        '019 23:59:59'#39
      
        '  OR Caixa.Fechamento BETWEEN '#39'28/10/2019 00:00:00'#39' AND '#39'05/11/2' +
        '019 23:59:59'#39')'
      '  AND (NOT (m.CodTitulo IS NULL AND m.CodConta IS NULL))')
    object QryRelatorioTipo: TStringField
      FieldName = 'Tipo'
      ReadOnly = True
      Size = 21
    end
    object QryRelatorioValor: TFloatField
      FieldName = 'Valor'
      ReadOnly = True
      DisplayFormat = '###0.00'
    end
  end
end
