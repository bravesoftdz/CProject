﻿unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.Effects, uGlobal,
  FMX.Ani, System.Rtti, FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.ScrollBox,
  FMX.Grid, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, System.ImageList, FMX.ImgList, Data.DB, System.Actions,
  FMX.ActnList, FMX.WebBrowser, FMX.StdActns, FMX.MediaLibrary.Actions,
  FMX.Media, cookplay.S3, FMX.ListBox, uListScroll,System.Bluetooth.Components,
  cookplay.Scale, System.Bluetooth;

type
  TfrmMain = class(TForm)
    layoutHitMenuButton: TLayout;
    Image3: TImage;
    txtMainTitle: TText;
    layoutHitSearchButton: TLayout;
    imgSearch: TImage;
    Rectangle1: TRectangle;
    tabcontrolService: TTabControl;
    tabHome: TTabItem;
    tabNewsFeed: TTabItem;
    Layout3D1: TLayout3D;
    tabControlLeftMenu: TTabControl;
    tabLeftMen: TTabItem;
    MenuRightRect: TRectangle;
    TabItem3: TTabItem;
    MenuLeftRect: TRectangle;
    layoutUser: TLayout;
    Line1: TLine;
    Line3: TLine;
    Layout9: TLayout;
    Layout10: TLayout;
    Circle1: TCircle;
    ShadowEffect1: TShadowEffect;
    Layout11: TLayout;
    txtNickname: TText;
    Text6: TText;
    Image7: TImage;
    Line7: TLine;
    layoutLogin: TLayout;
    layoutLoginTop: TLayout;
    lineLoginTop: TLine;
    layoutLeftmenuLogin: TLayout;
    Text7: TText;
    Image6: TImage;
    Line6: TLine;
    layoutOther: TLayout;
    layoutLeftmenuScale: TLayout;
    Text1: TText;
    Image8: TImage;
    Line4: TLine;
    layoutLeftmenuBuyScale: TLayout;
    Text3: TText;
    Image1: TImage;
    Line2: TLine;
    layoutLeftmenuQnA: TLayout;
    Text4: TText;
    Image2: TImage;
    layoutLeftmenuSetup: TLayout;
    Text5: TText;
    Image5: TImage;
    recBottomMenu: TRectangle;
    tabRecipe: TTabItem;
    tabCookbook: TTabItem;
    tabMyhome: TTabItem;
    imglistBottomMenu: TImageList;
    GridPanelLayout2: TGridPanelLayout;
    layoutNewsfeed: TLayout;
    imgNewsfeed: TImage;
    layoutRecipe: TLayout;
    imgRecipe: TImage;
    layoutCookbook: TLayout;
    imgCookbook: TImage;
    layoutMyhome: TLayout;
    imgMyhome: TImage;
    layoutHome: TLayout;
    imgHome: TImage;
    Layout1: TLayout;
    Layout5: TLayout;
    Image4: TImage;
    Text8: TText;
    txtFollower: TText;
    Text10: TText;
    txtFollowing: TText;
    Image9: TImage;
    txtRecipe: TText;
    Image10: TImage;
    txtCookbook: TText;
    ActionList1: TActionList;
    actLogin: TAction;
    actLogout: TAction;
    cirNotice: TCircle;
    recBlackScreen: TRectangle;
    tabTemp: TTabItem;
    recTitle: TRectangle;
    TabItem1: TTabItem;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    ShowShareSheetAction1: TShowShareSheetAction;
    Image12: TImage;
    Text9: TText;
    layoutMyhomeTop: TLayout;
    Layout4: TLayout;
    tabcontrolMyhome: TTabControl;
    tabMyhomeRecipe: TTabItem;
    tabMyHomeCookbook: TTabItem;
    tabMyhomeBookmark: TTabItem;
    tabMyhomeStory: TTabItem;
    gridpanelMyhome: TGridPanelLayout;
    layoutMyhomeNewsfeed: TLayout;
    layoutMyhomeRecipe: TLayout;
    layoutMyhomeCookbook: TLayout;
    layoutMyhomeBookmark: TLayout;
    Layout15: TLayout;
    lineMyhomeNewsfeed: TLine;
    txtMyhomeStory: TText;
    imgMyhomeStory: TImage;
    Layout16: TLayout;
    Layout17: TLayout;
    imgMyhomeRecipe: TImage;
    lineMyhomeRecipe: TLine;
    txtMyhomeRecipe: TText;
    Layout18: TLayout;
    Layout19: TLayout;
    imgMyhomeCookbook: TImage;
    lineMyhomeCookbook: TLine;
    txtMyhomeCookbook: TText;
    Layout20: TLayout;
    Layout21: TLayout;
    imgMyhomeBookmark: TImage;
    lineMyhomeBookmark: TLine;
    txtMyhomeBookmark: TText;
    Rectangle2: TRectangle;
    imgListMyhomeMenu: TImageList;
    Image11: TImage;
    Text11: TText;
    txtMyhomeFollowerCount: TText;
    layoutFollower: TLayout;
    layoutFollow: TLayout;
    Text12: TText;
    txtMyhomeFollowCount: TText;
    GridPanelLayout1: TGridPanelLayout;
    layoutMyhomNewsfeedCount: TLayout;
    layoutMyhomeRecipeCount: TLayout;
    layoutMyhomeCookbookCount: TLayout;
    Image13: TImage;
    txtMyhomeNewsfeedCount: TText;
    Image14: TImage;
    txtMyhomeRecipeCount: TText;
    Image15: TImage;
    txtMyhomeCookbookCount: TText;
    imgMyhomeBack: TImage;
    imglistAddItem: TImageList;
    recMyhomeBackground: TRectangle;
    layoutMyhomeAddItem: TLayout;
    imgAddCookbook: TImage;
    imgAddRecipe: TImage;
    imgAddStory: TImage;
    FloatAnimation1: TFloatAnimation;
    imgAddItem: TImage;
    Button1: TButton;
    recRecipeBody: TRectangle;
    StyleBook1: TStyleBook;
    scrollRecipeBody: TVertScrollBox;
    layoutRecipeListTop: TLayout;
    RoundRect1: TRoundRect;
    recRecipeButton: TRoundRect;
    txtRecipeButtonText: TText;
    txtRecipeRecent: TText;
    txtRecipeBest: TText;
    layoutRecipeListTemp: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Text2: TText;
    Image16: TImage;
    Image17: TImage;
    Text13: TText;
    Text14: TText;
    Layout8: TLayout;
    Button2: TButton;
    timeStart: TTimer;
    IdTCPClient1: TIdTCPClient;
    timeError: TTimer;
    Button3: TButton;
    procedure MenuRightRectClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure layoutHitSearchButtonClick(Sender: TObject);
    procedure layoutLeftmenuLoginClick(Sender: TObject);
    procedure layoutHomeClick(Sender: TObject);
    procedure actLoginExecute(Sender: TObject);
    procedure actLogoutExecute(Sender: TObject);
    procedure layoutLeftmenuSetupClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure layoutHitMenuButtonMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
    procedure layoutMyhomeNewsfeedMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure imgAddItemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure tabcontrolServiceChange(Sender: TObject);
    procedure imgAddRecipeClick(Sender: TObject);
    procedure recMyhomeBackgroundMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Button1Click(Sender: TObject);
    procedure txtRecipeBestClick(Sender: TObject);
    procedure scrollRecipeBodyViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
    procedure layoutLeftmenuScaleClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure timeStartTimer(Sender: TObject);
    procedure timeErrorTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FActiveTab: TTabItem;
    FRecipeList: TRecipeScrollList;
    FErrorMessage: string;

    procedure SetRecipeView(aRecipeView: TRecipeViewType);
    procedure ScaleEndDiscoverDevices(const Sender: TObject; const ADeviceList: TBluetoothLEDeviceList);
  public
    { Public declarations }
    procedure SetMenuLogin(ALogined: Boolean);
    procedure SetBottomMenu(menuindex: TBottomMenu);
    procedure SetMyhomeMenu(menuindex: TMyhomeMenu);
    procedure LeftMenuOpen(AShow: Boolean);
    function GetBottomMenuImage(index: TBottomMenu; AActive: Boolean): TBitmap;
    function GetMyhomeMenuImage(index: TMyhomeMenu; AActive: Boolean): TBitmap;
    procedure SetLoginInfo;
    procedure CallLoginForm(menuindex: TBottomMenu = bmNone);
    procedure SetMyhomeAddItemAction(aActive: Boolean);
  end;

