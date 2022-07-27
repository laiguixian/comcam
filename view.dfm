object viewForm: TviewForm
  Left = 249
  Top = 163
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #26597#30475#24405#20687
  ClientHeight = 649
  ClientWidth = 956
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel9: TPanel
    Left = 0
    Top = 0
    Width = 956
    Height = 649
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel3: TPanel
      Left = 0
      Top = 593
      Width = 956
      Height = 56
      Align = alBottom
      BevelOuter = bvNone
      Color = 15985881
      TabOrder = 0
      object SpeedButton2: TSpeedButton
        Left = 72
        Top = 24
        Width = 23
        Height = 22
        Hint = #21518#36864
        Caption = '<<'
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton2Click
      end
      object SpeedButton3: TSpeedButton
        Left = 104
        Top = 24
        Width = 23
        Height = 22
        Hint = #21069#36827
        Caption = '>>'
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton3Click
      end
      object SpeedButton4: TSpeedButton
        Left = 40
        Top = 24
        Width = 23
        Height = 22
        Hint = #25773#25918
        Caption = '>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton4Click
      end
      object SpeedButton5: TSpeedButton
        Left = 8
        Top = 24
        Width = 23
        Height = 22
        Hint = #26242#20572
        Caption = '||'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton5Click
      end
      object StopSBt: TSpeedButton
        Left = 136
        Top = 24
        Width = 23
        Height = 22
        Hint = #20572#27490
        Caption = #9632
        ParentShowHint = False
        ShowHint = True
        OnClick = StopSBtClick
      end
      object SpeedButton7: TSpeedButton
        Left = 619
        Top = 40
        Width = 17
        Height = 14
        Caption = #9679
      end
      object Label2: TLabel
        Left = 336
        Top = 40
        Width = 32
        Height = 13
        AutoSize = False
        Caption = '0'
      end
      object Label3: TLabel
        Left = 872
        Top = 43
        Width = 32
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0'
      end
      object Label6: TLabel
        Left = 296
        Top = 19
        Width = 25
        Height = 13
        AutoSize = False
        Caption = #24555#36864
      end
      object Label7: TLabel
        Left = 912
        Top = 19
        Width = 40
        Height = 13
        AutoSize = False
        Caption = #24555#36827
      end
      object SpeedButton11: TSpeedButton
        Left = 168
        Top = 24
        Width = 33
        Height = 22
        Hint = #25130#22270
        Caption = #25130#22270
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton11Click
      end
      object ScrollBar1: TScrollBar
        Left = 0
        Top = 0
        Width = 956
        Height = 17
        Align = alTop
        PageSize = 0
        TabOrder = 0
        OnChange = ScrollBar1Change
        OnScroll = ScrollBar1Scroll
      end
      object TrackBar1: TTrackBar
        Left = 328
        Top = 16
        Width = 585
        Height = 24
        Max = 41
        Position = 21
        TabOrder = 1
        OnChange = TrackBar1Change
      end
      object Button1: TButton
        Left = 144
        Top = 32
        Width = 33
        Height = 25
        Caption = #29366#24577
        TabOrder = 2
        Visible = False
        OnClick = Button1Click
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 173
      Height = 593
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Image2: TImage
        Left = 96
        Top = 400
        Width = 73
        Height = 57
        Stretch = True
        Visible = False
      end
      object ListBox1: TListBox
        Left = 0
        Top = 0
        Width = 173
        Height = 593
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = 15985881
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 24
        Items.Strings = (
          '00:00:00-01:00:00'
          '01:00:00-02:00:00'
          '02:00:00-03:00:00'
          '03:00:00-04:00:00'
          '04:00:00-05:00:00'
          '05:00:00-06:00:00'
          '06:00:00-07:00:00'
          '07:00:00-08:00:00'
          '08:00:00-09:00:00'
          '09:00:00-10:00:00'
          '10:00:00-11:00:00'
          '11:00:00-12:00:00'
          '12:00:00-13:00:00'
          '13:00:00-14:00:00'
          '14:00:00-15:00:00'
          '15:00:00-16:00:00'
          '16:00:00-17:00:00'
          '17:00:00-18:00:00'
          '18:00:00-19:00:00'
          '19:00:00-20:00:00'
          '20:00:00-21:00:00'
          '21:00:00-22:00:00'
          '22:00:00-23:00:00'
          '23:00:00-23:59:59')
        ParentFont = False
        TabOrder = 0
        OnDblClick = ListBox1DblClick
      end
      object ListBox2: TListBox
        Left = 56
        Top = 72
        Width = 81
        Height = 97
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ItemHeight = 13
        TabOrder = 1
        Visible = False
      end
    end
    object Panel4: TPanel
      Left = 173
      Top = 0
      Width = 783
      Height = 593
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object Panel7: TPanel
        Left = 56
        Top = 136
        Width = 129
        Height = 81
        BevelOuter = bvNone
        Color = clBlack
        TabOrder = 0
        Visible = False
        OnDblClick = Panel7DblClick
      end
      object Panel5: TPanel
        Left = 64
        Top = 272
        Width = 121
        Height = 89
        BevelOuter = bvNone
        Color = clBlack
        TabOrder = 1
        Visible = False
      end
      object Panel6: TPanel
        Left = 256
        Top = 144
        Width = 137
        Height = 97
        BevelOuter = bvNone
        Color = clBlack
        TabOrder = 2
        Visible = False
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 783
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        Color = 15985881
        TabOrder = 3
        object Label1: TLabel
          Left = 0
          Top = 3
          Width = 32
          Height = 13
          AutoSize = False
          Caption = #26085#26399#65306
        end
        object SpeedButton1: TSpeedButton
          Left = 336
          Top = 3
          Width = 57
          Height = 22
          Caption = #25171#24320#25991#20214
          OnClick = SpeedButton1Click
        end
        object Label5: TLabel
          Left = 120
          Top = 3
          Width = 49
          Height = 13
          AutoSize = False
          Caption = #25668#20687#22836#65306
        end
        object SpeedButton6: TSpeedButton
          Left = 464
          Top = 3
          Width = 33
          Height = 22
          Caption = #23567#23631
          OnClick = SpeedButton6Click
        end
        object SpeedButton8: TSpeedButton
          Left = 432
          Top = 3
          Width = 33
          Height = 22
          Caption = #22823#23631
          OnClick = SpeedButton8Click
        end
        object SpeedButton9: TSpeedButton
          Left = 400
          Top = 3
          Width = 33
          Height = 22
          Caption = #20840#23631
          OnClick = SpeedButton9Click
        end
        object Label4: TLabel
          Left = 528
          Top = 3
          Width = 17
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #215
        end
        object SpeedButton10: TSpeedButton
          Left = 576
          Top = 3
          Width = 33
          Height = 22
          Caption = #23450#23631
          OnClick = SpeedButton10Click
        end
        object SpeedButton12: TSpeedButton
          Left = 744
          Top = 3
          Width = 33
          Height = 22
          Caption = #36864#20986
          OnClick = SpeedButton12Click
        end
        object Label8: TLabel
          Left = 664
          Top = 19
          Width = 33
          Height = 15
          Hint = #24635#20307#21464#21270#29575
          AutoSize = False
          Caption = #24635#20307
          ParentShowHint = False
          ShowHint = True
        end
        object Label9: TLabel
          Left = 704
          Top = 19
          Width = 33
          Height = 16
          Hint = #21333#28857#21464#21270#29575
          AutoSize = False
          Caption = #21333#28857
          ParentShowHint = False
          ShowHint = True
        end
        object DateTimePicker1: TDateTimePicker
          Left = 32
          Top = 3
          Width = 81
          Height = 21
          Date = 41494.408668067130000000
          Time = 41494.408668067130000000
          TabOrder = 0
          OnChange = DateTimePicker1Change
        end
        object MediaPlayer1: TMediaPlayer
          Left = 496
          Top = 40
          Width = 253
          Height = 30
          Visible = False
          TabOrder = 1
        end
        object ComboBox1: TComboBox
          Left = 168
          Top = 3
          Width = 161
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          OnChange = ComboBox1Change
        end
        object Edit1: TEdit
          Left = 496
          Top = 3
          Width = 33
          Height = 21
          TabOrder = 3
          OnKeyPress = Edit1KeyPress
        end
        object Edit2: TEdit
          Left = 544
          Top = 3
          Width = 33
          Height = 21
          TabOrder = 4
          OnKeyPress = Edit2KeyPress
        end
        object CheckBox1: TCheckBox
          Left = 616
          Top = 3
          Width = 49
          Height = 17
          Caption = #35686#25253
          TabOrder = 5
          OnClick = CheckBox1Click
        end
        object Edit3: TEdit
          Left = 664
          Top = 3
          Width = 33
          Height = 16
          Hint = #24635#20307#21464#21270#29575
          AutoSize = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Text = '6'
          OnKeyPress = Edit3KeyPress
        end
        object Edit4: TEdit
          Left = 704
          Top = 3
          Width = 33
          Height = 16
          Hint = #21333#28857#21464#21270#29575
          AutoSize = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Text = '6'
          OnKeyPress = Edit4KeyPress
        end
      end
      object Panel8: TPanel
        Left = 144
        Top = 104
        Width = 529
        Height = 385
        TabOrder = 4
        Visible = False
        object Image1: TImage
          Left = 1
          Top = 1
          Width = 527
          Height = 342
          Align = alClient
          Stretch = True
        end
        object Panel10: TPanel
          Left = 1
          Top = 343
          Width = 527
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object SpeedButton13: TSpeedButton
            Left = 192
            Top = 16
            Width = 65
            Height = 22
            Caption = #20445#23384
            OnClick = SpeedButton13Click
          end
          object SpeedButton14: TSpeedButton
            Left = 272
            Top = 16
            Width = 65
            Height = 22
            Caption = #36864#20986
            OnClick = SpeedButton14Click
          end
        end
      end
      object WindowsMediaPlayer1: TWindowsMediaPlayer
        Left = 640
        Top = 496
        Width = 245
        Height = 240
        TabOrder = 5
        Visible = False
        ControlData = {
          000300000800000000000500000000000000F03F030000000000050000000000
          0000000008000200000000000300010000000B00FFFF0300000000000B00FFFF
          08000200000000000300320000000B00000008000A000000660075006C006C00
          00000B0000000B0000000B00FFFF0B00FFFF0B00000008000200000000000800
          020000000000080002000000000008000200000000000B00000052190000CE18
          0000}
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 410
    Top = 41
  end
  object Timer1: TTimer
    Interval = 40
    OnTimer = Timer1Timer
    Left = 873
    Top = 504
  end
  object SaveDialog1: TSaveDialog
    Left = 634
    Top = 233
  end
  object Timer2: TTimer
    Interval = 40
    OnTimer = Timer2Timer
    Left = 869
    Top = 344
  end
end
