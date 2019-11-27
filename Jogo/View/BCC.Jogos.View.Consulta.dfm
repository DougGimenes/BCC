inherited FrmConsultaJogo: TFrmConsultaJogo
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Identificacao'
          Title.Caption = 'Identifica'#231#227'o'
          Width = 600
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Num_Copias'
          Title.Caption = 'N'#250'm. C'#243'pias'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Num_Pessoas'
          Title.Caption = 'Max. Jogadores'
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT * FROM Jogos')
    object QryConsultaID_Jogo: TAutoIncField
      FieldName = 'ID_Jogo'
      ReadOnly = True
    end
    object QryConsultaIdentificacao: TStringField
      FieldName = 'Identificacao'
      Size = 100
    end
    object QryConsultaNum_Copias: TIntegerField
      FieldName = 'Num_Copias'
    end
    object QryConsultaAtivo: TBooleanField
      FieldName = 'Ativo'
    end
    object QryConsultaNum_Pessoas: TIntegerField
      FieldName = 'Num_Pessoas'
    end
  end
  inherited QryAutoComplete: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT TOP 1 Identificacao FROM Jogos')
    object QryAutoCompleteIdentificacao: TStringField
      FieldName = 'Identificacao'
      Size = 100
    end
  end
end
