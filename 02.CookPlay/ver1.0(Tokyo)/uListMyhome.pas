unit uListMyhome;

interface
uses FMX.Layouts, FMX.Objects, System.Classes, Data.DB, FMX.Dialogs,
  System.sysUtils, uGlobal, System.UITypes, FMX.Types, System.Types,
  FMX.Listbox, FMX.Graphics, FMX.TabControl, FMX.Gestures;

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

    recItemBody: TRectangle;

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

    layoutTail: TLayout;
  private
    procedure DoPreviousTab(Sender: TObject);
    procedure DoNextTab(Sender: TObject);

    procedure DisplayPicturePosition;

    procedure DoMenuImageClick(Sender: TObject);
    procedure DoRecommendationImageClick(Sender: TObject);
    procedure DoCommentImageClick(Sender: TObject);

    procedure DoStoryClick(Sender: TObject);
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
    FItemRectangle: TRectangle;

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
    function MakeRecipeItem(aIndex: integer): Boolean;
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
    procedure DeleteStoryItem(aStorySerial: LargeInt);

    procedure DoLayoutMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure DoLayoutMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  end;

const
  MYHOME_LIST_NO = 20;


implementation
uses ClientModuleUnit, cookplay.s3, uGlobalComponent, uComment, uMenuBottom;
{ TMyhomeStoryItem }

procedure TMyhomeRecipeStoryItem.ClearControls;
var
  i: integer;
