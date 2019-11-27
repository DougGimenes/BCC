object DmJogo: TDmJogo
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbJogos: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Jogos')
    Left = 88
    Top = 56
    object TbJogosID_Jogo: TAutoIncField
      FieldName = 'ID_Jogo'
      ReadOnly = True
    end
    object TbJogosIdentificacao: TStringField
      FieldName = 'Identificacao'
      Size = 100
    end
    object TbJogosNum_Copias: TIntegerField
      FieldName = 'Num_Copias'
    end
    object TbJogosAtivo: TBooleanField
      FieldName = 'Ativo'
    end
    object TbJogosNum_Pessoas: TIntegerField
      FieldName = 'Num_Pessoas'
    end
  end
end
