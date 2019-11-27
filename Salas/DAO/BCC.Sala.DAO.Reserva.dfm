object DmReserva: TDmReserva
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbReserva: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Reserva')
    Left = 88
    Top = 56
    object TbReservaID_Reserva: TAutoIncField
      FieldName = 'ID_Reserva'
      ReadOnly = True
    end
    object TbReservaID_Sala: TIntegerField
      FieldName = 'ID_Sala'
    end
    object TbReservaID_Cliente: TIntegerField
      FieldName = 'ID_Cliente'
    end
    object TbReservaDataHora: TDateTimeField
      FieldName = 'DataHora'
    end
    object TbReservaTempo: TDateTimeField
      FieldName = 'Tempo'
    end
  end
end
