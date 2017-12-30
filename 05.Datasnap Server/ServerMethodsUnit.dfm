object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 701
  Width = 994
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Password=cookpassword'
      'User_Name=root'
      'Server=db2.cookplay.net'
      'Database=cookplay'
      'CharacterSet=utf8'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 38
    Top = 24
  end
  object sqlFindUser: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Users WHERE Email=:Email AND Pwd=:Pwd')
    Left = 38
    Top = 88
    ParamData = <
      item
        Name = 'EMAIL'
        DataType = ftWideString
        ParamType = ptInput
        Value = 'nikkiji@hanmail.net'
      end
      item
        Name = 'PWD'
        DataType = ftWideString
        ParamType = ptInput
        Value = '1'
      end>
  end
  object dsFindUser: TDataSetProvider
    DataSet = sqlFindUser
    Left = 114
    Top = 86
  end
  object sqlUserCount: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from vUserCount Where Serial=:UserSerial')
    Left = 38
    Top = 152
    ParamData = <
      item
        Name = 'USERSERIAL'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsUserCount: TDataSetProvider
    DataSet = sqlUserCount
    Left = 116
    Top = 152
  end
  object sqlSetup: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Setup WHERE Users_Serial=:UserSerial')
    Left = 38
    Top = 222
    ParamData = <
      item
        Name = 'USERSERIAL'
        DataType = ftLargeint
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsSetup: TDataSetProvider
    DataSet = sqlSetup
    Left = 118
    Top = 220
  end
  object sqlSetupInsert: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'INSERT INTO Setup (Users_Serial, AlaramOn) VALUES (:UserSerial, ' +
        ':AlaramOn)')
    Left = 210
    Top = 216
    ParamData = <
      item
        Name = 'USERSERIAL'
        ParamType = ptInput
      end
      item
        Name = 'ALARAMON'
        ParamType = ptInput
      end>
  end
  object dsSetupInsert: TDataSetProvider
    DataSet = sqlSetupInsert
    Left = 290
    Top = 214
  end
  object sqlCategory: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM Category WHERE Deleted=0 ORDER BY CategoryType, Se' +
        'q')
    Left = 36
    Top = 298
  end
  object dsCategory: TDataSetProvider
    DataSet = sqlCategory
    Left = 116
    Top = 296
  end
  object sqlMyRecipe: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM Recipe WHERE Users_Serial=:UserSerial AND deleted=' +
        '0')
    Left = 468
    Top = 386
    ParamData = <
      item
        Name = 'USERSERIAL'
        DataType = ftLargeint
        ParamType = ptInput
      end>
  end
  object dsMyRecipe: TDataSetProvider
    DataSet = sqlMyRecipe
    Left = 548
    Top = 384
  end
  object sqlQuery: TFDQuery
    Connection = FDConnection1
    Left = 118
    Top = 30
  end
  object sqlMyMethod: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM RecipeMethod WHERE Recipe_Serial=:RecipeSerial Ord' +
        'er by Recipe_Serial, StepSeq')
    Left = 630
    Top = 384
    ParamData = <
      item
        Name = 'RECIPESERIAL'
        ParamType = ptInput
      end>
  end
  object dsMyMethod: TDataSetProvider
    DataSet = sqlMyMethod
    Left = 710
    Top = 382
  end
  object sqlMyIngredient: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM RecipeIngredient WHERE Recipe_Serial=:RecipeSerial' +
        ' Order By RecipeMethod_Serial, Seq')
    Left = 808
    Top = 384
    ParamData = <
      item
        Name = 'RECIPESERIAL'
        ParamType = ptInput
      end>
  end
  object dsMyIngredient: TDataSetProvider
    DataSet = sqlMyIngredient
    Left = 888
    Top = 384
  end
  object sqlDeleteQue: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM DeleteImageQue')
    Left = 350
    Top = 24
  end
  object dsDeleteQue: TDataSetProvider
    DataSet = sqlDeleteQue
    Left = 434
    Top = 24
  end
  object sqlRecipeBest: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM vRecipeBest Limit 1000')
    Left = 410
    Top = 118
  end
  object dsRecipeBest: TDataSetProvider
    DataSet = sqlRecipeBest
    Left = 508
    Top = 118
  end
  object sqlRecipeRecent: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM vRecipeLastest Limit 1000')
    Left = 414
    Top = 192
  end
  object dsRecipRecent: TDataSetProvider
    DataSet = sqlRecipeRecent
    Left = 512
    Top = 190
  end
  object sqlRecipeCount: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from vRecipeCount Where Recipe_Serial=:RecipeSerial')
    Left = 208
    Top = 154
    ParamData = <
      item
        Name = 'RECIPESERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object dsRecipeCount: TDataSetProvider
    DataSet = sqlRecipeCount
    Left = 286
    Top = 154
  end
  object sqlRecipe: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Recipe WHERE Serial=:Serial')
    Left = 34
    Top = 368
    ParamData = <
      item
        Name = 'SERIAL'
        DataType = ftLargeint
        ParamType = ptInput
        Value = -1
      end>
  end
  object dsRecipe: TDataSetProvider
    DataSet = sqlRecipe
    Left = 114
    Top = 366
  end
  object sqlvIngredientGroup: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM vRecipeIngredientGroup WHERE Recipe_Serial=:Recipe' +
        'Serial order by StepSeq, seq')
    Left = 202
    Top = 370
    ParamData = <
      item
        Name = 'RECIPESERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object dsvIngredientGroup: TDataSetProvider
    DataSet = sqlvIngredientGroup
    Left = 306
    Top = 372
  end
  object sqlvRecipeComment: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM vRecipeComment WHERE Recipe_Serial=:RecipeSerial')
    Left = 660
    Top = 474
    ParamData = <
      item
        Name = 'RECIPESERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object dsRecipeComment: TDataSetProvider
    DataSet = sqlvRecipeComment
    Left = 754
    Top = 472
  end
  object sqlStep: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM RecipeMethod WHERE Recipe_Serial=:RecipeSerial ORD' +
        'ER BY StepSeq')
    Left = 32
    Top = 434
    ParamData = <
      item
        Name = 'RECIPESERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object dsStep: TDataSetProvider
    DataSet = sqlStep
    Left = 112
    Top = 432
  end
  object sqlIngredient: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM RecipeIngredient WHERE RecipeMethod_Serial=:StepSe' +
        'rial Order by Seq')
    Left = 32
    Top = 508
    ParamData = <
      item
        Name = 'STEPSERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object dsIngredient: TDataSetProvider
    DataSet = sqlIngredient
    Left = 112
    Top = 506
  end
  object sqlvStoryList: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM vStoryList WHERE Users_Serial=:UserSerial Order by' +
        ' CreatedDate DESC')
    Left = 466
    Top = 552
    ParamData = <
      item
        Name = 'USERSERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object dsvStoryList: TDataSetProvider
    DataSet = sqlvStoryList
    Left = 546
    Top = 550
  end
  object sqlStoryImages: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM StoryContents WHERE Story_Serial=:StorySerial AND ' +
        'ValueType=12 Order by Seq')
    Left = 466
    Top = 616
    ParamData = <
      item
        Name = 'STORYSERIAL'
        ParamType = ptInput
      end>
  end
  object dsStoryImages: TDataSetProvider
    DataSet = sqlStoryImages
    Left = 548
    Top = 610
  end
  object sqlvStoryComment: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM vStoryComment WHERE Story_Serial=:StorySerial')
    Left = 658
    Top = 552
    ParamData = <
      item
        Name = 'STORYSERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object dsvStoryComment: TDataSetProvider
    DataSet = sqlvStoryComment
    Left = 758
    Top = 554
  end
  object sqlvRecipeList: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM vRecipeList WHERE Users_Serial=:UserSerial Order b' +
        'y CreatedDate DESC')
    Left = 464
    Top = 476
    ParamData = <
      item
        Name = 'USERSERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object dsvRecipeList: TDataSetProvider
    DataSet = sqlvRecipeList
    Left = 544
    Top = 474
  end
  object sqlvBookmarkList: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM vBookmarkList WHERE Users_Serial=:UserSerial Order' +
        ' by CreatedDate DESC')
    Left = 286
    Top = 554
    ParamData = <
      item
        Name = 'USERSERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object dsvBookmarkList: TDataSetProvider
    DataSet = sqlvBookmarkList
    Left = 374
    Top = 552
  end
  object sqlStoryCount: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from vStoryCount Where Story_Serial=:StorySerial')
    Left = 210
    Top = 282
    ParamData = <
      item
        Name = 'STORYSERIAL'
        DataType = ftWideString
        ParamType = ptInput
        Value = '-1'
      end>
  end
  object DsStoryCount: TDataSetProvider
    DataSet = sqlStoryCount
    Left = 288
    Top = 282
  end
end
