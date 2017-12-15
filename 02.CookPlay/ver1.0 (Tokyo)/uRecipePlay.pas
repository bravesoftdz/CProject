unit uRecipePlay;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  uScaleFrame, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Actions, FMX.ActnList, uGlobal, FMX.ScrollBox, FMX.Memo;

type
  TIngredientTexts = record
    IngredientTextList: TStringList;
    TimeTextList: TStringList;
    LinkedRecipeTextList: TStringList;
  public
    procedure Add(aType: TIngredientType; seq: Integer; aValue: string);
    procedure Clear;
  end;

  TfrmRecipePlay = class(TForm)
    Layout1: TLayout;
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
    VertScrollBox1: TVertScrollBox;
    frameScale1: TframeScale;
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
    Action3: TAction;
    Action4: TAction;
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
    Button1: TButton;
    Layout4: TLayout;
    txtTemp: TText;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure actCloseExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actPriorStepExecute(Sender: TObject);
    procedure frameScale1imgPriorIngredientClick(Sender: TObject);
    procedure frameScale1imgNextIngredientClick(Sender: TObject);
    procedure actShowStepImageExecute(Sender: TObject);
    procedure actNextStepExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FRecipeSerial: LargeInt;

    procedure ClearStepControls;

    procedure SetRecipeSerial(const Value: LargeInt);
    procedure SetImageView(const Value: Boolean);
    procedure SetStepHeader(const aNo: integer=0; const aTotal: integer=0);

    procedure DisplayStep;
    procedure SetDescription(aValue: string);
    procedure SetIngredient;

    property ImageView: Boolean Write SetImageView;
  public
    { Public declarations }
    property RecipeSerial: LargeInt write SetRecipeSerial;
  end;

var
  frmRecipePlay: TfrmRecipePlay;
  _RecipeView: TRecipeView;
  _IngredientTexts: TIngredientTexts;

implementation
uses cookplay.scale, cookplay.StatusBar, ClientModuleUnit;
{$R *.fmx}

procedure TfrmRecipePlay.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmRecipePlay.actNextStepExecute(Sender: TObject);
begin
//
end;

procedure TfrmRecipePlay.actPriorStepExecute(Sender: TObject);
begin
  if (_RecipeView.StepPosition > 0) and (_RecipeView.StepCount > 0) then
  begin
    _RecipeView.StepPosition := _RecipeView.StepPosition - 1;
    DisplayStep;
  end;
end;

procedure TfrmRecipePlay.actShowStepImageExecute(Sender: TObject);
begin
//
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

  if _RecipeView.StepCount > 0 then
  begin
    SetStepHeader(_RecipeView.StepCount+1, _RecipeView.StepCount);

    SetDescription(_RecipeView.Steps[_RecipeView.StepPosition].Description);
    SetIngredient;

  end;

//  FRecipe.StepPosition
//  frameScale1.ScaleNext('양파1개 100.3g', 100.3, TIngredientUnit.wuG);
//  frameScale1.ScaleNext('마늘3개 50g', 50, TIngredientUnit.wuG);


end;

procedure TfrmRecipePlay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RecipeSerial := NEW_RECIPE_SERIAL;
end;

procedure TfrmRecipePlay.FormCreate(Sender: TObject);
begin
  _IngredientTexts.IngredientTextList := TStringList.Create;
  _IngredientTexts.TimeTextList := TStringList.Create;
  _IngredientTexts.LinkedRecipeTextList := TStringList.Create;

  _RecipeView.Clear;
end;

procedure TfrmRecipePlay.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if IsBackKey(Key) then
    actClose.Execute;
end;

procedure TfrmRecipePlay.FormShow(Sender: TObject);
begin
  // Status Bar 색을 바꾼다
  Fill.Color := $FFFFDF77;
  StatusBarSetColor(Fill.Color);

  _IngredientTexts.Clear;
  _RecipeView.Clear;

  _RecipeView.RecipeSerial := FRecipeSerial;

  ClearStepControls;

  frameScale1.OpenScale(TScaleMeasureType.smPlay, '', _info.login.scale.MaxWeight, TIngredientUnit.wuG);

  if _RecipeView.RecipeSerial > NEW_RECIPE_SERIAL then
  begin
    _RecipeView.Clear;
    CM.LoadRecipeInfo(_RecipeView);

    DisplayStep;
  end;

end;

procedure TfrmRecipePlay.frameScale1imgNextIngredientClick(Sender: TObject);
begin
  frameScale1.imgNextIngredientClick(Sender);

  actNextIngredient.Execute;
end;