var
  frmMain: TfrmMain;

implementation
uses cookplay.StatusBar, ClientModuleUnit, uRecipeEditor, uSetup, uWeb,
  uScaleView, uRecipePlay;
{$R *.fmx}

procedure TfrmMain.actLoginExecute(Sender: TObject);
var
  msg: string;
begin
  if CM.Login(_info.login.email, _info.login.password, msg) = lrSuccess then
  begin
    // setup 을 refresh 한다
    _info.login.LoadInfo;

    // menu 를 refresh 한다
    SetMenuLogin(True);

    // Myhome Menu를 정리한다
    SetMyhomeMenu(mhNewsfeed);

    // 메뉴의 사용자 정보를 출력한다, Myhome 에도
    SetLoginInfo;
  end
  else
    actLogout.Execute;
end;

procedure TfrmMain.actLogoutExecute(Sender: TObject);
begin
  SetMenuLogin(False);

  CM.CloseMemTable;

  SetBottomMenu(bmHome);
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  frmRecipeEditor.RecipeSerial := 197;
  frmRecipeEditor.Show;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  frmRecipePlay.Show;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  frmScaleView.SetValue('Test Weight', 1000, TScaleMeasureType.smViewRatio, wuG,
    procedure (const aResult: TStringList)
    begin
      if Assigned(aResult) and (aResult.Count > 0) then
        showmessage(aResult[0]);
    end
  );

  frmScaleView.Show;
