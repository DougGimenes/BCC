inherited FrmConsultaRegraPromocao: TFrmConsultaRegraPromocao
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Top = 49
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 580
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Tipo'
          Title.Alignment = taCenter
          Width = 250
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT '
      '  Codigo, '
      '  Nome, '
      '  CASE Tipo'
      '    WHEN 0 THEN '#39'Dia da Semana'#39
      '    WHEN 1 THEN '#39'Data'#39
      '    WHEN 2 THEN '#39'Quantidade M'#237'nima'#39
      '  END AS Tipo'
      'FROM Regras_Promocao')
    object QryConsultaCodigo: TAutoIncField
      FieldName = 'Codigo'
      ReadOnly = True
    end
    object QryConsultaNome: TStringField
      FieldName = 'Nome'
      Size = 200
    end
    object QryConsultaTipo: TStringField
      FieldName = 'Tipo'
      ReadOnly = True
      Size = 17
    end
  end
  inherited QryAutoComplete: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT Nome FROM Regras_Promocao')
    object QryAutoCompleteNome: TStringField
      FieldName = 'Nome'
      Size = 200
    end
  end
end
