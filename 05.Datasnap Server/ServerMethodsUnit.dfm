object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 504
  Width = 653
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
    Left = 36
    Top = 440
    ParamData = <
      item
        Name = 'USERSERIAL'
        DataType = ftLargeint
        ParamType = ptInput
      end>
  end
  object dsMyRecipe: TDataSetProvider
    DataSet = sqlMyRecipe
    Left = 116
    Top = 438
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
    Left = 198
    Top = 438
    ParamData = <
      item
        Name = 'RECIPESERIAL'
        ParamType = ptInput
      end>
  end
  object dsMyMethod: TDataSetProvider
    DataSet = sqlMyMethod
    Left = 278
    Top = 436
  end
  object sqlMyIngredient: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT * FROM RecipeIngredient WHERE Recipe_Serial=:RecipeSerial' +
        ' Order By RecipeMethod_Serial, Seq')
    Left = 376
    Top = 438
    ParamData = <
      item
        Name = 'RECIPESERIAL'
        ParamType = ptInput
      end>
  end
  object dsMyIngredient: TDataSetProvider
    DataSet = sqlMyIngredient
    Left = 456
    Top = 438
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
    Left = 432
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
        'Serial')
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
end
