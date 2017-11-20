unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.Effects, uGlobal,
  FMX.Ani, System.Rtti, FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, FMX.ScrollBox,
  FMX.Grid, uWEB, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, System.ImageList, FMX.ImgList, Data.DB, System.Actions,
  FMX.ActnList, FMX.WebBrowser;

type
  TfrmMain = class(TForm)
    Layout4: TLayout;
    layoutHitMenuButton: TLayout;
    Image3: TImage;
    Text2: TText;
    layoutHitSearchButton: TLayout;
    imgSearch: TImage;
    Rectangle1: TRectangle;
    tabcontrolMain: TTabControl;
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
    layoutCallLogin: TLayout;
    Text7: TText;
    Image6: TImage;
    Line6: TLine;
    layoutOther: TLayout;
    Layout8: TLayout;
    Text1: TText;
    Image8: TImage;
    Line4: TLine;
    Layout7: TLayout;
    Text3: TText;
    Image1: TImage;
    Line2: TLine;
    Layout3: TLayout;
    Text4: TText;
    Image2: TImage;
    Layout2: TLayout;
    Text5: TText;
    Image5: TImage;
    Timer1: TTimer;
    Rectangle2: TRectangle;
    tabRecipe: TTabItem;
    tabCookbook: TTabItem;
    tabMyhome: TTabItem;
    BottomImageList: TImageList;
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
    Label2: TLabel;
    Label5: TLabel;
    ActionList1: TActionList;
    actLogin: TAction;
    actLogout: TAction;
    cirNotice: TCircle;
    Button1: TButton;
    wbRecipeList: TWebBrowser;
    Label1: TLabel;
    Rectangle3: TRectangle;
    wbCookbookList: TWebBrowser;
    procedure layoutHitMenuButtonMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MenuRightRectClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure layoutHitSearchButtonClick(Sender: TObject);
    procedure layoutCallLoginClick(Sender: TObject);
    procedure layoutHomeClick(Sender: TObject);
    procedure actLoginExecute(Sender: TObject);
    procedure actLogoutExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Layout2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure wbRecipeListDidStartLoad(ASender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetMenuLogin(ALogined: Boolean);
    procedure SetBottomMenu(menuindex: TBottomMenu);
    procedure LeftMenuOpen(AShow: Boolean);
    function GetBottomMenuImage(index: TBottomMenu; AActive: Boolean): TBitmap;
    procedure SetLoginInfo;
    procedure CallLoginForm(menuindex: TBottomMenu = bmNone);
  end;

var
  frmMain: TfrmMain;

implementation
uses cookplay.StatusBar, ClientModuleUnit, uRecipeEditor, uSetup;
{$R *.fmx}

procedure TfrmMain.actLoginExecute(Sender: TObject);
begin
  // setup 을 refresh 한다
  _info.login.LoadInfo;

  // menu 를 refresh 한다
  SetMenuLogin(True);

  // 메뉴의 사용자 정보를 출력한다
  SetLoginInfo;
end;

procedure TfrmMain.actLogoutExecute(Sender: TObject);
begin
  SetMenuLogin(False);
  CM.memUser.Close;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  Form: TfrmRecipeEditor;
begin
  Form := TfrmRecipeEditor.Create(nil);

  Form.ShowModal(
    procedure (ModalResult: TModalResult)
    begin
      ShowMessage('modal result');
    end
  );
end;

procedure TfrmMain.CallLoginForm(menuindex: TBottomMenu);
var
  url: string;
begin
  url := URL_LOGIN + '?email=' + _info.login.email + '&autologin=' + _info.login.autoLogin.ToInteger.ToString;
  frmWeb.goURL(url);
  if menuindex = bmNone then
    frmWeb.ShowModal(
      procedure (ModalResult: TModalresult)
      begin
      end
    )
  else
    frmWeb.ShowModal(
      procedure (ModalResult: TModalresult)
      begin
        if not CM.memUser.IsEmpty then
          SetBottomMenu(menuindex);
      end
    );
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // 설정정보를 저장한다
  _info.login.SaveInfo;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  msg: string;
begin
  exit;
  // Status Bar 색을 바꾼다
//  Fill.Color := GetColor(Fill.Color);
//  StatusBarSetColor(Fill.Color);


  // 환경을 읽어온다
  _info := TInfo.Create;

  // 메뉴 보기 설정
  tabControlLeftMenu.BringToFront;
  tabControlLeftMenu.TabIndex := 0;
  tabControlLeftMenu.TabPosition := TTabPosition.None;

  // Search Image 보이지 않게 하기
  imgSearch.Visible := False;

  LeftMenuOpen(False); // True - Open, False - Close

  // 서비스세팅(로그인 되어야 사용할 수 있는 것 구분)
  SetBottomMenu(bmHome);

  exit;

  // 메뉴 로그인정보 세팅(자동로그인참조)
  if _info.login.autoLogin and CM.Login(_info.login.email, _info.login.password, msg) then
    actLogin.Execute
  else
    actLogout.Execute;

  // connect to the Datasnap server
  try
    CM.SQLConnection.Connected := True;
  except
    ShowMessage('원격데이터에 접근할 수 없습니다!');
  end;

  wbRecipeList.Navigate(URL_RECIPE);
  wbCookbookList.Navigate('www.daum.net');
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    if tabControlLeftMenu.Visible then
      LeftMenuOpen(False)
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
    end;
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
end;

function TfrmMain.GetBottomMenuImage(index: TBottomMenu; AActive: Boolean): TBitmap;
begin
  if AActive then
    result := BottomImageList.Bitmap(TSizeF.Create(30,30), Ord(index) * 2)
  else
    result := BottomImageList.Bitmap(TSizeF.Create(30,30), Ord(index) * 2 + 1)
end;

procedure TfrmMain.Layout2Click(Sender: TObject);
var
  Form: TfrmSetup;
begin
  Form := TfrmSetup.Create(nil);
  Form.ShowModal(procedure (ModalResult: TModalResult) begin end);
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

procedure TfrmMain.layoutCallLoginClick(Sender: TObject);
begin
  LeftMenuOpen(False);

  CallLoginform;
end;

procedure TfrmMain.layoutHitMenuButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  LeftMenuOpen(True);
end;

procedure TfrmMain.LeftMenuOpen(AShow: Boolean);
begin
  if AShow then
  begin
    tabControlLeftMenu.Visible := True;
    TAnimator.Create.AnimateFloat(MenuLeftRect, 'Position.X', 0, 0.25 );
  end
  else
  begin
    TAnimator.Create.AnimateFloat(MenuLeftRect, 'Position.X', MenuLeftRect.Width * -1, 0.25 );
    tabControlLeftMenu.Visible := False;
  end;
end;

procedure TfrmMain.MenuRightRectClick(Sender: TObject);
begin
  LeftMenuOpen(False);
end;

procedure TfrmMain.SetBottomMenu(menuindex: TBottomMenu);
var
  size: TSizeF;
begin
  // 로그인이 필요한 경우 로그인으로 처리한다
  if (menuindex in [bmNewsfeed, bmMyhome]) and (CM.memUser.IsEmpty) then
  begin
    // 로그인을 호출한다
    CallLoginForm(menuindex);
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
        tabcontrolMain.ActiveTab := tabHome;
      end;
      bmNewsfeed:
      begin
        imgNewsfeed.Bitmap := GetBottomMenuImage(bmNewsfeed, True);
        tabcontrolMain.ActiveTab := tabNewsfeed;
      end;
      bmRecipe:
      begin
        imgRecipe.Bitmap := GetBottomMenuImage(bmRecipe, True);
        tabcontrolMain.ActiveTab := tabRecipe;
      end;
      bmCookbook:
      begin
        imgCookbook.Bitmap := GetBottomMenuImage(bmCookbook, True);
        tabcontrolMain.ActiveTab := tabCookbook;
      end;
      bmMyhome:
      begin
        imgMyhome.Bitmap := GetBottomMenuImage(bmMyhome, True);
        tabcontrolMain.ActiveTab := tabMyhome;
      end;
    end;
  end;
end;

procedure TfrmMain.SetLoginInfo;
var
  UserSerial: LargeInt;
  Follow, Follower, Recipe, Cookbook, Notice: integer;
begin
  // Login 세팅
  if not CM.memUser.IsEmpty then
  begin
    frmMain.SetMenuLogin(True); // True - Logined, False - Not Logined

    UserSerial := CM.memUser.FieldByName('Serial').AsLargeInt;
    CM.GetCount(UserSerial, Follow, Follower, Recipe, Cookbook, Notice);
    frmMain.txtFollower.Text := GetCountString(Follower);
    frmMain.txtFollowing.Text := GetCountString(Follow);
    frmMain.txtRecipe.Text := GetCountString(Recipe);
    frmMain.txtCookbook.Text := GetCountString(Cookbook);

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

  if layoutUser.Visible then
  begin
    layoutUser.Align := TAlignLayout.Top;
    layoutOther.Align :=  TAlignLayout.Top;
  end
  else
  begin
    layoutLogin.Align := TAlignLayout.Top;
    layoutOther.Align :=  TAlignLayout.Top;
  end;

//  if not CM.memUser.IsEmpty then
//  begin
//    txtNickname.Text := CM.memUserNickname.AsString;
//  end;
end;

procedure TfrmMain.wbRecipeListDidStartLoad(ASender: TObject);
begin
  showmessage('a');
end;

end.
