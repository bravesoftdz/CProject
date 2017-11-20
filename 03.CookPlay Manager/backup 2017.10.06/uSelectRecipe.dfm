object frmSelectRecipe: TfrmSelectRecipe
  Left = 0
  Top = 0
  Caption = #47112#49884#54588#50672#44208
  ClientHeight = 235
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 17
  object cxLabel9: TcxLabel
    Left = 11
    Top = 32
    Caption = 'Linked Recipe'
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
    AnchorX = 98
  end
  object cxcboLinkedRecipe: TcxDBLookupComboBox
    Left = 102
    Top = 28
    DataBinding.DataField = 'LinkedRecipe'
    DataBinding.DataSource = frmRecipe.dsMethod
    Properties.DropDownListStyle = lsFixedList
    Properties.KeyFieldNames = 'Serial'
    Properties.ListColumns = <
      item
        FieldName = 'Title'
      end>
    Properties.ListOptions.ShowHeader = False
    Properties.ListSource = dmDB.dsMyRecipe
    Properties.ReadOnly = False
    TabOrder = 1
    Width = 313
  end
  object cxLabel2: TcxLabel
    Left = 66
    Top = 65
    Caption = #49444#47749
    Properties.Alignment.Horz = taRightJustify
    Transparent = True
    AnchorX = 96
  end
  object cxDBMemo1: TcxDBMemo
    Left = 102
    Top = 64
    DataBinding.DataField = 'Description'
    DataBinding.DataSource = frmRecipe.dsMethod
    TabOrder = 3
    Height = 120
    Width = 313
  end
  object btnSave: TButton
    Left = 468
    Top = 46
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 468
    Top = 84
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object cxLabel8: TcxLabel
    Left = 72
    Top = 191
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
    AnchorX = 102
  end
  object cxDBSpinEdit2: TcxDBSpinEdit
    Left = 102
    Top = 190
    DataBinding.DataField = 'Seq'
    DataBinding.DataSource = frmRecipe.dsMethod
    TabOrder = 7
    Width = 125
  end
end
