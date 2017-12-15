unit uWeb;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Objects, FMX.Controls3D, FMX.Layers3D, FMX.Layouts,
  FMX.WebBrowser, system.RTTI, FMX.Controls.Presentation, FMX.StdCtrls, Data.DB,
  FMX.Ani, FMX.TabControl, uGlobal, System.ImageList, FMX.ImgList;

type
  TRecipeViewInfo = class
    UserSerial: LargeInt;
    RecipeSerial: LargeInt;
    Servings: Single;
    Ratio: Single;
    BodyRectangle: TRectangle;
    Layout: TLayout;
    RecommendationImage: TImage;
    RecommendationText: TText;
    CommentImage: TImage;
    CommentText: TText;
    BookmarkImage: TImage;
    PlayRecipeImage: TImage;

    Recommended: Boolean;
    Bookmarked: Boolean;
  end;

  TfrmWeb = class(TForm)
    Rectangle1: TRectangle;
    layoutBackButton: TLayout;
    Image1: TImage;
    timerClose: TTimer;
    ImageList1: TImageList;
    tabWeb: TTabControl;
    Rectangle2: TRectangle;
    procedure layoutBackButtonClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure timerCloseTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FRecipeBarList: TStringList;

    FCallbackRefFunc: TCallbackRefFunc;

    procedure CloseLastWebbrowser;

    procedure OnShouldStartLoadWithRequest(ASender: TObject; const URL: string);
    function CallMethod(AMethodName: string; AParameters: TArray<TValue>): TValue;
    function ProcessMethodUrlParse(AUrl: string; var MethodName: string; var Parameters: TArray<TValue>): Boolean;
    procedure AddTab(ATabControl: TTabControl);
    procedure SetRecipeView(aIndex: integer);
    procedure CreateRecipeViewControls(aTab: TTabItem);
    function RecipeMenuBar(aIndex: integer): TRecipeViewInfo;
    function RecipeMenuBarCount: integer;
    procedure SetRecommendationImage(aIndex: integer; aActive: Boolean);
    procedure SetBookmarkImage(aIndex: integer; aActive: Boolean);
    procedure SetRecommendationText(aIndex: integer; aText: string);
    procedure SetCommentText(aIndex: integer; aText: string);

    procedure OnRecommendationImageClick(Sender: TObject);
    procedure OnCommentImageClick(Sender: TObject);
    procedure OnBookmarkImageClick(Sender: TObject);
    procedure OnPlayRecipeImageClick(Sender: TObject);

    procedure CallbackUpdateComment(aResult: Boolean);
  public
    { Public declarations }
    procedure goURL(url: string; aCallbackRefFunc: TCallbackRefFunc = nil);
  end;

var
  frmWeb: TfrmWeb;

implementation
uses cookplay.StatusBar, system.NetEncoding, ClientModuleUnit, uMain,
  uChangeWeight, uComment, uRecipePlay;
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

  oWeb := TWebBrowser.Create(oTab);
  oWeb.Parent := oTab;
  oWeb.EnableCaching := False;
  oWeb.Name := STR_WEBBROWSER_NAME + count.ToString;
  oWeb.Align := TAlignLayout.Client;
  oWeb.OnShouldStartLoadWithRequest := OnShouldStartLoadWithrequest;

  CreateRecipeViewControls(oTab);
end;

procedure TfrmWeb.CallbackUpdateComment(aResult: Boolean);
begin
  if aResult then
    SetRecipeView(RecipeMenuBarCount - 1);
end;

function TfrmWeb.CallMethod(AMethodName: string;
  AParameters: TArray<TValue>): TValue;
var
  Msg: string;
  web: TWebBrowser;
  index: integer;
  LoginResult: TLoginResult;
  rv: TRecipeViewInfo;
  aRecipeSerial, aServings, aRatio: string;
begin
  if AMethodName = 'login' then
  begin
    LoginResult := CM.Login(AParameters[0].AsString, AParameters[1].AsString, Msg);
    if LoginResult = lrSuccess then
    begin
      // Save Login Information;
      _info.login.email := AParameters[0].AsString;
      _info.login.password := AParameters[1].AsString;
      _info.login.autoLogin := (AParameters[2].AsString = '1');
      _info.login.SaveInfo;

      frmMain.actLogin.Execute;

