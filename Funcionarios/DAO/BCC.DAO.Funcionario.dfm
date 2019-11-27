object DmFuncionario: TDmFuncionario
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbFuncionario: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Funcionarios')
    Left = 88
    Top = 56
    object TbFuncionarioID_Func: TAutoIncField
      FieldName = 'ID_Func'
      ReadOnly = True
    end
    object TbFuncionarioNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object TbFuncionarioCPF: TStringField
      FieldName = 'CPF'
    end
    object TbFuncionarioFunção: TIntegerField
      FieldName = 'Fun'#231#227'o'
    end
    object TbFuncionarioAtivo: TBooleanField
      FieldName = 'Ativo'
    end
  end
end
