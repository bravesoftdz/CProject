unit uGlobal;

interface

uses System.UITypes, System.SysUtils, System.IOUtils, iniFiles, FMX.Dialogs,
    System.Classes, Data.DB, FMX.WebBrowser;

type
  TSetupInfo = record
    AlaramOn: Boolean;
    ScreenOn: Boolean;
  end;

  TLoginInfo = class
  private
  public
    setup: TSetupInfo;
    autoLogin: Boolean;
    email: string;
    password: string;

    procedure LoadInfo;
    procedure SaveInfo;
  end;

  TInfo = class
  private
    FLogin: TLoginInfo;
    function GetLogined: Boolean;
    function GetUserSerial: LargeInt;
  public
    constructor Create;
  published
    property login: TLoginInfo read FLogin;
    property Logined: Boolean read GetLogined;
    property UserSerial: LargeInt read GetUserSerial;
  end;

  TBottomMenu = (bmNone=-1, bmHome, bmNewsFeed, bmRecipe, bmCookbook, bmMyhome);

function IsBackKey(var Key: Word): Boolean;
function GetColor(color: TAlphaColor): TAlphaColor;
function GetCountString(cnt: integer): string;
procedure CallNewWeb(url: string);

const
  DEFAULT_WIDTH = 375;
  COLOR_BACKGROUND = $FFFF7500;
  COLOR_ACTIVE_SWITCH = $FFFF7500;
  COLOR_INACTIVE_SWITCH = $FFB0B0B0;
  STR_WEBBROWSER_NAME = 'WebBrowser';

  TITLE_Login = '로그인';
  TITLE_Registration = '회원가입';

  URL_LOGIN = 'http://test.cookplay.net/test/login.php';
  URL_RECIPE = 'http://test.cookplay.net/test/recipe.php';

var
  _info: TInfo;

implementation
uses FMX.VirtualKeyboard, FMX.Platform, FMX.Types, ClientModuleUnit, uWeb;
{ TInfo }

constructor TInfo.Create;
begin
  inherited;

  FLogin := TLoginInfo.Create;
  FLogin.LoadInfo;
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

  IniFile := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'loginInfo.ini'));
  try
    autoLogin := IniFile.ReadBool('Login', 'AutoLogin', False);
    email := IniFile.ReadString('Login', 'Email', '');
    password := IniFile.ReadString('Login', 'Password', '');
    setup.ScreenOn := IniFile.ReadBool('Setup', 'ScreenOn', True);
    setup.AlaramOn := IniFile.ReadBool('Setup', 'AlaramOn', True);
  finally
    IniFile.Free;
  end;

  if _info.Logined then
    CM.GetSetup(_info.UserSerial, setup.AlaramOn)
end;

procedure TLoginInfo.SaveInfo;
var
  iniFile: TIniFile;
begin
  IniFile := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'loginInfo.ini'));
  try
    IniFile.WriteBool('Login', 'AutoLogin', autoLogin);
    IniFile.WriteString('Login', 'Email', email);
    IniFile.WriteString('Login', 'Password', password);
    IniFile.ReadBool('Setup', 'ScreenOn', setup.ScreenOn);
    IniFile.ReadBool('Setup', 'AlaramOn', setup.AlaramOn);
  finally
    IniFile.Free;
  end;

  if _info.Logined then
    CM.SetSetup(_info.UserSerial, setup.AlaramOn);
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

procedure CallNewWeb(url: string);
var
  Form: TfrmWeb;
begin
  Form := TfrmWeb.CreateNew(nil, 1);
  Form.Visible := False;
  Form.goURL('http://test.cookplay.net/test/sign_up.php');
  Form.ShowModal(procedure (ModalResult: TModalResult) begin end);
end;

end.
