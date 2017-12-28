unit uMyhomeFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.TabControl, FMX.Objects, uGlobal, System.ImageList,
  FMX.ImgList, uListMyhome, FMX.ListBox, System.Actions, FMX.ActnList,
  FMX.Gestures, uGlobalComponent;

type
  TframeMyhome = class(TFrame)
    layoutMyhomeBody: TLayout;
    layoutMyhomeScroll: TLayout;
    layoutMyhomeHeader: TLayout;
    layoutMyhomeTop: TLayout;
    imgMyhomeBack: TImage;
    recBlackScreen: TRectangle;
    Layout4: TLayout;
    Image12: TImage;
    layoutFollower: TLayout;
    Text11: TText;
    txtMyhomeFollowerCount: TText;
    layoutFollow: TLayout;
    Text12: TText;
    txtMyhomeFollowCount: TText;
    imgEditProfile: TImage;
    txtUserNickname: TText;
    GridPanelViewDetail: TGridPanelLayout;
    layoutMyhomNewsfeedCount: TLayout;
    Image13: TImage;
    txtMyhomeStoryCount: TText;
    layoutMyhomeRecipeCount: TLayout;
    Image14: TImage;
    txtMyhomeRecipeCount: TText;
    layoutMyhomeCookbookCount: TLayout;
    Image15: TImage;
    txtMyhomeCookbookCount: TText;
    recMyhomeMenu: TRectangle;
    gridpanelMyhome: TGridPanelLayout;
    layoutMyhomeStory: TLayout;
    Layout15: TLayout;
    imgMyhomeStory: TImage;
    lineMyhomeNewsfeed: TLine;
    txtMyhomeStory: TText;
    layoutMyhomeRecipe: TLayout;
    Layout16: TLayout;
    Layout17: TLayout;
    imgMyhomeRecipe: TImage;
    lineMyhomeRecipe: TLine;
    txtMyhomeRecipe: TText;
    layoutMyhomeCookbook: TLayout;
    Layout18: TLayout;
    Layout19: TLayout;
    imgMyhomeCookbook: TImage;
    lineMyhomeCookbook: TLine;
    txtMyhomeCookbook: TText;
    layoutMyhomeBookmark: TLayout;
    Layout20: TLayout;
    Layout21: TLayout;
    imgMyhomeBookmark: TImage;
    lineMyhomeBookmark: TLine;
    txtMyhomeBookmark: TText;
    tabcontrolMyhome: TTabControl;
    tabMyhomeStory: TTabItem;
    tabMyhomeRecipe: TTabItem;
    tabMyHomeCookbook: TTabItem;
    tabMyhomeBookmark: TTabItem;
    imgListMyhomeMenu: TImageList;
    scrollStory: TVertScrollBox;
    scrollRecipe: TVertScrollBox;
    scrollCookbook: TVertScrollBox;
    scrollBookmark: TVertScrollBox;
    layoutStoryTemp: TLayout;
    Layout1: TLayout;
    Circle1: TCircle;
    Text1: TText;
    Image1: TImage;
    Image2: TImage;
    Layout2: TLayout;
    Text2: TText;
    Layout3: TLayout;
    Layout6: TLayout;
    Text4: TText;
    Layout7: TLayout;
    RoundRect1: TRoundRect;
    Text5: TText;
    Layout8: TLayout;
    Text7: TText;
    Image4: TImage;
    Text6: TText;
    Image3: TImage;
    Line1: TLine;
    layoutStoryTemp2: TLayout;
    Layout10: TLayout;
    Circle2: TCircle;
    Text8: TText;
    Image7: TImage;
    Layout11: TLayout;
    RoundRect2: TRoundRect;
    Text10: TText;
    Layout12: TLayout;
    Text13: TText;
    Layout13: TLayout;
    Layout14: TLayout;
    Text14: TText;
    Image9: TImage;
    Text15: TText;
    Image10: TImage;
    Layout22: TLayout;
    Text16: TText;
    Layout23: TLayout;
    Image11: TImage;
    Image16: TImage;
    Text17: TText;
    Layout9: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Image5: TImage;
    Image6: TImage;
    procedure layoutMyhomeBodyResize(Sender: TObject);
    procedure layoutMyhomeStoryMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
    FMyHome: Boolean;
    FUserSerial: LargeInt;
    FNickname: String;
    FCallbackRef: TCallbackRefFunc; // 스크롤 시 사용자정보가 작아질 때, 사용자 Nickname 을 전달하기 위하여 사용한다

    FStorys: TMyhomeList;
    FRecipes: TMyhomeList;
    FCookbooks: TMyhomeList;
    FBookmarks: TMyhomeList;

    procedure SetMyhomeMenu(menuindex: TMyhomeMenu);
    function GetMyhomeMenuImage(index: TMyhomeMenu; AActive: Boolean): TBitmap;
  public
    { Public declarations }
    procedure Init(aUserSerial: LargeInt; aIsMyhome: Boolean; aCallback: TCallbackRefFunc = nil);
  end;

