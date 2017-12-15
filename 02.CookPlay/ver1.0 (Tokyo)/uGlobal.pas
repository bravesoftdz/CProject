unit uGlobal;

interface

uses System.UITypes, System.SysUtils, System.IOUtils, iniFiles, FMX.Dialogs,
    System.Classes, Data.DB, FMX.WebBrowser, FMX.Types, FMX.Layouts,
    FMX.Objects, FMX.Ani, FMX.Memo, System.Bluetooth, System.Bluetooth.Components,
    cookplay.Scale, System.Math;

type
  TCallbackFunc = procedure(const AResultList: TStringList=nil) of Object;
  TCallbackRefFunc = reference to procedure(const AResultList: TStringList=nil);
  TCallbackModalRefFunc = reference to procedure(const AResult: TModalResult);
  TCallbackBoolRefFunc = reference to procedure(const AResult: Boolean);

  TListType = (ltMyRecipe=0);
  TBottomMenu = (bmNone=-1, bmHome, bmNewsFeed, bmRecipe, bmCookbook, bmMyhome);
  TMyhomeMenu = (mhNone=-1, mhNewsfeed, mhRecipe, mhCookbook, mhBookmark);
  TPicturetype = (ptPicture=0, ptVideo);
  TRecipeState = (rsNone=0, rsNew, rsEdit, rsDeleted);
  TIngredientType = (itIngredient=0, itSeasoning, itTemperature, itTime, itRecipeLink);
//  TIngredientUnit = (wuNone=0, wuG, wuKg, wuPound, wuOunce, wuCentigrade, wuFahrenheit, wuSec, wuMinute, wuHour);
  TPictureVisibleState = (pvInvisible=0, pvVisible);
  TRecipeViewType = (rvRecent, rvBest);
  TPictureState = (psNotLoaded, psLoaded);
  TScaleMeasureType = (smViewSetup, smViewRatio, smViewMeasure, smPlay);
  TTimerMeasureType = (tmView, tmPlay);

  TSetupInfo = record
    AlaramOn: Boolean;
    ScreenOn: Boolean;
  end;

  TUserInfo = record
    Alaram: integer;
    Follower: integer;
    Follow: integer;
    Recipe: integer;
    Cookbook: integer;
    Notice: integer;
    MyFeed: integer;
    procedure Clear;
    procedure SetInfo(aAlaram, aFollower, aFollow, aRecipe, aCookbook, aNotice, aMyFeed: integer);
  end;

  TScaleMeasureInfo = record
    MaxWeight: Single;  // 전자저울 최대무게
    SmallWeight: Single;  // 전자저울 최소무게
    WeightUnit: TIngredientUnit;  // 전자저울 무게단위
    UserWeightUnit: TIngredientUnit;  // 사용자가 선택한 전자저울 무게단위, 선택을 안했을 경우 wuNone으로 세팅 = -1
  end;

  TLoginInfo = class
  private
  public
    setup: TSetupInfo;
    autoLogin: Boolean;
    email: string;
    password: string;

    scale: TScaleMeasureInfo;

    procedure LoadInfo;
    procedure SaveInfo;
  end;

  TMyRecipeList = record
    Serial: TStringList;
    Title: TStringList;
    PictureName: TStringList;
  end;

  TInfo = class
  private
    FLogin: TLoginInfo;
    FUser: TUserInfo;
    function GetLogined: Boolean;
    function GetUserSerial: LargeInt;
  public
    constructor Create;
  published
    property login: TLoginInfo read FLogin;
    property Logined: Boolean read GetLogined;
    property UserSerial: LargeInt read GetUserSerial;
    property user: TUserInfo read FUser;
  end;

  TRecipeListItem = class
    RecipeSerial: LargeInt;
    PictureName: string;
    Title: string;
    RecommendationCount: integer;
    CommentCount: integer;
    txtRecommendationCount: TText;
    txtCommentCount: TText;
    BodyLayout: TLayout;
    AniColor: TColorAnimation;
  end;

  TRecipeChangeWeightItem = class
    IngredientType: TIngredientType;
    Title: string;
    sorWeight: Single;
    tarWeight: Single;

    recItemBody: TRectangle;
    imgIcon: TImage;
    txtTitle: TText;
    txtWeight: TText;

    AniFloat: TFloatAnimation;
  end;

  TRecipeChangeWeight = class
    RecipeSerial: LargeInt;
    sorServings: integer;
    tarServings: integer;
    tarWeightRatio: Single;
    Ingredients: TStringList;
  public
    procedure Clear;
    function IngredientItem(aIndex: integer): TRecipeChangeWeightItem;
    function Ratio: Single;
    function NewWeight(aSorWeight: Single): Single;
  end;

  TRecipeCommentInfo = class
    Serial: LargeInt;
    Recipe_Serial: LargeInt;
    Users_Serial: LargeInt;
    Contents: string;
    PictureType: integer;
    Picture: string;
    UserPicture: string;
    Nickname: string;
    CreatedDatetime: string;
  end;

  TRecipeViewIngredient = record
    Title: string;
    Amount: string;
    AUnit: string;
    Seq: integer;

    LinkedRecipe: LargeInt;
    ItemType: TIngredientType;
    ItemWeightValue: Single;
    ItemTimeValue: string;
    ItemTemperatureValue: Single;
    ItemUnit: TIngredientUnit;
  private
    function GetString: string;
  public
    property ToString: string read GetString;
  end;

  TRecipeViewStep = record
    StepSerial: LargeInt;
    PictureName: String;
    Description: string;
    StepSeq: integer;

    IngredientPosition: integer; // 시작은 0 부터
    Ingredients: array of TRecipeViewIngredient;
  private
    function GetCount: integer;
  public
    procedure Clear;
    property IngredientCount: integer read GetCount;
  end;

  TRecipeView = record
    RecipeSerial: LargeInt;
    Title: string;

    StepPosition: integer; // 시작은 0 부터
    Steps: array of TRecipeViewStep;
  private
    function GetCount: integer;
  public
    procedure Clear;
    property StepCount: integer read GetCount;
  end;

