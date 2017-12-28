unit uChangeWeight;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, uGlobal, System.ImageList, FMX.ImgList, System.Math, FMX.Ani;

type
  TfrmChangeWeight = class(TForm)
    recHeader: TRectangle;
    layoutBackButton: TLayout;
    imgBack: TImage;
    Layout12: TLayout;
    txtFormTitle: TText;
    recBody: TRectangle;
    scrollBody: TScrollBox;
    Layout1: TLayout;
    Image1: TImage;
    Text1: TText;
    layoutRecipeLink: TLayout;
    Layout3: TLayout;
    Image2: TImage;
    Text2: TText;
    layoutSeasoning: TLayout;
    Layout5: TLayout;
    Image3: TImage;
    Text3: TText;
    layoutIngredient: TLayout;
    recTemp: TRectangle;
    Image4: TImage;
    Text4: TText;
    Text5: TText;
    ImageList1: TImageList;
    txtDone: TText;
    FloatAnimation: TFloatAnimation;
    procedure FormShow(Sender: TObject);
    procedure layoutBackButtonClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure txtDoneClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FloatAnimationFinish(Sender: TObject);
  private
    { Private declarations }
//    FRecipeSerial: LargeInt;
//    FServings: integer;
//    FRatio: Single;
    FItems: TRecipeChangeWeight;
    FCallbackRefFunc: TCallbackRefFunc;

    procedure CreateControls;
    procedure ChangeWeightUsingRatio;

    procedure OnRecScaleTap(Sender: TObject; const Point: TPointF);
    procedure OnAniFloatFinish(Sender: TObject);
  public
    { Public declarations }
    procedure Init(aRecipeSerial: LargeInt; aServings: integer; aRatio: Single;
      aCallbackRefFunc: TCallbackREfFunc);
  end;

var
  frmChangeWeight: TfrmChangeWeight;

implementation
uses cookplay.StatusBar, ClientModuleUnit, uScaleView;

{$R *.fmx}

procedure TfrmChangeWeight.ChangeWeightUsingRatio;
var
  i: integer;
  aItem: TRecipeChangeWeightItem;
begin
  if not Assigned(FItems.Ingredients) then
    Exit;

  scrollBody.BeginUpdate;
  for i := 0 to FItems.Ingredients.Count-1 do
  begin
    aItem := FItems.IngredientItem(i);

    if aItem.sorWeight > 0 then
    begin
      aItem.tarWeight := FItems.NewWeight(aItem.sorWeight);
      aItem.txtWeight.Text := FormatFloat('0,.#', aItem.tarWeight) + ' g';
    end;
  end;
  scrollBody.EndUpdate;
end;

procedure TfrmChangeWeight.CreateControls;
var
  i: integer;
  layout: Tlayout;
  ItemHeight: integer;
  cntIngredient, cntSeasoning, cntRecipeLink: integer;
  cnt: integer;

  aItem: TRecipeChangeWeightItem;
