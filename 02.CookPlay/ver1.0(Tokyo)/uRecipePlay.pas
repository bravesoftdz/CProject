unit uRecipePlay;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  uScaleFrame, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Actions, FMX.ActnList, uGlobal, FMX.ScrollBox, FMX.Memo, FMX.TabControl,
  cookplay.scale, uTimerFrame, FMX.Ani, System.ImageList, FMX.ImgList;

type
  TTimerStatus = (tsReady, tsCooking, tsOverCooking);

  TCPTimerInfo = class
    FStatus: TTimerStatus;

    Timer: TTimer;
    Title: string;
    TotalTime: Integer;
    Curtime: Integer;
    StepNo: integer;
    IngredientNo: integer;

    recBody: TRectangle;
    lineDivide: TLine;
    imgIcon: TImage;
    txtTitle: TText;
    txtDone: TText;
    BitmapAnimation: TBitmapAnimation;
  private
  public
    procedure Clear;
    procedure DoTimer(Sender: TObject);
    procedure DoDoneTextClick(Sender: TObject);
  end;

  TCPTimer = class
    ItemList: TStringList;
  private
    // 현재 가지고 있으면 가지고 있는 것을 보여주고, 없으면 새로 만들고 보여준다
    procedure Clear;
    function FindTimerInfo(aStepNo, aIngredientNo: integer): TCPTimerInfo; overload;
    function FindTimerInfo(oTimer: TTimer): TCPTimerInfo; overload;
    function FindtimerInfo(oText: TText): TCPTimerInfo; overload;
    function GetNewBodyY: Single;
    function hasOvercooking: Boolean;
  end;

  TIngredientTexts = record
    IngredientTextList: TStringList;
    TimeTextList: TStringList;
    LinkedRecipeTextList: TStringList;
    TextListAll: TStringList;
  private
    function GetTextList(const aLayoutWidth: Single; const aValue: string): TStringList;
    function GetCount: integer;
    function GetText: TText;

    property Count: integer read GetCount;
  public
    procedure Init;
    procedure Add(aType: TIngredientType; aSeq: Integer; const aValue: string);
    procedure Clear;
    property FocusedText: TText read GetText;
  end;

  TfrmRecipePlay = class(TForm)
    layoutBody: TLayout;
    Rectangle1: TRectangle;
    Line1: TLine;
    Rectangle2: TRectangle;
    Line2: TLine;
    Image1: TImage;
    imgClose: TImage;
    imgPriorStep: TImage;
    imgNextStep: TImage;
    txtStepPage: TText;
    imgActiveImage: TImage;
    Rectangle3: TRectangle;
    VertScrollBox: TVertScrollBox;
    Layout2: TLayout;
    imgInactiveImage: TImage;
    ActionList1: TActionList;
    actPriorStep: TAction;
    actNextStep: TAction;
    actPriorIngredient: TAction;
    actNextIngredient: TAction;
    actLoadRecipeInfo: TAction;
    actClose: TAction;
    actShowStepImage: TAction;
    actFirstIngredient: TAction;
    actTimeStartPause: TAction;
    Layout3: TLayout;
    layoutDescriptionBody: TLayout;
    Layout5: TLayout;
    Image2: TImage;
    txtDescription: TText;
    layoutTimeBody: TLayout;
    Layout7: TLayout;
    Image3: TImage;
    layoutTime: TLayout;
    layoutIngredientBody: TLayout;
    Layout10: TLayout;
    Image4: TImage;
    layoutIngredient: TLayout;
    layoutLinkedRecipeBody: TLayout;
    Layout13: TLayout;
    Image5: TImage;
    layoutLinkedRecipe: TLayout;
    Layout4: TLayout;
    txtTemp: TText;
    timeStart: TTimer;
    tabControl: TTabControl;
    tabScale: TTabItem;
    tabTimer: TTabItem;
    txtDescriptionTemp: TText;
    frameScale1: TframeScale;
    recGradient: TRectangle;
    Layout11: TLayout;
    imgPriorIngredient: TImage;
    FloatAnimationLeftIngredient: TFloatAnimation;
    Layout12: TLayout;
    imgNextIngredient: TImage;
    FloatAnimationRightIngredient: TFloatAnimation;
    Layout6: TLayout;
    timeTimer: TTimer;
    actTimerNext: TAction;
    recBackground: TRectangle;
    ImageList1: TImageList;
    imgScaleExisted: TImage;
    BitmapAnimationScaleOvercooking: TBitmapAnimation;
    scrollTimerList: TVertScrollBox;
    frameTimer1: TframeTimer;
    Image6: TImage;
    Layout1: TLayout;
    actRecipeViewSimple: TAction;
    FloatAnimation1: TFloatAnimation;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure actCloseExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actPriorStepExecute(Sender: TObject);
    procedure actNextStepExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frameScale1timerRWTimer(Sender: TObject);
    procedure timeStartTimer(Sender: TObject);
    procedure actFirstIngredientExecute(Sender: TObject);
    procedure actPriorIngredientExecute(Sender: TObject);
    procedure actNextIngredientExecute(Sender: TObject);
    procedure actTimeStartPauseExecute(Sender: TObject);
    procedure timeTimerTimer(Sender: TObject);
    procedure actTimerNextExecute(Sender: TObject);
    procedure imgScaleExistedClick(Sender: TObject);
    procedure recBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormResize(Sender: TObject);
    procedure actRecipeViewSimpleExecute(Sender: TObject);
    procedure imgActiveImageClick(Sender: TObject);
  private
    { Private declarations }
    FRecipeSerial: LargeInt;
    FPersons: integer;
    FRatio: Single;

    procedure ClearStepControls;

    procedure SetRecipeSerial(const Value: LargeInt);
    procedure SetImageView(const Value: Boolean);
    procedure SetStepHeader(const aNo: integer=0; const aTotal: integer=0);

    procedure DisplayStep;
    procedure SetDescription(aValue: string);
    procedure SetIngredient;
    procedure SetIngredientScaleTimer;
    procedure SetIngredientColor;

    procedure DoScaleNextButton(const AWeight: TWeightMessage);
    procedure DoTimerNextButton(Sender: TObject);

    procedure SetTimers;
    procedure ShowTimerList(aVisible: Boolean);

    property ImageView: Boolean Write SetImageView;
  public
    { Public declarations }
    property RecipeSerial: LargeInt write SetRecipeSerial;
    property Persons: integer write FPersons;
    property Ratio: Single write FRatio;
  end;

