object DmUsuario: TDmUsuario
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbUsuario: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Usuarios'
      'WHERE -1 = 1')
    Left = 88
    Top = 56
    object TbUsuarioID_User: TAutoIncField
      FieldName = 'ID_User'
      ReadOnly = True
    end
    object TbUsuarioID_Func: TIntegerField
      FieldName = 'ID_Func'
    end
    object TbUsuarioID_Cliente: TIntegerField
      FieldName = 'ID_Cliente'
    end
    object TbUsuarioUsuario: TStringField
      FieldName = 'Usuario'
      Size = 100
    end
    object TbUsuarioSenha: TStringField
      FieldName = 'Senha'
      Size = 100
    end
    object TbUsuarioAtivo: TBooleanField
      FieldName = 'Ativo'
    end
  end
end