end;

procedure TfrmMain.CallLoginForm(menuindex: TBottomMenu);
var
  url: string;
  aForm: TfrmWeb;
begin
  url := URL_LOGIN + '?email=' + _info.login.email + '&autologin=' + _info.login.autoLogin.ToInteger.ToString;

  aForm := TfrmWeb.Create(self);
  aForm.goURL(url);
  aForm.Show;
//
//  frmWeb.goURL(url);
//  frmWeb.Show;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // 설정정보를 저장한다
  _info.login.SaveInfo;

  if Assigned(FRecipeList) then
  begin
    FRecipeList.ClearControls;
    FRecipeList.DisposeOf;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // Myhome Add Item 위치 세팅
  SetMyhomeAddItemAction(False);
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    if tabControlLeftMenu.Visible then
      LeftMenuOpen(False)
    else if recMyhomeBackground.Opacity <> 0 then
      SetMyhomeAddItemAction(False)
    else
    begin
      MessageDlg( '종료 하시겠습니까 ?',
                   TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
       procedure(const AResult: TModalResult)
       begin
         case AResult of
           mrYES : Close;
         end;
       end);
    end
  end;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  tabControlLeftMenu.Position.X := 0;
  tabControlLeftMenu.Position.Y := 0;
  tabControlLeftMenu.Width  := frmMain.ClientWidth;
  tabControlLeftMenu.Height := frmMain.ClientHeight;
  tabControlLeftMenu.Padding.Bottom := 0;

  MenuLeftRect.Height := frmMain.ClientHeight;

  // MyHome Setting
  imgMyhomeBack.SendToBack;
  imgMyhomeBack.Position.X := 0;
  imgMyhomeBack.Position.Y := 0;
  imgMyhomeBack.Width := frmMain.ClientWidth;
  imgMyhomeBack.Height := layoutMyhomeTop.Height;

  recMyhomeBackground.Position.X := 0;
  recMyhomeBackground.Position.Y := 0;
  recMyhomeBackground.Width := frmMain.ClientWidth;
  recMyhomeBackground.Height := frmMain.ClientHeight;

