unit uWebFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.TabControl, System.Rtti, FMX.Objects, FMX.Layouts,
  FMX.Controls.Presentation;

type
  TframeWeb = class(TFrame)
    Rectangle1: TRectangle;
    layoutBackButton: TLayout;
    Image1: TImage;
    tabWeb: TTabControl;
    procedure layoutBackButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure OnShouldStartLoadWithRequest(ASender: TObject; const URL: string);
    function CallMethod(AMethodName: string; AParameters: TArray<TValue>): TValue;
    function ProcessMethodUrlParse(AUrl: string; var MethodName: string; var Parameters: TArray<TValue>): Boolean;
    procedure AddTab(ATabControl: TTabControl);
  public
    { Public declarations }
    procedure goURL(url: string; aNew:Boolean=False);
    procedure CloseWebbrowserOne;
  end;

implementation
uses FMX.WebBrowser, uGlobal, uMain, System.NetEncoding, ClientModuleUnit,
  FMX.DialogService;
{$R *.fmx}

{ TframeWeb }

procedure TframeWeb.AddTab(ATabControl: TTabControl);
var
  oTab: TTabItem;
  oWeb: TWebBrowser;
  count: integer;
begin
  count := ATabControl.TabCount;

  oTab := TTabItem.Create(ATabControl);
  oTab.Parent := ATabControl;
  oTab.Index := count;

  oWeb := TWebBrowser.Create(oTab);
  oWeb.EnableCaching := False;
  oWeb.Parent := oTab;
  oWeb.Name := STR_WEBBROWSER_NAME + count.ToString;
  oWeb.Align := TAlignLayout.Client;
  oWeb.OnShouldStartLoadWithRequest := OnShouldStartLoadWithrequest;
end;

function TframeWeb.CallMethod(AMethodName: string;
  AParameters: TArray<TValue>): TValue;
var
  web: TWebBrowser;
  Msg: string;
  index: integer;
begin
  if AMethodName = 'login' then // Web에서 로그인 되었을 때
  begin
    if CM.Login(AParameters[0].AsString, AParameters[1].AsString, Msg) then
    begin
      // Save Login Information;
      _info.login.email := AParameters[0].AsString;
      _info.login.password := AParameters[1].AsString;
      _info.login.autoLogin := (AParameters[2].AsString = '1');
      _info.login.SaveInfo;

      frmMain.actLogin.Execute;

      CloseWebBrowserOne;
    end
    else
      ShowMessage(Msg);
  end
  else if AMethodName = 'newpage' then
  begin
    if not AParameters[0].AsString.IsEmpty then
      goURL(AParameters[0].AsString, True);
  end
  else if AMethodName = 'recipe' then
  else if AMethodName = 'message' then
    ShowMessage(AParameters[0].AsString)
  else if AMethodName = 'close' then
  begin
    if not AParameters[0].AsString.IsEmpty then
    begin
      MessageDlg( AParameters[0].AsString, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK], 0,
        procedure(const AResult: TModalResult)
        begin
          CloseWebbrowserOne;
        end
      )
    end
    else
      CloseWebbrowserOne;
  end
  else if AMethodName = 'close_register' then // Paramer 0 = email
  begin
    if tabWeb.TabCount > 1 then
    begin
      index := tabWeb.TabCount - 1;

      web := TWebBrowser(tabWeb.Tabs[index].FindComponent(STR_WEBBROWSER_NAME + index.ToString));

      web.EvaluateJavaScript('change_email(''' + AParameters[0].AsString + ''')');

      CloseWebbrowserOne;
    end;
  end;

end;

procedure TframeWeb.CloseWebbrowserOne;
begin
  if tabWeb.TabCount = 1 then
    frmMain.tabControlMain.ActiveTab := frmMain.tabMain;

  if tabWeb.TabCount > 1 then
  begin
    if tabWeb.ActiveTab <> nil then
      tabWeb.ActiveTab.DisposeOf;

    tabWeb.TabIndex := tabWeb.TabCount-1;
  end;
end;

procedure TframeWeb.goURL(url: string; aNew:Boolean);
var
  wb: TWebBrowser;
  index: integer;
  wbname: string;
begin
  if aNew then
  begin
    index := tabWeb.TabCount;
    AddTab(tabWeb);
  end
  else
  begin
    if TabWeb.TabCount = 0 then // Tab 이 없으면
    begin
      index := 0;
      AddTab(tabWeb);
    end
    else if TabWeb.TabCount = 1 then
      index := 0
    else // 새로운 Tab 이 필요하면
    begin
      index := tabWeb.TabCount;
      AddTab(tabWeb);
    end;
  end;

  wbName := STR_WEBBROWSER_NAME + Index.ToString;

  wb := TWebBrowser(tabWeb.Tabs[index].FindComponent(wbName));
  wb.Navigate('about:blank');
  wb.Navigate(url);
  tabWeb.TabIndex := index;
end;

procedure TframeWeb.layoutBackButtonClick(Sender: TObject);
//var
//  index: integer;
//  Web: TWebBrowser;
begin
  CloseWebbrowserOne;
//  if tabWeb.ActiveTab <> nil then
//  begin
//    index := tabWeb.ActiveTab.Index;
//
//    web := TWebBrowser(tabWeb.Tabs[index].FindComponent(STR_WEBBROWSER_NAME + index.ToString));
//
//    if web <> nil then
//    begin
//      if index >= 0 then // Tab 이 있으면
//      begin
//        tabWeb.Delete(index);// .Tabs[index].Free;
//        tabWeb.TabIndex := tabWeb.TabCount - 1;
//      end;
//
////      if web.CanGoBack then // 이전 페이지가 있으면
////        web.GoBack
////      else if index >= 0 then // Tab 이 있으면
////      begin
////        tabWeb.Delete(index);// .Tabs[index].Free;
////        tabWeb.TabIndex := tabWeb.TabCount - 1;
////      end;
//    end;
//  end;
//
//  if tabWeb.TabCount = 0 then
//    frmMain.tabControlMain.ActiveTab := frmMain.tabMain;
end;

procedure TframeWeb.OnShouldStartLoadWithRequest(ASender: TObject;
  const URL: string);
var
  MethodName: string;
  Params: TArray<TValue>;
begin
  if ProcessMethodUrlParse(URL, MethodName, Params) then
    CallMethod(Methodname, Params);
end;

function TframeWeb.ProcessMethodUrlParse(AUrl: string; var MethodName: string;
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
