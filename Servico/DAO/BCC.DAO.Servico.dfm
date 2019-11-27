object DmServico: TDmServico
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbServico: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Servicos')
    Left = 88
    Top = 56
    object TbServicoID_Servico: TAutoIncField
      FieldName = 'ID_Servico'
      ReadOnly = True
    end
    object TbServicoNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object TbServicoValor: TFloatField
      FieldName = 'Valor'
    end
    object TbServicoAtivo: TBooleanField
      FieldName = 'Ativo'
    end
    object TbServicoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 255
    end
  end
end