//  SetMyhomeAddItemAction(False);

  recBlackScreen.Align := TAlignLayout.Client;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  // Status Bar 색을 바꾼다
  Fill.Color := GetColor(Fill.Color);
  StatusBarSetColor(Fill.Color);

  layoutRecipeListTemp.DisposeOf;

  // 블루투스 초기화
  BluetoothLE := TBluetoothLE.Create(nil);
  BluetoothLE.Enabled := True;

  // 전자저울 Object 초기화
  _Scale := TScaleConnection.Create(nil);

  // 환경정보 가져오기
  _info := TInfo.Create;

  // 아마존 S3 연결을 위한 초기화
  frmS3.init;

  // 블루투스 이벤트 연결
  BluetoothLE.OnEndDiscoverDevices := ScaleEndDiscoverDevices;

  tabcontrolService.TabPosition := TTabPosition.None;

  tabcontrolMyhome.TabPosition := TTabPosition.None;
  tabcontrolMyhome.ActiveTab := tabMyhomeStory;

  // 메뉴 보기 설정
  tabControlLeftMenu.BringToFront;
  tabControlLeftMenu.TabIndex := 0;
  tabControlLeftMenu.TabPosition := TTabPosition.None;

  // Search Image 보이지 않게 하기
  imgSearch.Visible := False;

  LeftMenuOpen(False); // True - Open, False - Close

  // 서비스세팅(로그인 되어야 사용할 수 있는 것 구분)
  SetBottomMenu(bmHome);

  try
    IdTCPClient1.Connect;
    IdTCPClient1.Disconnect;

    timeStart.Enabled := True;
  except
    FErrorMessage := '인터넷이 연결되어 있지 않습니다!' + #13#10 + '연결 후 다시 시작해 주십시오!';
    timeError.Enabled := True;
  end;
end;

function TfrmMain.GetBottomMenuImage(index: TBottomMenu; AActive: Boolean): TBitmap;
begin
  if AActive then
    result := imglistBottomMenu.Bitmap(TSizeF.Create(60,60), Ord(index) * 2)
  else
    result := imglistBottomMenu.Bitmap(TSizeF.Create(60,60), Ord(index) * 2 + 1)
end;

function TfrmMain.GetMyhomeMenuImage(index: TMyhomeMenu;
  AActive: Boolean): TBitmap;
begin
  if AActive then
    result := imglistMyhomeMenu.Bitmap(TSizeF.Create(48,48), Ord(index) * 2)
  else
    result := imglistMyhomeMenu.Bitmap(TSizeF.Create(48,48), Ord(index) * 2 + 1)
end;

procedure TfrmMain.imgAddItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  SetMyhomeAddItemAction(imgAddStory.Position.X = imgAddItem.Position.X);
end;

procedure TfrmMain.imgAddRecipeClick(Sender: TObject);
begin
  frmRecipeEditor.Show;
  SetMyhomeAddItemAction(False);
end;

procedure TfrmMain.layoutLeftmenuScaleClick(Sender: TObject);
begin
  LeftMenuOpen(False);

  frmScaleView.SetValue('', _info.login.scale.MaxWeight,
    TScaleMeasureType.smViewSetup, _info.login.scale.WeightUnit);

  frmScaleView.Show;
end;

procedure TfrmMain.layoutLeftmenuSetupClick(Sender: TObject);
begin
  frmSetup.Show;

  LeftMenuOpen(False);
end;

procedure TfrmMain.layoutHitMenuButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  LeftMenuOpen(True);
end;

procedure TfrmMain.layoutHitSearchButtonClick(Sender: TObject);
begin
  if imgSearch.Visible then
  begin
    // Do Search
  end;
end;

procedure TfrmMain.layoutHomeClick(Sender: TObject);
begin
  if (Sender = layoutHome) then SetBottomMenu(bmHome)
  else if (Sender = layoutNewsfeed) then SetBottomMenu(bmNewsFeed)
  else if (Sender = layoutRecipe) then SetBottomMenu(bmRecipe)
  else if (Sender = layoutCookbook) then SetBottomMenu(bmCookbook)
  else if (Sender = layoutMyhome) then SetBottomMenu(bmMyhome);
