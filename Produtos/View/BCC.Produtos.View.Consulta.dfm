inherited FrmConsultaProduto: TFrmConsultaProduto
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 450
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Estoque'
          Title.Alignment = taCenter
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Preco_Custo'
          Title.Alignment = taCenter
          Title.Caption = 'Pre'#231'o de Custo'
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Preco_Venda'
          Title.Alignment = taCenter
          Title.Caption = 'Pre'#231'o de Venda'
          Width = 140
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT * FROM PRODUTO')
    object QryConsultaNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object QryConsultaEstoque: TFloatField
      FieldName = 'Estoque'
      DisplayFormat = '#,##0.00'
    end
    object QryConsultaPreco_Custo: TFloatField
      FieldName = 'Preco_Custo'
      DisplayFormat = '#,##0.00'
    end
    object QryConsultaPreco_Venda: TFloatField
      FieldName = 'Preco_Venda'
      DisplayFormat = '#,##0.00'
    end
    object QryConsultaID_Prod: TAutoIncField
      FieldName = 'ID_Prod'
      ReadOnly = True
    end
  end
end
