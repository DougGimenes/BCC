object DmCliente: TDmCliente
  OldCreateOrder = False
  Height = 150
  Width = 215
  object TbCliente: TADOQuery
    Connection = DmDados.AcoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Cliente'
      'WHERE -1 = 1')
    Left = 88
    Top = 56
    object TbClienteID_Cliente: TIntegerField
      FieldName = 'ID_Cliente'
    end
    object TbClienteNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object TbClienteNascimento: TDateTimeField
      FieldName = 'Nascimento'
    end
    object TbClienteAtivo: TBooleanField
      FieldName = 'Ativo'
    end
    object TbClienteCPF: TStringField
      FieldName = 'CPF'
    end
    object TbClienteEndereco: TStringField
      FieldName = 'Endereco'
      Size = 100
    end
    object TbClienteBairro: TStringField
      FieldName = 'Bairro'
      Size = 100
    end
    object TbClienteNumero: TStringField
      FieldName = 'Numero'
      Size = 10
    end
    object TbClienteTelefone: TStringField
      FieldName = 'Telefone'
      Size = 11
    end
    object TbClienteEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
  end
end