begin
  SetLength(FImageNames, 0);

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
          frmComment.Init(TCommentType.ctStory, FTargetSerial,
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
          frmComment.Init(TCommentType.ctRecipe, FTargetSerial,
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
        // 삭제
        else if nIndex = 1 then
        begin
          MessageDlg( '선택된 스토리를 삭제하시겠습니까?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYES, TMsgDlgBtn.mbNo], 0,
            procedure(const AResult: TModalResult)
            begin
              if AResult = mrYes then
              begin
                if CM.DeleteStory(self.FTargetSerial) then
                begin
                  self.Parent.DeleteStoryItem(self.FTargetSerial);
                end
                else
                  ShowMessage('삭제하지 못했습니다!');
              end;
            end
          );

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
  end
  else
    showmessage('next');////
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
  end
  else
    showmessage('previous');//
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

procedure TMyhomeRecipeStoryItem.DoStoryClick(Sender: TObject);
begin
  showmessage('a');
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
  FItemRectangle := nil;

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
    TMyhomeRecipeStoryItem(FItemList.Objects[0]).recItemBody.DisposeOf;
    TMyhomeRecipeStoryItem(FItemList.Objects[0]).layoutTail.DisposeOf;
    FItemList.Objects[0].DisposeOf;
    FItemList.Delete(0);
  end;
end;

constructor TMyhomeList.Create;
begin
  FItemList := TStringList.Create;

  ClearControls;
end;

procedure TMyhomeList.DeleteStoryItem(aStorySerial: LargeInt);
var
  i, k: integer;
  aOldRecY, aOldLayoutY, tempRec, tempLayout: Single;
begin
  FScrollBox.BeginUpdate;

  for i := 0 to FItemList.Count-1 do
  begin
    if TMyhomeRecipeStoryItem(FItemList.Objects[i]).FTargetSerial = aStorySerial then
    begin
      aOldRecY := TMyhomeRecipeStoryItem(FItemList.Objects[i]).recItemBody.Position.Y;
      aOldLayoutY := TMyhomeRecipeStoryItem(FItemList.Objects[i]).layoutTail.Position.Y;

      TMyhomeRecipeStoryItem(FItemList.Objects[i]).recItemBody.DisposeOf;
      TMyhomeRecipeStoryItem(FItemList.Objects[i]).layoutTail.DisposeOf;
      FItemList.Objects[i].DisposeOf;
      FItemList.Delete(i);

      for k := i to FItemList.Count-1 do
      begin
        tempRec := TMyhomeRecipeStoryItem(FItemList.Objects[i]).recItemBody.Position.Y;
        tempLayout := TMyhomeRecipeStoryItem(FItemList.Objects[i]).layoutTail.Position.Y;

        TMyhomeRecipeStoryItem(FItemList.Objects[K]).recItemBody.Position.Y := aOldRecY;
        TMyhomeRecipeStoryItem(FItemList.Objects[K]).layoutTail.Position.Y := aOldLayoutY;

        aOldRecY := tempRec;
        aOldLayoutY := tempLayout;
      end;

      break;
    end;
  end;

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
      FScrollBox.AniCalculations.TouchTracking := [];

      if FScrollLayout.Position.Y - (FOldY - Y) < FScrollHeight then
        FScrollLayout.Position.Y := FScrollHeight
      else
        FScrollLayout.Position.Y := FScrollLayout.Position.Y - (FOldY - Y)
    end
    // Down
    else if (FOldY < Y) and (FScrollLayout.Position.Y < 0) then
    begin
      FScrollBox.AniCalculations.TouchTracking := [];

      if FScrollLayout.Position.Y + (Y - FOldY) > 0 then
        FScrollLayout.Position.Y := 0
      else
        FScrollLayout.Position.Y := FScrollLayout.Position.Y + (Y - FOldY)
    end
    else
      FScrollBox.AniCalculations.TouchTracking := [ttVertical];
  end
  else
    FScrollBox.AniCalculations.TouchTracking := [];

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
    TMyhomeRecipeStoryItem(FItemList.Objects[aItemPosition]).DoStoryClick(Sender);
  end
  else if ((FOldX - X) > 100) and (aItemPosition > -1) then
  begin
    case FListType of
      mhltStory, mhltRecipe: TMyhomeRecipeStoryItem(FItemList.Objects[aItemPosition]).DoNextTab(Sender);
      mhltCookbook: ;
      mhltBookmark: ;
    end;
  end
  else if ((FOldX - X) < -100) and (aItemPosition > -1) then
  begin
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
  FScrollBox.AniCalculations.TouchTracking := [];

  FGrab := True;

  FItemRectangle := TRectangle(Sender);

  FOldX := TRectangle(Sender).Position.X + X;
  FOldY := FScrollLayout.Position.Y + (TRectangle(Sender).Position.Y + Y - FScrollBox.ViewportPosition.Y) + 260; // 260 - MyhomeFrame's layoutMyhomeHeader.Height

  FFirstX := FOldX;
  FFirstY := FOldY;

  FBaseLayout.Root.Captured := FBaseLayout;
end;

function TMyhomeList.GetItemPosition: integer;
var
  i: integer;
begin
  result := -1;
  if Assigned(FItemRectangle) then
  begin
    case FListType of
      mhltStory, mhltRecipe:
        begin
          for i := 0 to FItemList.Count-1 do
            if TMyhomeRecipeStoryItem(FItemList.Objects[i]).recItemBody = FItemRectangle then
            begin
              result := i;
              break;
            end;
        end;
      mhltCookbook: ;
      mhltBookmark: ;
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
        FItemHeight := 50 + 38 + 54 + 39 + FImageHeight;
      end;
    mhltRecipe:
      begin
        CM.GetMyhomeRecipeList(FUserSerial, FItemList);

        FImagewidth := FItemWidth - 36; // Parent's Paddings
        FImageHeight := 240/320 * FImageWidth;
        FItemHeight := 50 + 38 + 54 + 39 + FImageHeight;
      end;
    mhltCookbook:
      begin
        FImagewidth := FItemWidth - 36; // Parent's Paddings
        FImageHeight := 240/320 * FImageWidth;
        FItemHeight := 50 + 38 + 54 + 39 + FImageHeight;
      end;
    mhltBookmark:
      begin
        FImagewidth := FItemWidth - 36; // Parent's Paddings
        FImageHeight := 240/320 * FImageWidth;
        FItemHeight := 50 + 38 + 54 + 39 + FImageHeight;
      end;
  end;

  DisplayItems(FDisplayedCount);
end;

function TMyhomeList.MakeBookmarkItem(aIndex: integer): Boolean;
begin
  result := true;
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

function TMyhomeList.MakeRecipeItem(aIndex: integer): Boolean;
begin
  result := true;
end;

function TMyhomeList.MakeRecipeStoryItem(aIndex: integer): Boolean;
var
  nX, nY: Single;
  aItem: TMyhomeRecipeStoryItem;
  i: integer;
  aListBoxItem: TListBoxItem;
  aImage: TImage;
  aTabItem: TTabItem;
begin
  // index 가 현재 List 의 개수보다 작으면 실행한다
  if aIndex < FItemList.Count then
  begin
    nX := 10;
    nY := FTopHeight + (FItemHeight * aIndex) + (10 * (aIndex+1)); // 10 = layoutTail.Height

    aItem := TMyhomeRecipeStoryItem(FItemList.Objects[aIndex]);
    aItem.Parent := self;

    aItem.recItemBody := TRectangle.Create(FScrollBox);
    aItem.recItemBody.Parent := FScrollBox;
    aItem.recItemBody.Position.X := nX;
    aItem.recItemBody.Position.Y := nY;
    aItem.recItemBody.Width := FItemWidth;
    aItem.recItemBody.Height := FItemHeight;
    aItem.recItemBody.Fill.Color := TAlphaColorRec.White;
    aItem.recItemBody.Stroke.Color := COLOR_BACKGROUND;
    aItem.recItemBody.Stroke.Thickness := 0.8;
    aItem.recItemBody.Padding.Left := 18;
    aItem.recItemBody.Padding.Right := 18;

    aItem.recItemBody.OnMouseDown := DoMouseDown;

    begin
      aItem.layoutItemTop := TLayout.Create(aItem.recItemBody);
      aItem.layoutItemTop.Parent := aItem.recItemBody;
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

      aItem.layoutItemImage := TLayout.Create(aItem.recItemBody);
      aItem.layoutItemImage.Parent := aItem.recItemBody;
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

      aItem.layoutInfo := TLayout.Create(aItem.recItemBody);
      aItem.layoutInfo.Parent := aItem.recItemBody;
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

      aItem.TxtExplain := TText.Create(aItem.recItemBody);
      aItem.TxtExplain.Parent := aItem.recItemBody;
      aItem.TxtExplain.Height := 54;
      aItem.TxtExplain.Position.Y := 51 + FItemHeight + 38 + 1;
      aItem.TxtExplain.Align := TAlignLayout.Top;
      aItem.TxtExplain.TextSettings.FontColor := COLOR_GRAY_UNSELECTED2;
      aItem.TxtExplain.TextSettings.Font.Size := 14;
      aItem.TxtExplain.TextSettings.VertAlign := TTextAlign.Leading;
      aItem.TxtExplain.TextSettings.HorzAlign := TTextAlign.Leading;
      aItem.TxtExplain.Text := frmGlobalComponent.GetString(aItem.FDescription, 70);
      aItem.txtExplain.HitTest := False;

      aItem.layoutBottom := TLayout.Create(aItem.recItemBody);
      aItem.layoutBottom.Parent := aItem.recItemBody;
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

    aItem.layoutTail := TLayout.Create(FScrollBox);
    aItem.layoutTail.Parent := FScrollBox;
    aItem.layoutTail.Position := TPosition.Create(PointF(0, nY + FItemHeight));
    aItem.layoutTail.Height := 10;

    result := True;
  end
  else
    result := False;
end;

end.