var
  frmRecipePlay: TfrmRecipePlay;
  _RecipeView: TRecipeView;
  _IngredientTexts: TIngredientTexts;
  _Timers: TCPTimer;

implementation
uses cookplay.StatusBar, ClientModuleUnit, uWeb, uViewStepImage;
{$R *.fmx}

procedure TfrmRecipePlay.actCloseExecute(Sender: TObject);
begin
  if recBackground.Opacity > 0 then
    ShowTimerList(False)
  else
    Close;
end;

procedure TfrmRecipePlay.actFirstIngredientExecute(Sender: TObject);
begin
  if _IngredientTexts.Count > 0 then
  begin
    _RecipeView.CurStep.IngredientPosition := 0;

    SetIngredientScaleTimer;

    SetIngredientColor;
  end
  else
    SetIngredientScaleTimer;
end;

procedure TfrmRecipePlay.actNextIngredientExecute(Sender: TObject);
begin
  FloatAnimationRightIngredient.Start;

  if _RecipeView.CurIngredientPosition < (_RecipeView.CurStep.IngredientCount-1) then
  begin
    Inc(_RecipeView.CurStep.IngredientPosition);

    SetIngredientScaleTimer;

    SetIngredientColor;
  end
  else
    actNextStep.Execute;
end;

procedure TfrmRecipePlay.actNextStepExecute(Sender: TObject);
begin
  if _RecipeView.StepPosition < (_RecipeView.StepCount-1) then
  begin
    Inc(_RecipeView.StepPosition);

    DisplayStep;

    actFirstIngredient.Execute;
  end;
end;

procedure TfrmRecipePlay.actPriorIngredientExecute(Sender: TObject);
begin
  FloatAnimationLeftIngredient.Start;

  if _RecipeView.CurIngredientPosition > 0 then
  begin
    Dec(_RecipeView.CurStep.IngredientPosition);

    SetIngredientScaleTimer;

    SetIngredientColor;
  end
  else
    actPriorStep.Execute;
end;

procedure TfrmRecipePlay.actPriorStepExecute(Sender: TObject);
begin
  if (_RecipeView.StepPosition > 0) then
  begin
    Dec(_RecipeView.StepPosition);

    DisplayStep;

    actFirstIngredient.Execute;
  end;
end;

procedure TfrmRecipePlay.actRecipeViewSimpleExecute(Sender: TObject);
var
  url: string;
  aForm: TfrmWeb;
begin
  url := URL_RECIPE_VIEW_SIMPLE + '?recipeserial=' + FRecipeSerial.ToString + '&servings=' + FPersons.ToString + '&ratio=' + FRatio.ToString;

  aForm := TfrmWeb.Create(self);
  aForm.goURL(url);
  aForm.Show;
end;

procedure TfrmRecipePlay.actTimerNextExecute(Sender: TObject);
var
  oTimerInfo: TCPTimerInfo;
begin
  oTimerInfo := _Timers.FindTimerInfo(_RecipeView.StepPosition, _RecipeView.CurIngredientPosition);
  if Assigned(oTimerInfo) then
  begin
    oTimerInfo.FStatus := TTimerStatus.tsCooking;
//    if not oTimerInfo.Timer.Enabled then
//    begin
//      oTimerInfo.status := TTimerStatus.tsCooking;
//      oTimerInfo.Timer.Enabled := True;
//    end;
  end;

  frameTimer1.FloatAnimationPlayAction.Start;
  actNextIngredient.Execute;
end;

procedure TfrmRecipePlay.actTimeStartPauseExecute(Sender: TObject);
var
  oTimerInfo: TCPTimerInfo;
begin
  oTimerInfo := _Timers.FindTimerInfo(_RecipeView.StepPosition, _RecipeView.CurIngredientPosition);
  if Assigned(oTimerInfo) then
  begin
    if frameTimer1.txtPlayStartPause.Text = 'START' then
    begin
      oTimerInfo.FStatus := TTimerStatus.tsCooking;
