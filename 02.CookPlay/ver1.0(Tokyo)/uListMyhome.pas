unit uListMyhome;

interface
uses FMX.Layouts, FMX.Objects, System.Classes, Data.DB, FMX.Dialogs,
  System.sysUtils, uGlobal, System.UITypes, FMX.Types, System.Types,
  FMX.Listbox, FMX.Graphics, FMX.TabControl, FMX.Gestures, FMX.Forms,
  FMX.Ani;

type
  TMyhomeList = class;

  TMyhomeRecipeStoryItem = class
    Parent: TMyhomeList;
    FTargetSerial: LargeInt;
    FUserPicture: string;
    FUserNicname: string;
    FCategory: string;
    FTitle: string;
    FDescription: string;
    FRecommendationCount: integer;
    FCommentCount: integer;
    FCreatedDate: string;

    FRecommanded: Boolean;

    FImageNames: array of string;

    layoutItemBody: TLayout;

    recContent: TRectangle;

    layoutTail: TLayout;

    layoutItemTop: TLayout;
    circleUser: TCircle;
    txtNickname: TText;
    imgMenu: TImage;

    layoutItemImage: TLayout;

    tabcontrolPicture: TTabControl;
    layoutPicturePosition: TLayout;
    recPicturePosition: TRoundRect;
    txtPicturePosition: TText;

    aPreviousTabAction: TPreviousTabAction;
    aNextTabAction: TNextTabAction;

    layoutInfo: TLayout;
    txtCategory: TText;
    layoutRecommendationCountBody: TLayout;
    layoutRecommendationCount: TLayout;
    imgRecommendationCount: TImage;
    txtRecommendationCount: TText;
    imgCommentCount: TImage;
    txtCommentCount: TText;

    txtTitle: TText;
    txtExplain: TText;

    layoutBottom: Tlayout;
    imgRecommendationAction: TImage;
    imgCommentAction: TImage;
  private
    procedure DoPreviousTab(Sender: TObject);
    procedure DoNextTab(Sender: TObject);

    procedure DisplayPicturePosition;

    procedure DoMenuImageClick(Sender: TObject);
    procedure DoRecommendationImageClick(Sender: TObject);
    procedure DoCommentImageClick(Sender: TObject);

    procedure DoRecipeStoryItemClick(Sender: TObject);
  public
    constructor Create;
    procedure ClearControls;
  end;

  TMyhomeBookmarkItem = class
    Parent: TMyhomeList;

    FTargetSerial: LargeInt; // Bookmark Serial
    FContentType: TBookmarkType; // story, recipe, cookbook
    FContentSerial: LargeInt;
    FUserPicture: string;
    FUserNicname: string;
    FTitle: string;
    FDescription: string;
    FRecommendationCount: integer;
    FCommentCount: integer;
    FCreatedDate: string;

    FImageName: string;

    layoutItemBody: TLayout;

    layoutDelete: TLayout;
    imgDelete: TImage;
    recContent: TRectangle;

    imgPicture: TImage;
    layoutSplit: TLayout;
    layoutRight: TLayout;

    layoutRightTop: TLayout;
    txtTitle: TText;
    layoutType: TLayout;
    imgType: TImage;
    txtDescription: TText;

    layoutRightBottom: TLayout;
    circleUser: TCircle;
    txtNickname: TText;
    layoutRecommendationCount: TLayout;
    imgRecommendationCount: TImage;
    txtRecommendationCount: TText;
    imgCommentCount: TImage;
    txtCommentCount: TText;

    layoutTail: TLayout;
  private
    procedure DoBookmarkItemClick(Sender: TObject);
    procedure DoDeleteImageClick(Sender: TObject);
  public
    constructor Create;
    procedure ClearControls;
  end;

  TMyhomeList = class
    FGrab: Boolean;
    FOldX: Single;
    FOldY: Single;
    FFirstX, FFirstY: Single;
    FScrollHeight: Single;
//    FItemRectangle: TRectangle;
    FItemLayout: TLayout;

    FCallbackRef: TCallbackRefFunc;

    FUserSerial: LargeInt;
    FNickname: string;
    FListType: TMyhomeListType;
    FDisplayedCount: integer;
    FTopHeight: integer;
    FItemList: TStringList;
    FScrollBox: TVertScrollBox;
    FBaseLayout: TLayout;
    FScrollLayout: TLayout;
    FItemWidth: Single;
    FItemHeight: Single;
    FImageHeight: Single;
    FImageWidth: Single;
  private
    procedure DisplayItems(aIndex: Integer);
    function MakeItem(aIndex: integer): Boolean;
    function MakeRecipeStoryItem(aIndex: integer): Boolean;
    function MakeCookbookItem(aIndex: integer): Boolean;
    function MakeBookmarkItem(aIndex: integer): Boolean;

    procedure DoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    function GetItemPosition: integer;

    property CurItemPosition: integer read GetItemPosition;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ClearControls;
    procedure Init(aUserSerial: LargeInt; aNickname: string;
      aListType: TMyhomeListType; aBaseLayout, aScrollLayout: TLayout;
      aScrollBox: TVertScrollBox; aTopHeight: integer;
      aCallbackRef: TCallbackRefFunc=nil);
    procedure DeleteRecipeStoryItem(aTargetSerial: LargeInt);

    procedure DoLayoutMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure DoLayoutMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  end;

const
  MYHOME_LIST_NO = 20;


implementation
uses ClientModuleUnit, cookplay.s3, uGlobalComponent, uComment, uMenuBottom,
  uRecipeEditor, uWeb;
{ TMyhomeStoryItem }

procedure TMyhomeRecipeStoryItem.ClearControls;
var
  i: integer;
begin
  SetLength(FImageNames, 0);

  Parent := nil;

  FTargetSerial := -1;
  FUserPicture := '';
  FUserNicname := '';
  FCategory :=  '#';
  FDescription := '';
  FRecommendationCount := 0;
  FCommentCount := 0;
  FCreatedDate := '';

  FRecommanded := False;
end;

constructor TMyhomeRecipeStoryItem.Create;
begin
  ClearControls;
end;

procedure TMyhomeRecipeStoryItem.DisplayPicturePosition;
begin
  if Assigned(tabcontrolPicture) and (tabcontrolPicture.TabCount > 0) then
    txtPicturePosition.Text := IntToStr(tabcontrolPicture.TabIndex + 1) + '/' + tabcontrolPicture.TabCount.ToString
  else
    txtPicturePosition.Text := '0/0';
end;

