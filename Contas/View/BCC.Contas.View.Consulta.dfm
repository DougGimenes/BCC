inherited FrmConsultaConta: TFrmConsultaConta
  Caption = 'Board Caf'#233' Control'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 650
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Vencimento'
          Title.Alignment = taCenter
          Width = 180
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT Codigo, Nome, Vencimento FROM Contas')
    object QryConsultaCodigo: TAutoIncField
      FieldName = 'Codigo'
      ReadOnly = True
    end
    object QryConsultaNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object QryConsultaVencimento: TDateTimeField
      FieldName = 'Vencimento'
      DisplayFormat = 'dd/mm/yyyy'
    end
  end
end
