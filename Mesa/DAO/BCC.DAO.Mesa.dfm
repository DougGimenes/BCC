object DmMesa: TDmMesa
  OldCreateOrder = False
  Height = 150
  Width = 280
  object TbItem: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Itens_Venda')
    Left = 128
    Top = 56
    object TbItemID_ItemVenda: TAutoIncField
      FieldName = 'ID_ItemVenda'
      ReadOnly = True
    end
    object TbItemID_Prod: TIntegerField
      FieldName = 'ID_Prod'
    end
    object TbItemID_Servico: TIntegerField
      FieldName = 'ID_Servico'
    end
    object TbItemID_Vendas: TIntegerField
      FieldName = 'ID_Vendas'
    end
    object TbItemID_Jogo: TIntegerField
      FieldName = 'ID_Jogo'
    end
    object TbItemValorUnitario: TFloatField
      FieldName = 'ValorUnitario'
    end
    object TbItemQtde_Prod: TFloatField
      FieldName = 'Qtde_Prod'
    end
    object TbItemDescricao: TStringField
      FieldName = 'Descricao'
      Size = 200
    end
    object TbItemValorTotal: TFloatField
      FieldName = 'ValorTotal'
    end
  end
  object TbMesa: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Vendas')
    Left = 48
    Top = 56
    object TbMesaID_Vendas: TAutoIncField
      FieldName = 'ID_Vendas'
      ReadOnly = True
    end
    object TbMesaID_Cliente: TIntegerField
      FieldName = 'ID_Cliente'
    end
    object TbMesaIdentificacao: TStringField
      FieldName = 'Identificacao'
      Size = 100
    end
    object TbMesaAberta: TBooleanField
      FieldName = 'Aberta'
    end
    object TbMesaValor_Total: TFloatField
      FieldName = 'Valor_Total'
    end
    object TbMesaFormaPag: TIntegerField
      FieldName = 'FormaPag'
    end
    object TbMesaCodCaixa: TIntegerField
      FieldName = 'CodCaixa'
    end
    object TbMesaData: TDateTimeField
      FieldName = 'Data'
    end
  end
  object TbTitulo: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM TITULOS')
    Left = 200
    Top = 56
    object TbTituloCodigo: TAutoIncField
      FieldName = 'Codigo'
      ReadOnly = True
    end
    object TbTituloCodVenda: TIntegerField
      FieldName = 'CodVenda'
    end
    object TbTituloValor: TFloatField
      FieldName = 'Valor'
    end
    object TbTituloPago: TFloatField
      FieldName = 'Pago'
    end
    object TbTituloTroco: TFloatField
      FieldName = 'Troco'
    end
    object TbTituloFormaPagto: TIntegerField
      FieldName = 'FormaPagto'
    end
  end
end