function IsBackKey(var Key: Word): Boolean;
function GetColor(color: TAlphaColor): TAlphaColor;
function GetCountString(cnt: integer): string;
procedure HideVirtualKeyboard;
procedure ShowVirtualKeyboard(const AControl: TFmxObject);
function IsVirtualKeyShown: Boolean;
procedure ShowMessage1(msg: string);
function GetLineCount(text: string): integer;
function GetTextHeight(aText: TText; aStr: string): Single;
function GetDateString(aDateTime: string): string;
function GetWeightUnitString(aValue: TIngredientUnit): string;

// 전자저울 DiscoverDevices
procedure ScaleEndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);

const
  DEFAULT_WIDTH = 375;
  COLOR_BACKGROUND = $FFFF7500;
  COLOR_ACTIVE_SWITCH = $FFFF7500;
  COLOR_INACTIVE_SWITCH = $FFB0B0B0;
  COLOR_INACTIVE_TEXT = $FFB0B0B0;
  COLOR_ACTIVE_TEXT = $FFFF7500;
  COLOR_BACKGROUND_IMAGE = $FFFFEDDD;
  COLOR_BOX_ROUND = $FFD8D8D8;
  COLOR_RECIPE_BACKGROUND = $FFEEEEEE;
  COLOR_UNDERBAR = $FFE6E6E6;
  STR_WEBBROWSER_NAME = 'WebBrowser';

  COLOR_GRAY_BACKGROUND = $FFF5F5F5;
  COLOR_GRAY_LINE = $FFD8D8D8;
  COLOR_GRAY_PLACEHOLDER = $FFBDBDBD;
  COLOR_GRAY_UNSELECTED1 = $FFB2B2B2;
  COLOR_GRAY_UNSELECTED2 = $FF888888;
  COLOR_GRAY_BUTTONTEXT = $FF585858;
  COLOR_GRAY_TEXT = $FF5E5E5E;

  COLOR_ORANGE_BACKGROUND = $FFFFEDDD;
  COLOR_ORANGE_LINE = $FFFFBB81;
  COLOR_ORANGE_PLACEHOLDER = $FFFF9000;
  COLOR_ORANGE_UNSELECTED1 = $FFFF7500;
  COLOR_ORANGE_UNSELECTED2 = $FFFF5F00;
  COLOR_ORANGE_BUTTONTEXT = $FFFF6322;

  COLOR_GREEN_UNSELECTED1 = $FFBDC000;
  COLOR_GREEN_UNSELECTED2 = $FF85AC1B;

  COLOR_SCALE_NORMAL = $FFFF7500;
  COLOR_SCALE_GOOD = $FF8DC000;
  COLOR_SCALE_OVER = $FFFF5F00;

  CRLF = #13#10;

  TITLE_Login = '로그인';
  TITLE_Registration = '회원가입';

  RESULT_SUCCESS = '1';
  RESULT_FAIL = '0';

  URL_LOGIN = 'http://test.cookplay.net/test/login.php';
  URL_RECIPE = 'http://test.cookplay.net/test/recipe.php';
  URL_RECIPE_VIEW = 'http://test.cookplay.net/test/recipe_view.php';

  DELIMETER_CATEGORY = ';';

  NEW_RECIPE_SERIAL = -1;
  NEW_STEP_SERIAL = -1;
  NEW_INGREDIENT_SERIAL = -1;
  NEW_PICTURE = '';
  INIT_TIME_STR = '00:00:00';

  CATEGORY0: array[0..11] of string = ('전체','메인반찬','밑반찬','국/찌게',
    '밥/죽/떡','김치','젓갈/장','퓨전','차/음료/술','양념/소스','베이커리',
    '디저트');

