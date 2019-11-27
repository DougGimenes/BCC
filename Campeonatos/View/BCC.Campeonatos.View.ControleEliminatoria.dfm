inherited FraControleCampeonatoEliminatoria: TFraControleCampeonatoEliminatoria
  Width = 960
  Height = 431
  inherited PnlMain: TPanel
    Width = 960
    Height = 431
    inherited DbgCompetidores: TDBGrid
      Left = 79
      Top = 32
      Height = 321
      Columns = <
        item
          Expanded = False
          FieldName = 'Cliente'
          Title.Caption = 'Jogador'
          Width = 505
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Partidas'
          Title.Alignment = taCenter
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Estado'
          Title.Alignment = taCenter
          Width = 150
          Visible = True
        end>
    end
    inherited EdtFiltro: TEdit
      Left = 79
      Top = 375
      ExplicitLeft = 79
      ExplicitTop = 375
    end
  end
  inherited QryCompetidores: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT '
      '  cli.Nome AS Cliente,'
      '  cli.ID_Cliente,'
      '  comp.Partidas,'
      '  CASE'
      '    WHEN (comp.Derrotas > 0) THEN '#39'Eliminado'#39
      '    ELSE '#39'Competindo'#39' '
      '  END AS Estado,'
      '  comp.ID_Comp'
      'FROM Competidores_Campeonato comp'
      '  LEFT JOIN Cliente cli ON cli.ID_Cliente = comp.ID_Cliente')
    object QryCompetidoresCliente: TStringField
      FieldName = 'Cliente'
      Size = 100
    end
    object QryCompetidoresID_Cliente: TAutoIncField
      FieldName = 'ID_Cliente'
      ReadOnly = True
    end
    object QryCompetidoresPartidas: TIntegerField
      FieldName = 'Partidas'
    end
    object QryCompetidoresEstado: TStringField
      FieldName = 'Estado'
      ReadOnly = True
      Size = 10
    end
    object QryCompetidoresID_Comp: TAutoIncField
      FieldName = 'ID_Comp'
      ReadOnly = True
    end
  end
end
