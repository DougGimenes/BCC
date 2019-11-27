object DmPromocao: TDmPromocao
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbPromocao: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Promocao')
    Left = 48
    Top = 56
    object TbPromocaoCodigo: TAutoIncField
      FieldName = 'Codigo'
      ReadOnly = True
    end
    object TbPromocaoCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object TbPromocaoCodRegra: TIntegerField
      FieldName = 'CodRegra'
    end
    object TbPromocaoPrecoPromocional: TFloatField
      FieldName = 'PrecoPromocional'
    end
    object TbPromocaoCodServico: TIntegerField
      FieldName = 'CodServico'
    end
  end
  object TbRegra: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Regras_Promocao')
    Left = 128
    Top = 56
    object TbRegraCodigo: TAutoIncField
      FieldName = 'Codigo'
      ReadOnly = True
    end
    object TbRegraNome: TStringField
      FieldName = 'Nome'
      Size = 200
    end
    object TbRegraDescricao: TMemoField
      FieldName = 'Descricao'
      BlobType = ftMemo
    end
    object TbRegraTipo: TIntegerField
      FieldName = 'Tipo'
    end
    object TbRegraDataInicial: TDateTimeField
      FieldName = 'DataInicial'
    end
    object TbRegraDataFinal: TDateTimeField
      FieldName = 'DataFinal'
    end
    object TbRegraQuantidadeMinima: TFloatField
      FieldName = 'QuantidadeMinima'
    end
    object TbRegraDiaSemana: TIntegerField
      FieldName = 'DiaSemana'
    end
  end
end
