object frmExplain: TfrmExplain
  Left = 0
  Top = 0
  Caption = #50836#47532#48169#48277
  ClientHeight = 227
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object imgSquare: TImage
    Left = 400
    Top = 33
    Width = 85
    Height = 85
    Stretch = True
  end
  object cxLabel8: TcxLabel
    Left = 36
    Top = 159
    Caption = #49692#49436
    ParentFont = False
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -13
    Style.Font.Name = #47569#51008' '#44256#46357
    Style.Font.Style = []
    Style.TextColor = clBlack
    Style.IsFontAssigned = True
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 66
  end
  object cxDBSpinEdit2: TcxDBSpinEdit
    Left = 66
    Top = 158
    DataBinding.DataField = 'Seq'
    DataBinding.DataSource = frmRecipe.dsMethod
    TabOrder = 1
    Width = 125
  end
  object cxLabel2: TcxLabel
    Left = 30
    Top = 33
    Caption = #49444#47749
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 60
  end
  object cxDBMemo1: TcxDBMemo
    Left = 66
    Top = 32
    DataBinding.DataField = 'Description'
    DataBinding.DataSource = frmRecipe.dsMethod
    TabOrder = 3
    Height = 120
    Width = 313
  end
  object btnLoadImage: TButton
    Left = 405
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 4
    OnClick = btnLoadImageClick
  end
  object btnClearImage: TButton
    Left = 405
    Top = 158
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 5
    OnClick = btnClearImageClick
  end
  object btnSave: TButton
    Left = 528
    Top = 50
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 6
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 528
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 7
    OnClick = btnCancelClick
  end
end
