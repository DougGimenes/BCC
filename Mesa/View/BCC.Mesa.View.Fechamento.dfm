inherited FrmFechaMesa: TFrmFechaMesa
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 306
  ClientWidth = 500
  OnCreate = FormCreate
  ExplicitWidth = 506
  ExplicitHeight = 335
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlMain: TPanel
    Width = 500
    Height = 306
    ExplicitTop = -8
    ExplicitWidth = 500
    ExplicitHeight = 327
    object LblFormaPagto: TLabel
      Left = 138
      Top = 19
      Width = 102
      Height = 19
      Caption = 'Forma Pagto.'
    end
    object CmbPagamento: TComboBox
      Left = 138
      Top = 41
      Width = 110
      Height = 27
      Style = csDropDownList
      TabOrder = 0
      OnChange = CmbPagamentoChange
      Items.Strings = (
        'Dinheiro'
        'D'#233'bito'
        'Cr'#233'dito')
    end
    object BtnFecharMesa: TButton
      Left = 148
      Top = 264
      Width = 200
      Height = 33
      Caption = 'Fechar Mesa'
      Enabled = False
      TabOrder = 1
      OnClick = BtnFecharMesaClick
    end
    object DbgTitulos: TDBGrid
      Left = 25
      Top = 103
      Width = 450
      Height = 155
      DataSource = DsTitulos
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'Valor'
          Title.Alignment = taCenter
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Pago'
          Title.Alignment = taCenter
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Troco'
          Title.Alignment = taCenter
          Width = 100
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'FormaString'
          Title.Alignment = taCenter
          Title.Caption = 'Forma Pagto.'
          Width = 120
          Visible = True
        end>
    end
    object LedValor: TLabeledEdit
      Left = 25
      Top = 41
      Width = 104
      Height = 25
      EditLabel.Width = 39
      EditLabel.Height = 19
      EditLabel.Caption = 'Valor'
      TabOrder = 3
      OnExit = LedValorExit
    end
    object LedPago: TLabeledEdit
      Left = 258
      Top = 41
      Width = 104
      Height = 25
      EditLabel.Width = 40
      EditLabel.Height = 19
      EditLabel.Caption = 'Pago'
      ReadOnly = True
      TabOrder = 4
      OnChange = LedPagoChange
    end
    object LedTroco: TLabeledEdit
      Left = 371
      Top = 41
      Width = 104
      Height = 25
      EditLabel.Width = 44
      EditLabel.Height = 19
      EditLabel.Caption = 'Troco'
      ReadOnly = True
      TabOrder = 5
    end
    object BtnAddForma: TButton
      Left = 315
      Top = 72
      Width = 160
      Height = 25
      Caption = 'Adicionar Pagto.'
      TabOrder = 6
      OnClick = BtnAddFormaClick
    end
  end
  object MtbTitulos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 72
    Top = 160
    object MtbTitulosValor: TFloatField
      FieldName = 'Valor'
    end
    object MtbTitulosPago: TFloatField
      FieldName = 'Pago'
    end
    object MtbTitulosTroco: TFloatField
      FieldName = 'Troco'
    end
    object MtbTitulosFormaPagto: TIntegerField
      FieldName = 'FormaPagto'
    end
    object MtbTitulosFormaString: TStringField
      FieldName = 'FormaString'
    end
  end
  object DsTitulos: TDataSource
    DataSet = MtbTitulos
    Left = 72
    Top = 208
  end
end
