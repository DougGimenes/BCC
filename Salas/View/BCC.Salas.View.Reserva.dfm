inherited FrmReservaSala: TFrmReservaSala
  OnResize = FrameResize
  inherited PnlMain: TPanel
    Width = 451
    Height = 305
    object PnlCentro: TPanel
      Left = 56
      Top = 65
      Width = 721
      Height = 463
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        721
        463)
      object LblTitulo: TLabel
        Left = 273
        Top = 5
        Width = 225
        Height = 32
        Anchors = [akTop, akRight]
        Caption = 'Reserva de Salas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ClvAgenda: TCalendarView
        Left = 12
        Top = 38
        Width = 255
        Height = 283
        Date = 43725.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
        HeaderInfo.DaysOfWeekFont.Color = clWindowText
        HeaderInfo.DaysOfWeekFont.Height = -13
        HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
        HeaderInfo.DaysOfWeekFont.Style = []
        HeaderInfo.Font.Charset = DEFAULT_CHARSET
        HeaderInfo.Font.Color = clWindowText
        HeaderInfo.Font.Height = -20
        HeaderInfo.Font.Name = 'Segoe UI'
        HeaderInfo.Font.Style = []
        OnClick = ClvAgendaClick
        ParentFont = False
        TabOrder = 0
      end
      object DbgAgenda: TDBGrid
        Left = 12
        Top = 327
        Width = 303
        Height = 122
        DataSource = DsAgenda
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'Sala'
            Width = 180
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Hora'
            Title.Alignment = taCenter
            Width = 100
            Visible = True
          end>
      end
      object PnlConteudo: TPanel
        Left = 343
        Top = 0
        Width = 378
        Height = 463
        Align = alRight
        BevelOuter = bvNone
        Caption = 'PnlConteudo'
        ShowCaption = False
        TabOrder = 2
        DesignSize = (
          378
          463)
        object LblData: TLabel
          Left = 53
          Top = 114
          Width = 108
          Height = 19
          Anchors = [akTop, akRight]
          Caption = 'Data desejada'
        end
        object LblHora: TLabel
          Left = 51
          Top = 148
          Width = 110
          Height = 19
          Anchors = [akTop, akRight]
          Caption = 'Hora desejada'
        end
        object LblTempo: TLabel
          Left = 118
          Top = 180
          Width = 43
          Height = 19
          Anchors = [akTop, akRight]
          Caption = 'Sa'#237'da'
        end
        object BtnCancelar: TButton
          Left = 164
          Top = 276
          Width = 88
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Cancelar'
          TabOrder = 0
          OnClick = BtnCancelarClick
        end
        object BtnSalvar: TButton
          Left = 258
          Top = 276
          Width = 80
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Salvar'
          TabOrder = 1
          OnClick = BtnSalvarClick
        end
        object LedCliente: TLabeledEdit
          Left = 164
          Top = 210
          Width = 174
          Height = 27
          Anchors = [akTop, akRight]
          EditLabel.Width = 53
          EditLabel.Height = 19
          EditLabel.Caption = 'Cliente'
          LabelPosition = lpLeft
          TabOrder = 2
          OnKeyDown = LedClienteKeyDown
        end
        object LedSala: TLabeledEdit
          Left = 164
          Top = 243
          Width = 174
          Height = 27
          Anchors = [akTop, akRight]
          EditLabel.Width = 33
          EditLabel.Height = 19
          EditLabel.Caption = 'Sala'
          LabelPosition = lpLeft
          TabOrder = 3
          OnKeyDown = LedSalaKeyDown
        end
        object DtpHora: TDateTimePicker
          Left = 164
          Top = 144
          Width = 174
          Height = 27
          Anchors = [akTop, akRight]
          Date = 43718.000000000000000000
          Time = 0.812688715275726300
          Kind = dtkTime
          TabOrder = 4
        end
        object DtpReserva: TDateTimePicker
          Left = 164
          Top = 112
          Width = 174
          Height = 27
          Anchors = [akTop, akRight]
          BevelOuter = bvNone
          Date = 43591.000000000000000000
          Time = 0.850779247688478800
          TabOrder = 5
        end
        object DtpSaida: TDateTimePicker
          Left = 167
          Top = 177
          Width = 174
          Height = 27
          Anchors = [akTop, akRight]
          Date = 43718.000000000000000000
          Time = 0.812688715275726300
          Kind = dtkTime
          TabOrder = 6
        end
      end
    end
    object PnlBotoes: TPanel
      Left = 0
      Top = 0
      Width = 451
      Height = 59
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object BimHelp: TImage
        Left = 319
        Top = 19
        Width = 24
        Height = 24
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000400000
          004008030000009DB781EC0000000373424954080808DBE14FE0000000097048
          5973000001C9000001C901610F545C0000001974455874536F66747761726500
          7777772E696E6B73636170652E6F72679BEE3C1A000001C5504C5445FFFFFF00
          AAAA1AB3CC2BBFD526B3D021B5D626B7D525B9D324B7D524B6D326B8D425B8D3
          24B6D425B6D325B7D326B7D225B7D326B7D424B8D426B7D325B7D324B7D325B7
          D325B7D325B7D225B7D325B7D325B7D325B7D325B7D325B7D326B7D327B8D328
          B8D429B8D42BB9D42DBAD52EBAD52FBAD530BBD531BBD534BCD637BDD739BDD7
          3BBED73CBFD83DBFD83EBFD83FBFD843C1D944C1D945C1D94AC3DA4BC3DB4CC4
          DB4DC4DB4FC5DB50C5DC51C5DC52C6DC54C7DC58C8DD59C8DE5AC9DE5BC9DE5C
          C9DE5DC9DE5DCADE5ECADF5FCADF60CADF61CBDF63CCE067CDE069CDE16ACEE1
          6BCEE16ECFE270D0E271D0E273D1E375D1E375D2E376D2E37BD4E47CD4E57DD4
          E57ED4E580D5E585D7E689D8E78BD9E88CD9E88DD9E891DBE995DCEA97DDEA9E
          DFEC9FDFECA1E0ECA2E0ECA6E2EDA9E2EEAAE3EEABE3EEACE4EEAFE5EFB1E5EF
          B2E6EFB8E8F1BEEAF2BFEAF2C1EAF2C1EBF3C3EBF3C7ECF4C7EDF4CBEEF4CDEE
          F5CFEFF5D1F0F6D2F0F6D4F1F6D7F2F7D8F2F7DAF3F8DBF3F8DCF3F8DDF4F8E3
          F6F9E4F6F9E4F6FAE6F7FAE9F8FBEAF8FBECF9FBEDF9FBEFFAFCF0FAFCF2FBFC
          F4FBFDF5FCFDF7FCFDF8FDFEF9FDFEFAFDFEFBFEFEFCFEFEFDFEFFFEFFFFFFFF
          FF2FE43E740000001E74524E5300030A0C1B1F3C4C4E62646870748A8EA4B0B6
          BEC0CBD5D8E5EAF2F8F9FE6DF304EA000003B94944415478DAA557D94F134118
          9F694B4BA1B495720826A26204832612052F10954488D108890F184C7C3151A3
          26FA87F8E003F1C507128278261E515E50413C50131320814414E4C672755B4A
          EFAEEDCEB4ECCCCE6C6BF6F7B0DFECCCF7FBEDCEF5CD371070A0CF30E8747A83
          1E44C29168341C8A70FC20B3D6603299F5444DC4170884D314D0656766B27445
          BFDF1B4D2D00CD5623AF5B20E8F68929044CB64CA006BF105013C8B065815458
          17425C01A32323251F80D07290236076E8D2E003105DF6B104A0D596163D0EC1
          2D2A04A03D276D3E001E97480BD818DF37DAEC76A357700BCA2524089480399F
          7631EDDDB11DB77A27267E86A8E6451F21602CA0C6CF78ACC22C7F770FFCA046
          D219940964E451F357DC5840FFD1D8BB55E23DB414DA10C8A3D6CF813AC68258
          7CEC21DED7979202A642D2B5B4D9C01AFA99673EE2FD6F000BC07C72FDE7B558
          921F59F35B1C8E44C36037E1E75F149140561EF9A5E6325C18EEF5C6CDFE6A3C
          C5E1FB2EC271695D12D01590FBB7E8122E7CEAC7056B2B56F8FE96F00C3AA371
          819C4DE40F9CAD4076FC69327CEC3E87EC423BE9BAEA890BE49BC9DACBB847ED
          0B1B7557D047FC77C978E25B8C09188AA898701BADA989478C61B92710BEE27C
          18826C0751076CD790ED1E94555E2841B68D5C0A60D90B41AE85AC0357EDF1E7
          5497EC6FB3AEA3181DB94345D5B515A8DFACA704F69C8EF541EC9A92559D3888
          EC7427E51B5980998A450F4AAAECB3A37F6415BB9AF056EB1DA07D9DD0920B52
          A1BC01CFD37C57906E5B81567B2A7E653DDE19FE074E45A30BDAAD29F8476A13
          D3FCFEABB2D50D1DD9EAFC9A9A44895AC7085E586852E51F3F94287DE963B507
          60B1418D5F7B1417227DDF980E617581C28B3832057B86004740AD0BBA96ADA8
          E07BFD8BE312501DC4AA7ACC7F3EC973F1AA4E6343A564C457235C17B7EA426A
          D92699A1377C1797EA52BE89BAD739CD7759616DA6042C375037DBA27C012763
          3B27A1BF254DE2E80B3E3FB69D950165034DE5F121EC98E30BC4028A22A4C990
          7BA61804867BF87C29A4D14195E8448965CCA7C29782AA22ACFF07A4B0AE3858
          0840514D001D2CF4D126635795150893FD7E1E1F1F6D8AC33589C67DF1E75C57
          88D38E0F57C5F19EC0CEF3C87EFEC0E6278F7745828171B21AD9DF4FD802C904
          4399E220E0CD08663B987C598AA34CB2241CAE4376E4258B4F2459CA342F8EEC
          5669A7861FCE30F8649AC74A3463D8722A36389E8F838C263AD164A7BAC050EA
          F08C7B597C45AAAB3DD9D69CEE03CD170EA0FDCAA3FDD205345FFB80F68B27D0
          7CF595A0EDF28D90EEF5FF1F77103242BB9197450000000049454E44AE426082}
        Stretch = True
        OnClick = BimHelpClick
      end
      object BtnNovo: TButton
        Left = 17
        Top = 18
        Width = 83
        Height = 25
        Caption = 'Agendar'
        TabOrder = 0
        OnClick = BtnNovoClick
      end
      object BtnEditar: TButton
        Left = 106
        Top = 18
        Width = 98
        Height = 25
        Caption = 'Reagendar'
        Enabled = False
        TabOrder = 1
        OnClick = BtnEditarClick
      end
      object BtnConsultar: TButton
        Left = 210
        Top = 18
        Width = 103
        Height = 25
        Caption = 'Consultar'
        TabOrder = 2
        OnClick = BtnConsultarClick
      end
    end
  end
  object MtbAgenda: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 168
    Top = 432
    object MtbAgendaSala: TStringField
      FieldName = 'Sala'
      Size = 100
    end
    object MtbAgendaHora: TTimeField
      FieldName = 'Hora'
    end
  end
  object DsAgenda: TDataSource
    DataSet = MtbAgenda
    Left = 104
    Top = 432
  end
end