//      oTimerInfo.Timer.Enabled := True;
//      frameTimer1.txtPlayStartPause.Text := 'STOP'
    end
    else
    begin
//      oTimerInfo.Timer.Enabled := False;
      oTimerInfo.FStatus := TTimerStatus.tsReady;
      oTimerInfo.Curtime := oTimerInfo.TotalTime;

      frameTimer1.movePosition(oTimerInfo.Title, oTimerInfo.Curtime, oTimerInfo.TotalTime, False);
//      frameTimer1.txtPlayStartPause.Text := 'START'
    end;
  end;
end;

procedure TfrmRecipePlay.ClearStepControls;
begin
  // 처음에는 STEP 사진이 없는 것으로 세팅
  ImageView := False;

  SetStepHeader(0, 0);

  SetDescription('');
end;

procedure TfrmRecipePlay.DisplayStep;
begin
  ClearStepControls;

//  frameScale1.ScaleNext('', _info.login.scale.MaxWeight, TIngredientUnit.wuG);

  VertScrollBox.BeginUpdate;

  if _RecipeView.StepCount > 0 then
  begin
    SetStepHeader(_RecipeView.StepPosition+1, _RecipeView.StepCount);

    // Image 있는 것 세팅
    ImageView := _RecipeView.CurStep.PictureName.Trim <> '';

    SetDescription(_RecipeView.CurStep.Description);

    SetIngredient;
  end;

  VertScrollBox.EndUpdate;
end;

procedure TfrmRecipePlay.DoScaleNextButton(const AWeight: TWeightMessage);
var
  oIng: TRecipeViewIngredient;
begin
  frameScale1.FloatAnimationPlayAction.Start;
  frameTimer1.FloatAnimationPlayAction.Start;

  oIng := _RecipeView.CurIngredient;

  if Assigned(oIng) then
  begin
    if oIng.ItemType = TIngredientType.itTime then
      actTimerNext.Execute
    else
      actNextIngredient.Execute;
  end
  else
    actNextIngredient.Execute;
end;

procedure TfrmRecipePlay.DoTimerNextButton(Sender: TObject);
begin
//
end;

procedure TfrmRecipePlay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RecipeSerial := NEW_RECIPE_SERIAL;

  _RecipeView.Clear;

  _Timers.Clear;

  _IngredientTexts.Clear;
end;

procedure TfrmRecipePlay.FormCreate(Sender: TObject);
begin
  _IngredientTexts.Init;

  _RecipeView := TRecipeView.Create;

  _Timers := TCPTimer.Create;
  _Timers.ItemList := TStringList.Create;
end;

procedure TfrmRecipePlay.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if IsBackKey(Key) then
    actClose.Execute;
end;

procedure TfrmRecipePlay.FormResize(Sender: TObject);
begin
  // Timer List 초기화
  recBackground.Position.X := 0;
  recBackground.Position.Y := 0;
  recBackground.Width := layoutBody.Width; //self.ClientWidth;
  recBackground.Height := layoutBody.Height;//.ClientHeight;

  scrollTimerList.Width := layoutBody.Width;//.ClientWidth;
  scrollTimerList.Position.X := 0;
  scrollTimerList.Position.Y := layoutBody.Height;//.ClientHeight;
  scrollTimerList.Visible := False;
end;

procedure TfrmRecipePlay.FormShow(Sender: TObject);
begin
  imgScaleExisted.Opacity := 0;
  imgScaleExisted.HitTest := False;

  // Status Bar 색을 바꾼다
  Fill.Color := $FFFFDF77;
  StatusBarSetColor(Fill.Color);

  ShowTimerList(False);

  _IngredientTexts.Clear;
  _RecipeView.Clear;

  _RecipeView.RecipeSerial := FRecipeSerial;

  ClearStepControls;

  // Tab Control Setting for Scale and Timer
  frameScale1.BeginUpdate;
  frameScale1.ScaleOpen(TScaleMeasureType.smPlay, '', _info.login.scale.MaxWeight, TIngredientUnit.wuG, DoScaleNextButton);
  frameScale1.EndUpdate;

  frameTimer1.Clear;
  frameTimer1.TimerOpen(DoTimerNextButton);
  frameTimer1.Resize(TScaleMeasureType.smPlay);


  tabControl.ActiveTab := tabScale;

  if _RecipeView.RecipeSerial > NEW_RECIPE_SERIAL then
  begin
    _RecipeView.Clear;

    CM.LoadRecipeInfo(_RecipeView, FPersons, FRatio);

    timeStart.Enabled := True;
  end;
end;

procedure TfrmRecipePlay.frameScale1timerRWTimer(Sender: TObject);
begin
  frameScale1.timerRWTimer(Sender);
end;

procedure TfrmRecipePlay.imgActiveImageClick(Sender: TObject);
begin
  if (Sender is TImage) and ((Sender as TImage).TagString <> '') then
  begin
    frmViewStepImage.Init((Sender as TImage).TagString, ClientWidth, ClientHeight);
    frmViewStepImage.Show;
  end;
