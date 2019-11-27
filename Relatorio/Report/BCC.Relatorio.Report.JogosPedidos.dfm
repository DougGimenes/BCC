object RelJogoSolicitado: TRelJogoSolicitado
  Left = 0
  Top = 0
  Caption = 'RelJogoSolicitado'
  ClientHeight = 525
  ClientWidth = 830
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RlrJogosSolicitados: TRLReport
    Left = 20
    Top = 8
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    PreviewOptions.Position = poOwnerFormCenter
    PreviewOptions.Caption = 'Board Caf'#233' Control'
    object RlbCabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 107
      BandType = btHeader
      object RllTitulo: TRLLabel
        Left = 135
        Top = 30
        Width = 448
        Height = 29
        Caption = 'RELAT'#211'RIO DE JOGOS SOLICITADOS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RllData: TRLLabel
        Left = 3
        Top = 82
        Width = 39
        Height = 19
        Caption = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RlConteudo: TRLBand
      Left = 38
      Top = 177
      Width = 718
      Height = 27
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object RdtJogo: TRLDBText
        Left = 3
        Top = 2
        Width = 39
        Height = 20
        DataField = 'Jogo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RldSeparador2: TRLDraw
        Left = 536
        Top = -2
        Width = 1
        Height = 29
      end
      object RdtVezes: TRLDBText
        Left = 536
        Top = 2
        Width = 186
        Height = 20
        Alignment = taCenter
        AutoSize = False
        DataField = 'Vezes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
    end
    object RlbTitulos: TRLBand
      Left = 38
      Top = 145
      Width = 718
      Height = 32
      BandType = btTitle
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object RllJogo: TRLLabel
        Left = 3
        Top = 6
        Width = 44
        Height = 19
        Caption = 'Jogo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RllQuantidade: TRLLabel
        Left = 563
        Top = 7
        Width = 134
        Height = 19
        Caption = 'Vezes Solicitado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RldSeparador1: TRLDraw
        Left = 536
        Top = -2
        Width = 1
        Height = 34
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 204
      Width = 718
      Height = 29
      BandType = btSummary
      object RdrVezes: TRLDBResult
        Left = 536
        Top = 7
        Width = 56
        Height = 18
        DataField = 'Jogo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        Info = riCount
        ParentFont = False
        Text = ''
      end
      object RllCount: TRLLabel
        Left = 380
        Top = 6
        Width = 150
        Height = 19
        Caption = 'N'#250'mero de Jogos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
end