procedure TMyhomeRecipeStoryItem.DoCommentImageClick(Sender: TObject);
begin
  if not _info.Logined then
    ShowMessage('로그인 하셔야 추천하실 수 있습니다!')
  else
  begin
    case Parent.FListType of
      mhltStory:
        begin
          frmComment.Init(TContentType.ctStory, FTargetSerial,
            procedure(const aResult: Boolean)
            begin
              // 댓글이 수정되었으면
              if aResult then
              begin
                self.FCommentCount := CM.GetStoryCommentCount(self.FTargetSerial);
                self.txtCommentCount.Text := self.FCommentCount.ToString;
              end;
            end
          );
        end;
      mhltRecipe:
        begin
          frmComment.Init(TContentType.ctRecipe, FTargetSerial,
            procedure(const aResult: Boolean)
            begin
              // 댓글이 수정되었으면
              if aResult then
              begin
                self.FCommentCount := CM.GetRecipeCommentCount(self.FTargetSerial);
                self.txtCommentCount.Text := self.FCommentCount.ToString;
              end;
            end
          );
        end;
      mhltCookbook: ;
      mhltBookmark: ;
    end;

    frmComment.Show;
  end;
end;

procedure TMyhomeRecipeStoryItem.DoMenuImageClick(Sender: TObject);
var
  aList: TStringList;
begin
  aList := TStringList.Create;
  aList.Add('수정');
  aList.Add('삭제');

  frmMenuBottom.Init(aList,
    procedure(const AResultList: TStringList)
    var
      nIndex: integer;
    begin
      if Assigned(aResultList) and (aResultList.Count > 0) then
      begin
        nIndex := aResultList[0].ToInteger;

        // 수정
        if nIndex = 0 then
        begin
          case Parent.FListType of
            mhltStory: ;
            mhltRecipe:
              begin
                frmRecipeEditor.RecipeSerial := self.FTargetSerial;
                frmRecipeEditor.Init(
                  procedure (const aResultList: TStringList)
                  var
                    i: integer;
                    aTabItem: TTabItem;
                    aImage: TImage;
                  begin
                    CM.UpdateMyhomeRecipeInfo(self);

                    while self.tabcontrolPicture.TabCount > 0 do
                      self.tabcontrolPicture.Delete(0);

                    for i:=0 to Length(self.FImageNames)-1 do
                    begin
                      aTabItem := TTabItem.Create(self.tabcontrolPicture);
                      aTabItem.Parent := self.tabcontrolPicture;
                      aTabItem.Index := i;
                      aTabItem.HitTest := False;

                      begin
                        aImage := TImage.Create(aTabItem);
                        aImage.Parent := aTabItem;
                        aImage.Align := TAlignLayout.Client;
                        aImage.HitTest := False;
                        if self.FImageNames[i] <> '' then
                        begin
                          if self.Parent.FListType = mhltStory then
                            frmS3.LoadImageFromS3(BUCKET_STORY, self.FImageNames[i], aImage.Bitmap)
                          else if self.Parent.FListType = mhltRecipe then
                            frmS3.LoadImageFromS3(BUCKET_RECIPE, self.FImageNames[i], aImage.Bitmap);
                        end;
                      end;
                      self.tabcontrolPicture.TabIndex := 0;
                    end;

                    self.DisplayPicturePosition;

                    self.txtCategory.Text := self.FCategory;
                    self.TxtExplain.Text := frmGlobalComponent.GetString(self.FDescription, 3, 70);
                  end
                );
                frmRecipeEditor.Show;
              end;
            mhltCookbook: ;
            mhltBookmark: ;
          end

        end
        // 삭제
        else if nIndex = 1 then
        begin
          case Parent.FListType of
            mhltStory:
              MessageDlg( '선택된 스토리를 삭제하시겠습니까?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYES, TMsgDlgBtn.mbNo], 0,
                procedure(const AResult: TModalResult)
                begin
                  if AResult = mrYes then
                  begin
                    if CM.DeleteStory(self.FTargetSerial) then
                    begin
                      self.Parent.DeleteRecipeStoryItem(self.FTargetSerial);
                    end
                    else
                      ShowMessage('삭제하지 못했습니다!');
                  end;
                end
              );
            mhltRecipe:
              MessageDlg( '선택된 레시피를 삭제하시겠습니까?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYES, TMsgDlgBtn.mbNo], 0,
                procedure(const AResult: TModalResult)
                begin
                  if AResult = mrYes then
                  begin
                    if CM.DeleteRecipe(self.FTargetSerial) then
                    begin
                      self.Parent.DeleteRecipeStoryItem(self.FTargetSerial);
                    end
                    else
                      ShowMessage('삭제하지 못했습니다!');
                  end;
                end
              );
            mhltCookbook: ;
            mhltBookmark: ;
          end
        end;
      end;
    end
  );

  frmMenuBottom.Show;
end;

procedure TMyhomeRecipeStoryItem.DoNextTab(Sender: TObject);
begin
  if Assigned(tabcontrolPicture) then
  begin
    if tabcontrolPicture.TabIndex < (tabcontrolPicture.TabCount-1) then
    begin
      tabcontrolPicture.TabIndex := tabcontrolPicture.TabIndex + 1;

      DisplayPicturePosition;
    end;
  end;
end;

procedure TMyhomeRecipeStoryItem.DoPreviousTab(Sender: TObject);
begin
  if Assigned(tabcontrolPicture) then
  begin
    if tabcontrolPicture.TabIndex > 0 then
    begin
      tabcontrolPicture.TabIndex := tabcontrolPicture.TabIndex - 1;

      DisplayPicturePosition;
    end;
  end;
end;

procedure TMyhomeRecipeStoryItem.DoRecommendationImageClick(Sender: TObject);
begin
  if not _info.Logined then
    ShowMessage('로그인 하셔야 추천하실 수 있습니다!')
  else
  begin
    self.FRecommanded := not self.FRecommanded;

    if self.FRecommanded then
    begin
      self.imgRecommendationAction.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(52,52), 4);
      self.FRecommendationCount := self.FRecommendationCount + 1;
      self.txtRecommendationCount.Text := self.FRecommendationCount.ToString;
    end
    else
    begin
      self.imgRecommendationAction.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(52,52), 5);
      self.FRecommendationCount := self.FRecommendationCount - 1;
      self.txtRecommendationCount.Text := self.FRecommendationCount.ToString;
    end;

    case Parent.FListType of
      mhltStory: CM.UpdateStoryRecommendation(self.FTargetSerial, _info.UserSerial, self.FRecommanded);
      mhltRecipe: CM.UpdateRecipeRecommendation(self.FTargetSerial, _info.UserSerial, self.FRecommanded);
      mhltCookbook: ;
      mhltBookmark: ;
    end;

  end;
end;

procedure TMyhomeRecipeStoryItem.DoRecipeStoryItemClick(Sender: TObject);
var
  aWeb: TfrmWeb;
  sURL: string;
begin
  aWeb := TfrmWeb.Create(Application);

  if Parent.FListType = mhltRecipe then
    sURL := URL_RECIPE_VIEW + '?recipeserial=' + self.FTargetSerial.ToString
  else if Parent.FListType = mhltStory then
    sURL := URL_STORY_VIEW + '?StorySerial=' + self.FTargetSerial.ToString
  else // Cookbook
  begin
  end;

  aWeb.goURL(sURL,
    procedure(const aResultList: TStringList)
    var
      aIndex: integer;
    begin
      if aResultList.Count > 2 then
      begin
        aIndex := TColorAnimation(Sender).Tag;
        // Recommendation Count
        self.FRecommendationCount := StrToIntDef(aResultList[0], 0);
        self.txtRecommendationCount.Text := GetCountString(self.FRecommendationCount);

        // Comment Count
        self.FCommentCount := StrToIntDef(aResultList[1], 0);
        self.txtCommentCount.Text := GetCountString(self.FCommentCount);

        // 북마크
        self.FRecommanded := (StrToIntDef(aResultList[2], 0) = 1);
        if self.FRecommanded then
          self.imgRecommendationAction.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(52,52), 4)
        else
          self.imgRecommendationAction.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(52,52), 5);
      end;
    end
  );

  aWeb.Show;