end;

procedure TfrmMain.layoutMyhomeNewsfeedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if (Sender = layoutMyhomeNewsfeed) then SetMyhomeMenu(mhNewsfeed)
  else if (Sender = layoutMyhomeRecipe) then SetMyhomeMenu(mhRecipe)
  else if (Sender = layoutMyhomeCookbook) then SetMyhomeMenu(mhCookbook)
  else if (Sender = layoutMyhomeBookmark) then SetMyhomeMenu(mhBookmark);
end;

procedure TfrmMain.layoutLeftmenuLoginClick(Sender: TObject);
begin
  LeftMenuOpen(False);

  CallLoginform;
end;

procedure TfrmMain.LeftMenuOpen(AShow: Boolean);
begin
  if AShow then
  begin
    FActiveTab := tabcontrolService.ActiveTab;
    tabcontrolService.ActiveTab := tabTemp;
    tabControlLeftMenu.Visible := True;
    TAnimator.Create.AnimateFloat(MenuLeftRect, 'Position.X', 0, 0.25 );
  end
  else
  begin
    tabcontrolService.ActiveTab := FActiveTab;
    TAnimator.Create.AnimateFloat(MenuLeftRect, 'Position.X', MenuLeftRect.Width * -1, 0.25 );
    tabControlLeftMenu.Visible := False;
  end;
end;

procedure TfrmMain.MenuRightRectClick(Sender: TObject);
begin
  LeftMenuOpen(False);
end;

procedure TfrmMain.recMyhomeBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  SetMyhomeAddItemAction(False);
end;

procedure TfrmMain.ScaleEndDiscoverDevices(const Sender: TObject;
  const ADeviceList: TBluetoothLEDeviceList);
var
  i, k: integer;
  bFound: Boolean;
begin
  try
    if ADeviceList.Count < 1 then
    begin
      if Assigned(_Scale.OnDisconnected) then
        _Scale.OnDisconnected(self);
  //    ShowMessage( 'Scale - * BLE 장비를 찾을 수 없습니다!');
  //    Exit;
    end
    else
    begin
      bFound := False;
      for i:=0 to ADeviceList.Count-1 do
        for k := 0 to Length(BLE)-1 do
        begin
          if Uppercase(ADeviceList.Items[i].DeviceName) = UpperCase(BLE[k].DeviceName) then
          begin
            bFound := True;
            _Scale.ConnectDevice(ADeviceList.Items[i]);
            Break;
          end;
        end;

      if (not bFound) and Assigned(_Scale.OnDisconnected) then
        _Scale.OnDisconnected(self);
    end;
  except
    _Scale.DisconnectDevice;
  end;
end;

procedure TfrmMain.scrollRecipeBodyViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
var
  ScrollHeight, ViewHeight: Single;
begin
  if Assigned(FRecipeList) then
  begin
    ScrollHeight := scrollRecipeBody.ContentBounds.Bottom;

    ViewHeight := newViewPortPosition.Y + scrollRecipeBody.Height;

    if ViewHeight = ScrollHeight   then
      FRecipeList.DisplayItems(FRecipeList.DisplayedCount);
  end;
end;

procedure TfrmMain.SetBottomMenu(menuindex: TBottomMenu);
var
  size: TSizeF;
