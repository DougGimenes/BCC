object RelVendasDia: TRelVendasDia
  Left = 0
  Top = 0
  Caption = 'RelVendasDia'
  ClientHeight = 374
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
        Left = 212
        Top = 30
        Width = 293
        Height = 29
        Caption = 'RELAT'#211'RIO DE VENDAS'
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
      object RdtCodigo: TRLDBText
        Left = 2
        Top = 3
        Width = 82
        Height = 18
        Alignment = taCenter
        DataField = 'ID_Vendas'
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
      object RdtMedia: TRLDBText
        Left = 667
        Top = 3
        Width = 48
        Height = 18
        Alignment = taRightJustify
        DataField = 'Media'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDraw2: TRLDraw
        Left = 92
        Top = -3
        Width = 1
        Height = 29
      end
      object RdtIdentificacao: TRLDBText
        Left = 98
        Top = 3
        Width = 92
        Height = 18
        DataField = 'Identificacao'
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
      object RllCodigo: TRLLabel
        Left = 13
        Top = 7
        Width = 61
        Height = 19
        Caption = 'Codigo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RllValor: TRLLabel
        Left = 618
        Top = 7
        Width = 97
        Height = 19
        Caption = 'Valor M'#233'dio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RldSeparador1: TRLDraw
        Left = 92
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
      object RllIdentificacao: TRLLabel
        Left = 98
        Top = 7
        Width = 103
        Height = 19
        Caption = 'Identifica'#231#227'o'
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
      object RdrQtde: TRLDBResult
        Left = 436
        Top = 6
        Width = 152
        Height = 18
        Alignment = taCenter
        AutoSize = False
        DataField = 'Vendas'
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
