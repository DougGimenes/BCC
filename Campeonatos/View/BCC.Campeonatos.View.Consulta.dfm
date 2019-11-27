inherited FrmConsultaCampeonato: TFrmConsultaCampeonato
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Campeonato'
          Width = 420
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Jogo'
          Width = 420
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT '
      '  C.ID_Campeonato,'
      '  C.Identificacao AS Campeonato,'
      '  C.Estado AS Estado,'
      '  J.Identificacao AS Jogo'
      'FROM Campeonatos C'
      '  LEFT JOIN Jogos J ON C.ID_Jogo = J.ID_Jogo')
    object QryConsultaID_Campeonato: TAutoIncField
      FieldName = 'ID_Campeonato'
      ReadOnly = True
    end
    object QryConsultaEstado: TIntegerField
      FieldName = 'Estado'
    end
    object QryConsultaJogo: TStringField
      FieldName = 'Jogo'
      Size = 100
    end
    object QryConsultaCampeonato: TStringField
      FieldName = 'Campeonato'
      Size = 100
    end
  end
end