begin
  // 로그인이 필요한 경우 로그인으로 처리한다
  if (menuindex in [bmNewsfeed, bmMyhome]) and (CM.memUser.IsEmpty) then
  begin
    // 로그인을 호출한다
    MessageDlg( '로그인이 필요한 서비스 입니다.' + #13#10 + '로그인 하시겠습니까 ?',
                 TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
     procedure(const AResult: TModalResult)
     begin
       case AResult of
         mrYES : CallLoginForm(menuindex);
       end;
     end);
  end
  else
  begin
    size := TSizeF.Create(30,30);

    imgHome.Bitmap := GetBottomMenuImage(bmHome, False);
    imgNewsfeed.Bitmap := GetBottomMenuImage(bmNewsfeed, False);
    imgRecipe.Bitmap := GetBottomMenuImage(bmRecipe, False);
    imgCookbook.Bitmap := GetBottomMenuImage(bmCookbook, False);
    imgMyhome.Bitmap := GetBottomMenuImage(bmMyhome, False);

    case menuindex of
      bmHome:
      begin
        imgHome.Bitmap := GetBottomMenuImage(bmHome, True);
        tabcontrolService.ActiveTab := tabHome;
        txtMainTitle.Text := '쿡플레이';
      end;
      bmNewsfeed:
      begin
        imgNewsfeed.Bitmap := GetBottomMenuImage(bmNewsfeed, True);
        tabcontrolService.ActiveTab := tabNewsfeed;
        txtMainTitle.Text := '피드';
      end;
      bmRecipe:
      begin
        imgRecipe.Bitmap := GetBottomMenuImage(bmRecipe, True);
        tabcontrolService.ActiveTab := tabRecipe;
        txtMainTitle.Text := '레시피';

        // 현재 Display 되고 있는 레시피가 없을 경우 새로 불러온다
        if not Assigned(FRecipeList) then
          SetRecipeView(TRecipeViewType.rvRecent);
      end;
      bmCookbook:
      begin
        imgCookbook.Bitmap := GetBottomMenuImage(bmCookbook, True);
        tabcontrolService.ActiveTab := tabCookbook;
        txtMainTitle.Text := '쿡북';
      end;
      bmMyhome:
      begin
        imgMyhome.Bitmap := GetBottomMenuImage(bmMyhome, True);
        tabcontrolService.ActiveTab := tabMyhome;
        txtMainTitle.Text := '마이홈';
      end;
    end;
  end;
end;

procedure TfrmMain.SetLoginInfo;
var
  UserSerial: LargeInt;
  Follow, Follower, Recipe, Cookbook, Notice, MyFeed: integer;
begin
  // Login 세팅
  if not CM.memUser.IsEmpty then
  begin
    frmMain.SetMenuLogin(True); // True - Logined, False - Not Logined

    UserSerial := CM.memUser.FieldByName('Serial').AsLargeInt;
    CM.GetCount(UserSerial, Follow, Follower, Recipe, Cookbook, Notice, MyFeed);

    // Count 정보를 세팅한다
    _info.user.SetInfo(Notice, Follower, Follow, Recipe, Cookbook, Notice, MyFeed);

    frmMain.txtFollower.Text := GetCountString(Follower);
    frmMain.txtFollowing.Text := GetCountString(Follow);
    frmMain.txtRecipe.Text := GetCountString(Recipe);
    frmMain.txtCookbook.Text := GetCountString(Cookbook);

    txtMyhomeFollowerCount.Text := txtFollower.Text;
    txtMyhomeFollowCount.Text := txtFollowing.Text;
    txtMyhomeRecipeCount.Text := txtRecipe.Text;
    txtMyhomeCookbookCount.Text := txtCookbook.Text;
    txtMyHomeNewsfeedCount.Text := GetCountString(MyFeed);

    cirNotice.Visible := (Notice > 0);
  end;
end;

procedure TfrmMain.SetMenuLogin(ALogined: Boolean);
begin
  layoutUser.Align := TAlignLayout.None;
  layoutLogin.Align := TAlignLayout.None;
  layoutOther.Align :=  TAlignLayout.None;

  layoutUser.Visible := ALogined;
  layoutLogin.Visible := not ALogined;

  if ALogined then
  begin
    layoutUser.Align := TAlignLayout.Top;
    layoutOther.Align :=  TAlignLayout.Top;
  end
  else
  begin
    layoutLogin.Align := TAlignLayout.Top;
    layoutOther.Align :=  TAlignLayout.Top;
  end;
end;

