inherited FrmConsultaServico: TFrmConsultaServico
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 710
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor'
          Title.Alignment = taCenter
          Width = 120
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT * FROM Servicos')
    object QryConsultaID_Servico: TAutoIncField
      FieldName = 'ID_Servico'
      ReadOnly = True
    end
    object QryConsultaNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object QryConsultaValor: TFloatField
      FieldName = 'Valor'
      DisplayFormat = '###0.00'
    end
  end
end
