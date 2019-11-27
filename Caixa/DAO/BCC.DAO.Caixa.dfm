object DmCaixa: TDmCaixa
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbCaixa: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Caixa')
    Left = 40
    Top = 56
    object TbCaixaCodigo: TAutoIncField
      FieldName = 'Codigo'
      ReadOnly = True
    end
    object TbCaixaAbertura: TDateTimeField
      FieldName = 'Abertura'
    end
    object TbCaixaFechamento: TDateTimeField
      FieldName = 'Fechamento'
    end
    object TbCaixaSaldoInicial: TFloatField
      FieldName = 'SaldoInicial'
    end
    object TbCaixaSaldaoFinal: TFloatField
      FieldName = 'SaldaoFinal'
    end
    object TbCaixaAberto: TBooleanField
      FieldName = 'Aberto'
    end
  end
  object QryValorFinal: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      '  SUM(Valor_Total) AS ValorCaixa'
      'FROM Vendas'
      'WHERE CodCaixa = 0')
    Left = 144
    Top = 56
    object QryValorFinalValorCaixa: TFloatField
      FieldName = 'ValorCaixa'
      ReadOnly = True
    end
  end
end
