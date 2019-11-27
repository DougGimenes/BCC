object DmSala: TDmSala
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbSala: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM SALA')
    Left = 88
    Top = 56
    object TbSalaID_Sala: TAutoIncField
      FieldName = 'ID_Sala'
      ReadOnly = True
    end
    object TbSalaNum_Pessoas: TIntegerField
      FieldName = 'Num_Pessoas'
    end
    object TbSalaAtivo: TBooleanField
      FieldName = 'Ativo'
    end
    object TbSalaIdentifiacacao: TStringField
      FieldName = 'Identifiacacao'
      Size = 100
    end
    object TbSalaValorHora: TFloatField
      FieldName = 'ValorHora'
    end
    object TbSalaDescricao: TMemoField
      FieldName = 'Descricao'
      BlobType = ftMemo
    end
  end
end