end;

{ TMyhomeStory }

procedure TMyhomeList.ClearControls;
begin
  FGrab := False;
  FOldX := 0;
  FOldY := 0;
  FFirstX := 0;
  FFirstY := 0;
  FScrollHeight := 0;
//  FItemRectangle := nil;
  FItemLayout := nil;

  FUserSerial := -1;
  FDisplayedCount := 0;
  FTopHeight := 0;
  FBaseLayout := nil;
  FScrollLayout := nil;
  FScrollBox := nil;
  FItemWidth := 0;
  FItemHeight := 0;

  while FItemList.Count > 0 do
  begin
    TMyhomeRecipeStoryItem(FItemList.Objects[0]).layoutItemBody.DisposeOf;
//    TMyhomeRecipeStoryItem(FItemList.Objects[0]).recItemBody.DisposeOf;
//    TMyhomeRecipeStoryItem(FItemList.Objects[0]).layoutTail.DisposeOf;
    FItemList.Objects[0].DisposeOf;
    FItemList.Delete(0);
  end;
end;

constructor TMyhomeList.Create;
begin
  FItemList := TStringList.Create;

  ClearControls;
end;

procedure TMyhomeList.DeleteRecipeStoryItem(aTargetSerial: LargeInt);
var
  i, k: integer;
  aOldY, tempLayoutY: Single;
//  tempRec, aOldRecY, aOldLayoutY: Single;
begin
  FScrollBox.BeginUpdate;

  for i := 0 to FItemList.Count-1 do
  begin
    if TMyhomeRecipeStoryItem(FItemList.Objects[i]).FTargetSerial = aTargetSerial then
    begin
      TMyhomeRecipeStoryItem(FItemList.Objects[i]).layoutItemBody.DisposeOf;
      FItemList.Objects[i].DisposeOf;
      FItemList.Delete(i);
      break;
    end;
  end;

//  for i := 0 to FItemList.Count-1 do
//  begin
//    if TMyhomeRecipeStoryItem(FItemList.Objects[i]).FTargetSerial = aTargetSerial then
//    begin
//      aOldY := TMyhomeRecipeStoryItem(FItemList.Objects[i]).layoutItemBody.Position.Y;
////      aOldRecY := TMyhomeRecipeStoryItem(FItemList.Objects[i]).recItemBody.Position.Y;
////      aOldLayoutY := TMyhomeRecipeStoryItem(FItemList.Objects[i]).layoutTail.Position.Y;
//
////      TMyhomeRecipeStoryItem(FItemList.Objects[i]).recItemBody.DisposeOf;
////      TMyhomeRecipeStoryItem(FItemList.Objects[i]).layoutTail.DisposeOf;
//      TMyhomeRecipeStoryItem(FItemList.Objects[i]).layoutItemBody.DisposeOf;
//      FItemList.Objects[i].DisposeOf;
//      FItemList.Delete(i);
//
//      for k := i to FItemList.Count-1 do
//      begin
////        tempRec := TMyhomeRecipeStoryItem(FItemList.Objects[k]).recItemBody.Position.Y;
//        tempLayoutY := TMyhomeRecipeStoryItem(FItemList.Objects[k]).layoutTail.Position.Y;
//
//        TMyhomeRecipeStoryItem(FItemList.Objects[K]).layoutItemBody.Position.Y := aOldY;
////        TMyhomeRecipeStoryItem(FItemList.Objects[K]).recItemBody.Position.Y := aOldRecY;
////        TMyhomeRecipeStoryItem(FItemList.Objects[K]).layoutTail.Position.Y := aOldLayoutY;
//
//        aOldY := tempLayoutY;
////        aOldRecY := tempRec;
////        aOldLayoutY := tempLayout;
//      end;
//
//      break;
//    end;
//  end;

  FScrollBox.EndUpdate;
end;

destructor TMyhomeList.Destroy;
begin
  ClearControls;

  inherited;
end;

procedure TMyhomeList.DisplayItems(aIndex: Integer);
var
  i, curCount: integer;
begin
  curCount := FDisplayedCount;
  if (aIndex >= curCount) then
  begin
    for i := 1 to MYHOME_LIST_NO do
      if MakeItem(curCount + i - 1) then
        FDisplayedCount := FDisplayedCount + 1;
  end;
end;

procedure TMyhomeList.DoLayoutMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if FGrab and (abs(FOldX - X) < 80) then // 좌우 Swipe
  begin
    // Up
    if (FOldY > Y) and (FScrollLayout.Position.Y > FScrollHeight) then
    begin
//      FScrollBox.AniCalculations.TouchTracking := [];

      if FScrollLayout.Position.Y - (FOldY - Y) < FScrollHeight then
        FScrollLayout.Position.Y := FScrollHeight
      else
        FScrollLayout.Position.Y := FScrollLayout.Position.Y - (FOldY - Y)
    end
    // Down
    else if (FOldY < Y) and (FScrollLayout.Position.Y < 0) then
    begin
//      FScrollBox.AniCalculations.TouchTracking := [];

      if FScrollLayout.Position.Y + (Y - FOldY) > 0 then
        FScrollLayout.Position.Y := 0
      else
        FScrollLayout.Position.Y := FScrollLayout.Position.Y + (Y - FOldY)
    end
    else
      FScrollBox.AniCalculations.TouchTracking := [ttVertical];
  end
  else
  ;
//    FScrollBox.AniCalculations.TouchTracking := [];

  FOldY := Y;
end;

procedure TMyhomeList.DoLayoutMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  aItemPosition: integer;
  aSList: TStringList;
