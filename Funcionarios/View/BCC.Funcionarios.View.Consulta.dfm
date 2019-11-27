inherited FrmConsultaFuncionario: TFrmConsultaFuncionario
  Caption = 'FrmConsultaFuncionario'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 680
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CPF'
          Width = 160
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT * FROM Funcionarios')
    object QryConsultaNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object QryConsultaCPF: TStringField
      FieldName = 'CPF'
    end
    object QryConsultaID_Func: TAutoIncField
      FieldName = 'ID_Func'
      ReadOnly = True
    end
  end
end
