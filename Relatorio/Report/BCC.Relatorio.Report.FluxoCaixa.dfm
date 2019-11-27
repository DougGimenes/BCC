object RelFluxoCaixa: TRelFluxoCaixa
  Left = 0
  Top = 0
  Caption = 'RelFluxoCaixa'
  ClientHeight = 488
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RlrFluxoCaixa: TRLReport
    Left = 8
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
        Left = 161
        Top = 30
        Width = 396
        Height = 29
        Caption = 'RELAT'#211'RIO DE FLUXO DE CAIXA'
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
      object RdtTipo: TRLDBText
        Left = 3
        Top = 2
        Width = 35
        Height = 18
        DataField = 'Tipo'
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
      object RdtValor: TRLDBText
        Left = 674
        Top = 3
        Width = 41
        Height = 18
        Alignment = taRightJustify
        DataField = 'Valor'
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
      object RllTipo: TRLLabel
        Left = 3
        Top = 6
        Width = 178
        Height = 19
        Caption = 'Natureza da opera'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RllValor: TRLLabel
        Left = 603
        Top = 6
        Width = 46
        Height = 19
        Caption = 'Valor'
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
        Left = 628
        Top = 6
        Width = 87
        Height = 18
        Alignment = taRightJustify
        DataField = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        Info = riSum
        ParentFont = False
        Text = ''
      end
      object RllValorFinal: TRLLabel
        Left = 436
        Top = 6
        Width = 94
        Height = 19
        Caption = 'Valor Final:'
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
