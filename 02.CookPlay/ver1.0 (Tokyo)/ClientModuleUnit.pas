unit ClientModuleUnit;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit, Data.DBXDataSnap,
  Data.DBXCommon, IPPeerClient, Data.DB, Data.SqlExpr, Datasnap.DBClient,
  Datasnap.DSConnect, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Dialogs,
  FMX.ListBox, FireDAC.Stan.StorageBin, System.UITypes, FMX.Forms, uGlobal,
  System.ImageList, FMX.ImgList, cookplay.scale;

type
  TUserLevel = (UnConfirmed=0, User=1, Manager=8, Admin=9);
  TLoginResult = (lrError=0, lrSuccess, lrResendEmail);

  TCM = class(TDataModule)
    SQLConnection: TSQLConnection;
    DSFindUser: TClientDataSet;
    DSProviderConnection: TDSProviderConnection;
    memUser: TFDMemTable;
    memUserSerial: TLargeintField;
    memUserID: TStringField;
    memUserPwd: TStringField;
    memUserNational: TStringField;
    memUserBirthday: TStringField;
    memUserGender: TStringField;
    memUserIP: TStringField;
    memUserEmail: TStringField;
    memUserIntroduction: TStringField;
    memUserPicture: TStringField;
    memUserSSO: TBooleanField;
    memUserCreatedDate: TDateTimeField;
    memUserLastUpdatedDate: TDateTimeField;
    memUserWithdrawaldate: TDateTimeField;
    memUserWithdrawal: TBooleanField;
    memUserDeleted: TBooleanField;
    memUserLevel: TStringField;
    memUserNickname: TWideStringField;
    memUserName: TWideStringField;
    DSUserCount: TClientDataSet;
    DSSetup: TClientDataSet;
    DSSetupInsert: TClientDataSet;
    memUserAgreeMarketing: TBooleanField;
    memCategory: TFDMemTable;
    DSCategory: TClientDataSet;
    memCategorySerial: TLargeintField;
    memCategoryCategoryType: TWideStringField;
    memCategoryCategoryCode: TSmallintField;
    memCategoryCategoryName: TWideStringField;
    memCategorySeq: TIntegerField;
    memCategoryDeleted: TBooleanField;
    memCategoryComment: TWideStringField;
    DSRecipe: TClientDataSet;
    memMyRecipe: TFDMemTable;
    DSMyRecipe: TClientDataSet;
    memMyRecipeSerial: TLargeintField;
    memMyRecipeUsers_Serial: TLargeintField;
    memMyRecipeTitle: TWideStringField;
    memMyRecipeDescription: TWideStringField;
    memMyRecipePictureType: TWideStringField;
    memMyRecipePicture: TWideStringField;
    memMyRecipePictureSquare: TWideStringField;
    memMyRecipePictureRectangle: TWideStringField;
    memMyRecipeCategory: TWideStringField;
    memMyRecipeMakingLevel: TSmallintField;
    memMyRecipeMakingTime: TSmallintField;
    memMyRecipeServings: TSmallintField;
    memMyRecipeHashcode: TWideStringField;
    memMyRecipeCreatedDate: TDateTimeField;
    memMyRecipeUpdatedDate: TDateTimeField;
    memMyRecipePublished: TBooleanField;
    memMyRecipeDeleted: TBooleanField;
    DSMyMethod: TClientDataSet;
    DSMyIngredient: TClientDataSet;
    memMyMethod: TFDMemTable;
    memMyIngredient: TFDMemTable;
    memMyMethodSerial: TLargeintField;
    memMyMethodRecipe_Serial: TLargeintField;
    memMyMethodMethodType: TSmallintField;
    memMyMethodPictureType: TSmallintField;
    memMyMethodPicture: TWideStringField;
    memMyMethodPictureRectangle: TWideStringField;
    memMyMethodPictureSquare: TWideStringField;
    memMyMethodDescription: TWideStringField;
    memMyMethodSeq: TSmallintField;
    memMyMethodStepSeq: TSmallintField;
    DSMyIngredientSerial: TLargeintField;
    DSMyIngredientRecipe_Serial: TLargeintField;
    DSMyIngredientRecipeMethod_Serial: TLargeintField;
    DSMyIngredientLinkedRecipe: TLargeintField;
    DSMyIngredientSeq: TIntegerField;
    DSMyIngredientItemType: TSmallintField;
    DSMyIngredientItemWeightValue: TBCDField;
    DSMyIngredientItemTimeValue: TWideStringField;
    DSMyIngredientItemTemperatureValue: TBCDField;
    DSMyIngredientItemUnit: TSmallintField;
    DSMyIngredientTitle: TWideStringField;
    DSMyIngredientAmount: TWideStringField;
    DSMyIngredientUnit: TWideStringField;
    memMyIngredientSerial: TLargeintField;
    memMyIngredientRecipe_Serial: TLargeintField;
    memMyIngredientRecipeMethod_Serial: TLargeintField;
    memMyIngredientLinkedRecipe: TLargeintField;
    memMyIngredientSeq: TIntegerField;
    memMyIngredientItemType: TSmallintField;
    memMyIngredientItemWeightValue: TBCDField;
    memMyIngredientItemTimeValue: TWideStringField;
    memMyIngredientItemTemperatureValue: TBCDField;
    memMyIngredientItemUnit: TSmallintField;
    memMyIngredientTitle: TWideStringField;
    memMyIngredientAmount: TWideStringField;
    memMyIngredientUnit: TWideStringField;
    DSDeleteQue: TClientDataSet;
    DSRecipeBest: TClientDataSet;
    DSRecipeRecent: TClientDataSet;
    imagelistGlobal: TImageList;
    DSRecipeCount: TClientDataSet;
    DSvIngredientGroup: TClientDataSet;
    DSvRecipeComment: TClientDataSet;
    DSStep: TClientDataSet;
    DSIngredient: TClientDataSet;
  private
    FInstanceOwner: Boolean;
    FServerMethods1Client: TServerMethods1Client;
    function GetServerMethods1Client: TServerMethods1Client;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethods1Client: TServerMethods1Client read GetServerMethods1Client write FServerMethods1Client;

    function Login(email, password: string; var Msg: string): TLoginResult;
    procedure GetRecipeTablesToMem;
    procedure GetCategoryTableToMem;
    procedure GetCount(UserSerial: LargeInt; var Follow, Follower, Recipe, Cookbook, Notice, MyFeed: integer);
    procedure GetSetup(UserSerial: LargeInt; var AlaramOn: Boolean);
    procedure SetSetup(UserSerial: LargeInt; AlaramOn: Boolean);
    procedure GetIngredientUnit(cbo: TComboBox);
    procedure GetRecipeInfo(cbo: TComboBox; aCategoryName: string);

    procedure CloseMemTable;

    function GetRecipeInfoCode(sCategoryType, sValue: string): integer;
    function GetRecipeInfoName(sCategoryType: string; nValue: integer): string;

    procedure AddtoDeleteImageQue(bucketname, objectname: string);

    procedure GetRecipeListBest(aList: TStringList);
    procedure GetRecipeListRecent(aList: TStringList);

    function UpdateRecipeRecommendation(aRecipeSerial, aUserSerial: LargeInt;
      aActive: Boolean): Boolean;
    function UpdateRecipeBookmark(aRecipeSerial, aUserSerial: LargeInt;
      aActive: Boolean): Boolean;

    procedure GetRecipeViewCount(aRecipeSerial, aUserSerial: LargeInt;
      var aRecommended, aBookmarked, aRecommendationCount, aCommentCount: integer);

    function GetIngredientGroup(aRecipeSerial: LargeInt; var aSorServings: integer;
      aTarServings: integer; aTarWeightRatio: Single): TStringList;

    function GetRecipeComment(aRecipeSerial: LargeInt): TStringList;

    function InsertRecipeComment(aRecipeSerial, aUserSerial: LargeInt; aComment: string): Boolean;
    function UpdateRecipeComment(aSerial: LargeInt; aComment: string): Boolean;
    function DeleteRecipeComment(aSerial: LargeInt): Boolean;

    function GetLastSerial: LargeInt;

    procedure LoadRecipeInfo(var aRecipe: TRecipeView);
