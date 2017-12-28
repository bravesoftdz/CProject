unit uListScroll;

interface
uses Datasnap.DBClient, FMX.Objects, System.Classes, uGlobal, FMX.Layouts,
  FMX.Types, System.Types, System.UITypes, FMX.Graphics, FMX.Dialogs,
  System.SysUtils, FMX.Ani, FMX.Forms;

type
  TPaintProcedure = procedure of object;

  TRecipeScrollList = class
    FDisplayedCount: integer;
    FTop: integer;
    FList: TStringList;
    FScrollBox: TVertScrollBox;
    FItemWidth: Single;
    FItemHeight: Single;

    procedure DisplayItems(aIndex: integer);
    function MakeRecipeItem(aIndex: integer): Boolean;

    procedure OnRecipeItemTap(Sender: TObject; const Point: TPointF);
  public
    constructor Create; overload;
    procedure ClearControls;
    procedure Init(aRecipeViewType: TRecipeViewType;
      aScrollBox: TVertScrollBox; aTopPosition: integer);
    procedure OnAniColorFinish(Sender: TObject);
  published
    property DisplayedCount: integer read FDisplayedCount;
  end;

const
  RECIPE_LIST_NO = 20;

implementation
uses ClientModuleUnit, cookplay.S3, uWeb, uMain;
{ TRecipeScrollList }

procedure TRecipeScrollList.ClearControls;
begin
  if Assigned(FList) then
    while FList.Count > 0 do
    begin
      if Assigned(TRecipeListItem(FList.Objects[0]).BodyLayout) then
        TRecipeListItem(FList.Objects[0]).BodyLayout.DisposeOf;

      FList.Objects[0].DisposeOf;
      FList.Delete(0);
    end;

  FList.DisposeOf;
  FDisplayedCount := 0;
  FTop := 0;
  FScrollBox := nil;

  FItemWidth := 0;
  FItemHeight := 0;
end;

constructor TRecipeScrollList.Create;
begin
  inherited;

  FDisplayedCount := 0;
  FTop := 0;
  FScrollBox := nil;

  FItemWidth := 0;
  FItemHeight := 0;
end;

procedure TRecipeScrollList.DisplayItems(aIndex: integer);
var
  i, curCount: integer;
begin
  curCount := FDisplayedCount;
  if (aIndex >= curCount) then
  begin
    for i := 1 to RECIPE_LIST_NO do
      if MakeRecipeItem(curCount + i - 1) then
        FDisplayedCount := FDisplayedCount + 1;
  end;
end;

procedure TRecipeScrollList.Init(aRecipeViewType: TRecipeViewType;
  aScrollBox: TVertScrollBox; aTopPosition: integer);
begin
  self.ClearControls;

  FList := TStringList.Create;

  FTop := aTopPosition;
  FScrollBox := aScrollBox;

  if aRecipeViewType = TRecipeViewType.rvRecent then
    CM.GetRecipeListRecent(FList)
  else if aRecipeViewType = TRecipeViewType.rvBest then
    CM.GetRecipeListBest(FList);

  FItemWidth := aScrollBox.Width / 2;
  FItemHeight := FItemWidth + 55;

  DisplayItems(FDisplayedCount);
end;

function TRecipeScrollList.MakeRecipeItem(aIndex: integer): Boolean;
var
  nX, nY: Single;
  aLayoutBody: TLayout;
  aRecPicture: TRectangle;
  aRecExplain: TRectangle;
  aTitleText: TText;
  aLayoutBottom: TLayout;
  aRecommendationIcon: TImage;
  aCommentIcon: TImage;
  aRecommendationText: TText;
  aCommentText: TText;
  aCorner: TCorner;
  aBitmap: TBitmap;
  aImage: TImage;