begin
  FGrab := False;
  FScrollBox.AniCalculations.TouchTracking := [ttVertical];

  aItemPosition := CurItemPosition;

  aSList := TStringList.Create;

  // Click Event
  if (Abs(FFirstX - X) < 3) and (Abs(FFirstY - Y) < 3)  then
  begin
    if aItemPosition > -1 then
      case FListType of
        mhltStory, mhltRecipe: TMyhomeRecipeStoryItem(FItemList.Objects[aItemPosition]).DoRecipeStoryItemClick(Sender);
        mhltCookbook: ;
        mhltBookmark: TMyhomeBookmarkItem(FItemList.Objects[aItemPosition]).DoBookmarkItemClick(Sender);
      end;
  end
  else if ((FOldX - X) > 100) and (aItemPosition > -1) then
  begin
    if aItemPosition > -1 then
      case FListType of
        mhltStory, mhltRecipe: TMyhomeRecipeStoryItem(FItemList.Objects[aItemPosition]).DoNextTab(Sender);
        mhltCookbook: ;
        mhltBookmark: ;
      end;
  end
  else if ((FOldX - X) < -100) and (aItemPosition > -1) then
  begin
    if aItemPosition > -1 then
      case FListType of
        mhltStory, mhltRecipe: TMyhomeRecipeStoryItem(FItemList.Objects[aItemPosition]).DoPreviousTab(Sender);
        mhltCookbook: ;
        mhltBookmark: ;
      end;
  end
  else if FScrollLayout.Position.Y > (FScrollHeight / 3) then
  begin
    FScrollLayout.AnimateFloat('Position.Y', 0, 0.25);

    if Assigned(FCallbackRef) then
    begin
      FCallbackRef(aSList);
    end;
  end
  else
  begin
    FScrollLayout.AnimateFloat('Position.Y', FScrollHeight, 0.25);

    if Assigned(FCallbackRef) then
    begin
      aSList.Add(FNickname);

      FCallbackRef(aSList);
    end;
  end;
end;

procedure TMyhomeList.DoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
//  FScrollBox.AniCalculations.TouchTracking := [];

  FGrab := True;

//  FItemRectangle := TRectangle(Sender);
  FItemLayout := TLayout(Sender);

//  FOldX := TRectangle(Sender).Position.X + X;
//  FOldY := FScrollLayout.Position.Y + (TRectangle(Sender).Position.Y + Y - FScrollBox.ViewportPosition.Y) + 260; // 260 - MyhomeFrame's layoutMyhomeHeader.Height
  FOldX := TLayout(Sender).Position.X + X;
  FOldY := FScrollLayout.Position.Y + (TLayout(Sender).Position.Y + Y - FScrollBox.ViewportPosition.Y) + 260; // 260 - MyhomeFrame's layoutMyhomeHeader.Height

  FFirstX := FOldX;
  FFirstY := FOldY;

  FBaseLayout.Root.Captured := FBaseLayout;
end;

function TMyhomeList.GetItemPosition: integer;
var
  i: integer;
begin
  result := -1;
//  if Assigned(FItemRectangle) then
  if Assigned(FItemLayout) then
  begin
    case FListType of
      mhltStory, mhltRecipe:
        begin
          for i := 0 to FItemList.Count-1 do
//            if TMyhomeRecipeStoryItem(FItemList.Objects[i]).recItemBody = FItemRectangle then
            if TMyhomeRecipeStoryItem(FItemList.Objects[i]).layoutItemBody = FItemLayout then
            begin
              result := i;
              break;
            end;
        end;
      mhltCookbook: ;
      mhltBookmark:
        begin
          for i := 0 to FItemList.Count-1 do
//            if TMyhomeRecipeStoryItem(FItemList.Objects[i]).recItemBody = FItemRectangle then
            if TMyhomeBookmarkItem(FItemList.Objects[i]).layoutItemBody = FItemLayout then
            begin
              result := i;
              break;
            end;
        end;
    end;
  end;
end;

procedure TMyhomeList.Init(aUserSerial: LargeInt;  aNickname: string;
  aListType: TMyhomeListType; aBaseLayout, aScrollLayout: TLayout;
  aScrollBox: TVertScrollBox; aTopHeight: integer;
  aCallbackRef: TCallbackRefFunc);
begin
  Clearcontrols;

  FUserSerial := aUserSerial;
  FNickname := aNickname;
  FListType := aListType;

  FBaseLayout := aBaseLayout;
  FScrollLayout := aScrollLayout;
  FScrollBox := aScrollBox;
  FTopHeight := aTopHeight;

  FCallbackRef := aCallbackRef;

  FBaseLayout.OnMouseMove := DoLayoutMouseMove;
  FBaseLayout.OnMouseUp := DoLayoutMouseUp;

  FItemWidth := aScrollBox.Width - 20;
  FScrollHeight :=  -210; // MyhomeFrame's layoutMyhomeTop;

  case FListType of
    mhltStory:
      begin
        CM.GetMyhomeStoryList(FuserSerial, FItemList);

        FImagewidth := FItemWidth - 36; // Parent's Paddings
        FImageHeight := 240/320 * FImageWidth;
        FItemHeight := 50 + 38 + 54 + 39 + 10 + FImageHeight;
      end;
    mhltRecipe:
      begin
        CM.GetMyhomeRecipeList(FUserSerial, FItemList);

        FImagewidth := FItemWidth - 36; // Parent's Paddings
        FImageHeight := 240/320 * FImageWidth;
        FItemHeight := 50 + 38 + 54 + 39 + 10 + FImageHeight;
      end;
    mhltCookbook:
      begin
        FImagewidth := FItemWidth - 36; // Parent's Paddings
        FImageHeight := 240/320 * FImageWidth;
        FItemHeight := 130;
      end;
    mhltBookmark:
      begin
        CM.GetMyhomeBookmarkList(FUserSerial, FItemList);

//        FImagewidth := FItemWidth - 36; // Parent's Paddings
//        FImageHeight := 240/320 * FImageWidth;
        FItemHeight := 130;
      end;
  end;

  DisplayItems(FDisplayedCount);
end;

function TMyhomeList.MakeBookmarkItem(aIndex: integer): Boolean;
var
  nX, nY: Single;
  aItem: TMyhomeBookmarkItem;
begin
  // index 가 현재 List 의 개수보다 작으면 실행한다
  if aIndex < FItemList.Count then
  begin
//    nX := 10;
    nY := FTopHeight + (FItemHeight * aIndex); // 10 - 맨위 Margin

    aItem := TMyhomeBookmarkItem(FItemList.Objects[aIndex]);
    aItem.Parent := self;

    aItem.layoutItemBody := TLayout.Create(FScrollBox);
    aItem.layoutItemBody.Parent := FScrollBox;
//    aItem.layoutItemBody.Position.X := nX;
    aItem.layoutItemBody.Position.Y := nY;
    aItem.layoutItemBody.Width := FItemWidth;
    aItem.layoutItemBody.Height := FItemHeight;
    aItem.layoutItemBody.HitTest := True;

    aItem.layoutItemBody.Align := TAlignLayout.Top;

    aItem.layoutItemBody.OnMouseDown := DoMouseDown;

