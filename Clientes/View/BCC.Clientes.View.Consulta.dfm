inherited FrmConsultaCliente: TFrmConsultaCliente
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 830
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT '
      '  ID_Cliente, '
      '  Nome, '
      '  CPF, '
      '  Ativo '
      'FROM Cliente')
    object QryConsultaID_Cliente: TAutoIncField
      FieldName = 'ID_Cliente'
      ReadOnly = True
    end
    object QryConsultaNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object QryConsultaCPF: TStringField
      FieldName = 'CPF'
    end
    object QryConsultaAtivo: TBooleanField
      FieldName = 'Ativo'
    end
  end
end