var
  _info: TInfo;
  _Scale: TScaleConnection;
  BluetoothLE: TBluetoothLE;

implementation
uses FMX.VirtualKeyboard, FMX.Platform, ClientModuleUnit;

procedure HideVirtualKeyboard;
var
  FService: IFMXVirtualKeyboardService;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if (FService <> nil) then
    FService.HideVirtualKeyboard;
end;

procedure ShowVirtualKeyboard(const AControl: TFmxObject);
var
  FService: IFMXVirtualKeyboardService;
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if (FService <> nil) then
    FService.ShowVirtualKeyboard(AControl);
end;

function IsVirtualKeyShown: Boolean;
var
  FService: IFMXVirtualKeyboardService;
begin
  result := False;
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
  if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyboardState) then
    result := True;
end;

procedure ShowMessage1(msg: string);
begin

end;

{ TInfo }

constructor TInfo.Create;
begin
  inherited;

  FLogin := TLoginInfo.Create;
  FLogin.LoadInfo;

  FUser.Clear;
end;

function TInfo.GetLogined: Boolean;
begin
  result := not CM.memUser.IsEmpty;
end;

function TInfo.GetUserSerial: LargeInt;
begin
  if Logined then
    result := CM.memUser.FieldByName('Serial').AsLargeInt
  else
    result := -1;
end;

{ TLoginInfo }

procedure TLoginInfo.LoadInfo;
var
  iniFile: TIniFile;
begin
  autoLogin := False;
  setup.ScreenOn := True;
  setup.AlaramOn := True;

  IniFile := TIniFile.Create(System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'loginInfo.ini'));
  try
    autoLogin := IniFile.ReadBool('Login', 'AutoLogin', False);
    email := IniFile.ReadString('Login', 'Email', '');
    password := IniFile.ReadString('Login', 'Password', '');
    setup.ScreenOn := IniFile.ReadBool('Setup', 'ScreenOn', True);
    setup.AlaramOn := IniFile.ReadBool('Setup', 'AlaramOn', True);
    scale.MaxWeight := IniFile.ReadFloat('Scale', 'MaxWeight', WEIGHT_DEFAULT_MAX); // default = 1kg = 10000g
    scale.SmallWeight := Inifile.ReadFloat('Scale', 'SmallWeight', WEIGHT_DEFAULT_SMALL); // default = 1g
    scale.WeightUnit := TIngredientUnit(IniFile.ReadInteger('Scale', 'WeightUnit', Ord(TIngredientUnit.wuG)));
    scale.UserWeightUnit := TIngredientUnit(IniFile.ReadInteger('Scale', 'UserWeightUnit', Ord(TIngredientUnit.wuNone)));
  finally
    IniFile.Free;
  end;

