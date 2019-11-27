object DmCompetidores: TDmCompetidores
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbCompetidores: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Competidores_Campeonato')
    Left = 88
    Top = 56
    object TbCompetidoresID_Comp: TAutoIncField
      FieldName = 'ID_Comp'
      ReadOnly = True
    end
    object TbCompetidoresPontuacao: TIntegerField
      FieldName = 'Pontuacao'
    end
    object TbCompetidoresPartidas: TIntegerField
      FieldName = 'Partidas'
    end
    object TbCompetidoresVitorias: TIntegerField
      FieldName = 'Vitorias'
    end
    object TbCompetidoresDerrotas: TIntegerField
      FieldName = 'Derrotas'
    end
    object TbCompetidoresEmpates: TIntegerField
      FieldName = 'Empates'
    end
    object TbCompetidoresID_Campeonato: TIntegerField
      FieldName = 'ID_Campeonato'
    end
    object TbCompetidoresID_Cliente: TIntegerField
      FieldName = 'ID_Cliente'
    end
  end
end
