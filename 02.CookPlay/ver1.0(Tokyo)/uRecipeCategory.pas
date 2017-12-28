unit uRecipeCategory;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TCallbackEvent = procedure (Sender: TObject) of Object;

  TCategoryItem = class
    Body: TRoundRect;
    CategoryName: TText;
    CategoryCode: integer;
    Selected: Boolean;
  public
    procedure CreateControls(AGrid: TGridPanelLayout; ACallback: TCallbackEvent; nCategoryCode: integer; sCategoryName: string);
    procedure SetDisplay;
  end;

  TfrmRecipeCategory = class(TForm)
    recTitle: TRectangle;
    layoutBackButton: TLayout;
    imgBack: TImage;
    recBody: TRectangle;
    Layout1: TLayout;
    Text1: TText;
    Layout2: TLayout;
    Text2: TText;
    Text8: TText;
    Layout12: TLayout;
    VertScrollBox1: TVertScrollBox;
    gCategory0: TGridPanelLayout;
    recCategory0: TRectangle;
    Layout3D1: TLayout3D;
    Layout3: TLayout;
    Text15: TText;
    recCategory1: TRectangle;
    gCategory1: TGridPanelLayout;
    Layout3D2: TLayout3D;
    Layout4: TLayout;
    Text28: TText;
    recCategory2: TRectangle;
    gCategory2: TGridPanelLayout;
    Layout3D3: TLayout3D;
    Layout5: TLayout;
    Text41: TText;
    recCategory3: TRectangle;
    gCategory3: TGridPanelLayout;
    Layout3D4: TLayout3D;
    Layout6: TLayout;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure layoutBackButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FCategoryCreated: Boolean; // Category 를 처음에만 생성하고 나중에하는 하지 않는다.
    FCategoryList: TStringList;

    procedure OnCategoryClick(Sender: TObject);
  public
    { Public declarations }
    procedure CreateCategories;
    procedure SetCategorySelected(sCategories: string);
    function GetSelectedCategoryString: string;
  published
    property CategoryList: TStringList read FCategoryList;
  end;


var
  frmRecipeCategory: TfrmRecipeCategory;

implementation
uses uGlobal, cookplay.StatusBar, uRecipeEditor, ClientModuleUnit;
{$R *.fmx}

procedure TfrmRecipeCategory.CreateCategories;
  procedure ClearGridPanelLayout(AGrid: TGridPanelLayout);
  begin
    AGrid.ControlCollection.Clear;
    AGrid.ColumnCollection.Clear;
    AGrid.RowCollection.Clear;
  end;

  procedure AddCategory(aRec: TRectangle; AGrid: TGridPanelLayout; FilterString: string);
  var
    row, i: integer;
    aItem: TCategoryItem;
  begin
    if CM.memCategory.Active then
    begin
      AGrid.BeginUpdate;

      try
        CM.memCategory.Filter := FilterString;
        CM.memCategory.Filtered := True;

        row := CM.memCategory.RecordCount div 3;
        if (CM.memCategory.RecordCount mod 3) > 0 then
          row := row + 1;

        aRec.Height := row * 45;

        AGrid.ColumnCollection.add;
        AGrid.ColumnCollection.add;
        AGrid.ColumnCollection.add;
        AGrid.ColumnCollection.Items[0].Value := 33.3;
        AGrid.ColumnCollection.Items[1].Value := 33.3;
        AGrid.ColumnCollection.Items[2].Value := 33.3;

        for i := 0 to row-1 do
          AGrid.RowCollection.Add;

        CM.memCategory.First;
        while not CM.memCategory.Eof do
        begin
          aItem := TCategoryItem.Create;
          aItem.CreateControls(AGrid, OnCategoryClick, CM.memCategoryCategoryCode.AsInteger, CM.memCategoryCategoryName.AsString);

          FCategoryList.AddObject(i.ToString, aItem);
          aItem.Body.Tag := FCategoryList.Count-1;

          AGrid.Controls.Add(aItem.Body);

          CM.memCategory.Next;
        end;
      except;
      end;

      AGrid.EndUpdate;
    end;
  end;
var
  i: integer;
begin
  if not FCategoryCreated then
  begin
    FCategoryCreated := True; // 한번만 생성하도록 세팅

    FCategoryList.Clear; // 모든 카테고리가 저장될 StringList 를 Clear 한다

    ClearGridPanelLayout(gCategory0);
    ClearGridPanelLayout(gCategory1);
    ClearGridPanelLayout(gCategory2);
    ClearGridPanelLayout(gCategory3);

    AddCategory(recCategory0, gCategory0, 'CategoryType=''RECIPEC'' AND  CategoryCode<100');
    AddCategory(recCategory1, gCategory1, 'CategoryType=''RECIPEC'' AND  CategoryCode>=100 AND CategoryCode<200');
    AddCategory(recCategory2, gCategory2, 'CategoryType=''RECIPEC'' AND  CategoryCode>=200 AND CategoryCode<300');
    AddCategory(recCategory3, gCategory3, 'CategoryType=''RECIPEC'' AND  CategoryCode>=300 AND CategoryCode<400');
  end
  else // 만들어져 있으면 Selected 를 Clear 한다
  begin
    for i := 0 to FCategoryList.Count-1 do
    begin
      TCategoryItem(FCategoryList.Objects[i]).Selected := False;
      TCategoryItem(FCategoryList.Objects[i]).SetDisplay;
    end;
  end;