begin
  // index 가 현재 List 의 개수보다 작으면 실행한다
  if aIndex < FList.Count then
  begin
    nX := (aIndex mod 2) * FItemWidth;
    nY := FTop + (FItemHeight * (aIndex div 2));

    aLayoutBody := TLayout.Create(FScrollBox);
    aLayoutBody.Parent := FScrollBox;
    aLayoutBody.Position.X := nX;
    aLayoutBody.Position.Y := nY;
    aLayoutBody.Width := FItemWidth;
    aLayoutBody.Height := FItemHeight;
    if (aIndex mod 2) = 0 then
      aLayoutBody.Padding := TBounds.Create(TRectF.Create(10,10,5,10))
    else
      aLayoutBody.Padding := TBounds.Create(TRectF.Create(5,10,10,10));

    aLayoutBody.Tag := aIndex; // 레시피 리스트의 item index

    if _info.UserSerial = -1 then
      aLayoutBody.TagString := URL_RECIPE_VIEW + '?recipeserial=' + TRecipeListItem(FList.Objects[aIndex]).RecipeSerial.ToString +
        '&userserial='
    else
      aLayoutBody.TagString := URL_RECIPE_VIEW + '?recipeserial=' + TRecipeListItem(FList.Objects[aIndex]).RecipeSerial.ToString +
        '&userserial=' + _info.UserSerial.ToString;

    aLayoutBody.OnTap := OnRecipeItemTap;
    aLayoutBody.HitTest := True;
    begin
      aRecPicture := TRectangle.Create(aLayoutBody);
      aRecPicture.Parent := aLayoutBody;
      aRecPicture.Align := TAlignLayout.Top;
      aRecPicture.Height := FItemWidth - 20;
      aRecPicture.Width := FItemWidth - 20;
      aRecPicture.Corners := [TCorner.TopLeft, TCorner.TopRight];
      aRecPicture.Fill.Color := TAlphaColorRec.Silver;
      aRecPicture.Stroke.Kind := TBrushKind.None;
      aRecPicture.XRadius := 10;
      aRecPicture.YRadius := 10;
      aRecPicture.Fill.Kind := TBrushKind.Bitmap;
      aRecPicture.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
      aRecPicture.TagString := TRecipeListItem(FList.Objects[aIndex]).PictureName;
      aRecPicture.Tag := Ord(TPictureState.psNotLoaded);
      aRecPicture.HitTest := False;

      if aRecPicture.TagString <> '' then
        frmS3.LoadImageFromS3(BUCKET_RECIPE, aRecPicture.TagString, aRecPicture.Fill.Bitmap.Bitmap);

      aRecExplain := TRectangle.Create(aLayoutBody);
      aRecExplain.Parent := aLayoutBody;
      aRecExplain.Align := TAlignLayout.Client;
      aRecExplain.Corners := [TCorner.BottomLeft, TCorner.BottomRight];
      aRecExplain.Fill.Color := TAlphaColorRec.White;
      aRecExplain.Padding := TBounds.Create(TRectF.Create(10,0,10,0));
      aRecExplain.Stroke.Kind := TBrushKind.None;
      aRecExplain.XRadius := 10;
      aRecExplain.YRadius := 10;
      aRecExplain.HitTest := False;
      aRecExplain.Name := 'recRecipeListExplain' + inttostr(aIndex);

      begin
        aTitleText := TText.Create(aRecExplain);
        aTitleText.Parent := aRecExplain;
        aTitleText.Height := 32;
        atitleText.Align := TAlignLayout.Top;
        if TRecipeListItem(FList.Objects[aIndex]).Title.Length > 12 then
          aTitleText.Text := Copy(TRecipeListItem(FList.Objects[aIndex]).Title, 1, 12) + '...'
        else
          aTitleText.Text := TRecipeListItem(FList.Objects[aIndex]).Title;

        aTitleText.TextSettings.Font.Size := 14;
        aTitleText.TextSettings.HorzAlign := TTextAlign.Leading;
        aTitleText.HitTest := False;

        aLayoutBottom := TLayout.Create(aRecExplain);
        aLayoutBottom.Parent := aRecExplain;
        aLayoutBottom.Position.Y := 32 + 1;
        aLayoutBottom.Align := TAlignLayout.Client;
        begin
          aCommentText := TText.Create(aLayoutBottom);
          aCommentText.Parent := aLayoutBottom;
          aCommentText.Width := 30;
          aCommentText.Margins.Left := 5;
          aCommentText.Align := TAlignLayout.Right;
          aCommentText.TextSettings.Font.Size := 12;
          aCommentText.TextSettings.FontColor := COLOR_GRAY_UNSELECTED1;
          aCommentText.TextSettings.HorzAlign := TTextAlign.Leading;
          aCommentText.Text := GetCountString(TRecipeListItem(FList.Objects[aIndex]).CommentCount);
          aCommentText.HitTest := False;

          aCommentIcon := TImage.Create(aLayoutBottom);
          aCommentIcon.Parent := aLayoutBottom;
          aCommentIcon.Width := 13;
          aCommentIcon.Align := TAlignLayout.Right;
          aCommentIcon.Bitmap := frmMain.imagelistGlobal.Bitmap(TSizeF.Create(26,26), 1);
          aCommentIcon.HitTest := False;

          aRecommendationText := TText.Create(aLayoutBottom);
          aRecommendationText.Parent := aLayoutBottom;
          aRecommendationText.Width := 30;
          aRecommendationText.Margins.Left := 5;
          aRecommendationText.Align := TAlignLayout.Right;
          aRecommendationText.TextSettings.Font.Size := 12;
          aRecommendationText.TextSettings.FontColor := COLOR_GRAY_UNSELECTED1;
          aRecommendationText.TextSettings.HorzAlign := TTextAlign.Leading;
          aRecommendationText.Text := GetCountString(TRecipeListItem(FList.Objects[aIndex]).RecommendationCount);
          aRecommendationText.HitTest := False;

          aRecommendationIcon := TImage.Create(aLayoutBottom);
          aRecommendationIcon.Parent := aLayoutBottom;
          aRecommendationIcon.Width := 13;
          aRecommendationIcon.Align := TAlignLayout.Right;
          aRecommendationIcon.Bitmap := frmMain.imagelistGlobal.Bitmap(TSizeF.Create(26,26), 0);
          aRecommendationIcon.HitTest := False;
        end;
      end;
    end;

    TRecipeListItem(FList.Objects[aIndex]).BodyLayout := aLayoutBody;
    TRecipeListItem(FList.Objects[aIndex]).AniColor := TColorAnimation.Create(aRecExplain);
    TRecipeListItem(FList.Objects[aIndex]).AniColor.PropertyName := 'Fill.Color';
    TRecipeListItem(FList.Objects[aIndex]).AniColor.Parent := aRecExplain;
    TRecipeListItem(FList.Objects[aIndex]).AniColor.StartValue := TAlphaColorRec.White;
    TRecipeListItem(FList.Objects[aIndex]).AniColor.StopValue := TAlphaColorRec.Silver;
    TRecipeListItem(FList.Objects[aIndex]).AniColor.Inverse := True;
    TRecipeListItem(FList.Objects[aIndex]).AniColor.Duration := 0.2;
    TRecipeListItem(FList.Objects[aIndex]).AniColor.Enabled := False;
    TRecipeListItem(FList.Objects[aIndex]).AniColor.OnFinish := OnAniColorFinish;
    TRecipeListItem(FList.Objects[aIndex]).AniColor.Tag := aIndex;

    TRecipeListItem(FList.Objects[aIndex]).txtRecommendationCount := aRecommendationText;
    TRecipeListItem(FList.Objects[aIndex]).txtCommentCount := aCommentText;

    result := True;
  end
  else
    result := False;