end;

procedure TfrmRecipePlay.imgScaleExistedClick(Sender: TObject);
begin
  ShowTimerList(True);
end;

procedure TfrmRecipePlay.recBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  actClose.Execute;
end;

procedure TfrmRecipePlay.SetDescription(aValue: string);
begin
  txtDescriptiontemp.AutoSize := False;
  txtDescriptionTemp.Height := 0;
  txtDescriptionTemp.Width := txtDescription.Width;
  txtDescriptionTemp.AutoSize := True;

  txtDescriptionTemp.Text := aValue;

  if txtDescriptionTemp.Height = 0 then
    layoutDescriptionBody.Height := 50
  else
  begin
    txtDescription.Height := txtDescriptionTemp.Height;
    layoutDescriptionBody.Height := txtDescription.Height + 17;
  end;

  txtDescription.Text := txtDescriptionTemp.Text;
end;

procedure TfrmRecipePlay.SetImageView(const Value: Boolean);
begin
  imgActiveImage.TagString := '';

  imgActiveImage.Visible := Value;
  imgInactiveImage.Visible := not Value;

  if imgActiveImage.Visible and Assigned(_RecipeView.CurStep) then
    imgActiveImage.TagString := _RecipeView.CurStep.PictureName;
end;

procedure TfrmRecipePlay.SetIngredient;
var
  i: integer;
  oText: TText;
begin
  _IngredientTexts.Clear;

  // 재료에 대한  Text Object 를 만든다
  for i := 0 to _RecipeView.Steps[_RecipeView.StepPosition].IngredientCount-1 do
    _IngredientTexts.Add(_RecipeView.Steps[_RecipeView.StepPosition].Ingredients[i].ItemType,
                         i,
                         _RecipeView.Steps[_RecipeView.StepPosition].Ingredients[i].ToString);

  if _IngredientTexts.IngredientTextList.Count = 0 then
    layoutIngredientBody.Visible := False
  else
  begin
    layoutIngredientBody.Visible := True;

    oText := TText(_IngredientTexts.IngredientTextList.Objects[_IngredientTexts.IngredientTextList.Count-1]);
    layoutIngredientBody.Height := oText.Position.Y + oText.Height + layoutIngredient.Margins.Top + layoutIngredient.Margins.Bottom;

    if layoutIngredientBody.Height < 28 then
      layoutIngredientBody.Height := 28;
  end;

  layoutLinkedRecipeBody.Position.Y := layoutIngredientBody.Position.Y + layoutIngredientBody.Height + 100;

  if _IngredientTexts.LinkedRecipeTextList.Count = 0 then
    layoutLinkedRecipeBody.Visible := False
  else
  begin
    layoutLinkedRecipeBody.Visible := True;

    oText := TText(_IngredientTexts.LinkedRecipeTextList.Objects[_IngredientTexts.LinkedRecipeTextList.Count-1]);
    layoutLinkedRecipeBody.Height := oText.Position.Y + oText.Height + layoutLinkedRecipe.Margins.Top + layoutLinkedRecipe.Margins.Bottom;

    if layoutLinkedRecipeBody.Height < 28 then
      layoutLinkedRecipeBody.Height := 28;
  end;

  layoutTimeBody.Position.Y := layoutLinkedRecipe.Position.Y + layoutLinkedRecipe.Height + 100;

  if _IngredientTexts.TimeTextList.Count = 0 then
    layoutTimeBody.Visible := False
  else
  begin
    layoutTimeBody.Visible := True;

    oText := TText(_IngredientTexts.TimeTextList.Objects[_IngredientTexts.TimeTextList.Count-1]);
    layoutTimeBody.Height := oText.Position.Y + oText.Height + layoutTime.Margins.Top + layoutTime.Margins.Bottom;

    if layoutTimeBody.Height < 28 then
      layoutTimeBody.Height := 28;
  end;
end;

procedure TfrmRecipePlay.SetIngredientColor;
var
  i: integer;
  oText: TText;
  str: string;
begin
  str := '';
  for i := 0 to _IngredientTexts.Count-1 do
  begin
    oText := TText(_IngredientTexts.TextListAll.Objects[i]);

    if oText.tag = _RecipeView.Steps[_RecipeView.StepPosition].IngredientPosition then
    begin
      oText.TextSettings.FontColor := COLOR_BACKGROUND;
      oText.TextSettings.Font.Style := [TFontStyle.fsBold];
    end
    else
    begin
      oText.TextSettings.FontColor := $FF585858;
      oText.TextSettings.Font.Style := [];
    end;
  end;
end;

procedure TfrmRecipePlay.SetIngredientScaleTimer;
var
  oIng: TRecipeViewIngredient;
  oTimerInfo: TCPTimerInfo;
begin
  if Assigned(_RecipeView.CurIngredient) then
  begin
    oIng := _RecipeView.CurIngredient;
    if oIng.ItemType = itTime then
    begin
      tabControl.ActiveTab := tabTimer;

      oTimerInfo := _Timers.FindTimerInfo(_RecipeView.StepPosition, _RecipeView.CurIngredientPosition);
      if Assigned(oTimerInfo) then
      begin
        frameTimer1.movePosition(oTimerInfo.Title, oTimerInfo.Curtime, oTimerInfo.TotalTime, not (oTimerInfo.FStatus=TTimerStatus.tsReady))