procedure TfrmMain.SetMyhomeAddItemAction(aActive: Boolean);
begin
  if tabcontrolService.ActiveTab = tabMyhome then
  begin
    layoutMyhomeAddItem.Visible := True;

    if aActive then
    begin
      recMyhomeBackground.Opacity := 0;
      TAnimator.Create.AnimateFloat(recMyhomeBackground, 'Opacity', 0.3, 0.15);
      recMyhomeBackground.HitTest := True;

      imgAddItem.Bitmap := imglistAddItem.Bitmap(TSizeF.Create(92,92), 1);

      imgAddStory.Position.X := 96;
      TAnimator.Create.AnimateFloat(imgAddStory, 'Position.X', 0, 0.25, TAnimationType.Out, TInterpolationType.Exponential);

      imgAddRecipe.Position.X := 96;
      imgAddRecipe.Position.Y := 96;
      TAnimator.Create.AnimateFloat(imgAddRecipe, 'Position.X', 30, 0.25, TAnimationType.Out, TInterpolationType.Exponential);
      TAnimator.Create.AnimateFloat(imgAddRecipe, 'Position.Y', 30, 0.25, TAnimationType.Out, TInterpolationType.Exponential);


      imgAddCookbook.Position.Y := 100;
      TAnimator.Create.AnimateFloat(imgAddCookbook, 'Position.Y', 0, 0.25, TAnimationType.Out, TInterpolationType.Exponential);
    end
    else
    begin
      if recMyhomeBackground.Opacity <> 0 then
      begin
        recMyhomeBackground.Opacity := 0.3;
        TAnimator.Create.AnimateFloat(recMyhomeBackground, 'Opacity', 0, 0.15);
      end;
      recMyhomeBackground.HitTest := False;

      imgAddItem.Bitmap := imglistAddItem.Bitmap(TSizeF.Create(92,92), 0);

      if imgAddstory.Position.X <> imgAddItem.Position.X then
      begin
        imgAddStory.Position.X := 0;
        TAnimator.Create.AnimateFloat(imgAddStory, 'Position.X', 96, 0.25, TAnimationType.Out, TInterpolationType.Exponential);

        imgAddRecipe.Position.X := 29;
        imgAddRecipe.Position.Y := 29;
        TAnimator.Create.AnimateFloat(imgAddRecipe, 'Position.X', 96, 0.25, TAnimationType.Out, TInterpolationType.Exponential);
        TAnimator.Create.AnimateFloat(imgAddRecipe, 'Position.Y', 96, 0.25, TAnimationType.Out, TInterpolationType.Exponential);


        imgAddCookbook.Position.Y := 0;
        TAnimator.Create.AnimateFloat(imgAddCookbook, 'Position.Y', 96, 0.25, TAnimationType.Out, TInterpolationType.Exponential);
      end;
    end;
  end
  else
  begin
    recMyhomeBackground.Opacity := 0;
    recMyhomeBackground.HitTest := False;
    layoutMyhomeAddItem.Visible := False;

    imgAddStory.Position := imgAddItem.Position;
    imgAddRecipe.Position := imgAddItem.Position;
    imgAddCookbook.Position := imgAddItem.Position;
  end;

end;

procedure TfrmMain.SetMyhomeMenu(menuindex: TMyhomeMenu);
  procedure SetMenu(menuindex: TMyhomeMenu; AActive: Boolean);
  var
    txtColor: TAlphaColor;
  begin
    if AActive then
      txtColor := COLOR_ACTIVE_TEXT
    else
      txtColor := COLOR_INACTIVE_TEXT;

    case menuindex of
      mhNewsfeed:
        begin
          imgMyhomeStory.Bitmap := GetMyhomeMenuImage(mhNewsfeed, AActive);
          txtMyhomeStory.TextSettings.FontColor := txtColor;
          lineMyhomeNewsfeed.Visible := AActive;
        end;
      mhRecipe:
        begin
          imgMyhomeRecipe.Bitmap := GetMyhomeMenuImage(mhRecipe, AActive);
          txtMyhomeRecipe.TextSettings.FontColor := txtColor;
          lineMyhomeRecipe.Visible := AActive;
        end;
      mhCookbook:
        begin
          imgMyhomeCookbook.Bitmap := GetMyhomeMenuImage(mhCookbook, AActive);
          txtMyhomeCookbook.TextSettings.FontColor := txtColor;
          lineMyhomeCookbook.Visible := AActive;
        end;
      mhBookmark:
        begin
          imgMyhomeBookmark.Bitmap := GetMyhomeMenuImage(mhBookmark, AActive);
          txtMyhomeBookmark.TextSettings.FontColor := txtColor;
          lineMyhomeBookmark.Visible := AActive;
        end;
    end;
  end;