begin
  scrollBody.BeginUpdate;
  layoutIngredient.Height := 10;
  layoutSeasoning.Height := 10;
  layoutRecipeLink.Height := 10;

  ItemHeight := 60;
  cntIngredient := 0;
  cntSeasoning := 0;
  cntRecipeLink := 0;
  cnt := 0;

  if Assigned(FItems.Ingredients) then
    for i := 0 to FItems.Ingredients.Count-1 do
    begin
      aItem := FItems.IngredientItem(i);
      // 양념
      if aItem.IngredientType = TIngredientType.itSeasoning then
      begin
        layout := layoutSeasoning;
        cntSeasoning := cntSeasoning + 1;
        cnt := cntSeasoning;
      end
      // 레시피 연결 재료
      else if aItem.IngredientType = TIngredientType.itRecipeLink then
      begin
        layout := layoutRecipeLink;
        cntRecipeLink := cntRecipeLink + 1;
        cnt := cntRecipeLink;
      end
      // 나머지는 재료로 구분
      else //if FItems.IngredientItem(i).IngredientType = TIngredientType.itIngredient then
      begin
        layout := layoutIngredient;
        cntIngredient := cntIngredient + 1;
        cnt := cntIngredient;
      end;

      layout.Height := ItemHeight * cnt + 10;

      aItem.recItemBody := TRectangle.Create(layout);
      aItem.recItemBody.Parent := layout;
      aItem.recItemBody.Position.Y := layout.Height;
      aItem.recItemBody.Align := TAlignLayout.Top;
      aItem.recItemBody.Fill.Color := TAlphaColorRec.White;
      aItem.recItemBody.Height := 50;
      aItem.recItemBody.Margins.Bottom := 10;
      aItem.recItemBody.Padding.Left := 8;
      aItem.recItemBody.padding.Right := 20;
      aItem.recItemBody.Stroke.Color := COLOR_GRAY_LINE;

      if FItems.IngredientItem(i).sorWeight > 0 then
        aItem.recItemBody.HitTest := True
      else
        aItem.recItemBody.HitTest := False;

      aItem.recItemBody.Tag := i; // Item 번호를 저장
      // Event
      aItem.recItemBody.OnTap := OnRecScaleTap;

      aItem.AniFloat := TFloatAnimation.Create(aItem.recItemBody);
      aItem.AniFloat.Parent := aItem.recItemBody;
      aItem.AniFloat.AutoReverse := True;
      aItem.AniFloat.Duration := 0.2;
      aItem.AniFloat.PropertyName := 'Opacity';
      aItem.AniFloat.StartValue := 1;
      aItem.AniFloat.StopValue := 0.5;
      aItem.AniFloat.OnFinish := OnAniFloatFinish;
      aItem.AniFloat.Tag := i;

      begin
        aItem.imgIcon := TImage.Create(aItem.recItemBody);
        aItem.imgIcon.Parent := aItem.recItemBody;
        aItem.imgIcon.Align := TAlignLayout.Left;
        aItem.imgIcon.Width := 27;
        aItem.imgIcon.HitTest := False;

        if FItems.IngredientItem(i).sorWeight > 0 then
          aItem.imgIcon.Bitmap := ImageList1.Bitmap(TSizeF.Create(54, 54), 0)
        else
          aItem.imgIcon.Bitmap := ImageList1.Bitmap(TSizeF.Create(54, 54), 1);

        aItem.txtTitle := TText.Create(aItem.recItemBody);
        aItem.txtTitle.Parent := aItem.recItemBody;
        aItem.txtTitle.Align := TAlignLayout.Client;
        aItem.txtTitle.Margins.Left := 10;
        aItem.txtTitle.Text := FItems.IngredientItem(i).Title;
        aItem.txtTitle.TextSettings.Font.Size := 14;
        aItem.txtTitle.TextSettings.FontColor := COLOR_GRAY_TEXT;
        aItem.txtTitle.TextSettings.HorzAlign := TTextAlign.Leading;
        aItem.txtTitle.HitTest := False;

        aItem.txtWeight := TText.Create(aItem.recItemBody);
        aItem.txtWeight.Parent := aItem.recItemBody;
        aItem.txtWeight.Align := TAlignLayout.Right;
        aItem.txtWeight.Margins.Left := 10;

        if FItems.IngredientItem(i).sorWeight > 0 then
          aItem.txtWeight.Text := FormatFloat('0,.#', FItems.IngredientItem(i).tarWeight) + ' g'
        else
          aItem.txtWeight.Text := '';

        aItem.txtWeight.TextSettings.HorzAlign := TTextAlign.Trailing;
        aItem.txtWeight.Width := 65;
        aItem.txtWeight.HitTest := False;
        aItem.txtWeight.Name := 'txtWeight' + inttostr(i);
      end;
    end;

  scrollBody.EndUpdate;
end;

procedure TfrmChangeWeight.FloatAnimationFinish(Sender: TObject);
var
  nItemNo: integer;
  aItem: TRecipeChangeWeightItem;