//        frameTimer1.movePosition(oTimerInfo.Title, oTimerInfo.Curtime, oTimerInfo.TotalTime, oTimerInfo.Timer.Enabled)
      end
      else
        frameTimer1.movePosition(oIng.Title, TimeStrToSecs(oIng.ItemTimeValue), TimeStrtoSecs(oIng.ItemTimeValue), False);
    end
//    if oIng.ItemType in [itIngredient, itSeasoning, itRecipeLink] then
    else
    begin
      tabControl.ActiveTab := tabScale;
      if oIng.ItemWeightValue > 0 then
        frameScale1.ScaleNext(oIng.ToString, oIng.ItemWeightValue, oIng.ItemUnit)
      else
        frameScale1.ScaleNext(oIng.ToString, _info.login.scale.MaxWeight, _info.login.scale.UserWeightUnit);
    end;
  end
  else
  begin
    tabControl.ActiveTab := tabScale;
    frameScale1.ScaleNext('', _info.login.scale.MaxWeight, _info.login.scale.UserWeightUnit);
  end;
end;

procedure TfrmRecipePlay.SetRecipeSerial(const Value: LargeInt);
begin
  FRecipeSerial := Value;
end;

procedure TfrmRecipePlay.SetStepHeader(const aNo: integer; const aTotal: integer);
begin
  txtStepPage.Text := 'STEP ' + aNo.ToString + '/' + aTotal.ToString;
end;

procedure TfrmRecipePlay.SetTimers;
const
  TimerListHeight = 56;
var
  nStepNo, nIngredientNo: integer;
  oIngredient: TRecipeViewIngredient;
  oTimerInfo: TCPTimerInfo;
begin
  _Timers.Clear;

  for nStepNo := 0 to _RecipeView.StepCount-1 do
    for nIngredientNo := 0 to _Recipeview.Steps[nStepNo].IngredientCount-1 do
    begin
      oIngredient := _Recipeview.Steps[nStepNo].Ingredients[nIngredientNo];
      if oIngredient.ItemType = itTime then
      begin
        oTimerInfo := TCPTimerInfo.Create;
        oTimerInfo.Title := oIngredient.Title;
        oTimerInfo.TotalTime := TimeStrtoSecs(oIngredient.ItemTimeValue);
        oTimerInfo.Curtime := oTimerInfo.TotalTime;

        oTimerInfo.StepNo := nStepNo;
        oTimerInfo.IngredientNo := nIngredientNo;

        oTimerInfo.Timer := TTimer.Create(nil);
        oTimerInfo.Timer.OnTimer := oTimerInfo.DoTimer;
        oTimerInfo.Timer.Interval := 1000;
        oTimerInfo.Timer.Enabled := True;

        oTimerInfo.recBody := TRectangle.Create(frmRecipePlay.scrollTimerList);
        oTimerInfo.recBody.parent := frmRecipePlay.scrollTimerList;
        oTimerInfo.recBody.Position := TPosition.Create(PointF(0, _Timers.GetNewBodyY));
        oTimerInfo.recBody.Align := TAlignLayout.Top;
        oTimerInfo.recBody.Height := TimerListHeight;
        oTimerInfo.recBody.Fill.Color := TAlphaColorRec.White;
        oTimerInfo.recBody.Stroke.kind := TBrushKind.None;
        begin
          oTimerInfo.lineDivide := TLine.Create(oTimerInfo.recBody);
          oTimerInfo.lineDivide.Parent := oTimerInfo.recBody;
          oTimerInfo.lineDivide.LineType := TLineType.Top;
          oTimerInfo.lineDivide.Height := 1;
          oTimerInfo.lineDivide.Align := TAlignLayout.Top;
          oTimerInfo.lineDivide.Stroke.Color := COLOR_GRAY_LINE;

          oTimerInfo.imgIcon := TImage.Create(oTimerInfo.recBody);
          oTimerInfo.imgIcon.Parent := oTimerInfo.recBody;
          oTimerInfo.imgIcon.Width := 30;
          oTimerInfo.imgIcon.Margins.Left := 10;
          oTimerInfo.imgIcon.Align := TAlignLayout.Left;
          oTimerInfo.imgIcon.Bitmap :=  ImageList1.Bitmap(TSizeF.Create(30,30), 0);

          oTimerInfo.BitmapAnimation := TBitmapAnimation.Create(oTimerInfo.imgIcon);
          oTimerInfo.BitmapAnimation.Parent := oTimerInfo.imgIcon;
          oTimerInfo.BitmapAnimation.AutoReverse := True;
          oTimerInfo.BitmapAnimation.Duration := 0.5;
          oTimerInfo.BitmapAnimation.Loop := True;
          oTimerInfo.BitmapAnimation.PropertyName := 'Bitmap';
          oTimerInfo.BitmapAnimation.StartValue := ImageList1.Bitmap(TSizeF.Create(30,30), 1);
          oTimerInfo.BitmapAnimation.StopValue := ImageList1.Bitmap(TSizeF.Create(30,30), 2);

          oTimerInfo.txtTitle := TText.Create(oTimerInfo.recBody);
          oTimerInfo.txtTitle.Parent := oTimerInfo.recBody;
          oTimerInfo.txtTitle.Margins.Left := 10;
          oTimerInfo.txtTitle.TextSettings.Font.Size := 16;
          oTimerInfo.txtTitle.TextSettings.HorzAlign := TTextAlign.Leading;
          oTimerInfo.txtTitle.Text := frameTimer1.GetIntToTime(oTimerInfo.Curtime) + '  ' + oIngredient.Title;
          oTimerInfo.txtTitle.Align := TAlignLayout.Client;

          oTimerInfo.txtDone := TText.Create(oTimerInfo.recBody);
          oTimerInfo.txtDone.Parent := oTimerInfo.recBody;
          oTimerInfo.txtDone.Margins.Left := 10;
          oTimerInfo.txtDone.Margins.Right := 10;
          oTimerInfo.txtDone.TextSettings.Font.Size := 16;
          oTimerInfo.txtDone.TextSettings.FontColor := COLOR_SCALE_COOKING;
          oTimerInfo.txtDone.TextSettings.HorzAlign := TTextAlign.Leading;
          oTimerInfo.txtDone.Text := '완료';
          oTimerInfo.txtDone.Width := 40;
          oTimerInfo.txtDone.Align := TAlignLayout.Right;
          oTimerInfo.txtDone.Visible := False;
          oTimerInfo.txtDone.OnClick := oTimerInfo.DoDoneTextClick;
        end;

        _Timers.ItemList.AddObject('', oTimerInfo);
      end;
    end;

  if (_Timers.ItemList.Count * TimerListHeight) > self.ClientHeight then
    scrollTimerList.Height := self.ClientHeight
  else
    scrollTimerList.Height := (_Timers.ItemList.Count * TimerListHeight);

  scrollTimerList.ViewportPosition := PointF(0,0);

  ShowTimerList(False);
