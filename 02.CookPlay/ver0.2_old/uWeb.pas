unit uWeb;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Objects, FMX.Controls3D, FMX.Layers3D, FMX.Layouts,
  FMX.WebBrowser, system.RTTI, FMX.Controls.Presentation, FMX.StdCtrls, Data.DB,
  FMX.Ani, FMX.TabControl, uGlobal;

type
  TfrmWeb = class(TForm)
    Rectangle1: TRectangle;
    layoutBackButton: TLayout;
    Image1: TImage;
    tabWeb: TTabControl;
    procedure layoutBackButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FBottomMenuIndex: TBottomMenu;
    procedure OnShouldStartLoadWithRequest(ASender: TObject; const URL: string);
    function CallMethod(AMethodName: string; AParameters: TArray<TValue>): TValue;
    function ProcessMethodUrlParse(AUrl: string; var MethodName: string; var Parameters: TArray<TValue>): Boolean;
    procedure AddTab(ATabControl: TTabControl);
  public
    { Public declarations }
    procedure goURL(url: string);
  end;

var
  frmWeb: TfrmWeb;

implementation
uses cookplay.StatusBar, system.NetEncoding, ClientModuleUnit, uMain;
{$R *.fmx}

procedure TfrmWeb.AddTab(ATabControl: TTabControl);
var
  oTab: TTabItem;
  oWeb: TWebBrowser;
  count: integer;
begin
  count := ATabControl.TabCount;

  oTab := TTabItem.Create(ATabControl);
  oTab.Parent := ATabControl;
  oTab.Index := count;

  oWeb := TWebBrowser.Create(self);
  oWeb.EnableCaching := False;
  oWeb.Parent := oTab;
  oWeb.Name := STR_WEBBROWSER_NAME + count.ToString;
  oWeb.Align := TAlignLayout.Client;
  oWeb.OnShouldStartLoadWithRequest := OnShouldStartLoadWithrequest;
end;

function TfrmWeb.CallMethod(AMethodName: string;
  AParameters: TArray<TValue>): TValue;
var
  Msg: string;
begin
  if AMethodName = 'login' then
  begin
    if CM.Login(AParameters[0].AsString, AParameters[1].AsString, Msg) then
    begin
      // Save Login Information;
      _info.login.email := AParameters[0].AsString;
      _info.login.password := AParameters[1].AsString;
      _info.login.autoLogin := (AParameters[2].AsString = '1');

      _info.login.SaveInfo;

      frmMain.actLogin.Execute;

      ModalResult := mrOK;
    end
    else
      ShowMessage(Msg);
  end
  else if AMethodName = 'newpage' then
  begin
    if not AParameters[0].AsString.IsEmpty then
      goURL(AParameters[0].AsString);
  end
  else if AMethodName = 'recipe' then
  else if AMethodName = 'message' then
    ShowMessage(AParameters[0].AsString);
end;

procedure TfrmWeb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult := mrClose;
end;

procedure TfrmWeb.FormCreate(Sender: TObject);
begin
  // 첫번째 Tab 세팅
  tabWeb.TabPosition := TTabPosition.None;

  // Status Bar 색을 바꾼다
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);

  // Main의 menuitem 을 초기화한다
  FBottomMenuIndex := bmNone;
end;

procedure TfrmWeb.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    layoutBackButton.OnClick(layoutBackButton);
  end;
end;

procedure TfrmWeb.goURL(url: string);
var
  wb: TWebBrowser;
  index: integer;
  wbname: string;
begin
  if TabWeb.TabCount = 0 then // Tab 이 없으면
  begin
    index := 0;
    AddTab(tabWeb);
  end
  else // 새로운 Tab 이 필요하면
  begin
    index := tabWeb.TabCount;
    AddTab(tabWeb);
  end;

  wbName := STR_WEBBROWSER_NAME + Index.ToString;

  wb := TWebBrowser(FindComponent(wbName));
  wb.Navigate(url);
  tabWeb.TabIndex := index;
end;

procedure TfrmWeb.layoutBackButtonClick(Sender: TObject);
var
  Web: TWebBrowser;
begin
  web := TWebBrowser(FindComponent(STR_WEBBROWSER_NAME + tabWeb.ActiveTab.Index.ToString));

  if web.CanGoBack then // 이전 페이지가 있으면
    web.GoBack
  else if tabWeb.ActiveTab.Index >= 0 then // Tab 이 있으면
  begin
    web.DisposeOf;
    tabWeb.ActiveTab.DisposeOf;
    tabWeb.TabIndex := tabWeb.TabCount - 1;
  end;

  if tabWeb.TabCount = 0 then
    Close;
end;

procedure TfrmWeb.OnShouldStartLoadWithRequest(ASender: TObject;
  const URL: string);
var
  MethodName: string;
  Params: TArray<TValue>;
begin
  if ProcessMethodUrlParse(URL, MethodName, Params) then
    CallMethod(Methodname, Params);
end;

function TfrmWeb.ProcessMethodUrlParse(AUrl: string; var MethodName: string;
  var Parameters: TArray<TValue>): Boolean;
const
  JSCALL_PREFIX = 'appcall://';
  JSCALL_PREFIX_LEN = Length(JSCALL_PREFIX);
var
  I: Integer;
  ParamStr: string;
  ParamArray: TArray<string>;
begin
  // iOS에서 특수기호(|)가 멀티바이트로 넘어옴
  AUrl := TNetEncoding.URL.Decode(AUrl);

  if AUrl.IndexOf(JSCALL_PREFIX) = -1 then
    Exit(False);

  if AUrl.IndexOf('?') > 0 then
  begin
    MethodName := AUrl.Substring(JSCALL_PREFIX_LEN, AUrl.IndexOf('?')-JSCALL_PREFIX_LEN);

    ParamStr := AUrl.Substring(AUrl.IndexOf('?')+1, Length(AUrl));
    ParamArray := ParamStr.Split(['&']);
    SetLength(Parameters, length(ParamArray));
    for I := 0 to Length(ParamArray)-1 do
      Parameters[I] := ParamArray[I];
  end
  else
    MethodName := AUrl.Substring(JSCALL_PREFIX_LEN, MaxInt);
  if MethodName.IndexOf('/') > 0 then
    MethodName := MethodName.Replace('/', '');

  Result := not MethodName.IsEmpty;
end;

end.
