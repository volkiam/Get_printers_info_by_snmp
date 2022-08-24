object Form1: TForm1
  Left = 192
  Top = 124
  Caption = 'GET Printer Info (SNMP)'
  ClientHeight = 292
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 25
    Height = 13
    Caption = 'Host:'
  end
  object Label2: TLabel
    Left = 8
    Top = 187
    Width = 77
    Height = 13
    Caption = 'Check one OID:'
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 54
    Height = 13
    Caption = 'Community:'
  end
  object Button1: TButton
    Left = 94
    Top = 83
    Width = 75
    Height = 25
    Caption = 'Get printer info'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 192
    Top = 16
    Width = 217
    Height = 233
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 47
    Top = 13
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '192.168.88.245'
  end
  object Edit2: TEdit
    Left = 8
    Top = 206
    Width = 161
    Height = 21
    TabOrder = 3
    Text = '1.3.6.1.2.1.1.5.0'
  end
  object Button2: TButton
    Left = 93
    Top = 233
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Edit3: TEdit
    Left = 68
    Top = 53
    Width = 100
    Height = 21
    TabOrder = 5
    Text = 'public'
  end
  object IdSNMP1: TIdSNMP
    ReceiveTimeout = 5000
    Community = 'public'
    Left = 272
    Top = 24
  end
end