end;

procedure TfrmRecipePlay.ShowTimerList(aVisible: Boolean);
begin
  scrollTimerList.Visible := aVisible;

  if aVisible and (_Timers.ItemList.Count > 0) then
  begin
    TAnimator.Create.AnimateFloat(recBackground, 'Opacity', 0.3, 0.15);
    recBackground.HitTest := True;

    TAnimator.Create.AnimateFloat(scrollTimerList, 'Position.Y', ClientHeight - scrollTimerList.Height, 0.25, TAnimationType.Out, TInterpolationType.Exponential);
  end
  else
  begin
    TAnimator.Create.AnimateFloat(recBackground, 'Opacity', 0, 0.15);
    recBackground.HitTest := False;

    TAnimator.Create.AnimateFloat(scrollTimerList, 'Position.Y', ClientHeight, 0.25, TAnimationType.Out, TInterpolationType.Exponential);
  end;
end;

procedure TfrmRecipePlay.timeStartTimer(Sender: TObject);
begin
  timeStart.Enabled := False;

  // 가져온 레시피 중에 Timer 가 있으면 Loading 한다
  SetTimers;

  DisplayStep;

  actFirstIngredient.Execute;
end;

procedure TfrmRecipePlay.timeTimerTimer(Sender: TObject);
// 이곳에서 무게표시 글자의 색깔을 정한다
var
  oTimerInfo: TCPTimerInfo;
  nStepNo, nIngredientNo: integer;
  i: integer;
begin
  if _Timers.ItemList.Count > 0 then
  begin
    if imgScaleExisted.Opacity < 1 then
    begin
      TAnimator.Create.AnimateFloat(imgScaleExisted, 'Opacity', 1, 0.3);
      imgScaleExisted.HitTest := True;
    end;

    if _Timers.hasOvercooking then
      BitmapAnimationScaleOvercooking.Start
    else
      BitmapAnimationScaleOvercooking.Stop;

    nStepNo := _RecipeView.StepPosition;
    nIngredientNo := _RecipeView.CurIngredientPosition;

    oTimerInfo := _Timers.FindTimerInfo(nStepNo, nIngredientNo);

    if Assigned(oTimerInfo) then
    begin
      case oTimerInfo.FStatus of
        tsReady:
          begin
            frameTimer1.txtTime.TextSettings.FontColor := COLOR_SCALE_READY;
            frameTimer1.txtPlayStartPause.Text := 'START';
          end;
        tsCooking:
          begin
            frameTimer1.txtTime.TextSettings.FontColor := COLOR_SCALE_COOKING;
            frameTimer1.txtPlayStartPause.Text := 'STOP';
          end;
        tsOverCooking:
          begin
            frameTimer1.txtTime.TextSettings.FontColor := COLOR_SCALE_OVERCOOKING;
            frameTimer1.txtPlayStartPause.Text := 'STOP';
          end;
      end;
    end;

    // 이곳에서 Timer List 색을 결정한다
    for i := 0 to _Timers.ItemList.Count-1 do
    begin
      oTimerInfo := TCPTimerInfo(_Timers.ItemList.Objects[i]);
      case oTimerInfo.FStatus of
        tsReady:
          begin
            if oTimerInfo.BitmapAnimation.Running then
              oTimerInfo.BitmapAnimation.Stop;
            oTimerInfo.imgIcon.Bitmap := ImageList1.Bitmap(TSizeF.Create(30,30), 0);
            oTimerInfo.txtTitle.TextSettings.FontColor := COLOR_SCALE_READY;

            oTimerInfo.txtDone.Visible := False;
          end;
        tsCooking:
          begin
            if oTimerInfo.BitmapAnimation.Running then
              oTimerInfo.BitmapAnimation.Stop;
            oTimerInfo.imgIcon.Bitmap := ImageList1.Bitmap(TSizeF.Create(30,30), 1);
            oTimerInfo.txtTitle.TextSettings.FontColor := COLOR_SCALE_COOKING;

            oTimerInfo.txtDone.Visible := True;
          end;
        tsOverCooking:
          begin
            if not oTimerInfo.BitmapAnimation.Running then
              oTimerInfo.BitmapAnimation.Start;
            oTimerInfo.txtTitle.TextSettings.FontColor := COLOR_SCALE_OVERCOOKING;

            oTimerInfo.txtDone.Visible := True;
          end;
      end;
    end;
  end
  else
  begin
    if imgScaleExisted.Opacity > 0 then
    begin
      TAnimator.Create.AnimateFloat(imgScaleExisted, 'Opacity', 0, 0.3);
      imgScaleExisted.HitTest := False;
    end;
  end;
