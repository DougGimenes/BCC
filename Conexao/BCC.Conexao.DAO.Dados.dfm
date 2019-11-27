object DmDados: TDmDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 88
  Width = 97
  object AcoConexao: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=segredo902;Persist Security Info=Tr' +
      'ue;User ID=Douglas;Initial Catalog=BCC_TESTE;Data Source=DOUGLAS' +
      '-PC\BCCSQL'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 24
  end
end
