inherited FrmConsultaReserva: TFrmConsultaReserva
  Caption = 'FrmConsultaReserva'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    inherited DbgConsulta: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'Sala'
          Width = 320
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Cliente'
          Width = 360
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DataHora'
          Title.Alignment = taCenter
          Title.Caption = 'Data'
          Width = 150
          Visible = True
        end>
    end
  end
  inherited QryConsulta: TADOQuery
    CursorType = ctStatic
    SQL.Strings = (
      'SELECT '
      '  *'
      'FROM'
      '( SELECT '
      '    r.ID_Reserva,'
      '    r.ID_Sala,'
      '    r.ID_Cliente,'
      '    r.DataHora,'
      '    c.Nome AS Cliente,'
      '    s.Identifiacacao AS Sala'
      '  FROM Reserva r'
      '    LEFT JOIN Cliente c ON c.ID_Cliente = r.ID_Cliente'
      '    LEFT JOIN Sala s ON s.ID_Sala = r.ID_Sala'
      '  WHERE r.DataHora > GETDATE() - 1) AS Consulta')
    object QryConsultaID_Reserva: TAutoIncField
      FieldName = 'ID_Reserva'
      ReadOnly = True
    end
    object QryConsultaID_Sala: TIntegerField
      FieldName = 'ID_Sala'
    end
    object QryConsultaID_Cliente: TIntegerField
      FieldName = 'ID_Cliente'
    end
    object QryConsultaDataHora: TDateTimeField
      FieldName = 'DataHora'
    end
    object QryConsultaCliente: TStringField
      FieldName = 'Cliente'
      Size = 100
    end
    object QryConsultaSala: TStringField
      FieldName = 'Sala'
      Size = 100
    end
  end
end