end;

{ TIngredientTexts }

procedure TIngredientTexts.Add(aType: TIngredientType; aSeq: Integer;
  const aValue: string);
const
  XMARGIN = 7;
  YMARGIN = 3;
var
  aLayoutWidth: Single;
  aItemWidth: Single;
  aTargetLayout: TLayout;
  i: integer;
  X, Y: Single;
  aTargetList: TStringList;
  aSourceTextList: TStringList;
  oText: TText;
begin
  case aType of
   itTime:
      begin
        aTargetLayout := frmRecipePlay.layoutTime;
        aTargetList := _IngredientTexts.TimeTextList;
      end;
    itRecipeLink:
      begin
        aTargetLayout := frmRecipePlay.layoutLinkedRecipe;
        aTargetList := _IngredientTexts.LinkedRecipeTextList;
      end;
    else // itIngredient, itSeasoning:
      begin
        aTargetLayout := frmRecipePlay.layoutIngredient;
        aTargetList := _IngredientTexts.IngredientTextList;
      end;
  end;

  aLayoutWidth := frmRecipePlay.layoutIngredient.Width;

  aSourceTextList := GetTextList(aLayoutWidth, aValue);

  for i := 0 to aSourceTextList.Count-1 do
  begin
    if aTargetList.Count > 0 then
    begin
      X := TText(aTargetList.Objects[aTargetList.Count-1]).Position.X + TText(aTargetList.Objects[aTargetList.Count-1]).Width + XMARGIN;
      Y := TText(aTargetList.Objects[aTargetList.Count-1]).Position.Y;
    end
    else
    begin
      X := 0;
      Y := 0;
    end;

    oText := TText.Create(aTargetLayout);
    oText.Parent := aTargetLayout;
    oText.TextSettings.Font.Size := 14;
    oText.TextSettings.HorzAlign := TTextAlign.Leading;
    oText.TextSettings.VertAlign := TTExtAlign.Leading;
    oText.TextSettings.WordWrap := False;
    oText.AutoSize := True;
    oText.Position := TPosition.Create(PointF(0,0));
    oText.Text := aSourceTextList[i];
    oText.Tag := aSeq;

    if (X + oText.Width) > aLayoutWidth then
    begin
      X := 0;
      Y := Y + oText.Height + YMARGIN;
    end;

    oText.Position := TPosition.Create(PointF(X,Y));
    aTargetList.AddObject('', oText);

    _IngredientTexts.TextListAll.AddObject('', oText);
  end;

  aSourceTextList.DisposeOf;
end;

procedure TIngredientTexts.Clear;
begin
  while self.IngredientTextList.Count > 0 do
  begin
    self.IngredientTextList.Objects[0].DisposeOf;
    self.IngredientTextList.Delete(0);
  end;

  while self.TimeTextList.Count > 0 do
  begin
    self.TimeTextList.Objects[0].DisposeOf;
    self.TimeTextList.Delete(0);
  end;

  while self.LinkedRecipeTextList.Count > 0 do
  begin
    self.LinkedRecipeTextList.Objects[0].DisposeOf;
    self.LinkedRecipeTextList.Delete(0);
  end;

  while self.TextListAll.Count > 0 do
  begin
    self.TextListAll.Objects[0].DisposeOf;
    self.TextListAll.Delete(0);
  end;
end;

function TIngredientTexts.GetCount: integer;
begin
  result := TextListAll.Count;
end;

function TIngredientTexts.GetText: TText;
var
  nIngredientNo: integer;
begin
  nIngredientNo := _RecipeView.CurIngredientPosition;

  if nIngredientNo > -1 then
    result := TText(self.TextListAll.Objects[nIngredientNo])
  else
    result := nil;