//    showmessage(nx.ToString + ', ' + ny.ToString + ' / ' + aItem.FTitle);

    begin
      aItem.recContent := TRectangle.Create(aItem.layoutItemBody);
      aItem.recContent.Parent := aItem.layoutItemBody;
      aItem.recContent.Fill.Color := TAlphaColorRec.White;
      aItem.recContent.Stroke.Kind := TBrushKind.None;
      aItem.recContent.Align := TAlignLayout.Top;
      aItem.recContent.Height := 120;
      aItem.recContent.HitTest := False;

      aItem.layoutDelete := TLayout.Create(aItem.layoutItemBody);
      aItem.layoutDelete.Parent := aItem.layoutItemBody;
      aItem.layoutDelete.Position := TPosition.Create(PointF(-8,-8));
      aItem.layoutDelete.Width := 32;
      aItem.layoutDelete.Height := 32;
      aItem.layoutDelete.HitTest := True;
      aItem.layoutDelete.OnClick := aItem.DoDeleteImageClick;
      begin
        aItem.imgDelete := TImage.Create(aItem.layoutDelete);
        aItem.imgDelete.Parent := aItem.layoutDelete;
        aItem.imgDelete.Position := TPosition.Create(PointF(0,0));
        aItem.imgDelete.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(64,64), 7);
        aItem.imgDelete.Width := 26;
        aItem.imgDelete.Height := 26;
        aItem.imgDelete.HitTest := False;
      end;

      begin
        aItem.imgPicture := TImage.Create(aItem.recContent);
        aItem.imgPicture.Parent := aItem.recContent;
        aItem.imgPicture.Width := 120;
        aItem.imgPicture.Align := TAlignLayout.Left;
        aItem.imgPicture.HitTest := False;

        case aItem.FContentType of
          btRecipe: frmS3.LoadImageFromS3(BUCKET_RECIPE, aItem.FImageName, aItem.imgPicture.Bitmap);
          btCookbook: ;
          btStory: frmS3.LoadImageFromS3(BUCKET_STORY, aItem.FImageName, aItem.imgPicture.Bitmap);
        end;

        aItem.layoutSplit := TLayout.Create(aItem.recContent);
        aItem.layoutSplit.Parent := aItem.recContent;
        aItem.layoutSplit.Width := 11;
        aItem.layoutSplit.Position.X := 121;
        aItem.layoutSplit.Align := TAlignLayout.Left;

        aItem.layoutRight := TLayout.Create(aItem.recContent);
        aItem.layoutRight.Parent := aItem.recContent;
        aItem.layoutRight.Align := TAlignLayout.Client;
        begin
          aItem.layoutRightTop := TLayout.Create(aItem.layoutRight);
          aItem.layoutRightTop.Parent := aItem.layoutRight;
          aItem.layoutRightTop.Height := 27;
          aItem.layoutRightTop.Align := TAlignLayout.Top;
          begin
            aItem.txtTitle := TText.Create(aItem.layoutRightTop);
            aItem.txtTitle.Parent := aItem.layoutRightTop;
            aItem.txtTitle.Align := TAlignLayout.Client;
            aItem.txtTitle.TextSettings.Font.Size := 14;
            aItem.txtTitle.TextSettings.HorzAlign := TTextAlign.Leading;
            aItem.txtTitle.Text := aItem.FTitle;
            aItem.txtTitle.HitTest := False;

            aItem.layoutType := TLayout.Create(aItem.layoutRightTop);
            aItem.layoutType.Parent := aItem.layoutRightTop;
            aItem.layoutType.Width := 24;
            aItem.layoutType.Align := TAlignLayout.Right;

            aItem.imgType := TImage.Create(aItem.layoutType);
            aItem.imgType.Parent := aItem.layoutType;
            aItem.imgType.Width := 16;
            aItem.imgType.Height := 16;
            aItem.imgType.Align := TAlignLayout.Center;
            aItem.imgType.HitTest := False;

            case aItem.FContentType of
              btRecipe: aItem.imgType.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(32,32), 9);
              btCookbook: aItem.imgType.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(32,32), 10);
              btStory: aItem.imgType.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(32,32), 8);
            end;
          end;

          aItem.txtDescription := TText.Create(aItem.layoutRight);
          aItem.txtDescription.Parent := aItem.layoutRight;
          aItem.txtDescription.Height := 44;
          aItem.txtDescription.Position.Y := 28;
          aItem.txtDescription.Margins.Top := 5;
          aItem.txtDescription.Margins.Right := 24;
          aItem.txtDescription.Align := TAlignLayout.Top;
          aItem.txtDescription.TextSettings.Font.Size := 12;
          aItem.txtDescription.TextSettings.FontColor := COLOR_GRAY_UNSELECTED2;
          aItem.txtDescription.TextSettings.HorzAlign := TTextAlign.Leading;
          aItem.txtDescription.TextSettings.VertAlign := TTextAlign.Leading;
          aItem.txtDescription.HitTest := False;
          aItem.txtDescription.Text := frmGlobalComponent.GetString(aItem.FDescription, 3, 70);

          aItem.layoutRightBottom := TLayout.Create(aItem.layoutRight);
          aItem.layoutRightBottom.Parent := aItem.layoutRight;
          aItem.layoutRightBottom.Height := 42;
          aItem.layoutRightBottom.Align := TAlignLayout.Bottom;
          begin
            aItem.circleUser := TCircle.Create(aItem.layoutRightBottom);
            aItem.circleUser.Parent := aItem.layoutRightBottom;
            aItem.circleUser.Width := 20;
            aItem.circleUser.Align := TAlignLayout.Left;
            aItem.circleUser.Stroke.Kind := TBrushKind.None;
            aItem.circleUser.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
            aItem.circleUser.Fill.Kind := TBrushKind.Bitmap;
            aItem.circleUser.HitTest := False;

            if aItem.FUserPicture.Trim <> '' then
              frmS3.LoadImageFromS3(BUCKET_USER, aItem.FUserPicture.Trim, aItem.circleUser.Fill.Bitmap.Bitmap)
            else
              aItem.circleUser.Fill.Bitmap.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(40,40), 11);

            aItem.txtNickname := TText.Create(aItem.layoutRightBottom);
            aItem.txtNickname.Parent := aItem.layoutRightBottom;
            aItem.txtNickname.Position.X := 21;
            aItem.txtNickname.Align := TAlignLayout.Left;
            aItem.txtNickname.Margins.Left := 5;
            aItem.txtNickname.TextSettings.Font.Size := 12;
            aItem.txtNickname.TextSettings.HorzAlign := TTextAlign.Leading;
            aItem.txtNickname.Text := aItem.FUserNicname;

            aItem.layoutRecommendationCount := TLayout.Create(aItem.layoutRightBottom);
            aItem.layoutRecommendationCount.Parent := aItem.layoutRightBottom;
            aItem.layoutRecommendationCount.Width := 100;
            aItem.layoutRecommendationCount.Align := TAlignLayout.Right;
            aItem.layoutRecommendationCount.Padding.Left := 6;
            begin
              aItem.imgRecommendationCount := TImage.Create(aItem.layoutRecommendationCount);
              aItem.imgRecommendationCount.Parent := aItem.layoutRecommendationCount;
              aItem.imgRecommendationCount.Width :=13;
              aItem.imgRecommendationCount.Align := TAlignLayout.Left;
              aItem.imgRecommendationCount.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(26,26), 2);

              aItem.txtRecommendationCount := TText.Create(aItem.layoutRecommendationCount);
              aItem.txtRecommendationCount.Parent := aItem.layoutRecommendationCount;
              aItem.txtRecommendationCount.Width := 30;
              aItem.txtRecommendationCount.Position.X := 14;
              aItem.txtRecommendationCount.Align := TAlignLayout.Left;
              aItem.txtRecommendationCount.Margins.Left := 5;
              aItem.txtRecommendationCount.TextSettings.HorzAlign := TTextAlign.Leading;
              aItem.txtRecommendationCount.TextSettings.Font.Size := 12;
              aItem.txtRecommendationCount.TextSettings.FontColor := COLOR_GRAY_UNSELECTED1;
              aItem.txtRecommendationCount.Text := aItem.FRecommendationCount.ToString;
              aItem.txtRecommendationCount.HitTest := False;

              aItem.imgCommentCount := TImage.Create(aItem.layoutRecommendationCount);
              aItem.imgCommentCount.Parent := aItem.layoutRecommendationCount;
              aItem.imgCommentCount.Width := 13;
              aItem.imgCommentCount.Position.X := 60;
              aItem.imgCommentCount.Align := TAlignLayout.Left;
              aItem.imgCommentCount.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(26,26), 3);

              aItem.txtCommentCount := TText.Create(aItem.layoutRecommendationCount);
              aItem.txtCommentCount.Parent := aItem.layoutRecommendationCount;
              aItem.txtCommentCount.Width := 30;
              aItem.txtCommentCount.Position.X := 80;
              aItem.txtCommentCount.Align := TAlignLayout.Left;
              aItem.txtCommentCount.Margins.Left := 5;
              aItem.txtCommentCount.TextSettings.HorzAlign := TTextAlign.Leading;
              aItem.txtCommentCount.TextSettings.Font.Size := 12;
              aItem.txtCommentCount.TextSettings.FontColor := COLOR_GRAY_UNSELECTED1;
              aItem.txtCommentCount.Text := aItem.FCommentCount.ToString;
              aItem.txtCommentCount.HitTest := False;
            end;
          end;
        end;
      end;

      aItem.layoutTail := Tlayout.Create(aItem.layoutItemBody);
      aItem.layoutTail.Parent := aItem.layoutItemBody;
      aItem.layoutTail.Position.Y := 121;
      aItem.layoutTail.Align := TAlignLayout.Client;
    end;

    result := True;
  end
  else
    result := False;
