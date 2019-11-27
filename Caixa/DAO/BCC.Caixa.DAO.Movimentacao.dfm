object DmMovimentacao: TDmMovimentacao
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbMovimentacaoCaixa: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM MovimentacaoCaixa'
      'WHERE -1 = 1')
    Left = 88
    Top = 56
    object TbMovimentacaoCaixaCodigo: TAutoIncField
      FieldName = 'Codigo'
      ReadOnly = True
    end
    object TbMovimentacaoCaixaCodCaixa: TIntegerField
      FieldName = 'CodCaixa'
    end
    object TbMovimentacaoCaixaValor: TFloatField
      FieldName = 'Valor'
    end
    object TbMovimentacaoCaixaCodConta: TIntegerField
      FieldName = 'CodConta'
    end
    object TbMovimentacaoCaixaCodTitulo: TIntegerField
      FieldName = 'CodTitulo'
    end
  end
end