procedure TfrmRecipePlay.frameScale1imgPriorIngredientClick(Sender: TObject);
begin
  frameScale1.imgPriorIngredientClick(Sender);

  actPriorIngredient.Execute;
end;

procedure TfrmRecipePlay.SetDescription(aValue: string);
begin
  txtTemp.Height := 0;
  txtTemp.Width := txtDescription.Width;

  txtTemp.Text := aValue;

  if txtTemp.Height = 0 then
    layoutDescriptionBody.Height := 50
  else
  begin
    txtDescription.Height := txtTemp.Height;
    layoutDescriptionBody.Height := txtDescription.Height + 24;
  end;

  txtDescription.Text := txtTemp.Text;
end;

procedure TfrmRecipePlay.SetImageView(const Value: Boolean);
begin
  imgActiveImage.Visible := Value;
  imgInactiveImage.Visible := not Value;
end;

procedure TfrmRecipePlay.SetIngredient;
var
  i: integer;
begin
  // 재료에 대한  Text Object 를 만든다
  for i := 0 to _RecipeView.Steps[_RecipeView.StepPosition].IngredientCount-1 do
    _IngredientTexts.Add(_RecipeView.Steps[_RecipeView.StepPosition].Ingredients[i].ItemType,
                         i,
                         _RecipeView.Steps[_RecipeView.StepPosition].Ingredients[i].ToString);
end;

procedure TfrmRecipePlay.SetRecipeSerial(const Value: LargeInt);
begin
  FRecipeSerial := Value;
end;

procedure TfrmRecipePlay.SetStepHeader(const aNo: integer; const aTotal: integer);
begin
  txtStepPage.Text := 'STEP ' + aNo.ToString + '/' + aTotal.ToString;
end;

{ TIngredientTexts }

procedure TIngredientTexts.Add(aType: TIngredientType; seq: Integer;
  aValue: string);
const
  MARGIN = 5;
var
  aLayoutWidth: Single;
  aListWidth: Single;
  aItemWidth: Single;
  aWordWidth: Single;
  aLayout: TLayout;
  aText: TText;
  aList: TStringList;
  i, nLineCount, nItemLineCount, nLoopCount: integer;
  nStartLine, nFinishLine: integer;
  X, Y: Single;

begin
  case aType of
    itIngredient, itSeasoning:
      begin
        aLayout := frmRecipePlay.layoutIngredient;
        aList := _IngredientTexts.IngredientTextList;
      end;
    itTime:
      begin
        aLayout := frmRecipePlay.layoutTime;
        aList := _IngredientTexts.TimeTextList;
      end;
    itRecipeLink:
      begin
        aLayout := frmRecipePlay.layoutLinkedRecipe;
        aList := _IngredientTexts.LinkedRecipeTextList;
      end;
  end;

  aText := TText.Create(aLayout);
  aText.Parent := aLayout;
  aText.TextSettings.Font.Size := 14;
  aText.Width := aLayout.Width;
  aText.AutoSize := True;
  aText.Text := aValue;
  aText.Tag := seq;

  aLayoutWidth := frmRecipePlay.layoutIngredient.Width;

  // 마지막 입력된 값을 기준으로 들어가야 할 위치를 선정한다
  X := 0;
  Y := 0;

  if aList.Count > 0 then
  begin
    X := TText(aList.Objects[aList.Count-1]).Position.X + TText(aList.Objects[aList.Count-1]).Width + MARGIN;
    Y := TText(aList.Objects[aList.Count-1]).Position.Y;
  end;

  // 마지막에 최소 한글자가 들어갈 수 있어야 표현하고, 다음줄로 넘긴다
  aWordWidth := aText.Canvas.TextWidth('쿡');

  if (X + aWordWidth) > aLayoutWidth  then
  begin
    X := 0;
    Y := Y + aText.Canvas.TextHeight('Cookplay');
  end;

  aText.Position := TPosition.Create(PointF(X,Y));

  aList.AddObject('', aText);
//
//
//
//
//
//
//
//
//
//  aListWidth := 0;
//  // 기존에 입력된 Text들의 길이를 구한다
//  for i := 0 to aList.Count-1 do
//    aListWidth := TText(aList.Objects[i]).Width + 5;
//
//  // 새로 추가할 X 위치
//  X := Frac(aListWidth / aLayoutWidth);
//
//  nStartLine := Trunc(aListWidth / aLayoutWidth);
//
//  if X > 0  then
//    nStartLine := nLineCount + 1;
//
//
//  // 새로 추가할 Y 위치
//  Y := aText.Canvas.TextHeight('CookPlay') * nLineCount;
//
//  nItemLineCount := TRunc(aText.Canvas.TextWidth(aValue) / aLayoutWidth )





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
end;

end.