end;

function TIngredientTexts.GetTextList(const aLayoutWidth: Single; const aValue: string): TStringList;
var
  i: integer;
  str: string;
  nPos: integer;
begin
  result := TStringList.Create;
  nPos := 0;
  for i := 1 to Length(aValue) do
  begin
    str := aValue.Substring(nPos, i-nPos);

    frmRecipePlay.txtTemp.Text := str;

    if frmRecipePlay.txtTemp.Width > aLayoutWidth then
    begin
      result.Add(aValue.Substring(nPos,i-nPos-1));

      nPos := i - 1;
    end;
  end;

  if nPos < (Length(aValue)-1) then
    result.Add(aValue.Substring(nPos, Length(aValue) - nPos));
end;

procedure TIngredientTexts.Init;
begin
  _IngredientTexts.IngredientTextList := TStringList.Create;
  _IngredientTexts.TimeTextList := TStringList.Create;
  _IngredientTexts.LinkedRecipeTextList := TStringList.Create;
  _IngredientTexts.TextListAll := TStringList.Create;
end;


{ TCPTimerData }

procedure TCPTimerInfo.Clear;
begin
  Timer.DisposeOf;

  recBody.DisposeOf;

  Title := '';
  TotalTime := 0;
  Curtime := 0;
  StepNo := -1;
  IngredientNo := -1;
end;

{ TCPTimer }

procedure TCPTimer.Clear;
begin
  while ItemList.Count > 0 do
  begin
    TCPTimerInfo(ItemList.Objects[0]).Clear;
    ItemList.Delete(0);
  end;
end;

function TCPTimer.FindTimerInfo(aStepNo, aIngredientNo: integer): TCPTimerInfo;
var
  i: integer;
begin
  result := nil;

  for i := 0 to ItemList.Count-1 do
    if (TCPTimerInfo(ItemList.Objects[i]).StepNo = aStepNo) and (TCPTimerInfo(ItemList.Objects[i]).IngredientNo = aIngredientNo) then
    begin
      result := TCPTimerInfo(ItemList.Objects[i]);
      break;
    end;
end;

function TCPTimer.FindTimerInfo(oTimer: TTimer): TCPTImerInfo;
var
  i: integer;
begin
  result := nil;
  for i := 0 to _Timers.ItemList.Count - 1 do
    if TCPTimerInfo(_Timers.ItemList.Objects[i]).Timer = oTimer then
    begin
      result := TCPTimerInfo(_Timers.ItemList.Objects[i]);
      break;
    end;
end;

function TCPTimer.GetNewBodyY: Single;
begin
  if ItemList.Count = 0 then
    result := 0
  else
    result := TCPTImerInfo(ItemList.Objects[ItemList.Count-1]).recBody.Position.Y + 10;
end;

function TCPTimer.hasOvercooking: Boolean;
var
  i: integer;
begin
  result := False;
  for i := 0 to self.ItemList.Count - 1 do
    if TCPTimerInfo(self.ItemList.Objects[i]).FStatus = tsOverCooking then
    begin
      result := True;
      break;
    end;
end;

procedure TCPTimerInfo.DoDoneTextClick(Sender: TObject);
var
  oTimerInfo: TCPTimerInfo;
begin
  oTimerInfo := _Timers.FindTimerInfo(StepNo, IngredientNo);
  if Assigned(oTimerInfo) then
  begin
    oTimerInfo.FStatus := TTimerStatus.tsReady;
    oTimerInfo.Curtime := oTimerInfo.TotalTime;

    frmRecipePlay.frameTimer1.movePosition(oTimerInfo.Title, oTimerInfo.Curtime, oTimerInfo.TotalTime, False);
  end;
end;

procedure TCPTimerInfo.DoTimer(Sender: TObject);
var
  oTimerInfo: TCPTimerInfo;
begin
  oTimerInfo := _Timers.FindTimerInfo(Timer);

  if Assigned(oTimerInfo) then
  begin
    oTimerInfo.txtTitle.Text := frmRecipePlay.frameTimer1.GetIntToTime(oTimerInfo.Curtime) + '  ' + oTimerInfo.Title;

    if oTimerInfo.FStatus <> TTimerStatus.tsReady then
    begin
      Dec(CurTime);

      if CurTime > 0 then
        FStatus := TTimerStatus.tsCooking
      else
        FStatus := TTimerStatus.tsOverCooking;



      if (oTimerInfo.StepNo = _RecipeView.StepPosition) and (oTimerInfo.IngredientNo = _RecipeView.CurIngredientPosition) then
        frmRecipePlay.frameTimer1.movePosition(Title, Curtime, TotalTime, True);
    end;
  end;
end;

function TCPTimer.FindTimerInfo(oText: TText): TCPTimerInfo;
var
  i: integer;
begin
  result := nil;
  for i := 0 to _Timers.ItemList.Count - 1 do
    if TCPTimerInfo(_Timers.ItemList.Objects[i]).txtDone = oText then
    begin
      result := TCPTimerInfo(_Timers.ItemList.Objects[i]);
      break;
    end;
end;

end.

