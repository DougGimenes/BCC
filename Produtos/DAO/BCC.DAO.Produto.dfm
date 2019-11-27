object DmProduto: TDmProduto
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbProduto: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Produto')
    Left = 88
    Top = 56
    object TbProdutoID_Prod: TAutoIncField
      FieldName = 'ID_Prod'
      ReadOnly = True
    end
    object TbProdutoNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object TbProdutoPreco_Custo: TFloatField
      FieldName = 'Preco_Custo'
    end
    object TbProdutoPreco_Venda: TFloatField
      FieldName = 'Preco_Venda'
    end
    object TbProdutoEstoque: TFloatField
      FieldName = 'Estoque'
    end
    object TbProdutoAtivo: TBooleanField
      FieldName = 'Ativo'
    end
    object TbProdutoCardapio: TBooleanField
      FieldName = 'Cardapio'
    end
    object TbProdutoControlaEstoque: TBooleanField
      FieldName = 'ControlaEstoque'
    end
  end
end
