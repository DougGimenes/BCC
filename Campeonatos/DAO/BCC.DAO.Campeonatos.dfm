object DmCampeonato: TDmCampeonato
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbCampeonato: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Campeonatos')
    Left = 88
    Top = 56
    object TbCampeonatoID_Campeonato: TAutoIncField
      FieldName = 'ID_Campeonato'
      ReadOnly = True
    end
    object TbCampeonatoNum_Participantes: TIntegerField
      FieldName = 'Num_Participantes'
    end
    object TbCampeonatoFormato: TIntegerField
      FieldName = 'Formato'
    end
    object TbCampeonatoEstado: TIntegerField
      FieldName = 'Estado'
    end
    object TbCampeonatoIdentificacao: TStringField
      FieldName = 'Identificacao'
      Size = 100
    end
    object TbCampeonatoID_Jogo: TIntegerField
      FieldName = 'ID_Jogo'
    end
  end
end