begin
  SetMenu(mhNewsfeed, False);
  SetMenu(mhRecipe, False);
  SetMenu(mhCookbook, False);
  SetMenu(mhBookmark, False);

  case menuindex of
    mhNewsfeed:
    begin
      SetMenu(menuindex, True);
      tabcontrolMyhome.ActiveTab := tabMyhomeStory;
    end;
    mhRecipe:
    begin
      SetMenu(menuindex, True);
      tabcontrolMyhome.ActiveTab := tabMyhomeRecipe;
    end;
    mhCookbook:
    begin
      SetMenu(menuindex, True);
      tabcontrolMyhome.ActiveTab := tabMyhomeCookbook;
    end;
    mhBookmark:
    begin
      SetMenu(menuindex, True);
      tabcontrolMyhome.ActiveTab := tabMyhomeBookmark;
    end;
  end;
end;

procedure TfrmMain.SetRecipeView(aRecipeView: TRecipeViewType);
begin
  if not Assigned(FRecipeList) then
    FRecipeList := TRecipeScrollList.Create;

  if aRecipeview = TRecipeViewType.rvRecent then
  begin
    recRecipeButton.Align := TAlignLayout.Left;
    txtRecipeButtonText.Text := txtRecipeRecent.Text;

    FRecipeList.Init(TRecipeViewType.rvRecent, scrollRecipeBody, Round(layoutRecipeListTop.Height));
  end
  else if aRecipeView = TRecipeViewType.rvBest then
  begin
    recRecipeButton.Align := TAlignLayout.Right;
    txtRecipeButtonText.Text := txtRecipeBest.Text;

    FRecipeList.Init(TRecipeViewType.rvBest, scrollRecipeBody, Round(layoutRecipeListTop.Height));
  end;
end;

procedure TfrmMain.ShowShareSheetAction1BeforeExecute(Sender: TObject);
begin
  ShowShareSheetAction1.Bitmap.Assign(image1.Bitmap);
end;

procedure TfrmMain.tabcontrolServiceChange(Sender: TObject);
begin
  // Myhome Add Item 위치및 보이기 세팅
  SetMyhomeAddItemAction(False);
end;

procedure TfrmMain.timeErrorTimer(Sender: TObject);
begin
  timeError.Enabled := False;

  FMX.Dialogs.MessageDlg( FErrorMessage, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK], 0,
    procedure(const AResult: TModalResult)
    begin
      frmMain.Close;
    end
  );
end;

procedure TfrmMain.timeStartTimer(Sender: TObject);
begin
  timeStart.Enabled := False;

  if _info.login.autoLogin then
    actLogin.Execute
  else
    SetMenuLogin(False); // menu 를 refresh 한다

  // Myhome Add Item 위치 세팅
  SetMyhomeAddItemAction(False);

  // connect to the Datasnap server
  try
    CM.SQLConnection.Connected := True;
  except
    FErrorMessage := '서비스에 접근할 수 없습니다!' + #13#10 + '종료 후 다시 시작해 주십시오!';
    ShowMessage('원격데이터에 접근할 수 없습니다!');
  end;
end;

procedure TfrmMain.txtRecipeBestClick(Sender: TObject);
begin
  if Sender = txtRecipeRecent then
    SetRecipeView(TRecipeViewType.rvRecent)
  else if Sender = txtRecipeBest then
    SetRecipeView(TRecipeViewType.rvBest);
end;

end.