//  if _info.Logined then
//    CM.GetSetup(_info.UserSerial, setup.AlaramOn)
end;

procedure TLoginInfo.SaveInfo;
var
  iniFile: TIniFile;
begin
  IniFile := TIniFile.Create(System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, 'loginInfo.ini'));
  try
    IniFile.WriteBool('Login', 'AutoLogin', autoLogin);
    IniFile.WriteString('Login', 'Email', email);
    IniFile.WriteString('Login', 'Password', password);
    IniFile.WriteBool('Setup', 'ScreenOn', setup.ScreenOn);
    IniFile.WriteBool('Setup', 'AlaramOn', setup.AlaramOn);
    IniFile.WriteFloat('Scale', 'MaxWeight', scale.MaxWeight);
    IniFile.WriteFloat('Scale', 'SmallWeight', scale.SmallWeight);
    IniFile.WriteInteger('Scale', 'WeightUnit', Ord(scale.WeightUnit));
    IniFile.WriteInteger('Scale', 'UserWeightUnit', Ord(scale.UserWeightUnit));
  finally
    IniFile.Free;
  end;

//  if _info.Logined then
//    CM.SetSetup(_info.UserSerial, setup.AlaramOn);
end;

function IsBackKey(var Key: Word): Boolean;
var
  FService : IFMXVirtualKeyboardService;  // FMX.Platform, FMX.VirtualKeyboard;
begin
  result := False;

  if Key = vkHardwareBack Then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

    // 키보드 뜬상태가 아닐때 : 키보드 뜬상태면 키보드 자체종료 시킴.
    if not ( (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) ) then
    begin
      Key :=  0 ;  // 기본액션인 앱 종료를 방지함.

      result := True;
    end;
  end;
end;

function GetColor(color: TAlphaColor): TAlphaColor;
begin
  TAlphaColorRec(Result).R := TAlphaColorRec(color).R;
  TAlphaColorRec(Result).G := TAlphaColorRec(color).G;
  TAlphaColorRec(Result).B := TAlphaColorRec(color).B;
  TAlphaColorRec(Result).A := 0;
end;

function GetCountString(cnt: integer): string;
var
  m, n: integer;
begin
  if cnt < 10000 then //만
    result := FormatFloat('0,', cnt)
  else if cnt < 100000 then //십만
  begin
    m := cnt div 10000; //만
    n := (cnt mod 10000) div 1000; // 천
    result := m.ToString + '.' + n.ToString + '만';
  end
  else if cnt < 1000000 then //백만
  begin
    m := cnt div 100000; //십만
    n := (cnt mod 100000) div 10000; //만
    result := m.ToString + '.' + n.ToString + '십만';
  end
  else if cnt < 100000000 then //천만
  begin
    m := cnt div 1000000; //백만
    n := (cnt mod 1000000) div 100000; //십만
    result := m.ToString + '.' + n.ToString + '백만';
  end
  else if cnt < 100000000 then // 억
  begin
    m := cnt div 10000000; //천만
    n := (cnt mod 10000000) div 1000000; //백만
    result := FormatFloat('#,', m) + '.' + n.ToString + '천만';
  end
  else // 억이상
  begin
    m := cnt div 100000000; // 억
    n := (cnt - 100000000) div 10000000; //천만
    result := FormatFloat('#,', m) + '.' + n.ToString + '억';
  end;
end;

{ TUserInfo }

procedure TUserInfo.Clear;
begin
  Alaram := 0;
  Follower := 0;
  Follow := 0;
  Recipe := 0;
  Cookbook := 0;
  Notice := 0;
  MyFeed := 0;
end;

procedure TUserInfo.SetInfo(aAlaram, aFollower, aFollow, aRecipe,
  aCookbook, aNotice, aMyFeed: integer);
begin
  Alaram := aAlaram;
  Follower := aFollower;
  Follow := aFollow;
  Recipe := aRecipe;
  Cookbook := aCookbook;
  Notice := aNotice;
  MyFeed := aMyFeed;
end;

{ TRecipeChangeWeight }

procedure TRecipeChangeWeight.Clear;
var
  i: integer;
