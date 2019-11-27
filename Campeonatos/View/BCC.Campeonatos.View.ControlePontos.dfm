inherited FraControleCampeonatoPontos: TFraControleCampeonatoPontos
  Width = 993
  Height = 451
  inherited PnlMain: TPanel
    Width = 993
    Height = 451
    inherited DbgCompetidores: TDBGrid
      Left = 100
      Top = 30
      Height = 341
      Columns = <
        item
          Expanded = False
          FieldName = 'Cliente'
          Title.Caption = 'Jogador'
          Width = 300
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Pontuacao'
          Title.Alignment = taCenter
          Title.Caption = 'Pontua'#231#227'o'
          Width = 90
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
          FieldName = 'Vitorias'
          Title.Alignment = taCenter
          Title.Caption = 'Vit'#243'rias'
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Empates'
          Title.Alignment = taCenter
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Derrotas'
          Title.Alignment = taCenter
          Width = 90
          Visible = True
        end>
    end
    inherited EdtFiltro: TEdit
      Left = 159
      Top = 429
      ExplicitLeft = 159
      ExplicitTop = 429
    end
  end
  inherited QryCompetidores: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT '
      '  cli.Nome AS Cliente,'
      '  cli.ID_Cliente,'
      '  comp.Pontuacao,'
      '  comp.Partidas,'
      '  comp.Vitorias,'
      '  comp.Empates,'
      '  comp.Derrotas,'
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
    object QryCompetidoresPontuacao: TIntegerField
      FieldName = 'Pontuacao'
    end
    object QryCompetidoresPartidas: TIntegerField
      FieldName = 'Partidas'
    end
    object QryCompetidoresVitorias: TIntegerField
      FieldName = 'Vitorias'
    end
    object QryCompetidoresEmpates: TIntegerField
      FieldName = 'Empates'
    end
    object QryCompetidoresDerrotas: TIntegerField
      FieldName = 'Derrotas'
    end
    object QryCompetidoresID_Comp: TAutoIncField
      FieldName = 'ID_Comp'
      ReadOnly = True
    end
  end
end