end;

var
  CM: TCM;

implementation
{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TCM.AddtoDeleteImageQue(bucketname, objectname: string);
begin
  if not dsDeleteQue.Active then
    dsDeleteQue.Open;

  dsDeleteQue.Insert;
  dsDeleteQue.FieldByName('BucketName').AsString := bucketname;
  dsDeleteQue.FieldByName('ImageName').AsString := objectname;
  dsDeleteQue.FieldByName('CreatedDate').AsDateTime := now;
  dsDeleteQue.Post;
end;

procedure TCM.CloseMemTable;
begin
  memUser.Close;
  memCategory.Close;
  memMyRecipe.Close;
  memMyMethod.Close;
  memMyIngredient.Close;
end;

constructor TCM.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

function TCM.DeleteRecipeComment(aSerial: LargeInt): Boolean;
var
  sql: string;
begin
  try
    sql := 'Delete from RecipeComment' +
           ' Where Serial = ' + aSerial.ToString;

    result := ServerMethods1Client.UpdateQuery(sql);
  finally
    SQLConnection.Close;
  end;
end;

destructor TCM.Destroy;
begin
  FServerMethods1Client.Free;
  inherited;
end;

procedure TCM.GetCategoryTableToMem;
var
  i: integer;
begin
  memCategory.Close;
  memCategory.Open;
  DSCategory.Open;

  DSCategory.First;
  while not DSCategory.Eof do
  begin
    memCategory.Insert;
    for i := 0 to DSCategory.FieldCount-1 do
      memCategory.Fields[i].Value := DSCategory.Fields[i].Value;
    memCategory.Post;

    DSCategory.Next;
  end;
end;

procedure TCM.GetCount(UserSerial: LargeInt; var Follow, Follower, Recipe, Cookbook, Notice, MyFeed: integer);
begin
  Follow := 0;
  Follower := 0;
  Recipe := 0;
  Cookbook := 0;
  Notice := 0;
  MyFeed := 0;

  try
    DSUserCount.Close;
    DSUserCount.ParamByName('UserSerial').Value := UserSerial;
    DSUserCount.Open;

    if not DSUserCount.IsEmpty then
    begin
      Follow := DSUserCount.FieldByName('FollowNo').AsInteger;
      Follower := DSUserCount.FieldByName('FollowerNo').AsInteger;
      Recipe := DSUserCount.FieldByName('RecipeNo').AsInteger;
      Cookbook := DSUserCount.FieldByName('CookbookNo').AsInteger;
      Notice := DSUserCount.FieldByName('NoticeNo').AsInteger;
      MyFeed := DSUserCount.FieldByName('MyFeedNo').AsInteger;
    end;
  finally
    DSUserCount.Close;
    SQLConnection.Close;
  end;
end;

function TCM.GetIngredientGroup(aRecipeSerial: LargeInt; var aSorServings: integer;
      aTarServings: integer; aTarWeightRatio: Single): TStringList;
// 레시피 재료를 찾아서 보낸다
var
  oList: TStringList;
  oItem: TRecipeChangeWeightItem;
begin
  SQLConnection.Open;
  oList := TStringList.Create;

  try
    DSRecipe.Close;
    DSRecipe.ParamByName('Serial').Value := aRecipeSerial;
    DSRecipe.Open;

    if not DSRecipe.IsEmpty then
      aSorServings := DSRecipe.FieldByName('Servings').AsInteger
    else
      aSorServings := 1; // Default is 1

    DSvIngredientGroup.Close;
    DSvIngredientGroup.ParamByName('RecipeSerial').Value := aRecipeSerial;
    DSvIngredientGroup.Open;

    if not DSvIngredientGroup.IsEmpty then
    begin
      DSvIngredientGroup.First;
      while not DSvIngredientGroup.Eof do
      begin
        oItem := TRecipeChangeWeightItem.Create;
        oItem.IngredientType := TIngredientType(DSvIngredientGroup.FieldByName('ItemType').AsInteger);
        oItem.Title := DSvIngredientGroup.FieldByName('Title').AsWideString;
        oItem.sorWeight := DSvIngredientGroup.FieldByName('ItemWeightValue').AsSingle;
        oItem.tarWeight := oItem.sorWeight * (aTarServings / aSorServings) * aTarWeightRatio;

        if oItem.IngredientType in [itIngredient, itSeasoning, itRecipeLink]  then
          oList.AddObject('', oItem);

        DSvIngredientGroup.Next;
      end;
    end;
  finally
    SQLConnection.Close;
    result := oList;
  end;
end;

procedure TCM.GetIngredientUnit(cbo: TComboBox);
begin
  if Assigned(cbo) then
  begin
    memCategory.Filtered := False;
    memCategory.Filter := 'CategoryType=''UnitType''';
    memCategory.Filtered := True;

    cbo.Clear;
    memCategory.First;
    while not memCategory.eof do
    begin
      if memCategoryComment.IsNull then
        cbo.Items.Add(memCategoryCategoryName.AsWideString)
      else
        cbo.Items.Add(memCategoryCategoryName.AsWideString + '(' + memCategoryComment.AsWideString + ')');

      memCategory.Next;
    end;
  end;
end;

function TCM.GetLastSerial: LargeInt;
begin
  result := ServerMethods1Client.LastInsertID;
end;

function TCM.GetServerMethods1Client: TServerMethods1Client;
begin
  if FServerMethods1Client = nil then
  begin
    SQLConnection.Open;
    FServerMethods1Client:= TServerMethods1Client.Create(SQLConnection.DBXConnection, FInstanceOwner);
  end;
  Result := FServerMethods1Client;
end;

procedure TCM.GetSetup(UserSerial: LargeInt; var AlaramOn: Boolean);
begin
  AlaramOn := True;

  try
    DSSetup.Close;
    DSSetup.ParamByName('UserSerial').Value := UserSerial;
    DSSetup.Open;

    if not DSSetup.IsEmpty then
      AlaramOn := DSSetup.FieldByName('AlaramOn').AsBoolean;

  finally
    DSSetup.Close;
    SQLConnection.Close;
  end;
end;

function TCM.InsertRecipeComment(aRecipeSerial, aUserSerial: LargeInt;
  aComment: string): Boolean;
var
  sql: string;
begin
  try
    try
      sql := 'Insert into RecipeComment' +
             '       (Recipe_Serial, Users_Serial, Contents, CreatedDate)' +
             '       VALUES' +
             '       (' + aRecipeSerial.ToString + ', ' + aUserSerial.ToString + ', ''' + aComment.Trim + ''', ''' + FormatDatetime('YYYY-MM-DD HH:NN:SS', now) + ''')';

      result := ServerMethods1Client.UpdateQuery(sql);
    except
      on E:Exception do
        Showmessage(E.Message);
    end;
  finally
    SQLConnection.Close;
  end;
end;

procedure TCM.LoadRecipeInfo(var aRecipe: TRecipeView);
var
  nStepNo, nIngredientNo: integer;
begin
  if aRecipe.RecipeSerial = NEW_RECIPE_SERIAL then
    Exit;

  try
    if not SQLConnection.Connected then
      SQLConnection.Open;

    DSRecipe.Close;
    DSRecipe.ParamByName('Serial').AsLargeInt := aRecipe.RecipeSerial;
    DSRecipe.Open;

    if not DSRecipe.IsEmpty then
    begin
      aRecipe.Title := DSRecipe.FieldByName('Title').AsWideString;

      DSStep.Close;
      DSStep.ParamByName('RecipeSerial').AsLargeInt := aRecipe.RecipeSerial;
      DSStep.Open;

      DSStep.First;
      while not DSStep.Eof do
      begin
        SetLength(aRecipe.Steps, aRecipe.StepCount+1);
        nStepNo := aRecipe.StepCount-1;

        aRecipe.Steps[nStepNo].Clear;

        aRecipe.Steps[nStepNo].StepSerial := DSStep.FieldByName('Serial').AsLargeInt;
        aRecipe.Steps[nStepNo].Description := DSStep.FieldByName('Description').AsWideString;
        aRecipe.Steps[nStepNo].PictureName := DSStep.FieldByName('Picture').AsWideString;
        aRecipe.Steps[nStepNo].StepSeq := DSStep.FieldByName('StepSeq').AsInteger;

        DSIngredient.Close;
        DSIngredient.ParamByName('StepSerial').AsLargeInt := aRecipe.Steps[nStepNo].StepSerial;
        DSIngredient.Open;

        DSIngredient.First;
        while not DSIngredient.Eof do
        begin
          SetLength(aRecipe.Steps[nStepNo].Ingredients, aRecipe.Steps[nStepNo].IngredientCount+1);
          nIngredientNo := aRecipe.Steps[nStepNo].IngredientCount-1;

          aRecipe.Steps[nStepNo].Ingredients[nIngredientNo].Title := DSIngredient.FieldByName('Title').AsWideString;
          aRecipe.Steps[nStepNo].Ingredients[nIngredientNo].Amount := DSIngredient.FieldByName('Amount').AsWideString;
          aRecipe.Steps[nStepNo].Ingredients[nIngredientNo].AUnit := DSIngredient.FieldByName('Unit').AsWideString;
          aRecipe.Steps[nStepNo].Ingredients[nIngredientNo].Seq := DSIngredient.FieldByName('seq').AsInteger;
          aRecipe.Steps[nStepNo].Ingredients[nIngredientNo].LinkedRecipe := DSIngredient.FieldByName('LinkedRecipe').AsLargeInt;
          aRecipe.Steps[nStepNo].Ingredients[nIngredientNo].ItemType := TIngredientType(DSIngredient.FieldByName('ItemType').AsInteger);
          aRecipe.Steps[nStepNo].Ingredients[nIngredientNo].ItemWeightValue := DSIngredient.FieldByName('ItemWeightValue').AsSingle;
          aRecipe.Steps[nStepNo].Ingredients[nIngredientNo].ItemTimeValue := DSIngredient.FieldByName('ItemTimeValue').AsString;
          aRecipe.Steps[nStepNo].Ingredients[nIngredientNo].ItemTemperatureValue := DSIngredient.FieldByName('ItemTemperatureValue').AsSingle;
          aRecipe.Steps[nStepNo].Ingredients[nIngredientNo].ItemUnit := TIngredientUnit(DSIngredient.FieldByName('ItemUnit').AsInteger);

          DSIngredient.Next;
        end;

        DSStep.Next;
      end;
    end;
  finally
    SQLConnection.Close;
  end;
end;

function TCM.Login(email, password: string; var Msg: string): TLoginResult;
var
  i: integer;
  LoginResult: TLoginResult;
begin
  if not SQLConnection.Connected then
    SQLConnection.Open;

  CloseMemTable;

  LoginResult := lrError;
  try
    try
      DSFindUser.Close;
      DSFindUSer.ParamByName('EMAIL').Value := email;
      DSFindUser.ParamByName('PWD').Value := password;
      DSFindUser.Open;

      if DSFindUser.IsEmpty then
        Msg := '이메일 또는 비밀번호를 확인하세요!'
      else
      begin
        if DSFindUser.FieldByName('Withdrawal').AsBoolean then
          Msg := '탈퇴한 회원정보입니다!' +#13#10 +
                 '같은 이메일로 재가입을 하시려면,' + #13#10 +
                 '메뉴의 ''문의하기''를 이용해 주세요!'
        else if DSFindUser.FieldByName('Level').AsInteger < Ord(TUserLevel.User)  then
          LoginResult := lrResendEmail
        else
        begin
          memUser.Open;
          memUser.Insert;
          for i := 0 to DSFinduser.FieldCount-1 do
            if (DSFindUser.Fields[i].DataType = ftWideString) or (DSFindUser.Fields[i].DataType = ftString) then
              memUser.Fields[i].AsWideString := DSFindUser.Fields[i].AsWideString
  //            memUser.Fields[i].AsString := UTF8Decode(DSFindUser.Fields[i].AsString)
            else
              memUser.Fields[i].Value := DSFindUser.Fields[i].Value;
          memUser.Post;

          GetRecipeTablesToMem;

          GetCategoryTableToMem;

          LoginResult := lrSuccess;
        end;
      end;
    except
      Msg := '에러가 발생했습니다!';
      memUser.Close;

      LoginResult := lrError;
    end;
  finally
    DSCategory.Close;
    DSFindUser.Close;
    SQLConnection.Close;

    result := LoginResult;
  end;
end;

function TCM.GetRecipeInfoCode(sCategoryType, sValue: string): integer;
begin
  result := -1;

  memCategory.Filtered := False;
  memCategory.Filter := 'CategoryType=''' + sCategoryType + '''';
  memCategory.Filtered := True;

  memCategory.First;
  while not memCategory.Eof do
  begin
    if (memCategoryCategoryType.AsString = sCategoryType) and (memCategoryCategoryName.AsString = sValue) then
    begin
      result := memCategoryCategoryCode.AsInteger;
      break;
    end;

    memCategory.Next;
  end;
end;

function TCM.GetRecipeInfoName(sCategoryType: string; nValue: integer): string;
begin
  result := '';

  memCategory.Filtered := False;
  memCategory.Filter := 'CategoryType=''' + sCategoryType + '''';
  memCategory.Filtered := True;

  memCategory.First;
  while not memCategory.Eof do
  begin
    if (memCategoryCategoryType.AsString = sCategoryType) and (memCategoryCategoryCode.AsInteger = nValue) then
    begin
      result := memCategoryCategoryName.AsString;
      break;
    end;

    memCategory.Next;
  end;
end;

procedure TCM.GetRecipeListBest(aList: TStringList);
var
  aRecipeItem: TRecipeListItem;
begin
  if not Assigned(aList) then
    Exit;

  try
    while aList.Count > 0 do
    begin
      aList.Objects[0].DisposeOf;
      aList.Delete(0);
    end;

    DSRecipeBest.Open;

    if not DSRecipeBest.IsEmpty then
    begin
      DSRecipeBest.First;

      while not DSRecipeBest.Eof do
      begin
        aRecipeItem := TRecipeListItem.Create;

        aRecipeItem.RecipeSerial := DSRecipeBest.FieldByName('Serial').AsLargeInt;
        aRecipeItem.PictureName := DSRecipeBest.FieldByName('PictureSquare').AsWideString;
        aRecipeItem.Title := DSRecipeBest.FieldByName('Title').AsWideString;
        aRecipeItem.RecommendationCount := DSRecipeBest.FieldByName('RecommendationCount').AsInteger;
        aRecipeItem.CommentCount := DSRecipeBest.FieldByName('CommentCount').AsInteger;

        aList.AddObject('', aRecipeItem);

        DSRecipeBest.Next;
      end;
    end;
  finally
    DSRecipeBest.Close;
    SQLConnection.Close;
  end;
end;

procedure TCM.GetRecipeListRecent(aList: TStringList);
var
  aRecipeItem: TRecipeListItem;
begin
  if not Assigned(aList) then
    Exit;

  try
    while aList.Count > 0 do
    begin
      aList.Objects[0].DisposeOf;
      aList.Delete(0);
    end;

    DSRecipeRecent.Open;

    if not DSRecipeRecent.IsEmpty then
    begin
      DSRecipeRecent.First;
      while not DSRecipeRecent.Eof do
      begin
        aRecipeItem := TRecipeListItem.Create;

        aRecipeItem.RecipeSerial := DSRecipeRecent.FieldByName('Serial').AsLargeInt;
        aRecipeItem.PictureName := DSRecipeRecent.FieldByName('PictureSquare').AsWideString;
        aRecipeItem.Title := DSRecipeRecent.FieldByName('Title').AsWideString;
        aRecipeItem.RecommendationCount := DSRecipeRecent.FieldByName('RecommendationCount').AsInteger;
        aRecipeItem.CommentCount := DSRecipeRecent.FieldByName('CommentCount').AsInteger;

        aList.AddObject('', aRecipeItem);

        DSRecipeRecent.Next;
      end;
    end;
  finally
    DSRecipeRecent.Close;
    SQLConnection.Close;
  end;
end;

function TCM.GetRecipeComment(aRecipeSerial: LargeInt): TStringList;
// 레시피의 댓글을 찾아서 보낸다
var
  oList: TStringList;
  aCommentItem: TRecipeCommentInfo;
begin
  SQLConnection.Open;
  oList := TStringList.Create;

  try
    DSvRecipeComment.Close;
    DSvRecipeComment.ParamByName('RecipeSerial').Value := aRecipeSerial;
    DSvRecipeComment.Open;

    if not DSvRecipeComment.IsEmpty then
    begin
      DSvRecipeComment.First;
      while not DSvRecipeComment.Eof do
      begin
        aCommentItem := TRecipeCommentInfo.Create;
        aCommentItem.Serial := DSvRecipeComment.FieldByName('Serial').AsLargeInt;
        aCommentItem.Recipe_Serial := DSvRecipeComment.FieldByName('Recipe_Serial').AsLargeInt;
        aCommentItem.Users_Serial := DSvRecipeComment.FieldByName('Users_Serial').AsLargeInt;
        aCommentItem.Contents := DSvRecipeComment.FieldByName('Contents').AsWideString;
        aCommentItem.PictureType := DSvRecipeComment.FieldByName('PictureType').AsInteger;
        aCommentItem.Picture := DSvRecipeComment.FieldByName('Picture').AsWideString;
        aCommentItem.UserPicture := DSvRecipeComment.FieldByName('UserPicture').AsWideString;
        aCommentItem.Nickname := DSvRecipeComment.FieldByName('Nickname').AsWideString;
        aCommentItem.CreatedDatetime := DSvRecipeComment.FieldByName('CreatedDate').AsWideString;

        oList.AddObject('', aCommentItem);

        DSvRecipeComment.Next;
      end;
    end;
  finally
    SQLConnection.Close;
    result := oList;
  end;
end;

procedure TCM.GetRecipeInfo(cbo: TComboBox; aCategoryName: string);
begin
  if Assigned(cbo) then
  begin
    memCategory.Filtered := False;
    memCategory.Filter := 'CategoryType=''' + aCategoryName + '''';
    memCategory.Filtered := True;

    cbo.Clear;
    memCategory.First;
    while not memCategory.eof do
    begin
      cbo.Items.Add(memCategoryCategoryName.AsWideString);

      memCategory.Next;
    end;
  end;
end;

procedure TCM.GetRecipeTablesToMem;
// 이 함수를 호출하려면
//    SQLConnection.Connected = True 되어야 한다
// myRecipe, myMethod, myIngredient 정보를 memTable로 가져온다
var
  i: integer;
begin
  if not SQLConnection.Connected then
    Exit;

  memMyRecipe.Close;
  memMyMethod.Close;
  memMyIngredient.Close;

  if not memUser.IsEmpty then
  begin
    // MyRecipe를 가져온다
    memMyRecipe.Open;
    DSMyRecipe.Close;
    DSMyRecipe.ParamByName('UserSerial').Value := memUserSerial.Value;
    DSMyRecipe.Open;

    DSMyRecipe.First;
    while not DSMyRecipe.Eof do
    begin
      memMyRecipe.Append;
      for i := 0 to DSMyRecipe.FieldCount-1 do
        memMyRecipe.Fields[i].Value := DSMyRecipe.Fields[i].Value;
      memMyRecipe.Post;

      // Method를 가져온다
      memMyMethod.Open;
      DSMyMethod.Close;
      DSMyMethod.ParamByName('RecipeSerial').Value := memMyRecipe.FieldByName('Serial').Value;
      DSMyMethod.Open;

      DSMyMethod.First;
      while not DSMyMethod.Eof do
      begin
        memMyMethod.Append;
        for i := 0 to DSMyMethod.FieldCount-1 do
          memMyMethod.Fields[i].Value := DSMyMethod.Fields[i].Value;
        memMyMethod.Post;

        DSMyMethod.Next;
      end;

      // Ingredient를 가져온다
      memMyIngredient.Open;
      DSMyIngredient.Close;
      DSMyIngredient.ParamByName('RecipeSerial').Value := memMyRecipe.FieldByName('Serial').Value;
      DSMyIngredient.Open;

      DSMyIngredient.First;
      while not DSMyIngredient.Eof do
      begin
        memMyIngredient.Append;
        for i := 0 to DSMyIngredient.FieldCount-1 do
          memMyIngredient.Fields[i].Value := DSMyIngredient.Fields[i].Value;
        memMyIngredient.Post;

        DSMyIngredient.Next;
      end;

      DSMyRecipe.Next;
    end;

    DSMyRecipe.Close;
  end;
end;

procedure TCM.GetRecipeViewCount(aRecipeSerial, aUserSerial: LargeInt;
  var aRecommended, aBookmarked, aRecommendationCount, aCommentCount: integer);
var
  query: string;
begin
  if not SQLConnection.Connected then
    SQLConnection.Open;

  aRecommended := 0;
  aBookmarked := 0;
  aRecommendationCount := 0;
  aCommentCount := 0;

  try
    try
      // 해당 레시피에 대하여 추천을 했는지 확인
      query := 'Select Recipe_Serial' +
               '  From RecipeRecommendation' +
               ' Where Recipe_Serial=' + aRecipeSerial.ToString +
               '   And Users_Serial=' + aUserSerial.ToString;

      aRecommended := CM.ServerMethods1Client.GetCount(query);

      // 해당 레시피에 대하여 북마크를 했는지 확인
      query := 'Select Serial' +
               '  From Bookmark' +
               ' Where Users_Serial=' + aUserSerial.ToString +
               '   And ContentsType=1' +
               '   And ContentsSerial=' + aRecipeSerial.ToString;

      aBookmarked := CM.ServerMethods1Client.GetCount(query);

      // 레시피의 추천 및 댓글의 개수를 가져온다
      DSRecipeCount.Close;
      DSRecipeCount.ParamByName('RecipeSerial').Value := aRecipeSerial;
      DSRecipeCount.Open;

      if not DSRecipeCount.IsEmpty then
      begin
        aRecommendationCount := DSRecipeCount.FieldByName('RecommendationCount').AsInteger;
        aCommentCount := DSRecipeCount.FieldByName('CommentCount').AsInteger;
      end;
    except
    end;
  finally
    DSRecipeCount.Close;
    SQLConnection.Close;
  end;
end;

procedure TCM.SetSetup(UserSerial: LargeInt; AlaramOn: Boolean);
begin
  try
    DSSetup.Close;
    DSSetup.ParamByName('UserSerial').Value := UserSerial;
    DSSetup.Open;

    if not DSSetup.IsEmpty then
    begin
      DSSetup.Edit;
      DSSetup.FieldByName('AlaramOn').AsBoolean := AlaramOn;
      DSSetup.Post;
    end
    else if UserSerial >= 0 then
    begin
      DSSetupInsert.Close;
      DSSetupInsert.ParamByName('UserSerial').Value := UserSerial;
      DSSetupInsert.ParamByName('AlaramOn').Value := AlaramOn;
      DSSetupInsert.Execute;
    end;
  finally
    DSSetup.Close;
    DSSetupInsert.Close;
    SQLConnection.Close;
  end;
end;

function TCM.UpdateRecipeBookmark(aRecipeSerial, aUserSerial: LargeInt;
  aActive: Boolean): Boolean;
var
  sQuery: string;
  nFindBookmarkSerial: LargeInt;
begin
  if not SQLConnection.Connected then
    SQLConnection.Open;

  try
    try
      // 해당 레시피가 북마크 되어 있는지 확인한다
      sQuery := 'Select * From Bookmark ' +
                ' Where Users_Serial=' + aUserSerial.ToString +
                '   And ContentsSerial = ' + aRecipeSerial.ToString +
                '   And ContentsType=1';
      nFindBookmarkSerial := ServerMethods1Client.GetQueryLargeInt(sQuery, 'Serial');

      result := True;
      sQuery := '';
      // Bookmark 해야 할 경우
      if aActive then
      begin
        // 이전에 북마크 한 것이 없으면, 북마크를 추가한다
        if nFindBookmarkSerial = -1 then
          sQuery := 'Insert Into Bookmark ' +
                    '(Users_Serial, ContentsType, ContentsSerial, CreatedDate) ' +
                    'VALUES ' +
                    '(' + aUserSerial.ToString + ', 1, ' + aRecipeSerial.ToString + ', ''' + FormatDatetime('YYYY-MM-DD HH:NN:SS', now) + ''')';
      end
      // Bookmark 에서 없애야 할 경우
      else
      begin
        // 이전 Bookmark가 있으면, 테이블에서 Bookmark를 삭제한다
        if nFindBookmarkSerial > -1 then
          sQuery := 'Delete from Bookmark ' +
                    ' Where Users_Serial=' + aUserSerial.ToString +
                    '   AND ContentsType=1' +
                    '   AND ContentsSerial=' + aRecipeSerial.ToString;
      end;

      if sQuery.Trim <> '' then
        result := ServerMethods1Client.UpdateQuery(sQuery);
    except
      result := False;
    end;
  finally
    SQLConnection.Close;
  end;
end;

function TCM.UpdateRecipeComment(aSerial: LargeInt; aComment: string): Boolean;
var
  sql: string;
begin
  try
    try
      sql := 'Update RecipeComment' +
             '   Set Contents=''' + aComment + '''' +
             ' Where Serial=' + aSerial.ToString;

      result := ServerMethods1Client.UpdateQuery(sql);
    except
      on E:Exception do
        Showmessage(E.Message);
    end;
  finally
    SQLConnection.Close;
  end;
end;

function TCM.UpdateRecipeRecommendation(aRecipeSerial,
  aUserSerial: LargeInt; aActive: Boolean): Boolean;
var
  sQuery: string;
  nFindSerial: LargeInt;
begin
  if not SQLConnection.Connected then
    SQLConnection.Open;

  try
    try
      // 레시피를 사용자가 추천한 것이 있는 확인한다
      sQuery := 'Select * From RecipeRecommendation ' +
                ' Where Users_Serial=' + aUserSerial.ToString +
                '   And Recipe_Serial=' + aRecipeSerial.ToString;
      nFindSerial := ServerMethods1Client.GetQueryLargeInt(sQuery, 'Recipe_Serial');

      result := True;
      sQuery := '';
      // 추천해야 할 경우
      if aActive then
      begin
        // 이전에 추천한 것이 없으면, 추천 테이블에 추가한다
        if nFindSerial = -1 then
          sQuery := 'Insert Into RecipeRecommendation ' +
                    '(Recipe_Serial, Users_Serial, CreatedDate) ' +
                    'VALUES ' +
                    '(' + aRecipeSerial.ToString + ', ' + aUserSerial.ToString + ', ''' + FormatDatetime('YYYY-MM-DD HH:NN:SS', now) + ''')';
      end
      // 추천하지 않아야 할 경우
      else
      begin
        // 이전체 추천한 것이 있으면, 추천 테이블에서 사용자를 삭제한다
        if nFindSerial > -1 then
          sQuery := 'Delete From RecipeRecommendation' +
                    ' Where Users_Serial=' + aUserSerial.ToString +
                    '   And Recipe_Serial=' + aRecipeSerial.ToString;
      end;

      if sQuery.Trim <> '' then
        result := ServerMethods1Client.UpdateQuery(sQuery);
    except
      result := False;
    end;
  finally
    SQLConnection.Close;
  end;
end;

end.