end;

procedure TRecipeScrollList.OnAniColorFinish(Sender: TObject);
var
  aForm: TfrmWeb;
begin
  aForm := TfrmWeb.Create(Application);
  aForm.goURL(TColorAnimation(Sender).TagString,
    procedure(const aResultList: TStringList)
    var
      aIndex: integer;
    begin
      if aResultList.Count > 1 then
      begin
        aIndex := TColorAnimation(Sender).Tag;
        // Recommendation Count
        TRecipeListItem(FList.Objects[aIndex]).RecommendationCount := StrToIntDef(aResultList[0], 0);
        TRecipeListItem(FList.Objects[aIndex]).txtRecommendationCount.Text := GetCountString(TRecipeListItem(FList.Objects[aIndex]).RecommendationCount);

        // Comment Count
        TRecipeListItem(FList.Objects[aIndex]).CommentCount := StrToIntDef(aResultList[1], 0);
        TRecipeListItem(FList.Objects[aIndex]).txtCommentCount.Text := GetCountString(TRecipeListItem(FList.Objects[aIndex]).CommentCount);
      end;
    end
  );
  aForm.Show;
end;

procedure TRecipeScrollList.OnRecipeItemTap(Sender: TObject;
  const Point: TPointF);
begin
  TRecipeListItem(FList.Objects[TLayout(Sender).Tag]).AniColor.TagString := TLayout(Sender).TagString;
  TRecipeListItem(FList.Objects[TLayout(Sender).Tag]).AniColor.Start;
end;

end.
