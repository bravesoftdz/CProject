unit uChangeWeight;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, uGlobal, System.ImageList, FMX.ImgList;

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
    procedure FormShow(Sender: TObject);
    procedure layoutBackButtonClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure txtDoneClick(Sender: TObject);
  private
    { Private declarations }
    FRecipeSerial: LargeInt;
    FServings: integer;
    FRatio: Single;
    FItems: TRecipeChangeWeight;
    FCallbackFunc: TCallbackFunc;

    procedure CreateControls;
    procedure ChangeWeightUsingRatio;
  public
    { Public declarations }
    procedure Init(aRecipeSerial: LargeInt; aServings: integer; aRatio: Single;
      aCallbackFunc: TCallbackFunc);
  end;

var
  frmChangeWeight: TfrmChangeWeight;

implementation
uses cookplay.StatusBar, ClientModuleUnit;

{$R *.fmx}

procedure TfrmChangeWeight.ChangeWeightUsingRatio;
var
  i: integer;
  txtWeight: TText;
  r: Single;
begin
  if not Assigned(FItems.Ingredients) then
    Exit;

  scrollBody.BeginUpdate;
  for i := 0 to FItems.Ingredients.Count-1 do
  begin
    txtWeight := TText(FItems.IngredientItem(i).recBody.FindComponent('txtWeight'+ inttostr(i)));

    if Assigned(txtWeight) and (txtWeight.Text.Trim <> '') then
    begin
      r := (FServings / FItems.Servings) * FRatio;
      txtWeight.Text := FormatFloat('0,.#', FItems.IngredientItem(i).Weight * r) + ' g';
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

  recItemBody: TRectangle;
  imgIcon: TImage;
  txtTitle: TText;
  txtWeight: TText;
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
      if FItems.IngredientItem(i).IngredientType = TIngredientType.itIngredient then
      begin
        layout := layoutIngredient;
        cntIngredient := cntIngredient + 1;
        cnt := cntIngredient;
      end
      else if FItems.IngredientItem(i).IngredientType = TIngredientType.itSeasoning then
      begin
        layout := layoutSeasoning;
        cntSeasoning := cntSeasoning + 1;
        cnt := cntSeasoning;
      end
      else if FItems.IngredientItem(i).IngredientType = TIngredientType.itRecipeLink then
      begin
        layout := layoutRecipeLink;
        cntRecipeLink := cntRecipeLink + 1;
        cnt := cntRecipeLink;
      end;

      layout.Height := ItemHeight * cnt + 10;

      recItemBody := TRectangle.Create(layout);
      recItemBody.Parent := layout;
      recItemBody.Position.Y := layout.Height;
      recItemBody.Align := TAlignLayout.Top;
      recItemBody.Fill.Color := TAlphaColorRec.White;
      recItemBody.Height := 50;
      recItemBody.Margins.Bottom := 10;
      recItemBody.Padding.Left := 8;
      recItemBody.padding.Right := 20;
      recItemBody.Stroke.Color := COLOR_GRAY_LINE;
      recItemBody.HitTest := True;
      begin
        imgIcon := TImage.Create(recItemBody);
        imgIcon.Parent := recItemBody;
        imgIcon.Align := TAlignLayout.Left;
        imgIcon.Width := 27;
        imgIcon.HitTest := False;

        if FItems.IngredientItem(i).Weight > 0 then
        begin
          imgIcon.Bitmap := ImageList1.Bitmap(TSizeF.Create(54, 54), 0);

          // Event 삽입
        end
        else
          imgIcon.Bitmap := ImageList1.Bitmap(TSizeF.Create(54, 54), 1);

        txtTitle := TText.Create(recItemBody);
        txtTitle.Parent := recItemBody;
        txtTitle.Align := TAlignLayout.Client;
        txtTitle.Margins.Left := 10;
        txtTitle.Text := FItems.IngredientItem(i).Title;
        txtTitle.TextSettings.Font.Size := 14;
        txtTitle.TextSettings.FontColor := COLOR_GRAY_TEXT;
        txtTitle.TextSettings.HorzAlign := TTextAlign.Leading;
        txtTitle.HitTest := False;

        txtWeight := TText.Create(recItemBody);
        txtWeight.Parent := recItemBody;
        txtWeight.Align := TAlignLayout.Right;
        txtWeight.Margins.Left := 10;

        if FItems.IngredientItem(i).Weight > 0 then
          txtWeight.Text := FormatFloat('0,.#', FItems.IngredientItem(i).Weight) + ' g'
        else
          txtWeight.Text := '';

        txtWeight.TextSettings.HorzAlign := TTextAlign.Trailing;
        txtWeight.Width := 65;
        txtWeight.HitTest := False;
        txtWeight.Name := 'txtWeight' + inttostr(i);
      end;

      FItems.IngredientItem(i).recBody := recItemBody;
    end;

  scrollBody.EndUpdate;
end;

procedure TfrmChangeWeight.FormCreate(Sender: TObject);
begin
  recTemp.DisposeOf;
  FItems := TRecipeChangeWeight.Create;
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

  FItems.Clear;

  FItems.Ingredients := CM.GetIngredientGroup(FRecipeSerial);

  CreateControls;
  ChangeWeightUsingRatio;
end;

procedure TfrmChangeWeight.Init(aRecipeSerial: LargeInt; aServings: Integer;
  aRatio: Single; aCallbackFunc: TCallbackFunc);
begin
  FRecipeSerial := aRecipeSerial;
  FServings := aServings;
  FRatio := aRatio;
  FCallbackFunc := aCallbackFunc;
end;

procedure TfrmChangeWeight.layoutBackButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmChangeWeight.txtDoneClick(Sender: TObject);
var
  sList: TStringList;
begin
  if Assigned(FCallbackFunc) then
  begin
    sList := TStringList.Create;
    sList.Add(FRatio.ToString);
    FCallbackFunc(sList);
  end
  else
    ShowMessage('무게 변경기능을 호출할 수 없습니다!');

  Close;
end;

end.
