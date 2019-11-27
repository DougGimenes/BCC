inherited FrmConsultaMesa: TFrmConsultaMesa
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Identificacao'
          Title.Alignment = taCenter
          Title.Caption = 'Identifica'#231#227'o'
          Width = 415
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Cliente'
          Title.Alignment = taCenter
          Width = 305
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ValorTotal'
          Title.Alignment = taCenter
          Width = 100
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT'
      '  V.Id_Vendas,'
      '  V.Identificacao,'
      '  C.Nome AS Cliente,'
      '  V.Valor_Total AS ValorTotal,'
      '  V.Aberta'
      'FROM Vendas V'
      '  LEFT JOIN Cliente C ON C.ID_Cliente = V.ID_Cliente')
    object QryConsultaId_Vendas: TAutoIncField
      FieldName = 'Id_Vendas'
      ReadOnly = True
    end
    object QryConsultaIdentificacao: TStringField
      FieldName = 'Identificacao'
      Size = 100
    end
    object QryConsultaCliente: TStringField
      FieldName = 'Cliente'
      Size = 100
    end
    object QryConsultaValorTotal: TFloatField
      FieldName = 'ValorTotal'
    end
    object QryConsultaAberta: TBooleanField
      FieldName = 'Aberta'
    end
  end
  inherited QryAutoComplete: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT Identificacao FROM Vendas')
    object QryAutoCompleteIdentificacao: TStringField
      FieldName = 'Identificacao'
    end
  end
end