end;

function TMyhomeList.MakeCookbookItem(aIndex: integer): Boolean;
begin
  result := true;
end;

function TMyhomeList.MakeItem(aIndex: integer): Boolean;
begin
  result := False;
  case FListType of
    mhltStory: result := MakeRecipeStoryItem(aIndex);
    mhltRecipe: result := MakeRecipeStoryItem(aIndex);
    mhltCookbook: result := MakeCookbookItem(aIndex);
    mhltBookmark: result := MakeBookmarkItem(aIndex);
  end;
end;

function TMyhomeList.MakeRecipeStoryItem(aIndex: integer): Boolean;
var
//  nX: Single;
  nY: Single;
  aItem: TMyhomeRecipeStoryItem;
  i: integer;
  aImage: TImage;
  aTabItem: TTabItem;
begin
  // index 가 현재 List 의 개수보다 작으면 실행한다
  if aIndex < FItemList.Count then
  begin
//    nX := 10;
//    nY := FTopHeight + (FItemHeight * aIndex) + (10 * (aIndex+1)); // 10 = layoutTail.Height

    nY := FTopHeight + (FItemHeight * aIndex);

    aItem := TMyhomeRecipeStoryItem(FItemList.Objects[aIndex]);
    aItem.Parent := self;

    aItem.layoutItemBody := TLayout.Create(FScrollBox);
    aItem.layoutItemBody.Parent := FScrollBox;
//    aItem.layoutItemBody.Position.X := nX;
    aItem.layoutItemBody.Position.Y := nY;
    aItem.layoutItemBody.Width := FItemWidth;
    aItem.layoutItemBody.Height := FItemHeight;
    aItem.layoutItemBody.HitTest := True;
    aItem.layoutItemBody.Align := TAlignLayout.Top;

    aItem.layoutItemBody.OnMouseDown := DoMouseDown;

    aItem.recContent := TRectangle.Create(aItem.layoutItemBody);
    aItem.recContent.Parent := aItem.layoutItemBody;
//    aItem.recContent.Position.X := nX;
    aItem.recContent.Position.Y := nY;
//    aItem.recContent.Width := FItemWidth;
    aItem.recContent.Height := FItemHeight - 10;  // 10 = tail
    aItem.recContent.Fill.Color := TAlphaColorRec.White;
    aItem.recContent.Stroke.Color := COLOR_BACKGROUND;
    aItem.recContent.Stroke.Thickness := 0.8;
    aItem.recContent.Padding.Left := 18;
    aItem.recContent.Padding.Right := 18;
    aItem.recContent.Align := TAlignLayout.top;
    aItem.recContent.HitTest := False;

//    aItem.recItemBody.OnMouseDown := DoMouseDown;

    aItem.layoutTail := TLayout.Create(aItem.layoutItemBody);
    aItem.layoutTail.Parent := aItem.layoutItemBody;
    aItem.layoutTail.Position := TPosition.Create(PointF(0, nY + FItemHeight));
    aItem.layoutTail.Height := 10;
    aItem.layoutTail.Align := TAlignLayout.Client;


    begin
      aItem.layoutItemTop := TLayout.Create(aItem.recContent);
      aItem.layoutItemTop.Parent := aItem.recContent;
      aItem.layoutItemTop.Height := 50;
      aItem.layoutItemTop.Align := TAlignLayout.Top;
      begin
        aItem.circleUser := TCircle.Create(aItem.layoutItemTop);
        aItem.circleUser.Parent := aItem.layoutItemTop;
        aItem.circleUser.Width := 32;
        aItem.circleUser.Align := TAlignLayout.Left;
        aItem.circleUser.Stroke.Kind := TBrushKind.None;
        aItem.circleUser.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
        aItem.circleUser.Fill.Kind := TBrushKind.Bitmap;
        aItem.circleUser.HitTest := False;

        if aItem.FUserPicture.Trim <> '' then
          frmS3.LoadImageFromS3(BUCKET_USER, aItem.FUserPicture.Trim, aItem.circleUser.Fill.Bitmap.Bitmap)
        else
          aItem.circleUser.Fill.Bitmap.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(32,32), 0);


        aItem.txtNickname := TText.Create(aItem.layoutItemTop);
        aItem.txtNickname.Parent := aItem.layoutItemTop;
        aItem.txtNickname.Text := aItem.FUserNicname.Trim;
        aItem.txtNickname.Align := TAlignLayout.Left;
        aItem.txtNickname.Margins.Left := 10;
        aItem.txtNickname.Margins.Right := 10;
        aItem.txtNickname.TextSettings.Font.Size := 14;

        aItem.imgMenu := TImage.Create(aItem.layoutItemTop);
        aItem.imgMenu.Parent := aItem.layoutItemTop;
        aItem.imgMenu.Width := 24;
        aItem.imgMenu.Align := TAlignLayout.Right;
        aItem.imgMenu.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(24,24), 1);

        aItem.imgMenu.OnClick := aItem.DoMenuImageClick;

        aItem.imgMenu.Visible := self.FUserSerial = _info.UserSerial;
      end;

      aItem.layoutItemImage := TLayout.Create(aItem.recContent);
      aItem.layoutItemImage.Parent := aItem.recContent;
      aItem.layoutItemImage.Position.Y := 51; //:= TPosition.Create(PointF(0,0));
      aItem.layoutItemImage.Height := FImageHeight;
      aItem.layoutItemImage.Align := TAlignLayout.Top;
      begin
        aItem.tabcontrolPicture := TTabControl.Create(aItem.layoutItemImage);
        aItem.tabcontrolPicture.Parent := aItem.layoutItemImage;
        aItem.tabControlPicture.Position := TPosition.Create(PointF(0,0));
        aItem.tabcontrolPicture.Width := FImageWidth;
        aItem.tabcontrolPicture.Height := FImageHeight;
        aItem.tabcontrolPicture.TabPosition := TTabPosition.None;
        aItem.tabcontrolPicture.HitTest := False;