begin
  RecipeSerial := NEW_RECIPE_SERIAL;
  sorServings := 1;
  tarServings := 1;
  tarWeightRatio := 1;

  if Assigned(Ingredients) then
    while Ingredients.Count > 0 do
    begin
      IngredientItem(0).recItemBody.DisposeOf;
      Ingredients.Delete(0);
    end;
end;

function TRecipeChangeWeight.IngredientItem(
  aIndex: integer): TRecipeChangeWeightItem;
begin
  if Assigned(Ingredients) and (aIndex < Ingredients.Count) then
    result := TRecipeChangeWeightItem(Ingredients.Objects[aIndex])
  else
    result := nil;
end;

function TRecipeChangeWeight.NewWeight(aSorWeight: Single): Single;
begin
  result := aSorWeight * Ratio;
end;

function TRecipeChangeWeight.Ratio: Single;
begin
  result := (tarServings / sorServings) * RoundTo(tarWeightRatio, -5);
end;

function GetLineCount(text: string): integer;
var
  aMemo: TMemo;
begin
  try
    aMemo := TMemo.Create(nil);
    aMemo.Lines.Text := text;
    result := aMemo.Lines.Count;
  finally
    aMemo.DisposeOf;
  end;
end;

function GetTextHeight(aText: TText; aStr: string): Single;
var
  linecount: integer;
begin
  linecount := GetLineCount(aStr);

  result := aText.Canvas.TextHeight('CookPlay') * linecount;
end;

function GetDateString(aDateTime: string): string;
var
  ShortMonthNames: array[1..12] of string;
  year, month, day: word;
  aDate: TDateTime;
begin
  ShortMonthNames[ 1] := 'Jan';
  ShortMonthNames[ 2] := 'Feb';
  ShortMonthNames[ 3] := 'Mar';
  ShortMonthNames[ 4] := 'Apr';
  ShortMonthNames[ 5] := 'May';
  ShortMonthNames[ 6] := 'Jun';
  ShortMonthNames[ 7] := 'Jul';
  ShortMonthNames[ 8] := 'Aug';
  ShortMonthNames[ 9] := 'Sep';
  ShortMonthNames[10] := 'Oct';
  ShortMonthNames[11] := 'Nov';
  ShortMonthNames[12] := 'Dec';

  try
    aDate := StrToDatetime(aDateTime);
    DecodeDate(aDate, year, month, day);

    result := ShortMonthNames[month] + FormatDateTime(' mm, ampm h:mm', aDate);
  except
    result := '';
  end;
end;

function GetWeightUnitString(aValue: TIngredientUnit): string;
begin
  case aValue of
    wu01G: result := 'g';
    wuG: result := 'g';
    wuKg: result := 'kg';
    wuPound: result := 'lb';
    wuOunce: result := 'oz';
    else result := '';
  end;
end;


procedure ScaleEndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
var
  i, k: integer;
begin
  if ADeviceList.Count < 1 then
  begin
    ShowMessage( 'Cookplay 전자저울을 찾을 수 없습니다!');
    Exit;
  end
  else
  begin
    for i:=0 to ADeviceList.Count-1 do
      for k := 0 to Length(BLE)-1 do
      begin
        if Uppercase(ADeviceList.Items[i].DeviceName) = UpperCase(BLE[k].DeviceName) then
        begin
          _Scale.ConnectDevice(ADeviceList.Items[i]);
          Break;
        end;
      end;
  end;
end;

{ TRecipeView }

procedure TRecipeView.Clear;
begin
  StepPosition := 0;
  SetLength(Steps, 0);
end;

function TRecipeView.GetCount: integer;
begin
  result := Length(Steps);
end;

{ TRecipeViewStep }

procedure TRecipeViewStep.Clear;
begin
  IngredientPosition := 0;
end;

function TRecipeViewStep.GetCount: integer;
begin
  result := Length(Ingredients);
end;

{ TRecipeViewIngredient }

function TRecipeViewIngredient.GetString: string;
begin
  result := Title + ' ' + Amount + AUnit;
  if ItemWeightValue > 0 then
    result := result + '(' + ItemWeightValue.ToString + GetWeightUnitString(ItemUnit) + ')';
end;

end.
