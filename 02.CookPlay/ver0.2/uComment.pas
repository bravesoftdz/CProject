unit uComment;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, uGlobal, FMX.Controls.Presentation, FMX.Edit, FMX.ScrollBox,
  FMX.Memo, FMX.Ani, System.ImageList, FMX.ImgList;

type
  TfrmComment = class(TForm)
    recHeader: TRectangle;
    layoutBackButton: TLayout;
    Layout12: TLayout;
    txtFormTitle: TText;
    imgClose: TImage;
    recBody: TRectangle;
    scrollBody: TVertScrollBox;
    layoutInput: TLayout;
    layoutVK: TLayout;
    Line1: TLine;
    recInput: TRoundRect;
    txtInput: TText;
    memoInput: TMemo;
    txtPromptText: TText;
    Layout1: TLayout;
    layoutTemp: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Circle1: TCircle;
    Text1: TText;
    Text3: TText;
    Text4: TText;
    ColorAnimationInput: TColorAnimation;
    ImageList1: TImageList;
    Image1: TImage;
    layoutBack: TLayout;
    recBack: TRectangle;
    Rectangle6: TRectangle;
    txtDelete: TText;
    Rectangle20: TRectangle;
    txtModify: TText;
    recModify: TRectangle;
    Layout2: TLayout;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure imgCloseClick(Sender: TObject);
    procedure memoInputEnter(Sender: TObject);
    procedure memoInputExit(Sender: TObject);
    procedure memoInputChange(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure recInputClick(Sender: TObject);
    procedure ColorAnimationInputFinish(Sender: TObject);
    procedure recBackClick(Sender: TObject);
    procedure recModifyClick(Sender: TObject);
    procedure txtModifyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtDeleteClick(Sender: TObject);
  private
    { Private declarations }
    FCommentList: TStringList;
    FCommentControlList: TStringList;
    FCommentTextList: TStringList;
    FCommentMenuImageList: TStringList;

    FRecipeSerial: LargeInt;
    FSelectedComment: integer;

    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    FKeyboardShown: Boolean;

    FOldViewPosition: TPointF;
    FOldControl: TControl;

    procedure UpdateKBBounds;
    procedure RestorePosition;
    procedure ClearRecipeCommentControls;

    procedure HideMenu;
    procedure ShowMenu;

    procedure HideModifyRectangle;
    procedure ShowModifyRectangle;

    procedure OnMenuImageClick(Sender: TObject);

    procedure CloseForm;
    procedure ClearMemo;

    procedure RemoveComment(aIndex: integer);
  public
    { Public declarations }
    procedure Init(aRecipeSerial: LargeInt);
    procedure LoadComment;
    function Comments(aIndex: integer): TRecipeCommentInfo;
    function CommentControls(aIndex: integer): TLayout;
    function CommentTexts(aIndex: integer): TText;
    function CommentMenuImages(aIndex: integer): TImage;
    procedure MakeCommentItem(aIndex: integer);
  end;

var
  frmComment: TfrmComment;

implementation
uses cookplay.StatusBar, ClientModuleUnit, cookplay.S3;

{$R *.fmx}

procedure TfrmComment.imgCloseClick(Sender: TObject);
begin
  CloseForm;
end;

procedure TfrmComment.Init(aRecipeSerial: LargeInt);
begin
  FRecipeSerial := aRecipeSerial;
end;

procedure TfrmComment.LoadComment;
var
  i: integer;
begin
  FCommentList := CM.GetRecipeComment(FRecipeSerial);

  scrollBody.BeginUpdate;

  for i := 0 to FCommentList.Count-1 do
    MakeCommentItem(i);

  scrollBody.EndUpdate;

  // 스크롤을 처음으로 올린다
  scrollBody.ViewportPosition := PointF(0,0);
end;

procedure TfrmComment.MakeCommentItem(aIndex: integer);
var
  aLayoutBody: TLayout;
  aLayoutImage, aLayoutContent: TLayout;
  aCircle: TCircle;
  aNicknameText: TText;
  aMenuImage: TImage;
  aContentText: TText;
  aDatetimeText: TText;
begin
  aLayoutBody := TLayout.Create(scrollBody);
  aLayoutBody.Parent := scrollBody;

  if aIndex > 0 then
    aLayoutBody.Position.Y := CommentControls(aIndex-1).Position.Y + CommentControls(aIndex-1).Height + 1
  else
    aLayoutBody.Position.Y := 1;

  aLayoutBody.Align := TAlignLayout.Top;
  aLayoutBody.Padding := TBounds.Create(TRectF.Create(20,10,0,0));
  begin
    aLayoutImage := TLayout.Create(aLayoutBody);
    aLayoutImage.Parent := aLayoutBody;
    aLayoutImage.Width := 30;
    aLayoutImage.Align := TAlignLayout.Left;
    begin
      aCircle := TCircle.Create(aLayoutImage);
      aCircle.Parent := aLayoutImage;
      aCircle.Align := TAlignLayout.Top;
      aCircle.Fill.Kind := TBrushKind.Bitmap;
      aCircle.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
      aCircle.Fill.Color := COLOR_GRAY_BACKGROUND;
      aCircle.Stroke.Kind := TBrushKind.None;

      if Comments(aIndex).UserPicture.Trim <> '' then
        frmS3.LoadImageFromS3(BUCKET_USER, comments(aIndex).UserPicture.Trim, aCircle.Fill.Bitmap.Bitmap)
      else
        aCircle.Fill.Bitmap.Bitmap := ImageList1.Bitmap(TSizeF.Create(60,60), 0);
    end;

    aLayoutContent := TLayout.Create(aLayoutBody);
    aLayoutContent.Parent := aLayoutBody;
    aLayoutContent.Align := TAlignLayout.Client;
    aLayoutContent.Padding := TBounds.Create(TRectF.Create(10,5,10,0));
    begin
      aNicknameText := TText.Create(aLayoutContent);
      aNicknameText.Parent := aLayoutContent;
      aNicknameText.Height := 25;
      aNicknameText.Align := TAlignLayout.Top;
      aNicknameText.Text := Comments(aIndex).Nickname;
      aNicknameText.TextSettings.Font.Size := 14;
      aNicknameText.TextSettings.HorzAlign := TTextAlign.Leading;
      aNicknameText.TextSettings.VertAlign := TTextAlign.Leading;
      begin
        aMenuImage := TImage.Create(aNicknameText);
        aMenuImage.Parent := aNicknameText;
        aMenuImage.Width := 24;
        aMenuImage.Align := TAlignLayout.Right;
        aMenuImage.Bitmap := ImageList1.Bitmap(TSizeF.Create(48,48), 1);
        aMenuImage.Tag := aIndex;
        aMenuImage.Visible := Comments(aIndex).Users_Serial = CM.memUserSerial.AsLargeInt;
        aMenuImage.OnClick := OnMenuImageClick;
      end;

      aContentText := TText.Create(aLayoutContent);
      aContentText.Parent := aLayoutContent;
      aContentText.Position.Y := aNicknameText.Height + 1;
      aContentText.Align := TAlignLayout.Top;
      aContentText.TextSettings.Font.Size := 14;
      aContentText.TextSettings.FontColor := COLOR_GRAY_BUTTONTEXT;
      aContentText.TextSettings.HorzAlign := TTextAlign.Leading;
      aContentText.TextSettings.VertAlign := TTextAlign.Leading;
      aContentText.Height := GetTextHeight(aContentText, Comments(aIndex).Contents.Trim);
      aContentText.Text := Comments(aIndex).Contents.Trim;

      aDateTimeText := TText.Create(aLayoutContent);
      aDateTimeText.Parent := aLayoutContent;
      aDateTimeText.Align := TAlignLayout.Client;
      aDateTimeText.TextSettings.Font.Size := 11;
      aDateTimeText.TextSettings.FontColor := COLOR_GRAY_UNSELECTED2;
      aDateTimeText.TextSettings.HorzAlign := TTextAlign.Leading;
      aDateTimeText.Text := GetDateString(Comments(aIndex).CreatedDatetime);
    end;
  end;
  aLayoutBody.Height := aNicknameText.Height + aContentText.Height + 17 + 20;

  FCommentControlList.AddObject('', aLayoutBody);
  FCommentTextList.AddObject('', aContentText);
  FCommentMenuImageList.AddObject('', aMenuImage);
end;

procedure TfrmComment.memoInputChange(Sender: TObject);
var
  fontheight: Single;
begin
  fontheight := memoInput.Canvas.TextHeight('Cookplay');

  if memoInput.Lines.Count <= 1 then
    layoutInput.Height := 50
  else
    layoutInput.Height := 50 + fontheight * (memoInput.Lines.Count-1);
end;

procedure TfrmComment.memoInputEnter(Sender: TObject);
begin
  txtPromptText.Visible := False;
end;

procedure TfrmComment.memoInputExit(Sender: TObject);
begin
  txtPromptText.Visible := memoInput.Lines.Text.Trim = '';
end;

procedure TfrmComment.OnMenuImageClick(Sender: TObject);
begin
   FSelectedComment := TImage(Sender).Tag;

   ClearMemo;

   ShowMenu;
end;

procedure TfrmComment.RemoveComment(aIndex: integer);
var
  i: integer;
begin
  if (aIndex >= 0) and (aIndex < FCommentList.Count) then
  begin
    // 삭제되는 Comment 아래 것들의 순서를 하나씩 위로 올린다
    for i := aIndex+1 to FCommentList.Count-1 do
      CommentMenuImages(i).Tag := CommentMenuImages(i).Tag - 1;

    scrollBody.BeginUpdate;

    CommentMenuImages(aIndex).DisposeOf;
    FCommentMenuImageList.Delete(aIndex);

    CommentTexts(aIndex).DisposeOf;
    FCommentTextList.Delete(aIndex);

    CommentControls(aIndex).DisposeOf;
    FCommentControlList.Delete(aIndex);

    FCommentList.Delete(aIndex);

    scrollBody.EndUpdate;
  end;
end;

procedure TfrmComment.RestorePosition;
begin
//  scrollBody.ViewportPosition:= FOldViewPosition;
//  scrollBody.RealignContent;

  FOldControl := nil;
end;

procedure TfrmComment.ShowMenu;
begin
  layoutBack.Visible := True;
  TAnimator.Create.AnimateFloat(layoutBack, 'Opacity', 1, 0.15);
end;

procedure TfrmComment.ShowModifyRectangle;
begin
  txtFormTitle.Text := '수정';
  recModify.Visible := True;
  TAnimator.Create.AnimateFloat(recModify, 'Opacity', 0.3, 0.15);

  memoInput.SetFocus;
  memoInput.Lines.Text := Comments(FSelectedComment).Contents;
  memoInput.OnEnter(memoInput);
  memoInput.OnChange(memoInput);
end;

procedure TfrmComment.txtDeleteClick(Sender: TObject);
begin
  HideMenu;

  MessageDlg( '댓글을 삭제하시겠습니까?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYES, TMsgDlgBtn.mbNo], 0,
    procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
      begin
        if CM.DeleteRecipeComment(Comments(FSelectedComment).Serial) then
        begin
          ClearMemo;

          RemoveComment(FSelectedComment);

//          ClearRecipeCommentControls;
//
//          LoadComment;
        end
        else
          ShowMessage('삭제하지 못했습니다!');
      end;
    end
  );
end;

procedure TfrmComment.txtModifyClick(Sender: TObject);
begin
  HideMenu;
  ShowModifyRectangle;
end;

procedure TfrmComment.recBackClick(Sender: TObject);
begin
  HideMenu;
end;

procedure TfrmComment.recInputClick(Sender: TObject);
begin
  ColorAnimationInput.Start;
end;

procedure TfrmComment.recModifyClick(Sender: TObject);
begin
  HideModifyRectangle;
end;

procedure TfrmComment.UpdateKBBounds;
var
  LFocused : TControl;
  nScrollY: Single;
  aLayout: TLayout;
//  LFocusRect: TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    FNeedOffset := True;

    FOldControl := TControl(Focused.GetObject);

    LFocused := TControl(Focused.GetObject);

    nScrollY := LFocused.AbsoluteRect.Top - recBody.Position.Y;

    if nSCrollY < 0 then
    begin
      scrollBody.ViewportPosition := PointF(0, scrollBody.ViewportPosition.Y - (nScrollY * -1) - 20);
    end
    else if FKeyboardShown and (LFocused.AbsoluteRect.Bottom > FKBBounds.Top) then
    begin
      FOldViewPosition := scrollBody.ViewportPosition;

      FNeedOffset := True;
      scrollBody.RealignContent;

      layoutVK.Height := FKBBounds.Bottom - FKBBounds.Top - 20;//self.ClientHeight - FKBBounds.Top - 120;

      if recModify.Visible and (FSelectedComment > -1) then
      begin
        aLayout := CommentControls(FSelectedComment);
        scrollBody.ViewportPosition := PointF(0, aLayout.Position.Y);// PointF(0, scrollBody.ViewportPosition.Y + nSCrollY + 10);
      end
      else
        scrollBody.ViewPortPosition := PointF(0, scrollBody.ViewportPosition.Y + layoutVK.Height);
//      scrollBody.ViewportPosition := PointF(0, scrollBody.ViewportPosition.Y + LFocused.AbsoluteRect.Bottom - FKBBounds.Top);
    end
  end;

  if not FNeedOffset then
    RestorePosition;
end;

procedure TfrmComment.ClearMemo;
begin
  memoInput.ResetFocus;
  memoInput.Lines.Text := '';
  memoInput.OnExit(memoInput);
end;

procedure TfrmComment.ClearRecipeCommentControls;
begin
  FCommentList.Clear;

  while FCommentControlList.Count > 0 do
  begin
    CommentMenuImages(0).DisposeOf;
    FCommentMenuImageList.Delete(0);

    CommentTexts(0).DisposeOf;
    FCommentTextList.Delete(0);

    CommentControls(0).DisposeOf;
    FCommentControlList.Delete(0);
  end;

  FCommentControlList.Clear;
  FCommentMenuImageList.Clear;
  FCommentTextList.Clear;
end;

procedure TfrmComment.CloseForm;
begin
  if recModify.Visible then
    HideModifyRectangle
  else if layoutBack.Visible then
    HideMenu
  else
    Close;
end;

procedure TfrmComment.ColorAnimationInputFinish(Sender: TObject);
var
  aComment: string;
begin
  // Login 된 사용자이면 실행한다
  if not CM.memUser.IsEmpty then
  begin
    aComment := memoInput.Lines.Text.Trim;
    if aComment = '' then
      ShowMessage('댓글을 입력해 주십시오!')
    else
    begin
      // 댓글 수정상태이면
      if recModify.Visible then
      begin
        if CM.UpdateRecipeComment(Comments(FSelectedComment).Serial, aComment) then
        begin
          Comments(FSelectedComment).Contents := aComment;
          CommentTexts(FSelectedComment).Text := aComment;

          HideModifyRectangle;
        end
        else
          ShowMessage('댓글을 수정하지 못했습니다!');
      end
      // 댓글 신규 입력 상태이면
      else
      begin
        if CM.InsertRecipeComment(FRecipeSerial, CM.memUserSerial.AsLargeInt, aComment) then
        begin
          ClearMemo;

          FCommentList.Clear;
          FCommentList := CM.GetRecipeComment(FRecipeSerial);

          MakeCommentItem(FCommentList.Count-1);

          scrollBody.ViewportPosition := TPointF.Create(0, CommentControls(FCommentList.Count-1).Position.Y + CommentControls(FCommentList.Count-1).Height);
        end
        else
          ShowMessage('댓글을 저장하지 못하였습니다!');
      end;
    end;
  end;
end;

function TfrmComment.CommentControls(aIndex: integer): TLayout;
begin
  if Assigned(FCommentControlList) and (FCommentControlList.Count > 0) then
    result := TLayout(FCommentControlList.Objects[aIndex])
  else
    result := nil;
end;

function TfrmComment.CommentMenuImages(aIndex: integer): TImage;
begin
  if Assigned(FCommentMenuImageList) and (FCommentMenuImageList.Count > 0) then
    result := TImage(FCommentMenuImageList.Objects[aIndex])
  else
    result := nil;
end;

function TfrmComment.Comments(aIndex: integer): TRecipeCommentInfo;
begin
  if Assigned(FCommentList) and (FCommentList.Count > 0) then
    result := TRecipeCommentInfo(FCommentList.Objects[aIndex])
  else
    result := nil;
end;

function TfrmComment.CommentTexts(aIndex: integer): TText;
begin
  if Assigned(FCommentTextList) and (FCommentTextList.Count > 0) then
    result := TText(FCommentTextList.Objects[aIndex])
  else
    result := nil;
end;

procedure TfrmComment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  HideMenu;
  HideModifyRectangle;

  ClearRecipeCommentControls;
end;

procedure TfrmComment.FormCreate(Sender: TObject);
begin
  FCommentList := TStringList.Create;
  FCommentControlList := TStringList.Create;
  FCommentTextList := TStringList.Create;
  FCommentMenuImageList := TStringList.Create;

  layoutTemp.DisposeOf;

  recBack.Align := TAlignLayout.Client;

  layoutBack.Position := TPosition.Create(TPointF.Create(0,0));
  layoutBack.Width := ClientWidth;
  layoutBack.Height := ClientHeight;

  HideMenu;

  recModify.Align := TAlignLayout.Client;

  HideModifyRectangle;
end;

procedure TfrmComment.FormFocusChanged(Sender: TObject);
begin
  FOldViewPosition := scrollBody.ViewportPosition;
  UpdateKBBounds;
end;

procedure TfrmComment.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if IsBackKey(Key) then
    CloseForm;
end;

procedure TfrmComment.FormShow(Sender: TObject);
begin
  // Status Bar 색을 바꾼다
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);

  layoutVK.Height := 0;

  FNeedOffset := False;
  FKeyboardShown := False;

  ClearRecipeCommentControls;

  FOldViewPosition := TPointF.Create(0,0); // Scroll Position to 0

  ClearMemo;

  LoadComment;
end;

procedure TfrmComment.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  if recModify.Visible then
    HideModifyRectangle;

  layoutVK.Height := 0;

  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;

  RestorePosition;

  FKeyboardShown := False;
end;

procedure TfrmComment.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  if not FKeyboardShown then
  begin
    FKeyboardShown := True;

    FKBBounds := TRectF.Create(Bounds);
    // 가상키보드의 Form에서의 위치를 가져온다
    FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
    FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
    UpdateKBBounds;
  end;
end;

procedure TfrmComment.HideMenu;
begin
  TAnimator.Create.AnimateFloat(layoutBack, 'Opacity', 0, 0.15);
  layoutBack.Visible := False;
end;

procedure TfrmComment.HideModifyRectangle;
begin
  txtFormTitle.text := '댓글';
  TAnimator.Create.AnimateFloat(recModify, 'Opacity', 0, 0.15);
  recModify.Visible := False;

  ClearMemo;
end;

end.
