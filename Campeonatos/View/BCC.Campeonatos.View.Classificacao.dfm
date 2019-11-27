inherited FrmClassificacaoCampeonato: TFrmClassificacaoCampeonato
  Width = 964
  Height = 453
  ExplicitWidth = 451
  ExplicitHeight = 305
  inherited PnlMain: TPanel
    Width = 964
    Height = 453
    ExplicitLeft = -3
    ExplicitTop = 0
    ExplicitWidth = 964
    ExplicitHeight = 453
    object LblTitulo: TLabel
      Left = 266
      Top = 40
      Width = 431
      Height = 32
      Anchors = [akTop]
      Caption = 'Classifica'#231#227'o do Campeonato ##'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBGrid1: TDBGrid
      Left = 126
      Top = 96
      Width = 712
      Height = 321
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DsClassificacao
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -16
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Pontuacao'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Patidas'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Vitorias'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Empates'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Derrotas'
          Visible = True
        end>
    end
  end
  object MtbClassificacao: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 560
    Top = 112
    object MtbClassificacaoNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object MtbClassificacaoPontuacao: TIntegerField
      FieldName = 'Pontuacao'
    end
    object MtbClassificacaoPatidas: TIntegerField
      FieldName = 'Patidas'
    end
    object MtbClassificacaoVitorias: TIntegerField
      FieldName = 'Vitorias'
    end
    object MtbClassificacaoEmpates: TIntegerField
      FieldName = 'Empates'
    end
    object MtbClassificacaoDerrotas: TIntegerField
      FieldName = 'Derrotas'
    end
  end
  object DsClassificacao: TDataSource
    DataSet = MtbClassificacao
    Left = 456
    Top = 112
  end
end