begin
  nItemNo := TRectangle(FloatAnimation.Parent).Tag;
  aItem := FItems.IngredientItem(nItemNo);

  frmScaleView.SetValue('', aItem.tarWeight, smViewRatio,
    _info.login.scale.UserWeightUnit,
    procedure (const aResult: TStringList)
    var
      aTarWeight: Single;
    begin
      aTarWeight := StrToFloatDef(aResult[0], 0);

      if aTarWeight > 0 then
      begin
        // 소수점 2자리 까지만, 소주점 3자리에서 Round Up
//        FItems.tarWeightRatio := RoundTo(aTarWeight / aItem.sorWeight, -2);
        FItems.tarWeightRatio := RoundTo(aTarWeight / aItem.tarWeight, -2);
        ChangeWeightUsingRatio;
      end;
    end
  );
  frmScaleView.Show;
end;

procedure TfrmChangeWeight.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FCallbackRefFunc := nil;

  FItems.Clear;
end;

procedure TfrmChangeWeight.FormCreate(Sender: TObject);
begin
  recTemp.DisposeOf;
  FItems := TRecipeChangeWeight.Create;

  FCallbackRefFunc := nil;
  FItems.Clear;
end;

procedure TfrmChangeWeight.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    layoutBackButton.OnClick(layoutBackButton);
  end;
end;

procedure TfrmChangeWeight.FormShow(Sender: TObject);
begin
  // Status Bar 색을 바꾼다
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);

  // 원래의 Servings 와 재료 정보를 가져온다
  FItems.Ingredients := CM.GetIngredientGroup(FItems.RecipeSerial, FItems.sorServings, FItems.tarServings, FItems.tarWeightRatio);

  CreateControls;

  ChangeWeightUsingRatio;
end;

procedure TfrmChangeWeight.Init(aRecipeSerial: LargeInt; aServings: Integer;
  aRatio: Single; aCallbackRefFunc: TCallbackRefFunc);
begin
  FItems.Clear;

  FItems.RecipeSerial := aRecipeSerial;
  FItems.tarServings := aServings;
  FItems.tarWeightRatio := aRatio;

  FCallbackRefFunc := aCallbackRefFunc;
end;

procedure TfrmChangeWeight.layoutBackButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmChangeWeight.OnAniFloatFinish(Sender: TObject);
var
  nItemNo: integer;
  aItem: TRecipeChangeWeightItem;
begin
  nItemNo := TFloatAnimation(Sender).Tag;
  aItem := FItems.IngredientItem(nItemNo);

  frmScaleView.SetValue('', aItem.tarWeight, smViewRatio,
    _info.login.scale.UserWeightUnit,
    procedure (const aResult: TStringList)
    var
      aTarWeight: Single;
    begin
      aTarWeight := StrToFloatDef(aResult[0], 0);

      if aTarWeight > 0 then
      begin
        // 소수점 2자리 까지만, 소주점 3자리에서 Round Up
//        FItems.tarWeightRatio := aTarWeight / aItem.sorWeight;
        FItems.tarWeightRatio := aTarWeight / aItem.tarWeight;

        ChangeWeightUsingRatio;
      end;
    end
  );
  frmScaleView.Show;
end;

procedure TfrmChangeWeight.OnRecScaleTap(Sender: TObject; const Point: TPointF);
begin
  FItems.IngredientItem(TRectangle(Sender).Tag).AniFloat.Start;
end;

procedure TfrmChangeWeight.txtDoneClick(Sender: TObject);
var
  sList: TStringList;
begin
  if Assigned(FCallbackRefFunc) then
  begin
    sList := TStringList.Create;
    sList.Add(FItems.tarServings.ToString);
    sList.Add(RoundTo(FITems.tarWeightRatio, -5).ToString);

    FCallbackRefFunc(sList);
  end
  else
    ShowMessage('무게 변경기능을 호출할 수 없습니다!');

  Close;
end;

end.