//      CloseLastWebbrowser;
      timerClose.Tag := 1;
      timerClose.Enabled := True;
    end
    else if LoginResult = lrResendEmail then
    begin
      msg := '이메일 인증이 아직 이루어지지 않았습니다!' + #13#10 +
             '인증 메일을 다시 받으시겠습니까?';
      MessageDlg( msg,TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
      procedure(const AResult: TModalResult)
      begin
        if AResult = mrYES then
        begin
          index := tabWeb.TabCount - 1;
          web := TWebBrowser(tabWeb.Tabs[index].FindComponent(STR_WEBBROWSER_NAME + index.ToString));
          web.EvaluateJavaScript('resend_email(''' + AParameters[0].AsString + ''')');
        end;
      end);
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
    ShowMessage(AParameters[0].AsString)
  else if AMethodName = 'close_message' then
  begin
    ShowMessage(AParameters[0].AsString);

//    CloseLastWebbrowser;
    timerClose.Tag := 1;
    timerClose.Enabled := True;
  end
  else if AMethodName = 'close' then
  begin
    if not AParameters[0].AsString.IsEmpty then
    begin
      MessageDlg( AParameters[0].AsString, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK], 0,
        procedure(const AResult: TModalResult)
        begin
//          CloseLastWebbrowser
          timerClose.Tag := 1;
          timerClose.Enabled := True;
        end
      )
    end
  end
  else if AMethodName = 'confirm_register' then
  begin
    if not AParameters[0].AsString.IsEmpty then
      goURL(AParameters[0].AsString);
  end
  else if AMethodName = 'close_register' then // Paramer 0 = email
  begin
    if tabWeb.TabCount >= 2 then
    begin
      index := tabWeb.TabCount - 2;

      web := TWebBrowser(tabWeb.Tabs[index].FindComponent(STR_WEBBROWSER_NAME + index.ToString));

      web.EvaluateJavaScript('change_email(''' + AParameters[0].AsString + ''')');
    end;

//    CloseLastWebbrowser;
    timerClose.Tag := 1;
    timerClose.Enabled := True;
  end
  else if AMethodName = 'changeweight' then
  begin
    aRecipeSerial := AParameters[0].AsString;
    aServings := AParameters[1].AsString;
    aRatio := AParameters[2].AsString;

    if (StrToInt64Def(aRecipeSerial, -1)>-1) and (StrToIntDef(aServings, 0)>0) and (StrToFloatDef(aRatio, 0)>0) then
    begin
      frmChangeWeight.Init(aRecipeSerial.ToInt64, aServings.ToInteger, aRatio.ToSingle,
        procedure (const aResultList: TStringList)
        var
          web: TWebBrowser;
          index: integer;
        begin
          if Assigned(aResultList) then
          begin
            index := tabWeb.TabCount - 1;
            web := TWebBrowser(tabWeb.Tabs[index].FindComponent(STR_WEBBROWSER_NAME + index.ToString));

            if Assigned(web) then
            begin
//              showmessage('infoRecipe(' + AResultList[0] + ', ' + AResultList[1] + ');');
              web.EvaluateJavaScript('infoRecipe(' + AResultList[0] + ', ' + aResultList[1] + ');');
            end
            else
              ShowMessage('바뀐 무게를 적용할 수 없습니다!');
          end
          else
            ShowMessage('정확한 무게값을 받지 못했습니다!');
        end
      );

      frmChangeWeight.Show;
    end;
  end
  else if AMethodName = 'recipe_play' then
  begin
    frmRecipePlay.RecipeSerial := RecipeMenuBar(RecipeMenuBarCount - 1).RecipeSerial;
    frmRecipePlay.Persons := StrToIntDef(AParameters[0].AsString, 1);
    frmRecipePlay.Ratio := StrToFloatDef(AParameters[1].AsString, 1);
    frmRecipePlay.Show;
  end
end;

procedure TfrmWeb.CloseLastWebbrowser;
var
  web: TWebBrowser;
  aindex, i: integer;
begin
  if tabWeb.TabCount > 1 then
  begin
    aindex := tabWeb.TabCount - 1;
    web := TWebBrowser(tabWeb.Tabs[aindex].FindComponent(STR_WEBBROWSER_NAME + aindex.ToString));
    web.DisposeOf;
    tabWeb.Delete(aindex);
  end
  else
    frmWeb.Close;
end;

procedure TfrmWeb.CreateRecipeViewControls(aTab: TTabItem);
var
  rv: TRecipeViewInfo;
  aLine: TLine;
begin
  rv := TrecipeViewInfo.Create;;

  rv.BodyRectangle := TRectangle.Create(aTab);
  rv.BodyRectangle.Parent := aTab;
  rv.BodyRectangle.Height := 50;
  rv.BodyRectangle.Fill.Color := TAlphaColorRec.White;
  rv.BodyRectangle.Stroke.Kind := TBrushKind.None;
  rv.BodyRectangle.Padding.Left := 20;
  rv.BodyRectangle.Padding.Right := 20;
  rv.BodyRectangle.Align := TAlignLayout.Bottom;
  rv.BodyRectangle.Visible := False;

  begin
    rv.Layout := TLayout.Create(rv.BodyRectangle);
    rv.Layout.Parent := rv.BodyRectangle;
    rv.Layout.Align := TAlignLayout.Client;
    begin
      aLine := TLine.Create(rv.Layout);
      aLine.Parent := rv.Layout;
      aLine.LineType := TLineType.Top;
      aLine.Height := 1;
      aLine.Align := TAlignLayout.Top;
      aLine.Margins.Left := -25;
      aLine.Margins.Right := -25;
      aLine.Stroke.Color := COLOR_GRAY_LINE;

      rv.RecommendationImage := TImage.Create(rv.Layout);
      rv.RecommendationImage.Parent := rv.Layout;
      rv.RecommendationImage.Width := 30;
      rv.RecommendationImage.Align := TAlignLayout.Left;
      rv.RecommendationImage.OnClick := OnRecommendationImageClick;
      rv.RecommendationImage.Visible := _info.Logined;

      rv.RecommendationText := TText.Create(rv.Layout);
      rv.RecommendationText.Parent := rv.Layout;
      rv.RecommendationText.Position.X := 31;
      rv.RecommendationText.Width := 40;
      rv.RecommendationText.Align := TAlignLayout.Left;
      rv.RecommendationText.TextSettings.FontColor := COLOR_GRAY_UNSELECTED1;
      rv.RecommendationText.Visible := _info.Logined;

      rv.CommentImage := TImage.Create(rv.Layout);
      rv.CommentImage.Parent := rv.Layout;
      rv.CommentImage.Position.X := 81;
      rv.CommentImage.Width := 30;
      rv.CommentImage.Align := TAlignLayout.Left;
      rv.CommentImage.Bitmap := ImageList1.Bitmap(TSizeF.Create(60,60), 4);
      rv.CommentImage.OnClick := OnCommentImageClick;
      rv.CommentImage.Visible := _info.Logined;

      rv.CommentText := TText.Create(rv.Layout);
      rv.CommentText.Parent := rv.Layout;
      rv.CommentText.Position.X := 111;
      rv.CommentText.Width := 40;
      rv.CommentText.Align := TAlignLayout.Left;
      rv.CommentText.TextSettings.FontColor := COLOR_GRAY_UNSELECTED1;
      rv.CommentText.Visible := _info.Logined;

      rv.BookmarkImage := TImage.Create(rv.Layout);
      rv.BookmarkImage.Parent := rv.Layout;
      rv.BookmarkImage.Position.X := 161;
      rv.BookmarkImage.Width := 30;
      rv.BookmarkImage.Align := TAlignLayout.Left;
      rv.BookmarkImage.OnClick := OnBookmarkImageclick;
      rv.BookmarkImage.Visible := _info.Logined;

      rv.PlayRecipeImage := TImage.Create(rv.Layout);
      rv.PlayRecipeImage.Parent := rv.Layout;
      rv.PlayRecipeImage.Position.X := 191;
      rv.PlayRecipeImage.Width := 30;
      rv.PlayRecipeImage.Align := TAlignLayout.Right;
      rv.PlayRecipeImage.Bitmap := ImageList1.Bitmap(TSizeF.Create(60,60), 5);
      rv.PlayRecipeImage.OnClick := OnPlayRecipeImageClick;
    end;
  end;

  FRecipeBarList.AddObject('', rv);
end;

procedure TfrmWeb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  timerClose.Enabled := False;
  Action := TCloseAction.caFree;
end;

procedure TfrmWeb.FormCreate(Sender: TObject);
begin
  FRecipeBarList := TStringList.Create;
end;

procedure TfrmWeb.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    layoutBackButton.OnClick(layoutBackButton);
  end;
end;

procedure TfrmWeb.FormShow(Sender: TObject);
begin
  // 첫번째 Tab 세팅
  tabWeb.TabPosition := TTabPosition.None;

  // Status Bar 색을 바꾼다
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);
end;

procedure TfrmWeb.goURL(url: string;  aCallbackRefFunc: TCallbackRefFunc);
var
  wb: TWebBrowser;
  index: integer;
  wbname: string;
begin
  FCallbackRefFunc := aCallbackRefFunc;

  index := tabWeb.TabCount;

  AddTab(tabWeb);

  wbName := STR_WEBBROWSER_NAME + Index.ToString;

  wb := TWebBrowser(tabWeb.Tabs[index].FindComponent(wbName));
  wb.Navigate(url);
  tabWeb.TabIndex := index;
//
  wb.SetFocus;
end;

procedure TfrmWeb.layoutBackButtonClick(Sender: TObject);
begin
//  CloseLastWebbrowser;
  timerClose.Tag := 1;
  timerClose.Enabled := True;
end;

procedure TfrmWeb.OnBookmarkImageClick(Sender: TObject);
var
  aIndex: integer;
  rv: TRecipeViewInfo;
begin
  if CM.memUser.IsEmpty then
    ShowMessage('로그인 하셔야 북마크를 사용하실 수 있습니다!')
  else
  begin
    aIndex := RecipeMenuBarCount - 1;
    rv := RecipeMenuBar(aIndex);

    CM.UpdateRecipeBookmark(rv.RecipeSerial, rv.UserSerial, (TImage(Sender).Tag = 0));
    SetBookmarkImage(aIndex, TImage(Sender).Tag = 0);

    SetRecipeView(aIndex);
  end;
end;

procedure TfrmWeb.OnCommentImageClick(Sender: TObject);
var
  aIndex: integer;
begin
  if not _info.Logined then
    ShowMessage('로그인 하셔야 댓글을 입력하실 수 있습니다!')
  else
  begin
    // Comment 화면을 Display 한다
    aIndex := RecipeMenuBarCount - 1;

    frmComment.Init(RecipeMenuBar(aIndex).RecipeSerial,
      procedure(const aResult: Boolean)
      var
        aList: TStringList;
      begin
        if aResult then
        begin
          SetRecipeView(RecipeMenuBarCount - 1);

          if Assigned(FCallbackRefFunc) then
            try
              aList := TStringList.Create;
              aList.Add(RecipeMenuBar(aIndex).RecommendationText.Text); // RecommendationCount
              aList.Add(RecipeMenuBar(aIndex).CommentText.Text); // CommentCount
              FCallbackRefFunc(aList);
            finally
              aList.DisposeOf;
            end;
        end;
      end
    );
    frmComment.Show;
  end;
end;

procedure TfrmWeb.OnPlayRecipeImageClick(Sender: TObject);
var
  aIndex: integer;
  rv: TRecipeViewInfo;
  web: TWebBrowser;
  index: integer;
begin
  // Recipe를 Play 한다

  aIndex := RecipeMenuBarCount - 1;

  rv := RecipeMenuBar(aIndex);

  if rv.RecipeSerial > NEW_RECIPE_SERIAL then
  begin
    index := tabWeb.TabCount - 1;

    web := TWebBrowser(tabWeb.Tabs[index].FindComponent(STR_WEBBROWSER_NAME + index.ToString));

    web.EvaluateJavaScript('RecipePlay();');
  end;
end;

procedure TfrmWeb.OnRecommendationImageClick(Sender: TObject);
var
  aIndex: integer;
  rv: TRecipeViewInfo;
  aList: TStringList;
begin
  if CM.memUser.IsEmpty then
    ShowMessage('로그인 하셔야 추천하실 수 있습니다!')
  else
  begin
    aIndex := RecipeMenuBarCount - 1;
    rv := RecipeMenuBar(aIndex);

    CM.UpdateRecipeRecommendation(rv.RecipeSerial, rv.UserSerial, (TImage(Sender).Tag = 0));
    SetRecommendationImage(aIndex, TImage(Sender).Tag = 0);

    SetRecipeView(aIndex);

    if Assigned(FCallbackRefFunc) then
      try
        aList := TStringList.Create;
        aList.Add(RecipeMenuBar(aIndex).RecommendationText.Text); // RecommendationCount
        aList.Add(RecipeMenuBar(aIndex).CommentText.Text); // CommentCount
        FCallbackRefFunc(aList);
      finally
        aList.DisposeOf;
      end;
  end;
end;

procedure TfrmWeb.OnShouldStartLoadWithRequest(ASender: TObject;
  const URL: string);
var
  MethodName: string;
  sRecipeSerial: string;
  p: integer;
  p2: integer;
  rv: TRecipeViewInfo;
  aIndex: integer;
  Params: TArray<TValue>;
begin
  if URL.IndexOf('recipe_view.php') > 0 then
  begin
    try
      p := URL.IndexOf('=');
      p2 := URL.IndexOf('&');

      if p > -1 then
      begin
        if p2 = -1 then
          sRecipeSerial := copy(URL, p+2, URL.Length - p + 1)
        else
          sRecipeSerial := copy(URL, p+2, (p2-p-1));

        aIndex := RecipeMenuBarCount - 1;

        rv := RecipeMenuBar(aIndex);

        rv.RecipeSerial := sRecipeSerial.ToInt64;

        rv.UserSerial := _info.UserSerial;

        if rv.UserSerial > -1 then
          SetRecipeView(aIndex);
      end;
    except
      ShowMessage('일부 레시피 정보를 가져올 수 없습니다!' + #13#10 + url);
    end;

  end;

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

function TfrmWeb.RecipeMenuBar(aIndex: integer): TRecipeViewInfo;
begin
  result := nil;

  if aIndex < FRecipeBarList.Count then
    result := TRecipeViewInfo(FRecipeBarList.Objects[aIndex]);
end;

function TfrmWeb.RecipeMenuBarCount: integer;
begin
  result := FRecipeBarList.Count;
end;

procedure TfrmWeb.SetBookmarkImage(aIndex: integer; aActive: Boolean);
begin
  if aActive then
  begin
    RecipeMenuBar(aIndex).BookmarkImage.Bitmap := ImageList1.Bitmap(TSizeF.Create(60,60), 2);
    RecipeMenuBar(aIndex).BookmarkImage.Tag := 1;
  end
  else
  begin
    RecipeMenuBar(aIndex).BookmarkImage.Bitmap := ImageList1.Bitmap(TSizeF.Create(60,60), 3);
    RecipeMenuBar(aIndex).BookmarkImage.Tag := 0;
  end;
end;

procedure TfrmWeb.SetCommentText(aIndex: integer; aText: string);
begin
  RecipeMenuBar(aIndex).CommentText.Text := aText;
end;

procedure TfrmWeb.SetRecipeView(aIndex: integer);
var
  aRecommended, aBookmarked, aRecommendationCount, aCommentCount: integer;
begin
  if _info.Logined then
  begin
    CM.GetRecipeViewCount(RecipeMenuBar(aIndex).RecipeSerial, RecipeMenuBar(aIndex).UserSerial,
      aRecommended, aBookmarked, aRecommendationCount, aCommentCount);

    // 해당 레시피에 대하여 추천을 했는지 표시
    SetRecommendationImage(aIndex, (aRecommended > 0));
    // 해당 레시피에 대하여 북마크 했는지 표시
    SetBookmarkImage(aIndex, (aBookmarked > 0));
    // 추천 개수 표시
    SetRecommendationText(aIndex, aRecommendationCount.ToString);
    // 댓글 개수 표시
    SetCommentText(aIndex, aCommentCount.ToString);
  end;

  RecipeMenuBar(aIndex).BodyRectangle.Visible := True;
end;

procedure TfrmWeb.SetRecommendationImage(aIndex: integer; aActive: Boolean);
begin
  if aActive then
  begin
    RecipeMenuBar(aIndex).RecommendationImage.Bitmap := ImageList1.Bitmap(TSizeF.Create(60,60), 0);
    RecipeMenuBar(aIndex).RecommendationImage.Tag := 1;
  end
  else
  begin
    RecipeMenuBar(aIndex).RecommendationImage.Bitmap := ImageList1.Bitmap(TSizeF.Create(60,60), 1);
    RecipeMenuBar(aIndex).RecommendationImage.Tag := 0;
  end;
end;

procedure TfrmWeb.SetRecommendationText(aIndex: integer; aText: string);
begin
  RecipeMenuBar(aIndex).RecommendationText.Text := aText;
end;

procedure TfrmWeb.timerCloseTimer(Sender: TObject);
  procedure CloseWebbrowser(cnt: integer);
  var
    web: TWebBrowser;
    aindex, i: integer;
  begin
    for i := 0 to cnt-1 do
      if tabWeb.TabCount > 1 then
      begin
        aindex := tabWeb.TabCount - 1;
        web := TWebBrowser(tabWeb.Tabs[aindex].FindComponent(STR_WEBBROWSER_NAME + aindex.ToString));
        web.DisposeOf;
        tabWeb.Delete(aindex);
      end
      else if tabWeb.TabCount = 1 then
        Close;

    tabWeb.TabIndex := tabWeb.TabCount - 1;

//    if tabWeb.TabCount = 0 then
//      Close
//    else
//      tabWeb.TabIndex := tabWeb.TabCount - 1;
  end;
begin
  timerClose.Enabled := False;

  CloseWebbrowser(timerClose.Tag);

  timerClose.Tag := 0;
end;

end.
