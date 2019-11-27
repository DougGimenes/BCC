object RelProdutosVendidos: TRelProdutosVendidos
  Left = 0
  Top = 0
  Caption = 'RelProdutosVendidos'
  ClientHeight = 437
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
        Left = 129
        Top = 30
        Width = 459
        Height = 29
        Caption = 'RELAT'#211'RIO DE PRODUTOS VENDIDOS'
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
      object RdtDescricao: TRLDBText
        Left = 3
        Top = 3
        Width = 76
        Height = 18
        DataField = 'Descricao'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RldSeparador2: TRLDraw
        Left = 587
        Top = -2
        Width = 1
        Height = 29
      end
      object RdtValor: TRLDBText
        Left = 640
        Top = 3
        Width = 75
        Height = 18
        Alignment = taRightJustify
        DataField = 'ValorTotal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDraw2: TRLDraw
        Left = 436
        Top = -3
        Width = 1
        Height = 29
      end
      object RdtQtde: TRLDBText
        Left = 484
        Top = 3
        Width = 97
        Height = 18
        Alignment = taRightJustify
        DataField = 'QtdeVendida'
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
      object RllDescricao: TRLLabel
        Left = 3
        Top = 7
        Width = 83
        Height = 19
        Caption = 'Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RllValor: TRLLabel
        Left = 625
        Top = 7
        Width = 90
        Height = 19
        Caption = 'Valor Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RldSeparador1: TRLDraw
        Left = 436
        Top = -2
        Width = 1
        Height = 34
      end
      object RLDraw1: TRLDraw
        Left = 587
        Top = -4
        Width = 1
        Height = 34
      end
      object RllQtdeVendida: TRLLabel
        Left = 465
        Top = 7
        Width = 116
        Height = 19
        Caption = 'Qtde. Vendida'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 204
      Width = 718
      Height = 29
      BandType = btSummary
      object RdrVezes: TRLDBResult
        Left = 593
        Top = 6
        Width = 121
        Height = 18
        Alignment = taRightJustify
        DataField = 'ValorTotal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        Info = riSum
        ParentFont = False
        Text = ''
      end
      object RdrQtde: TRLDBResult
        Left = 438
        Top = 6
        Width = 143
        Height = 18
        Alignment = taRightJustify
        DataField = 'QtdeVendida'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        Info = riSum
        ParentFont = False
        Text = ''
      end
    end
  end
end
