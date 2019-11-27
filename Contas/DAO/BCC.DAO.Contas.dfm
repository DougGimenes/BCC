object DmContas: TDmContas
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbContas: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Contas')
    Left = 88
    Top = 56
    object TbContasCodigo: TAutoIncField
      FieldName = 'Codigo'
      ReadOnly = True
    end
    object TbContasNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object TbContasValor: TFloatField
      FieldName = 'Valor'
    end
    object TbContasVencimento: TDateTimeField
      FieldName = 'Vencimento'
    end
    object TbContasEmissao: TDateTimeField
      FieldName = 'Emissao'
    end
    object TbContasPagamento: TDateTimeField
      FieldName = 'Pagamento'
    end
  end
end
