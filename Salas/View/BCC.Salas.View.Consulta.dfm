inherited FrmConsultaSala: TFrmConsultaSala
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Identifiacacao'
          Title.Caption = 'Identifiaca'#231#227'o'
          Width = 700
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Num_Pessoas'
          Title.Caption = 'Max. Pessoas'
          Width = 120
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT * FROM Sala')
    object QryConsultaID_Sala: TAutoIncField
      FieldName = 'ID_Sala'
      ReadOnly = True
    end
    object QryConsultaIdentifiacacao: TStringField
      FieldName = 'Identifiacacao'
      Size = 100
    end
    object QryConsultaNum_Pessoas: TIntegerField
      FieldName = 'Num_Pessoas'
    end
    object QryConsultaAtivo: TBooleanField
      FieldName = 'Ativo'
    end
  end
end