end;

procedure TfrmRecipeCategory.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmRecipeEditor.UpdateCategory;
end;

procedure TfrmRecipeCategory.FormCreate(Sender: TObject);
begin
  FCategoryCreated := False;
  FCategoryList := TStringList.Create;
end;

procedure TfrmRecipeCategory.FormShow(Sender: TObject);
begin
  // Status Bar 색을 바꾼다
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);
end;

function TfrmRecipeCategory.GetSelectedCategoryString: string;
var
  i: integer;
begin
  result := '';

  for i := 0 to FCategoryList.Count-1 do
    if TCategoryItem(FCategoryList.Objects[i]).Selected then
    begin
      if result = '' then
        result := TCategoryItem(FCategoryList.Objects[i]).CategoryCode.ToString
      else
        result := result + DELIMETER_CATEGORY + TCategoryItem(FCategoryList.Objects[i]).CategoryCode.ToString;
    end;
end;

procedure TfrmRecipeCategory.layoutBackButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRecipeCategory.OnCategoryClick(Sender: TObject);
  function GetSelectedCount: integer;
  var
    i: integer;
  begin
    result := 0;
    for i := 0 to FCategoryList.Count-1 do
      if TCategoryItem(FCategoryList.Objects[i]).Selected then
        result := result + 1;
  end;
var
  index: integer;
begin
  if Sender is TRoundRect then
  begin
    index := TRoundRect(Sender).tag;
    if TCategoryItem(FCategoryList.Objects[index]).Selected then
    begin
      TCategoryItem(FCategoryList.Objects[index]).Selected := False;
      TCategoryItem(FCategoryList.Objects[index]).SetDisplay;
    end
    else
    begin
      if GetSelectedCount >= 10 then
        ShowMessage('10개 까지 선택이 가능합니다!')
      else
      begin
        TCategoryItem(FCategoryList.Objects[index]).Selected := True;
        TCategoryItem(FCategoryList.Objects[index]).SetDisplay;
      end;
    end;
  end;
end;

procedure TfrmRecipeCategory.SetCategorySelected(sCategories: string);
var
  i, k, nCategoryCode: integer;
  aList: TStringList;
begin
  if sCategories.Trim <> '' then
  begin
    aList := TStringList.Create;
    aList.Delimiter := DELIMETER_CATEGORY;
    aList.DelimitedText := sCategories;

    // Clear Category Selection
    for i := 0 to FCategoryList.Count-1 do
      TCategoryItem(FCategoryList.Objects[i]).Selected := False;

    for i := 0 to aList.Count-1 do
    begin
      if aList.Strings[i].Trim <> '' then
      begin
        nCategoryCode := aList.Strings[i].ToInteger;

        // Set Select
        for k := 0 to FCategoryList.Count-1 do
          if TCategoryItem(FCategoryList.Objects[k]).CategoryCode = nCategoryCode then
            TCategoryItem(FCategoryList.Objects[k]).Selected := True;
      end;
    end;

    // Display All
    for k := 0 to FCategoryList.Count-1 do
      TCategoryItem(FCategoryList.Objects[k]).SetDisplay;
  end;
end;

{ TCategoryItem }

procedure TCategoryItem.CreateControls(AGrid: TGridPanelLayout; ACallback: TCallbackEvent;
  nCategoryCode: integer; sCategoryName: string);
begin
  Body := TRoundRect.Create(AGrid);
  Body.Parent := AGrid;
  Body.Width := 95;
  Body.Height := 30;
  Body.Fill.Color := COLOR_BACKGROUND;
  Body.Fill.Kind := TBrushKind.Solid;
  Body.Stroke.Color := COLOR_BACKGROUND;
  Body.OnClick := ACallback;

  CategoryCode := nCategoryCode;

  CategoryName := TText.Create(Body);
  CategoryName.Parent := Body;
  CategoryName.HitTest := False;
  CategoryName.Align := TAlignLayout.Client;
  CategoryName.TextSettings.Font.Size := 14;
  CategoryName.Text := sCategoryName;

  Selected := False;

  SetDisplay;
end;

procedure TCategoryItem.SetDisplay;
begin
  if Selected then
  begin
    Body.Fill.Color := COLOR_BACKGROUND;
    Body.Fill.Kind := TBrushKind.Solid;
    Body.Stroke.Color := COLOR_BACKGROUND;

    CategoryName.TextSettings.FontColor := TAlphaColorRec.White;
  end
  else
  begin
    Body.Fill.Kind := TBrushKind.None;
    Body.Stroke.Color := $FF979797;

    CategoryName.TextSettings.FontColor := TAlphaColorRec.Black;
  end;
end;

end.