implementation
uses ClientModuleUnit;
{$R *.fmx}

function TframeMyhome.GetMyhomeMenuImage(index: TMyhomeMenu;
  AActive: Boolean): TBitmap;
begin
  if AActive then
    result := imglistMyhomeMenu.Bitmap(TSizeF.Create(48,48), Ord(index) * 2)
  else
    result := imglistMyhomeMenu.Bitmap(TSizeF.Create(48,48), Ord(index) * 2 + 1)
end;

procedure TframeMyhome.Init(aUserSerial: LargeInt; aIsMyhome: Boolean; aCallback: TCallbackRefFunc = nil);
var
  UserSerial: LargeInt;
  Follow, Follower, Recipe, Story, Cookbook, Notice, MyFeed: integer;
begin
  // 디자인 작업한 것을 없앤다
  layoutStoryTemp.DisposeOf;
  layoutStoryTemp2.DisposeOf;

  FMyHome := aIsMyhome;
  FUserSerial := aUserSerial;
  FCallbackRef := aCallback;

  // Tab Control 정리
  tabcontrolMyhome.TabPosition := TTabPosition.None;
  tabcontrolMyhome.ActiveTab := tabMyhomeStory;

  // Myhome 일 때 세팅
  imgEditProfile.Visible := FMyhome;

  Follower := 0;
  Follow := 0;
  Recipe := 0;
  Story := 0;
  Cookbook := 0;
  Notice := 0;
  MyFeed := 0;

  if FMyHome and _info.Logined then
  begin
    FNickName := _info.user.Nickname;
    Follower := _info.user.Follower;
    Follow := _info.user.Follow;
    Recipe := _info.user.Recipe;
    Story := _info.user.Story;
    Cookbook := _info.user.Cookbook;
    Notice := _info.user.Notice;
    MyFeed := _info.user.MyFeed;
  end
  else
  begin
    UserSerial := FUserSerial;
    CM.GetCount(UserSerial, FNickname, Follow, Follower, Recipe, Story, Cookbook, Notice, MyFeed);
  end;

  txtUserNickname.Text := FNickname;

  txtMyhomeFollowerCount.Text := GetCountString(Follower);
  txtMyhomeFollowCount.Text := GetCountString(Follow);
  txtMyhomeRecipeCount.Text := GetCountString(Recipe);
  txtMyhomeCookbookCount.Text := GetCountString(Cookbook);
  txtMyHomeStoryCount.Text := GetCountString(Story);

  SetMyhomeMenu(TMyhomeMenu.mhStory);
end;