//        aStoryItem.tabcontrolPicture.OnMouseDown := DoMouseDown;

        for i:=0 to Length(aItem.FImageNames)-1 do
        begin
          aTabItem := TTabItem.Create(aItem.tabcontrolPicture);
          aTabItem.Parent := aItem.tabcontrolPicture;
          aTabItem.Index := i;
          aTabItem.HitTest := False;
//          aTabItem.OnMouseDown := DoMouseDown;
          begin
            aImage := TImage.Create(aTabItem);
            aImage.Parent := aTabItem;
            aImage.Align := TAlignLayout.Client;
            aImage.HitTest := False;
            if aItem.FImageNames[i] <> '' then
            begin
              if aItem.Parent.FListType = mhltStory then
                frmS3.LoadImageFromS3(BUCKET_STORY, aItem.FImageNames[i], aImage.Bitmap)
              else if aItem.Parent.FListType = mhltRecipe then
                frmS3.LoadImageFromS3(BUCKET_RECIPE, aItem.FImageNames[i], aImage.Bitmap);
            end;
          end;
          aItem.tabcontrolPicture.TabIndex := 0;
        end;

        aItem.aPreviousTabAction := TPreviousTabAction.Create(frmGlobalComponent);
        aItem.aPreviousTabAction.OnUpdate := aItem.DoPreviousTab;

        aItem.aNextTabAction := TNextTabAction.Create(frmGlobalComponent);
        aItem.aNextTabAction.OnUpdate := aItem.DoNextTab;

        aItem.tabcontrolPicture.Touch.GestureManager := frmGlobalComponent.MyhomeGestureManager;
        aItem.tabcontrolPicture.Touch.StandardGestures := [TStandardGesture.sgLeft, TStandardGesture.sgRight];
        aItem.tabcontrolPicture.Touch.GestureList[0].Action := aItem.aNextTabAction;
        aItem.tabcontrolPicture.Touch.GestureList[1].Action := aItem.aPreviousTabAction;

        aItem.layoutPicturePosition := TLayout.Create(aItem.layoutItemImage);
        aItem.layoutPicturePosition.Parent := aItem.layoutItemImage;
        aItem.layoutPicturePosition.Height := 33;
        aItem.layoutPicturePosition.Align := TAlignLayout.Bottom;
        begin
          aItem.recPicturePosition := TRoundRect.Create(aItem.layoutPicturePosition);
          aItem.recPicturePosition.Parent := aItem.layoutPicturePosition;
          aItem.recPicturePosition.Align := TAlignLayout.Center;
          aItem.recPicturePosition.Fill.Color := TAlphaColorRec.Black;
          aItem.recPicturePosition.Stroke.Kind := TBrushKind.None;
          aItem.recPicturePosition.Opacity := 0.5;
          aItem.recPicturePosition.Width := 50;
          aItem.recPicturePosition.Height := 20;

          aItem.txtPicturePosition := TText.Create(aItem.layoutPicturePosition);
          aItem.txtPicturePosition.Parent := aItem.layoutPicturePosition;
          aItem.txtPicturePosition.HitTest := False;
          aItem.txtPicturePosition.Width := 38;
          aItem.txtPicturePosition.Height := 20;
          aItem.txtPicturePosition.Align := TAlignLayout.Center;
          aItem.txtPicturePosition.TextSettings.Font.Size := 14;
          aItem.txtPicturePosition.TextSettings.FontColor := TAlphaColorRec.White;
        end;

        aItem.DisplayPicturePosition;
      end;

      aItem.layoutInfo := TLayout.Create(aItem.recContent);
      aItem.layoutInfo.Parent := aItem.recContent;
      aItem.layoutInfo.Height := 38;
      aItem.layoutInfo.Position.Y := 51 + FItemHeight + 1;
      aItem.layoutInfo.Align := TAlignLayout.Top;
      aItem.layoutInfo.Padding.Top := 7;
      begin
        aItem.txtCategory := TText.Create(aItem.layoutInfo);
        aItem.txtCategory.Parent := aItem.layoutInfo;
        aItem.txtCategory.Align := TAlignLayout.Client;
        aItem.txtCategory.TextSettings.HorzAlign := TTextAlign.Leading;
        aItem.txtCategory.TextSettings.Font.Size := 12;
        aItem.txtCategory.Margins.Right := 10;
        aItem.txtCategory.TextSettings.FontColor := COLOR_BACKGROUND;
        aItem.txtCategory.Text := aItem.FCategory;
        aItem.txtCategory.HitTest := False;

        aItem.layoutRecommendationCountBody := TLayout.Create(aItem.layoutInfo);
        aItem.layoutRecommendationCountBody.Parent := aItem.layoutInfo;
        aItem.layoutRecommendationCountBody.Width := 100;
        aItem.layoutRecommendationCountBody.Align := TAlignLayout.Right;
        begin
          aItem.layoutRecommendationCount := TLayout.Create(aItem.layoutRecommendationCountBody);
          aItem.layoutRecommendationCount.Parent := aItem.layoutRecommendationCountBody;
          aItem.layoutRecommendationCount.Height := 20;
          aItem.layoutRecommendationCount.Align := TAlignLayout.Top;
          begin
            aItem.imgRecommendationCount := TImage.Create(aItem.layoutRecommendationCount);
            aItem.imgRecommendationCount.Parent := aItem.layoutRecommendationCount;
            aItem.imgRecommendationCount.Width :=13;
            aItem.imgRecommendationCount.Align := TAlignLayout.Left;
            aItem.imgRecommendationCount.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(26,26), 2);

            aItem.txtRecommendationCount := TText.Create(aItem.layoutRecommendationCount);
            aItem.txtRecommendationCount.Parent := aItem.layoutRecommendationCount;
            aItem.txtRecommendationCount.Width := 30;
            aItem.txtRecommendationCount.Position.X := 14;
            aItem.txtRecommendationCount.Align := TAlignLayout.Left;
            aItem.txtRecommendationCount.Margins.Left := 5;
            aItem.txtRecommendationCount.TextSettings.HorzAlign := TTextAlign.Leading;
            aItem.txtRecommendationCount.TextSettings.Font.Size := 12;
            aItem.txtRecommendationCount.TextSettings.FontColor := COLOR_GRAY_UNSELECTED1;
            aItem.txtRecommendationCount.Text := aItem.FRecommendationCount.ToString;
            aItem.txtRecommendationCount.HitTest := False;

            aItem.imgCommentCount := TImage.Create(aItem.layoutRecommendationCount);
            aItem.imgCommentCount.Parent := aItem.layoutRecommendationCount;
            aItem.imgCommentCount.Width := 13;
            aItem.imgCommentCount.Position.X := 60;
            aItem.imgCommentCount.Align := TAlignLayout.Left;
            aItem.imgCommentCount.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(26,26), 3);

            aItem.txtCommentCount := TText.Create(aItem.layoutRecommendationCount);
            aItem.txtCommentCount.Parent := aItem.layoutRecommendationCount;
            aItem.txtCommentCount.Width := 30;
            aItem.txtCommentCount.Position.X := 80;
            aItem.txtCommentCount.Align := TAlignLayout.Left;
            aItem.txtCommentCount.Margins.Left := 5;
            aItem.txtCommentCount.TextSettings.HorzAlign := TTextAlign.Leading;
            aItem.txtCommentCount.TextSettings.Font.Size := 12;
            aItem.txtCommentCount.TextSettings.FontColor := COLOR_GRAY_UNSELECTED1;
            aItem.txtCommentCount.Text := aItem.FCommentCount.ToString;
            aItem.txtCommentCount.HitTest := False;
          end;
        end;
      end;

      aItem.TxtExplain := TText.Create(aItem.recContent);
      aItem.TxtExplain.Parent := aItem.recContent;
      aItem.TxtExplain.Height := 54;
      aItem.TxtExplain.Position.Y := 51 + FItemHeight + 38 + 1;
      aItem.TxtExplain.Align := TAlignLayout.Top;
      aItem.TxtExplain.TextSettings.FontColor := COLOR_GRAY_UNSELECTED2;
      aItem.TxtExplain.TextSettings.Font.Size := 14;
      aItem.TxtExplain.TextSettings.VertAlign := TTextAlign.Leading;
      aItem.TxtExplain.TextSettings.HorzAlign := TTextAlign.Leading;
      aItem.TxtExplain.Text := frmGlobalComponent.GetString(aItem.FDescription, 3, 70);
      aItem.txtExplain.HitTest := False;

      aItem.layoutBottom := TLayout.Create(aItem.recContent);
      aItem.layoutBottom.Parent := aItem.recContent;
      aItem.layoutBottom.Height := 39;
      aItem.layoutBottom.Padding.Bottom := 15;
      aItem.layoutBottom.Position.Y := 51 + FItemHeight + 38 + 54 + 1;
      aItem.layoutBottom.Align := TAlignLayout.Top;
      begin
        aItem.imgRecommendationAction := TImage.Create(aItem.layoutBottom);
        aItem.imgRecommendationAction.Parent := aItem.layoutBottom;
        aItem.imgRecommendationAction.Width := 26;
        aItem.imgRecommendationAction.Align := TAlignLayout.Right;
        aItem.imgRecommendationAction.Margins.Right := 25;

        aItem.imgRecommendationAction.OnClick := aItem.DoRecommendationImageClick;

        if aItem.FRecommanded then
          aItem.imgRecommendationAction.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(52,52), 4)
        else
          aItem.imgRecommendationAction.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(52,52), 5);

        aItem.imgCommentAction := TImage.Create(aItem.layoutBottom);
        aItem.imgCommentAction.Parent := aItem.layoutBottom;
        aItem.imgCommentAction.Width := 26;
        aItem.imgCommentAction.Position.X := aItem.layoutBottom.Width;
        aItem.imgCommentAction.Align := TAlignLayout.Right;
        aItem.imgCommentAction.Margins.Right := 25;

        aItem.imgCommentAction.OnClick := aItem.DoCommentImageClick;

        aItem.imgCommentAction.Bitmap := frmGlobalComponent.ImageListMyhome.Bitmap(TSizeF.Create(52,52), 6)
      end;
    end;

    result := True;
  end
  else
    result := False;