procedure TframeMyhome.layoutMyhomeBodyResize(Sender: TObject);
begin
  layoutMyhomeHeader.Height := layoutMyhomeTop.Height + recMyhomeMenu.Height;

  layoutMyhomeScroll.Position := TPosition.Create(PointF(0,0));
  layoutMyhomeScroll.Width := layoutMyhomeBody.Width;
  layoutMyhomeScroll.Height := layoutMyhomeBody.Height + layoutMyhomeTop.Height;

  imgMyhomeBack.SendToBack;
  imgMyhomeBack.Position.X := 0;
  imgMyhomeBack.Position.Y := 0;
  imgMyhomeBack.Width := layoutMyhomeBody.Width;
  imgMyhomeBack.Height := layoutMyhomeTop.Height;

  scrollStory.Align := TAlignLayout.Client;
  scrollRecipe.Align := TAlignLayout.Client;
  scrollCookbook.Align := TAlignLayout.Client;
  scrollBookmark.Align := TAlignLayout.Client;

  recBlackScreen.Align := TAlignLayout.Client;
end;

procedure TframeMyhome.layoutMyhomeStoryMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if (Sender = layoutMyhomeStory) then SetMyhomeMenu(mhStory)
  else if (Sender = layoutMyhomeRecipe) then SetMyhomeMenu(mhRecipe)
  else if (Sender = layoutMyhomeCookbook) then SetMyhomeMenu(mhCookbook)
  else if (Sender = layoutMyhomeBookmark) then SetMyhomeMenu(mhBookmark);
end;

procedure TframeMyhome.SetMyhomeMenu(menuindex: TMyhomeMenu);
  procedure SetMenu(menuindex: TMyhomeMenu; AActive: Boolean);
  var
    txtColor: TAlphaColor;
  begin
    if AActive then
      txtColor := COLOR_ACTIVE_TEXT
    else
      txtColor := COLOR_INACTIVE_TEXT;

    case menuindex of
      mhStory:
        begin
          imgMyhomeStory.Bitmap := GetMyhomeMenuImage(mhStory, AActive);
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
  SetMenu(mhStory, False);
  SetMenu(mhRecipe, False);
  SetMenu(mhCookbook, False);
  SetMenu(mhBookmark, False);

  case menuindex of
    mhStory:
    begin
      SetMenu(menuindex, True);
      tabcontrolMyhome.ActiveTab := tabMyhomeStory;

      if not Assigned(FStorys) then
      begin
        FStorys := TMyhomeList.Create;
        FStorys.Init(FUserSerial, FNickname, mhltStory, layoutMyhomeBody, layoutMyhomeScroll, scrollStory, 0, FCallbackRef);
      end
      else
      begin
        layoutMyhomeBody.OnMouseMove := FStorys.DoLayoutMouseMove;
        layoutMyhomeBody.OnMouseUp := FStorys.DoLayoutMouseUp;
      end;
    end;
    mhRecipe:
    begin
      SetMenu(menuindex, True);
      tabcontrolMyhome.ActiveTab := tabMyhomeRecipe;

      if not Assigned(FRecipes) then
      begin
        FRecipes := TMyhomeList.Create;
        FRecipes.Init(FUserSerial, FNickname, mhltRecipe, layoutMyhomeBody, layoutMyhomeScroll, scrollRecipe, 0, FCallbackRef);
      end;
    end;
    mhCookbook:
    begin
      SetMenu(menuindex, True);
      tabcontrolMyhome.ActiveTab := tabMyhomeCookbook;

      if not Assigned(FCookbooks) then
      begin
        FCookbooks := TMyhomeList.Create;
        FCookbooks.Init(FUserSerial, FNickname, mhltCookbook, layoutMyhomeBody, layoutMyhomeScroll, scrollCookbook, 0, FCallbackRef);
      end;
    end;
    mhBookmark:
    begin
      SetMenu(menuindex, True);
      tabcontrolMyhome.ActiveTab := tabMyhomeBookmark;

      if not Assigned(FBookmarks) then
      begin
        FBookmarks := TMyhomeList.Create;
        FBookmarks.Init(FUserSerial, FNickname, mhltBookmark, layoutMyhomeBody, layoutMyhomeScroll, scrollBookmark, 0, FCallbackRef);
      end;
    end;
  end;
end;

end.