end;

{ TMyhomeBookmarkItem }

procedure TMyhomeBookmarkItem.ClearControls;
begin
  Parent := nil;

  FTargetSerial := -1; // Bookmark Serial
  FContentType := btStory; // story, recipe, cookbook
  FContentSerial := -1;
  FUserPicture := '';
  FUserNicname := '';
  FTitle := '';
  FDescription := '';
  FRecommendationCount := 0;
  FCommentCount := 0;
  FCreatedDate := '';

  FImageName := '';
end;

constructor TMyhomeBookmarkItem.Create;
begin
  ClearControls;
end;

procedure TMyhomeBookmarkItem.DoBookmarkItemClick(Sender: TObject);
var
  aWeb: TfrmWeb;
  sURL: string;
begin
  aWeb := TfrmWeb.Create(Application);

  if FContentType = btRecipe then
    sURL := URL_RECIPE_VIEW + '?recipeserial=' + self.FContentSerial.ToString
  else if FContentType = btStory then
    sURL := URL_STORY_VIEW + '?StorySerial=' + self.FContentSerial.ToString
  else // Cookbook
  begin
  end;

  aWeb.goURL(sURL,
    procedure(const aResultList: TStringList)
    var
      aIndex: integer;
    begin
      if aResultList.Count > 2 then
      begin
        aIndex := TColorAnimation(Sender).Tag;
        // Recommendation Count
        self.FRecommendationCount := StrToIntDef(aResultList[0], 0);
        self.txtRecommendationCount.Text := GetCountString(self.FRecommendationCount);

        // Comment Count
        self.FCommentCount := StrToIntDef(aResultList[1], 0);
        self.txtCommentCount.Text := GetCountString(self.FCommentCount);

        // 북마크가 해제되었으면
        if StrToIntDef(aResultList[3], 0) = 0 then
        begin
          Parent.FScrollBox.BeginUpdate;

          self.layoutItemBody.DisposeOf;
          aIndex := Parent.FItemList.IndexOfObject(self);
          Parent.FItemList.Objects[aIndex].DisposeOf;
          Parent.FItemList.Delete(aIndex);

          Parent.FScrollBox.EndUpdate;
        end;
      end;
    end
  );

  aWeb.Show;
end;

procedure TMyhomeBookmarkItem.DoDeleteImageClick(Sender: TObject);
begin
  MessageDlg( '선택된 북마크를 삭제하시겠습니까?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYES, TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: TModalResult)
    var
      aIndex: integer;
    begin
      if AResult = mrYes then
      begin
        if CM.DeleteBookmark(self.FTargetSerial) then
        begin
          Parent.FScrollBox.BeginUpdate;

          self.layoutItemBody.DisposeOf;
          aIndex := Parent.FItemList.IndexOfObject(self);
          Parent.FItemList.Objects[aIndex].DisposeOf;
          Parent.FItemList.Delete(aIndex);

          Parent.FScrollBox.EndUpdate;
        end
        else
          ShowMessage('삭제하지 못했습니다!');
      end;
    end
  );
end;

end.
