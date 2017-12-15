unit uRecipeEditor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Edit,
  FMX.ScrollBox, FMX.Memo, FMX.ListBox, FMX.ComboEdit, FMX.ComboTrackBar,
  FMX.TabControl, FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList,
  FMX.StdActns, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.DateTimeCtrls, FMX.Gestures, System.ImageList, FMX.ImgList, FMX.Ani,
  FMX.EditBox, FMX.NumberBox, uGlobal, FMX.Effects, cookplay.scale;

type
  TPictureInfo = record
    PictureType: TPicturetype;
    PictureName: string;
    PictureSquareName: string;
    PictureRectangleName: string;

    State: TRecipeState;
  public
    procedure Clear;
  end;

  TIngredientInfo = class
    Serial: LargeInt; // -1 이면 New, 아니면 기존 serial
    State: TRecipeState;

    LinkedRecipeSerial: LargeInt;

    IngredientType: TIngredientType;
    IngredientItemUnit: TIngredientUnit;
    ScaleWeight: Single;

    layoutIngredientBody: TLayout;
    imgLeft: TImage;    
    recNameBody: TRectangle;
    edtName: TEdit;
    recTimerBody: TRectangle;
    txtTimer: TText;
    recQuantityBody: TRectangle;
    edtQuantity: TEdit;
    recUnitBody: TRectangle;
    cboUnit: TComboBox;
    edtUnit: TEdit;

    txtScale: TText;
    imgScale: TImage;

    layout1: TLayout; // Recipe Linke 에 사용
    layout2: TLayout; // Recipe Linke 에 사용
  end;

  TStepInfo = class
    Serial: LargeInt; // -1이면 New, 아니면 기존 serial
    State: TRecipeState;

    No: integer;  // 1부터 시작
    // 재료 drag & drop을 위한 변수
    FCanMovingIngredient: Boolean;
    FGrab: Boolean; // 현재 drag & drop 상태 표시
    FMovingLayout: TLayout; // 선택된 재료 Layout을 지정
    FOffset: TPointF; // 재료 선택 시 최초 Mouse 위치 저장

    // Stemp Info
    layoutStep: TLayout;
    layoutStepHead: TLayout;
    txtStepNo: TText;
    imgDeleteStep: TImage;

    memoDescription: TMemo;
    Picture: TPictureInfo;
    recStepImage: TRectangle;
    imgStep: TImage;
    imgStepCamera: TImage;
    imgDeleteStepImage: TImage;
    imgStepImageOrigin: TImage;
    imgStepImageRectangle: TImage;
    txtEditIngredient: TText;

    // Ingredient Title
    txtStepIngredientTitle: TText;
    txtStepIngredientTitleEdit: TText;
    layoutIngredient: TLayout;

    // Ingredient
    Ingredients: TStringList;
    DeletedIngredient: TStringList; // 기존것 중 삭제시킨 것을 저장한다

    layoutAddIngredient: TLayout;
    imgAddIngredient: TImage;

    recDivider: TRectangle;
  private
    procedure SetCanMovingIngredient(const Value: Boolean);
    procedure OnScaleImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure OnScaleImageTap(Sender: TObject; const Point: TPointF);
    procedure OnBodyLayoutMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure OnBodyLayoutMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure OnDeleteImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  published
    property CanMovingIngredient: Boolean read FCanMovingIngredient write SetCanMovingIngredient;
  end;

  TStepArray = array of TStepInfo;

  TRecipeInfo = class
    // 기본정보
    Serial: LargeInt; // -1 이면 New, 아니면 기존 serial
    State: TRecipeState;

    DeletedImageQue: TStringList;
    AddedImageQue: TStringList;

    Steps: TStringList;
    DeletedSteps: TStringList;
  private
    procedure Clear;
  public
    function GetStepNo(StepLayout: TLayout): integer;
    function GetIngredientNo(IngredientBodyLayout: TLayout): integer;
    procedure ChangeIngredientEditState(IngredientEditText: TText);
    procedure Sort;
    function GetStep(aStepNo: integer): TStepInfo;
    function GetIngredient(aStepNo: integer; aIngredientNo: integer): TIngredientInfo;
  end;

  TfrmRecipeEditor = class(TForm)
    Text2: TText;
    Text4: TText;
    Layout3: TLayout;
    scrollRecipe: TVertScrollBox;
    StyleBook1: TStyleBook;
    lbCategory: TListBox;
    layoutRecipeInfo: TLayout;
    layoutTitle: TLayout;
    Text1: TText;
    Rectangle4: TRectangle;
    edtTitle: TEdit;
    Rectangle3: TRectangle;
    layoutDescription: TLayout;
    Rectangle5: TRectangle;
    Rectangle7: TRectangle;
    imgRecipe: TImage;
    imgRecipeCamera: TImage;
    Rectangle9: TRectangle;
    layoutCategory: TLayout;
    Rectangle11: TRectangle;
    Text3: TText;
    cboPerson: TComboBox;
    txtPerson: TText;
    cboDifficult: TComboBox;
    txtDifficult: TText;
    cboTime: TComboBox;
    txtTime: TText;
    layoutStepBody: TLayout;
    layoutStepTemp: TLayout;
    Memo2: TMemo;
    Rectangle2: TRectangle;
    Image2: TImage;
    Image6: TImage;
    Text9: TText;
    recBody: TRectangle;
    layoutBottom: TLayout;
    imgAddStep: TImage;
    Image3: TImage;
    imgMoveStep: TImage;
    Line1: TLine;
    Text5: TText;
    imgDeleteStep: TImage;
    Layout6: TLayout;
    txtEditIngredient: TText;
    Layout7: TLayout;
    memDescription: TMemo;
    Layout8: TLayout;
    Rectangle14: TRectangle;
    imgDeleteRecipeImage: TImage;
    Image13: TImage;
    ImageList: TImageList;
    txtTimer1: TText;
    Layout11: TLayout;
    Layout16: TLayout;
    Rectangle16: TRectangle;
    Edit5: TEdit;
    Rectangle17: TRectangle;
    Edit6: TEdit;
    Layout19: TLayout;
    imgAddIngredient2: TImage;
    recHeader: TRectangle;
    layoutBackButton: TLayout;
    imgBack: TImage;
    Text8: TText;
    cboUnit: TComboBox;
    Rectangle1: TRectangle;
    edtUnit: TEdit;
    recBackground: TRectangle;
    layoutMenu: TLayout;
    Rectangle6: TRectangle;
    Image19: TImage;
    txtMenuAddIngredient: TText;
    Rectangle10: TRectangle;
    Image20: TImage;
    txtMenuAddRecipe: TText;
    Rectangle18: TRectangle;
    Image21: TImage;
    txtMenuAddTimer: TText;
    Rectangle20: TRectangle;
    Image22: TImage;
    txtMenuAddSeasoning: TText;
    recTimer: TRectangle;
    Rectangle22: TRectangle;
    Rectangle23: TRectangle;
    Rectangle24: TRectangle;
    Text15: TText;
    Text16: TText;
    Text17: TText;
    Text18: TText;
    Text19: TText;
    numHour: TNumberBox;
    numMin: TNumberBox;
    numSec: TNumberBox;
    btnTimerOK: TSpeedButton;
    Layout21: TLayout;
    Rectangle21: TRectangle;
    Edit7: TEdit;
    Rectangle25: TRectangle;
    Edit8: TEdit;
    Rectangle19: TRectangle;
    Image16: TImage;
    Image17: TImage;
    Text7: TText;
    Layout17: TLayout;
    Rectangle26: TRectangle;
    Edit9: TEdit;
    Rectangle27: TRectangle;
    Edit10: TEdit;
    Rectangle28: TRectangle;
    ComboBox1: TComboBox;
    Edit11: TEdit;
    Image8: TImage;
    Text6: TText;
    Image7: TImage;
    Image10: TImage;
    Image14: TImage;
    Layout1: TLayout;
    Rectangle15: TRectangle;
    Edit4: TEdit;
    Image18: TImage;
    Text11: TText;
    btnAddStep: TSpeedButton;
    Image1: TImage;
    layoutTop: TLayout;
    txtDone: TText;
    recPicture: TRectangle;
    Line2: TLine;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    btnGetPictureFromCamera: TButton;
    btnGetPictureFromGallery: TButton;
    imgRecipeOrigin: TImage;
    recWhite: TRectangle;
    imgGrab: TImage;
    GlowEffect1: TGlowEffect;
    layoutScrollBottom: TLayout;
    imgRecipeRectangle: TImage;
    Rectangle8: TRectangle;
    Edit1: TEdit;
    Circle1: TCircle;
    Circle2: TCircle;
    Layout2: TLayout;
    procedure FormShow(Sender: TObject);
    procedure layoutBackButtonClick(Sender: TObject);
    procedure cboPersonChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtTitleClick(Sender: TObject);
    procedure edtTitleExit(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure cboUnitChange(Sender: TObject);
    procedure edtUnitExit(Sender: TObject);
    procedure cboUnitClosePopup(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure recBackgroundClick(Sender: TObject);
    procedure btnTimerOKClick(Sender: TObject);
    procedure btnAddStepClick(Sender: TObject);
    procedure ReAlignLayoutStepBody;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtTimer1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure TakePhotoFromCameraAction1DidCancelTaking;
    procedure TakePhotoFromLibraryAction1DidCancelTaking;
    procedure imgRecipeTap(Sender: TObject; const Point: TPointF);
    procedure imgDeleteRecipeImageTap(Sender: TObject; const Point: TPointF);
    procedure lbCategoryTap(Sender: TObject; const Point: TPointF);
    procedure txtDoneClick(Sender: TObject);
    procedure txtMenuAddIngredientClick(Sender: TObject);
    procedure imgRecipePaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure imgMoveStepClick(Sender: TObject);
  private
    { Private declarations }
    FRecipe: TRecipeInfo;

    FSelectedStepNo: integer; // 선택된 Step Number를 기록한다
    FSelectedTimerText: TText; // 생성된 최근이 Timer Text를 timer 입력을 위하여 저장한다

    FSelectedImage: TImage; // 카메라에서 가져오는 이미지를 저장할 Control

    FControlNeedFocusing: TControl;

    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    FKeyboardShown: Boolean;

    FOldViewPosition: TPointF;
//    FOldControl: TControl;

    procedure CalcContentBoundsProc(Sender: TObject;
                                    var ContentBounds: TRectF);
    function GetUnitString(str: string): string;
    procedure RestorePosition;
    procedure UpdateKBBounds;
    procedure ShowAddIngredientMenu(aVisible: Boolean);
    procedure ShowTimerInput(aVisible: Boolean);
    procedure ShowPictureInput(aVisible: Boolean; R: TRectF);
    procedure CallbackMyRecipeListResult(const aResultList: TStringList);
    procedure ClearControls;
    procedure AddStep(aParent: TLayout; Serial: LargeInt);
    procedure AddIngredient(step: TStepInfo; it: TIngredientType;
      aIngredientTable: TFDMemTable; aRecipeTitle: string='');
    procedure GetPicture(bmp: TBitmap);
    function GetPictureCameraImage(Image: TImage): TImage;
    function GetPictureDeleteImage(Image: TImage): TImage;
    function GetPictureOriginImage(Image: TImage): TImage;
    function GetPictureRectangleImage(Image: TImage): TImage;
    function CheckInputValid: Boolean;
    procedure LoadRecipeInfo;
    procedure SaveRecipe(isPublished: Boolean);

    // Events
    procedure OnTimerClick(Sender: TObject);
    procedure OnAddIngredientTap(Sender: TObject; const Point: TPointF);
    procedure OnUnitEditExit(Sender: TObject);
    procedure OnUnitComboChange(Sender: TObject);
    procedure OnUnitComboclosePopup(Sender: TObject);

    procedure OnStepPictureTap(Sender: TObject; const Point: TPointF);
    procedure OnDeleteStepImageTap(Sender: TObject; const Point: TPointF);

    procedure OnEditClick(Sender: TObject);
    procedure OnEditExit(Sender: TObject);
    procedure OnEditTap(Sender: TObject; const Point: TPointF);

    procedure OnDeleteStepClick(Sender: TObject);

    procedure OnCallbackDragNDrop(const AResultList: TStringList=nil);

    procedure OnEditIngredientTap(Sender: TObject; const Point: TPointF);
    function GetRecipeSerial: LargeInt;
    procedure SetRecipeSerial(const Value: LargeInt);
  public
    { Public declarations }
    procedure UpdateCategory;
  published
    property RecipeSerial: LargeInt read GetRecipeSerial write SetRecipeSerial;
  end;

  function GetRectString(aRect: TRectF): string;
  function GetPointString(aPoint: TPointF): string;
var
  frmRecipeEditor: TfrmRecipeEditor;

implementation
uses cookplay.statusBar, uRecipeCategory, ClientModuleUnit,
  System.Math, uList, cookplay.S3, uListDragNDrop, uScaleView;
{$R *.fmx}

procedure TfrmRecipeEditor.GetPicture(bmp: TBitmap);
var
  cameraImage, deleteImage, originImage, rectangleImage: TImage;
  loadedImage: TImage;
begin
  ShowPictureInput(False, TRectF.Create(0,0,0,0));

  loadedImage := TImage.Create(self);
  loadedImage.Bitmap.Assign(bmp);

  cameraImage := GetPictureCameraImage(FSelectedImage);
  deleteImage := GetPictureDeleteImage(FSelectedImage);
  originImage := GetPictureOriginImage(FSelectedImage);
  rectangleImage := GetPictureRectangleImage(FSelectedImage);

  // origin
  frmS3.CropImageToJPEG(loadedImage, originImage, Point(loadedImage.Bitmap.Width, loadedImage.Bitmap.Height));
  // Square
  frmS3.CropImageToJPEG(loadedImage, FSelectedImage, SizeSequre);
  // Rectangle
  frmS3.CropImageToJPEG(loadedImage, rectangleImage, SizeRectangle);

  FSelectedImage.TagString := NEW_PICTURE; // TagString 이 ''이면 새로운 것 아니면 S3에 있는 이미지

  if Assigned(cameraImage) then cameraImage.Visible := False;
  if Assigned(deleteImage) then deleteImage.Visible := True;

  loadedImage.DisposeOf;
end;

function TfrmRecipeEditor.GetPictureCameraImage(Image: TImage): TImage;
var
  i: integer;
begin
  result := nil;

  for i := 0 to Image.ControlsCount-1 do
    if (Image.Controls[i] is TImage) and (TImage(Image.Controls[i]).Align = TAlignLayout.Center) then
    begin
      result := TImage(Image.Controls[i]);
      break;
    end;
end;

function TfrmRecipeEditor.GetPictureDeleteImage(Image: TImage): TImage;
var
  i: integer;
begin
  result := nil;

  for i := 0 to Image.ControlsCount-1 do
    if (Image.Controls[i] is TImage) and (TImage(Image.Controls[i]).Width = 30) then
    begin
      result := TImage(Image.Controls[i]);
      break;
    end;
end;

function TfrmRecipeEditor.GetPictureOriginImage(Image: TImage): TImage;
var
  i: integer;
begin
  result := nil;

  for i := 0 to Image.ControlsCount-1 do
    if (Image.Controls[i] is TImage) and (TImage(Image.Controls[i]).Width = 20) then
    begin
      result := TImage(Image.Controls[i]);
      break;
    end;
end;

function TfrmRecipeEditor.GetPictureRectangleImage(Image: TImage): TImage;
var
  i: integer;
begin
  result := nil;

  for i := 0 to Image.ControlsCount-1 do
    if (Image.Controls[i] is TImage) and (TImage(Image.Controls[i]).Width = 15) then
    begin
      result := TImage(Image.Controls[i]);
      break;
    end;
end;

function TfrmRecipeEditor.GetRecipeSerial: LargeInt;
begin
  if Assigned(FRecipe) then
    result := FRecipe.Serial
  else
    result := -1;
end;

function TfrmRecipeEditor.GetUnitString(str: string): string;
var
  n: integer;
begin
  n := pos('(', str);
  if n > 0 then
    result := copy(str, 1, n-1)
  else
    result := str;
end;

procedure TfrmRecipeEditor.imgMoveStepClick(Sender: TObject);
var
  strList: TStringList;
  i: integer;
begin
  if FRecipe.Steps.Count > 0 then
  begin
    strList := TStringList.Create;

    for i := 0 to FRecipe.Steps.Count-1 do
      strList.Add('STEP ' + inttostr(i+1) + ' : ' + FRecipe.GetStep(i).memoDescription.Text);

    frmListDragNDrop.Init(strList, OnCallBackDragNDrop);
    frmListDragNDrop.Show;
  end;
end;

procedure TfrmRecipeEditor.CalcContentBoundsProc(Sender: TObject;
  var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
                                2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TfrmRecipeEditor.cboPersonChange(Sender: TObject);
begin
  txtPerson.Visible := (cboPerson.ItemIndex = -1);
  txtTime.Visible := (cboTime.ItemIndex = -1);
  txtDifficult.Visible := (cboDifficult.ItemIndex = -1);
end;

procedure TfrmRecipeEditor.cboUnitChange(Sender: TObject);
begin
  edtUnit.HitTest := False;

  if cboUnit.ItemIndex = -1 then
    edtUnit.Text := ''
  else if cboUnit.ItemIndex <> cboUnit.Items.Count-1 then
    edtUnit.Text := GetUnitString(cboUnit.Selected.Text);
end;

procedure TfrmRecipeEditor.cboUnitClosePopup(Sender: TObject);
begin
  if cboUnit.ItemIndex = cboUnit.Items.Count-1 then
  begin
    edtUnit.HitTest := True;
    edtUnit.SetFocus;
    self.FormFocusChanged(self);
  end;
end;

function TfrmRecipeEditor.CheckInputValid: Boolean;
  procedure ErrMessage(msg: string; aControl: TControl; KeyboardShown: Boolean; var RetVal: Boolean);
  begin
    MessageDlg(msg, TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK], 0,
      procedure(const AResult: TModalResult)
      begin
        if Assigned(aControl) then
        begin
          aControl.OnClick(aControl);
          if KeyboardShown then
            ShowVirtualKeyboard(aControl)
          else
            HideVirtualKeyboard;
        end;
      end
    );
    RetVal := False;
  end;
var
  nStepNo, nIngredientNo: integer;
  AStep: TStepInfo;
  AIngredient: TIngredientInfo;
  fvalue: Extended;
begin
  FRecipe.Sort; // Step 과 Ingredient를 Sorting 한다.

  nStepNo := 0;
  nIngredientNo := 0;

  result := True;
  try
    if edtTitle.Text.Trim = '' then
      ErrMessage('제목을 입력해 주세요!', edtTitle, true, result)
    else if memDescription.Text.Trim = '' then
      ErrMessage('요리소개를 입력해 주세요!', memDescription, true, result)
    else if imgRecipe.Bitmap.IsEmpty then
      ErrMessage('요리소개 사진을 입력해 주세요!', memDescription, false, result)
    else if (cboPerson.ItemIndex = -1) then
      ErrMessage('요리정보-''인원''을 선택해 주세요!', nil, false, result)
    else if (cboTime.ItemIndex = -1) then
      ErrMessage('요리정보-''시간''을 선택해 주세요!', nil, false, result)
    else if (cboDifficult.ItemIndex = -1) then
      ErrMessage('요리정보-''난이도''를 선택해 주세요!', nil, false, result)
    else if FRecipe.Steps.Count = 0 then
      ErrMessage('Step을 입력해 주세요!', nil, true, result)
    else
    begin
      for nStepNo := 0 to FRecipe.Steps.Count-1 do
      begin
        aStep := FRecipe.GetStep(nStepNo);

        if aStep.memoDescription.Text.IsEmpty then
          ErrMessage('STEP 설명을 입력해 주세요!', aStep.memoDescription, true, result)
        else
        begin
          // Ingredient Check
          for nIngredientNo := 0 to FRecipe.GetStep(nStepNo).Ingredients.Count-1 do
          begin
            aIngredient := FRecipe.GetIngredient(nStepNo, nIngredientNo);

            if AIngredient.IngredientType in [itIngredient, itSeasoning, itRecipeLink] then
            begin
              // 재료이름, 용량, 단위가 모두 입력이 안된 경우 Skip한다 (입력을 안했거나, 전자저울 무게값만 있거나)
              if (AIngredient.edtName.Text.Trim = '') and (AIngredient.edtQuantity.Text.Trim = '') and (AIngredient.edtUnit.Text.Trim = '') then
                continue
              // 재료이름, 용량, 단위 중 한가지로도 입력이 되었다면
              else
              begin
                // 재료이름을 체크한다
                if AIngredient.edtName.Text.Trim = '' then
                begin
                  ErrMessage('재료의 이름을 입력해 주세요!', AIngredient.edtName, true, result);
                  break;
                end
                // 용량을 체크한다
                else if AIngredient.edtQuantity.Text.Trim = '' then
                begin
                  ErrMessage('용량을 입력해 주세요!', AIngredient.edtQuantity, true, result);
                  break;
                end
                else if not TryStrtoFloat(aIngredient.edtQuantity.Text.Trim, fValue) then
                begin
                  ErrMessage('용량은 소수점 한자리 까지 입력이 가능합니다!' +#13#10 + '예) 1, 2, 1.5, 3.2 ...', aIngredient.edtQuantity, true, result);
                  break;
                end
                // 단위를 체크한다
                else if AIngredient.edtUnit.Text.Trim = '' then
                begin
                  if aIngredient.edtName.IsFocused then
                    ErrMessage('단위를 선택해 주십시오', AIngredient.edtName, False, result)
                  else
                    ErrMessage('단위를 선택해 주십시오', AIngredient.edtQuantity, False, result);
                  break;
                end;
              end;
            end
            else if AIngredient.IngredientType = itTime then
            begin
              // 시간 설명을 체크한다
              if AIngredient.edtName.Text.Trim = '' then
              begin
                ErrMessage('시간에 대한 설명을 입력해 주세요!', AIngredient.edtName, true, result);
                break;
              end
              else if (AIngredient.edtName.Text.Trim <> '') and (AIngredient.txtTimer.Text.Trim = INIT_TIME_STR) then
              begin
                ErrMessage('시간을 설정해 주십시오!', AIngredient.edtName, true, result);
                break;
              end;
            end;
          end;
        end;
      end;
    end
  except
    on E:Exception do
    begin
      ShowMessage(E.Message);
      result := False;
    end;
  end;
end;

procedure TfrmRecipeEditor.ClearControls;
var
  i: integer;
begin
  imgRecipeOrigin.Visible := False; // Recipe Image 원본
  imgRecipeOrigin.Bitmap.Assign(nil);

  imgRecipeRectangle.Visible := False;
  imgRecipeRectangle.Bitmap.Assign(nil);

  scrollRecipe.ViewportPosition := TPointF.Create(0,0);

  edtTitle.Text := '';

  ShowAddIngredientMenu(False);
  ShowTimerInput(False);
  ShowPictureInput(False, TRectF.Create(0,0,0,0));

  memDescription.Lines.Clear;
  imgRecipe.Bitmap.Assign(nil);
  imgRecipe.TagString := '';

  imgRecipeCamera.Visible := True;
  imgDeleteRecipeImage.Visible := False;

  // Control Clear
  cboPerson.ItemIndex := 0; // 1인분
  cboTime.ItemIndex := 5; // 1시간 이내
  cboDifficult.ItemIndex := 0; // 하

  // Category를 만든다, 만들어져 있으면 Clear 한다
  frmRecipeCategory.CreateCategories;

  // Category를 세팅한다 - DB 연결되면 frmRecipeCategory 에 세팅

  // Category를 레시피 하면에 표시한다
  UpdateCategory;
end;

procedure TfrmRecipeEditor.edtTitleClick(Sender: TObject);
begin
  TControl(Sender).Canfocus := True;
  TControl(Sender).SetFocus;
end;

procedure TfrmRecipeEditor.edtTitleExit(Sender: TObject);
begin
  TControl(Sender).Canfocus := False;
end;

procedure TfrmRecipeEditor.edtUnitExit(Sender: TObject);
begin
  edtUnit.HitTest := False;
end;

procedure TfrmRecipeEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ShowAddIngredientMenu(False);
  // Recipe를 초기화 한다
  FRecipe.Clear;
end;

procedure TfrmRecipeEditor.FormCreate(Sender: TObject);
begin
  FRecipe := TRecipeInfo.Create;
  FRecipe.Steps := TStringList.Create;
  FRecipe.DeletedSteps := TStringList.Create;
  FRecipe.DeletedImageQue := TStringList.Create;
  FRecipe.AddedImageQue := TStringList.Create;

  // Recipe를 초기화 한다
  FRecipe.Clear;

  FOldViewPosition := TPointF.Create(0,0); // Scroll Position to 0
  FKeyboardShown := False;

  layoutStepTemp.DisposeOf;

  scrollRecipe.OnCalcContentBounds := CalcContentBoundsProc;
end;

procedure TfrmRecipeEditor.FormFocusChanged(Sender: TObject);
begin
//  if FKeyboardShown then
  if IsVirtualKeyShown then
  begin
    FOldViewPosition := scrollRecipe.ViewportPosition;
    UpdateKBBounds;
  end;
end;

procedure TfrmRecipeEditor.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if IsBackKey(Key) then
  begin
    if layoutMenu.Position.Y < ClientHeight then
      ShowAddIngredientMenu(False)
    else if recTimer.Opacity = 1 then
      ShowTimerInput(False)
    else if recPicture.Opacity = 1 then
      ShowPictureInput(False, TRectF.Create(0,0,0,0))
    else
      layoutBackButton.OnClick(layoutBackButton);
  end;
end;

procedure TfrmRecipeEditor.FormResize(Sender: TObject);
begin
  recBackground.Position.X := 0;
  recBackground.Position.Y := 0;
  recBackground.Width := ClientWidth;
  recBackground.Height := ClientHeight;
  recBackground.Opacity := 0;
  recBackground.HitTest := False;

  layoutMenu.Width := ClientWidth+2;
  layoutMenu.Height := 224;

  layoutMenu.Position.X := 0;
  layoutMenu.Position.Y := ClientHeight;

  FSelectedTimerText := nil;
  recTimer.Opacity := 0;
  recPicture.Opacity := 0;
end;

procedure TfrmRecipeEditor.FormShow(Sender: TObject);
var
  i: integer;
begin
  // 재료 단위를 가져온다
  CM.GetIngredientUnit(cboUnit);

  FSelectedStepNo := -1;

  // Input 에 control일 갈 때 화면 스크롤을 위한 layout
  layoutScrollBottom.Height := 30;

  // Status Bar 색을 바꾼다
  Fill.Color := GetColor(COLOR_BACKGROUND);
  StatusBarSetColor(Fill.Color);

  recTimer.Align := TAlignLayout.Center;
  recTimer.Margins.Top := -65; // 가상 키보드에 가리지 않게 하기 위하여

  // drag & drop을 위한 control 세팅
  recWhite.Visible := False;
  imgGrab.Visible := False;

  // 인원수 세팅
  for i := 0 to cboPerson.Items.Count-1 do
  begin
    cboPerson.ListBox.ListItems[i].Font.Size := 16;
    cboPerson.ListBox.ListItems[i].StyledSettings :=  cboPerson.ListBox.ListItems[i].StyledSettings - [TStyledSetting.Size];
  end;
  // 시간 세팅
  for i := 0 to cboTime.Items.Count-1 do
  begin
    cboTime.ListBox.ListItems[i].Font.Size := 16;
    cboTime.ListBox.ListItems[i].StyledSettings :=  cboTime.ListBox.ListItems[i].StyledSettings - [TStyledSetting.Size];
  end;
  // 난이도 세팅
  for i := 0 to cboDifficult.Items.Count-1 do
  begin
    cboDifficult.ListBox.ListItems[i].Font.Size := 16;
    cboDifficult.ListBox.ListItems[i].StyledSettings :=  cboDifficult.ListBox.ListItems[i].StyledSettings - [TStyledSetting.Size];
  end;

  CM.GetRecipeInfo(cboPerson, 'Servings');
  CM.GetRecipeInfo(cboTime, 'MakingTime');
  CM.GetRecipeInfo(cboDifficult, 'MakingLevel');

  // 화면에 세팅된 이전 값들을 Clear 한다
  ClearControls;

  // 신규일 경우 step 1개를 추가 한다
  if FRecipe.Serial = NEW_RECIPE_SERIAL then
    AddStep(layoutStepBody, NEW_STEP_SERIAL) // 새로운 Step, Step Serial은 -1로 세팅
  // Editing일 경우 기존 값을 세팅한다
  else
    LoadRecipeInfo;

  // scroll을 처음으로 이동
  scrollRecipe.ViewportPosition := TPointf.Create(0,0);
end;

procedure TfrmRecipeEditor.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  layoutScrollBottom.Height := 30;

  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;

  RestorePosition;

  FKeyboardShown := False;
end;

procedure TfrmRecipeEditor.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
//  if not FKeyboardShown then
//  begin
    FKeyboardShown := True;

    FOldViewPosition := scrollRecipe.ViewportPosition;

    FKBBounds := TRectF.Create(Bounds);
    showmessage('Bounds Top / Bottom / Height = ' + FKBBounds.Top.ToString + ' / ' + FKBBounds.Bottom.ToString + ' / ' + FKBBounds.Height.ToString);
    // 가상키보드의 Form에서의 위치를 가져온다
    FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
    FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
    UpdateKBBounds;
//  end;
end;

procedure TfrmRecipeEditor.imgDeleteRecipeImageTap(Sender: TObject;
  const Point: TPointF);
begin
  MessageDlg( '이미지를 삭제하시겠습니까?',
             TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult = mrYES then
    begin
      imgRecipe.Bitmap.Assign(nil);
      imgRecipe.TagString := '';
      imgDeleteRecipeImage.Visible := False;
      imgrecipeCamera.Visible := True;
    end;
  end);
end;

procedure TfrmRecipeEditor.imgRecipePaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin
  if (TImage(Sender).Tag = Ord(TPictureVisibleState.pvInvisible)) and (TImage(Sender).TagString.Trim <> '') then
  begin
    frmS3.LoadImageFromS3(BUCKET_RECIPE, TImage(Sender).TagString, TImage(Sender).Bitmap);
    TImage(Sender).Tag := Ord(TPictureVisibleState.pvVisible);
  end;
end;

procedure TfrmRecipeEditor.imgRecipeTap(Sender: TObject; const Point: TPointF);
var
  image: TImage;
begin
  if Sender is TImage then
  begin
    image := TImage(Sender);

    FSelectedImage := image;
    ShowPictureInput(True, image.AbsoluteRect);
  end;
end;

procedure TfrmRecipeEditor.layoutBackButtonClick(Sender: TObject);
begin
  MessageDlg( '작성중인 레시피를 저장하고 종료하시겠습니까?',
             TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult = mrYES then
    begin
      if CheckInputValid then
        SaveRecipe(False);
    end
    else if AResult = mrNo then
      Close;
  end);
end;

procedure TfrmRecipeEditor.lbCategoryTap(Sender: TObject; const Point: TPointF);
begin
  frmRecipeCategory.Show;
end;

procedure TfrmRecipeEditor.LoadRecipeInfo;
var
  sSquareImage: string;
  aStep: TStepInfo;
  aIngredient: TIngredientInfo;
  aIngredientType: TIngredientType;
begin
  if CM.memMyRecipe.Locate('Serial', FRecipe.Serial, []) then
  begin
    edtTitle.Text := CM.memMyRecipe.FieldByName('Title').AsWideString;

    // Category를 세팅한다
    frmRecipeCategory.SetCategorySelected(CM.memMyRecipe.FieldByName('Category').AsString);
    // Category를 레시피 화면에 표시한다
    UpdateCategory;

    memDescription.TextSettings.Font.Size := 16;
    memDescription.StyledSettings :=  memDescription.StyledSettings - [TStyledSetting.Size];
    memDescription.Lines.Text := CM.memMyRecipe.FieldByName('Description').AsWideString;

    sSquareImage := CM.memMyRecipe.FieldByName('PictureSquare').AsWideString;

    imgRecipeCamera.Visible := (sSquareImage.Trim = '');
    imgDeleteRecipeImage.Visible := not (sSquareImage.Trim = '');

    if sSquareImage.Trim <> '' then
    begin
      try
//        frmS3.LoadImageFromS3(BUCKET_RECIPE, sSquareImage, imgRecipe);
        imgRecipe.TagString := sSquareImage;
        imgRecipe.Tag := Ord(TPictureVisibleState.pvInvisible);
      except
      end;
    end;

    cboPerson.ItemIndex := cboPerson.Items.IndexOf( CM.GetRecipeInfoName('Servings', CM.memMyRecipe.FieldByName('Servings').AsInteger) );
    cboTime.ItemIndex := cboTime.Items.IndexOf( CM.GetRecipeInfoName('MakingTime', CM.memMyRecipe.FieldByName('MakingTime').AsInteger) );
    cboDifficult.ItemIndex := cboDifficult.Items.IndexOf( CM.GetRecipeInfoName('MakingLevel', CM.memMyRecipe.FieldByName('MakingLevel').AsInteger) );

    frmRecipeCategory.SetCategorySelected(cM.memMyRecipe.FieldByName('Category').AsString);
    UpdateCategory;

    layoutStepBody.BeginUpdate;

    CM.memMyMethod.First;
    while not CM.memMyMethod.Eof do
    begin
      if CM.memMyMethod.FieldByName('Recipe_Serial').AsLargeInt = FRecipe.Serial then
      begin
        AddStep(layoutStepBody, CM.memMyMethod.FieldByName('Serial').AsLargeInt); // 새로운 Step, Step Serial은 -1로 세팅

        // Step Setting
        aStep := FRecipe.GetStep(FRecipe.Steps.Count-1);
        // Step Description
        aStep.memoDescription.TextSettings.WordWrap := True;
        aStep.memoDescription.TextSettings.Font.Size := 16;
        aStep.memoDescription.StyledSettings :=  aStep.memoDescription.StyledSettings - [TStyledSetting.Size];

        aStep.memoDescription.Lines.Text := CM.memMyMethod.FieldByName('Description').AsWideString;
        // Step Image
        sSquareImage := CM.memMyMethod.FieldByName('PictureSquare').AsWideString;

        aStep.imgStepCamera.Visible := (sSquareImage.Trim = '');
        aStep.imgDeleteStepImage.Visible := not (sSquareImage.Trim = '');

        if sSquareImage.trim <> '' then
        begin
          try
//            frmS3.LoadImageFromS3(BUCKET_RECIPE, sSquareImage, aStep.imgStep);
            aStep.imgStep.TagString := sSquareImage;
            aStep.imgStep.Tag := Ord(TPictureVisibleState.pvInvisible);
          except
          end;
        end;

        // Ingredient Setting
        if Assigned(aStep) then
        begin
          CM.memMyIngredient.First;
          while not CM.memMyIngredient.Eof do
          begin
            if CM.memMyIngredient.FieldByName('RecipeMethod_Serial').AsLargeInt = aStep.Serial then
            begin
              AddIngredient(aStep, TIngredientType(CM.memMyIngredient.FieldByName('ItemType').AsInteger), CM.memMyIngredient);

              // Resize High of the layoutStep
              aStep.layoutStep.Height := aStep.layoutStepHead.Height + aStep.txtStepIngredientTitle.Height +
                  aStep.layoutIngredient.Height + aStep.layoutAddIngredient.Height;
            end;

            CM.memMyIngredient.Next;
          end;
        end;
      end;

      CM.memMyMethod.Next;
    end;

    layoutStepBody.EndUpdate;
  end;

  ReAlignLayoutStepBody;
end;

procedure TfrmRecipeEditor.OnAddIngredientTap(Sender: TObject;
  const Point: TPointF);
begin
  if Sender is TImage then
  begin
    HideVirtualKeyboard;
    FSelectedStepNo := TLayout(TLayout(TImage(Sender).Parent).Parent).Tag;
    ShowAddIngredientMenu(True);
  end;
end;

procedure TfrmRecipeEditor.OnCallbackDragNDrop(const AResultList: TStringList);
var
  i, x, y: integer;
  str: string;
begin
  if FRecipe.Steps.Count = 0 then
    Exit;

  str := '';
  // Copy Seq
  for i := 0 to AResultList.Count-1 do
    FRecipe.GetStep(AResultList[i].ToInteger).No :=  i + 1;

  // step sorting
  for x := 0 to FRecipe.Steps.Count-1 do
    for y := x+1 to FRecipe.Steps.Count-1 do
      if FRecipe.GetStep(x).No > FRecipe.GetStep(y).No  then
        FRecipe.Steps.Exchange(x, y);

  ReAlignLayoutStepBody;
end;

procedure TfrmRecipeEditor.OnDeleteStepClick(Sender: TObject);
var
  aStep: TStepInfo;
  AStepLayout: TLayout;
  StepNo: Integer;
begin
  if FRecipe.Steps.Count > 0 then
  begin
    MessageDlg( '해당 STEP을 삭제하시겠습니까?',
               TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
      procedure(const AResult: TModalResult)
      begin
        if aResult = mrYES then
        begin
          aStepLayout := TLayout(Sender).Parent.Parent.Parent as TLayout;

          StepNo := FRecipe.GetStepNo(aStepLayout);
          aStep := FRecipe.GetStep(StepNo);

          layoutStepBody.BeginUpdate;

          FRecipe.Steps.Delete(StepNo);

          if aStep.Serial = NEW_STEP_SERIAL then
          begin
            aStep.layoutStep.DisposeOf;
            aStep.DisposeOf;
          end
          else
          begin
            aStep.layoutStep.Parent := nil;
            FRecipe.DeletedSteps.AddObject('', aStep);
          end;

          frmRecipeEditor.ReAlignLayoutStepBody;

          layoutStepBody.EndUpdate;
        end;
      end
    );
  end;
end;

procedure TfrmRecipeEditor.OnDeleteStepImageTap(Sender: TObject;
  const Point: TPointF);
var
  parentImage: TImage;
  cameraImage: TImage;
begin
  MessageDlg( '이미지를 삭제하시겠습니까?',
             TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult = mrYES then
    begin
      parentImage := TImage(TImage(Sender).Parent);
      parentImage.Bitmap.Assign(nil);
      TImage(Sender).Visible := False;

      cameraImage := GetPictureCameraImage(parentImage);
      if Assigned(cameraImage) then
        cameraImage.Visible := True;
    end;
  end);
end;

procedure TfrmRecipeEditor.OnEditClick(Sender: TObject);
begin
  TControl(Sender).Canfocus := True;
  TControl(Sender).SetFocus;
end;

procedure TfrmRecipeEditor.OnEditExit(Sender: TObject);
begin
  TControl(Sender).Canfocus := False;
end;

procedure TfrmRecipeEditor.OnEditIngredientTap(Sender: TObject;
  const Point: TPointF);
begin
  FRecipe.ChangeIngredientEditState(TText(Sender));
end;

procedure TfrmRecipeEditor.OnEditTap(Sender: TObject; const Point: TPointF);
begin
  TControl(Sender).Canfocus := True;
  TControl(Sender).SetFocus;
end;

procedure TfrmRecipeEditor.OnStepPictureTap(Sender: TObject;
  const Point: TPointF);
var
  image: TImage;
begin
  if Sender is TImage then
  begin
    image := TImage(Sender);

    FSelectedImage := image;
    ShowPictureInput(True, image.AbsoluteRect);
  end;
end;

procedure TfrmRecipeEditor.OnTimerClick(Sender: TObject);
begin
  FSelectedTimerText := TText(Sender);
  ShowTimerInput(True);
end;

procedure TfrmRecipeEditor.OnUnitComboChange(Sender: TObject);
var
  i: integer;
  AEdit: TEdit;
begin
  if Sender is TComboBox then
  begin
    for i := 0 to TComboBox(Sender).ControlsCount-1 do
      if TCombobox(Sender).Controls[i] is TEdit then
      begin
        AEdit := TEdit(TCombobox(Sender).Controls[i]);
        break;
      end;

    if Assigned(AEdit) then
    begin
      AEdit.HitTest := False;

      if TComboBox(Sender).ItemIndex = -1 then
        AEdit.Text := ''
      else if TComboBox(Sender).ItemIndex <> TComboBox(Sender).Items.Count-1 then
        AEdit.Text := GetUnitString(TComboBox(Sender).Selected.Text);
    end;
  end;
end;

procedure TfrmRecipeEditor.OnUnitComboclosePopup(Sender: TObject);
var
  i: integer;
  AEdit: TEdit;
begin
  if Sender is TComboBox then
  begin
    for i := 0 to TComboBox(Sender).ControlsCount-1 do
      if TCombobox(Sender).Controls[i] is TEdit then
      begin
        AEdit := TEdit(TCombobox(Sender).Controls[i]);
        break;
      end;

    if Assigned(AEdit) and (TComboBox(Sender).ItemIndex = TComboBox(Sender).Items.Count-1) then
    begin
      AEdit.HitTest := True;
      AEdit.SetFocus;
      self.FormFocusChanged(self);
    end;
  end;
end;

procedure TfrmRecipeEditor.OnUnitEditExit(Sender: TObject);
begin
  if Sender is TEdit then
    TEdit(Sender).HitTest := False;
end;

procedure TfrmRecipeEditor.ReAlignLayoutStepBody;
var
  i, h: integer;
begin
  h := 0;
  for i := 0 to FRecipe.Steps.Count-1 do
  begin
    FRecipe.GetStep(i).txtStepNo.Text := 'STEP ' + IntToStr(i + 1);
    FRecipe.GetStep(i).txtStepIngredientTitle.Text := FRecipe.GetStep(i).txtStepNo.Text + ' 재료/시간';
    FRecipe.GetStep(i).layoutStep.Position.Y := h;
    h := h + Round(TStepInfo(FRecipe.Steps.Objects[i]).layoutStep.Height);
  end;

  layoutStepBody.Height := h + 10;

  recBody.Height := layoutTop.Height + layoutStepBody.Height;

  scrollRecipe.RealignContent;  
end;

//------------------------------------------------------------------------------
// 레시피 리스트 가져오기 위한 List Form 을 Call 할 때 같이 보낸
// Callback 함수이다.
// List Form 에서 레시피 리스트를 선택하면
// aResultList 의 첫번째에 레시피 serial 을 보내준다
//------------------------------------------------------------------------------
procedure TfrmRecipeEditor.CallbackMyRecipeListResult(const aResultList: TStringList);
var
  aStep: TStepInfo;
begin
  // FStepNo 는 각 Step의 재료추가 이미지를 선택했을 때 세팅 된다, 초기값 -1
  if (FSelectedStepNo > 0) and (aResultList.Count > 0) then
  begin
    aStep := TStepInfo(FRecipe.Steps.Objects[FSelectedStepNo-1]);

    CM.memMyRecipe.First;
    while not CM.memMyRecipe.Eof do
    begin
      if CM.memMyRecipe.FieldByName('serial').AsString = aResultList[0] then
      begin
        AddIngredient(aStep, itRecipeLink, nil, CM.memMyRecipe.FieldByName('Title').AsString);
        aStep.layoutStep.Height := aStep.layoutStepHead.Height + aStep.txtStepIngredientTitle.Height +
                                   aStep.layoutIngredient.Height + aStep.layoutAddIngredient.Height;
        ReAlignLayoutStepBody;

        break;
      end;

      CM.memMyRecipe.Next;
    end;  
  end;
  
  ShowAddIngredientMenu(False);    
end;

procedure TfrmRecipeEditor.recBackgroundClick(Sender: TObject);
begin
  ShowAddIngredientMenu(False);
  ShowTimerInput(False);
  ShowPictureInput(False, TRectF.Create(0,0,0,0));
end;

procedure TfrmRecipeEditor.RestorePosition;
begin
//  scrollRecipe.ViewportPosition:= FOldViewPosition;
//  scrollRecipe.RealignContent;

//  FOldControl := nil;
end;

procedure TfrmRecipeEditor.ShowTimerInput(aVisible: Boolean);
  procedure GetHourMinSec(str: string; var h, m, s: integer);
  begin
    try
      if (not str.IsEmpty) and (Length(str)=8) then
      begin
        h := strtoint(copy(str, 1, 2));
        m := strtoint(copy(str, 4, 2));
        s := strtoint(copy(str, 7, 2));
      end;
    except
      h := 0; m := 0; s := 0;
    end;
  end;

var
  h, m, s: integer;
begin
  HideVirtualKeyboard;

  h := 0;
  m := 0;
  s := 0;

  if Assigned(FSelectedTimerText) then
    GetHourMinSec(FSelectedTimerText.Text, h, m, s);

  numHour.Value := h;
  numMin.Value := m;
  numSec.Value := s;

  if aVisible then
  begin
//    if recTimer.Opacity = 0 then
//    begin
      TAnimator.Create.AnimateFloat(recBackground, 'Opacity', 0.3, 0.15);
      recBackground.HitTest := True;

      TAnimator.Create.AnimateFloat(recTimer, 'Opacity', 1, 0);
//    end;
  end
  else
  begin
//    if recTimer.Opacity = 1 then
//    begin
      TAnimator.Create.AnimateFloat(recBackground, 'Opacity', 0, 0.15);
      recBackground.HitTest := False;

      TAnimator.Create.AnimateFloat(recTimer, 'Opacity', 0, 0);
//    end;
  end;

  recTimer.HitTest := aVisible;
  btnTimerOK.HitTest := aVisible;
  numHour.HitTest := aVisible;
  numMin.HitTest := aVisible;
  numSec.HitTest := aVisible;
end;

procedure TfrmRecipeEditor.AddIngredient (step: TStepInfo; it: TIngredientType;
    aIngredientTable: TFDMemTable; aRecipeTitle: string);
var
  aIngredient: TIngredientInfo;
  h, BeforeHeight: integer;
  i: integer;
begin
  aIngredient := TIngredientInfo.Create;

  aIngredient.IngredientType := it;
  aIngredient.ScaleWeight := 0;

  if aIngredientTable <> nil then
  begin
    // 기존의 Serial, Unit, SacleWeight 를 가져온다
    aIngredient.Serial := aIngredientTable.FieldByName('serial').AsLargeInt;
    aIngredient.IngredientItemUnit := TIngredientUnit(aIngredientTable.FieldByName('ItemUnit').AsInteger);
    aIngredient.ScaleWeight :=  aIngredientTable.FieldByName('ItemWeightValue').AsSingle;
    aIngredient.LinkedRecipeSerial := aIngredientTable.FieldByName('LinkedRecipe').AsLargeInt;
  end
  else
  begin
    // 신규일 경우 serial을 신규로 세팅한다.
    aIngredient.Serial := NEW_INGREDIENT_SERIAL;
    aIngredient.LinkedRecipeSerial := -1;
  end;

  BeforeHeight := 0;
  for i := 0 to step.Ingredients.Count-1 do
    BeforeHeight := BeforeHeight + Round(TIngredientInfo(step.Ingredients.Objects[i]).layoutIngredientBody.Height);

  if it = itRecipeLink then
    h := 95
  else
    h := 50;

  step.layoutIngredient.Height := BeforeHeight + h;

  aIngredient.layoutIngredientBody := TLayout.Create(step.layoutIngredient);
  aIngredient.layoutIngredientBody.Parent := step.layoutIngredient;
  aIngredient.layoutIngredientBody.Position.Y := BeforeHeight + 10;
  aIngredient.layoutIngredientBody.Height := h;
  aIngredient.layoutIngredientBody.Align := TAlignLayout.Top;
  aIngredient.layoutIngredientBody.Padding := TBounds.Create(TRectF.Create(0,5,0,5));

  with aIngredient do
  begin
    case it of
      itIngredient, itSeasoning:
        begin
          imgLeft := TImage.Create(layoutIngredientBody);
          imgLeft.Parent := layoutIngredientBody;
          imgLeft.Width := 30;
          imgLeft.Align := TAlignLayout.Left;
          imgLeft.Tag := Ord(itIngredient);
          imgLeft.OnMouseDown := Step.OnDeleteImageMouseDown;

          if it = itIngredient then
            imgLeft.Bitmap := ImageList.Bitmap(TSizeF.Create(60,60), 2)
          else
            imgLeft.Bitmap := ImageList.Bitmap(TSizeF.Create(60,60), 3);

          recNameBody := TRectangle.Create(layoutIngredientBody);
          recNameBody.Parent := layoutIngredientBody;
          recNameBody.Align := TAlignLayout.Client;
          recNameBody.Fill.Color := TAlphaColorRec.Whitesmoke;
          recNameBody.Stroke.Color := COLOR_BOX_ROUND;
          recNameBody.Margins := TBounds.Create(TRectF.Create(5,0,10,0));
          recNameBody.Padding := TBounds.Create(TRectF.Create(3,0,3,0));
          begin
            edtName := TEdit.Create(recNameBody);
            edtName.Parent := recNameBody;
            edtName.StyleLookup := 'Edit2Style1';

            if it = itIngredient then
              edtName.TextPrompt := '예)김치'
            else
              edtName.TextPrompt := '예)후추';

            if aIngredientTable <> nil then
              edtname.Text := aIngredientTable.FieldByName('Title').AsWideString;

            edtName.Align := TAlignLayout.VertCenter;
            edtName.TextSettings.Font.Size := 14;
            edtName.MaxLength := 100;
            edtName.StyledSettings := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];

            edtName.CanFocus := False;
            edtName.OnExit := OnEditExit;
            edtName.OnClick := OnEditClick;
          end;

          recQuantityBody := TRectangle.Create(layoutIngredientBody);
          recQuantityBody.Parent := layoutIngredientBody;
          recQuantityBody.Width := 65;
          recQuantityBody.align := TAlignLayout.Right;
          recQuantityBody.Fill.Color := TAlphaColorRec.Whitesmoke;
          recQuantityBody.Stroke.Color := COLOR_BOX_ROUND;
          recQuantityBody.Margins.Right := 10;
          recQuantityBody.Padding := TBounds.Create(TRectF.Create(3,0,3,0));
          begin
            edtQuantity := TEdit.Create(recQuantityBody);
            edtQuantity.Parent := recQuantityBody;
            edtQuantity.StyleLookup := 'Edit2Style1';
            edtQuantity.TextPrompt := '예)200';
            edtQuantity.TextSettings.Font.Size := 14;
            edtQuantity.Font.Size := 14;
            edtQuantity.Align := TAlignLayout.VertCenter;
            edtQuantity.KeyboardType := TVirtualKeyboardType.PhonePad;
            edtQuantity.StyledSettings := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];

            edtQuantity.CanFocus := False;
            edtQuantity.OnExit := OnEditExit;
            edtQuantity.OnClick := OnEditClick;

            // 기존의 Quantity를 세팅한다
            if aIngredientTable <> nil then
              edtQuantity.Text := aIngredientTable.FieldByName('amount').AsWideString;
          end;

          recUnitBody := TRectangle.Create(layoutIngredientBody);
          recUnitBody.Parent := layoutIngredientBody;
          recUnitBody.Width := 65;
          recUnitBody.Position.X := recQuantityBody.Position.X + 10; // 위치잡기
          recUnitBody.align := TAlignLayout.Right;
          recUnitBody.Fill.Color := TAlphaColorRec.Whitesmoke;
          recUnitBody.Stroke.Color := COLOR_BOX_ROUND;
          recUnitBody.Margins.Right := 5;
          recUnitBody.Padding := TBounds.Create(TRectF.Create(3,0,3,0));
          begin
            cboUnit := TComboBox.Create(recUnitBody);
            cboUnit.Parent := recUnitBody;
            cboUnit.CanFocus := False;
            cboUnit.Align := TAlignLayout.VertCenter;
            cboUnit.StyleLookup := 'cboUnitStyle1';
            CM.GetIngredientUnit(cboUnit);

            cboUnit.OnChange := OnUnitComboChange;
            cboUnit.OnClosePopup := OnUnitComboclosePopup;
            begin
              edtUnit := TEdit.Create(cboUnit);
              edtUnit.Parent := cboUnit;
              edtUnit.HitTest := False;
              edtUnit.TextPrompt := '예)g';
              edtUnit.StyleLookup := 'edtWhitesmokeStyle1';
              edtUnit.TextSettings.Font.Size := 14;
              edtUnit.Align := TAlignLayout.VertCenter;
              edtUnit.StyledSettings := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
              edtUnit.OnExit := OnUnitEditExit;

              // 기존의 Unit 값으로 세팅한다
              if aIngredientTable <> nil then
                edtUnit.Text := aIngredientTable.FieldByName('Unit').AsWideString;
            end;
          end;

          imgScale := TImage.Create(layoutIngredientBody);
          imgScale.Parent := layoutIngredientBody;
          imgScale.Width := 40;
          imgScale.Position.X := recUnitBody.Position.X + 30; // 위치잡기
          imgScale.Align := TAlignLayout.Right;
          imgScale.Bitmap := ImageList.Bitmap(TSizeF.Create(80,80), 8);

          imgScale.Tag := Ord(itIngredient);
          imgScale.OnMouseDown := Step.OnScaleImageMouseDown; // 재료 수정
          imgScale.OnTap := Step.OnScaleImageTap; // 전자저울 연결
          begin
            txtScale := TText.Create(imgScale);
            txtScale.parent := imgScale;
            txtScale.Align := TAlignLayout.Client;
            txtScale.TextSettings.FontColor := COLOR_BACKGROUND;
            txtScale.Opacity := 0;
            txtScale.HitTest := False;
          end;

          // 저울무게값이 있으면, 세팅한다
          if (aIngredient.ScaleWeight > 0) then
          begin
            txtScale.Text := aIngredient.ScaleWeight.ToString;
            txtScale.Opacity := 1;
            imgScale.Bitmap.Assign(nil);
          end;
        end;
      itTime:
        begin
          imgLeft := TImage.Create(layoutIngredientBody);
          imgLeft.Parent := layoutIngredientBody;
          imgLeft.Width := 30;
          imgLeft.Align := TAlignLayout.Left;
          imgLeft.Tag := Ord(itTime);
          imgLeft.OnMouseDown := Step.OnDeleteImageMouseDown;

          imgLeft.Bitmap := ImageList.Bitmap(TSizeF.Create(60,60), 4);

          recNameBody := TRectangle.Create(layoutIngredientBody);
          recNameBody.Parent := layoutIngredientBody;
          recNameBody.Align := TAlignLayout.Client;
          recNameBody.Fill.Color := TAlphaColorRec.Whitesmoke;
          recNameBody.Stroke.Color := COLOR_BOX_ROUND;
          recNameBody.Margins := TBounds.Create(TRectF.Create(5,0,10,0));
          recNameBody.Padding := TBounds.Create(TRectF.Create(3,0,3,0));
          begin
            edtName := TEdit.Create(recNameBody);
            edtName.Parent := recNameBody;
            edtName.StyleLookup := 'Edit2Style1';
            edtName.TextPrompt := '예)굽기';

            if aIngredientTable <> nil then
              edtname.Text := aIngredientTable.FieldByName('Title').AsWideString;

            edtName.Align := TAlignLayout.VertCenter;
            edtName.TextSettings.Font.Size := 14;
            edtName.MaxLength := 100;
            edtName.StyledSettings := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];

            edtName.CanFocus := False;
            edtName.OnExit := OnEditExit;
            edtName.OnClick := OnEditClick;
          end;

          recTimerBody := TRectangle.Create(layoutIngredientBody);
          recTimerBody.Parent := layoutIngredientBody;
          recTimerBody.Width := 140 + 40;
          recTimerBody.Align := TAlignLayout.Right;
          recTimerBody.Fill.Color := TAlphaColorRec.Whitesmoke;
          recTimerBody.Stroke.Color := COLOR_BOX_ROUND;
          recTimerBody.Margins := TBounds.Create(TRectF.Create(0,0,5,0));
          recTimerBody.Padding := TBounds.Create(TRectF.Create(5,0,3,0));
          begin
            txtTimer := TText.Create(recTimerBody);
            txtTimer.Parent := recTimerBody;

            if aIngredientTable <> nil then
              txtTimer.Text := aIngredientTable.FieldByName('ItemTimeValue').AsWideString
            else
              txtTimer.Text := INIT_TIME_STR;

            txtTimer.Align := TAlignLayout.Client;
            txtTimer.TextSettings.Font.Size := 14;
            txtTimer.TextSettings.HorzAlign := TTextAlign.Leading;

            txtTimer.OnClick := OnTimerClick;
          end;

          imgScale := TImage.Create(layoutIngredientBody);
          imgScale.Parent := layoutIngredientBody;
          imgScale.Position.X := ClientWidth;
          imgScale.Width := 40;
          imgScale.Align := TAlignLayout.Right;
          imgScale.Visible := False;

          imgScale.Tag := Ord(itTime);
          imgScale.OnMouseDown := Step.OnScaleImageMouseDown; // 재료 수정을 위해
          imgScale.OnTap := Step.OnScaleImageTap; // 저울 연결을 위해
          begin
            txtScale := TText.Create(imgScale);
            txtScale.parent := imgScale;
            txtScale.Align := TAlignLayout.Client;
            txtScale.TextSettings.FontColor := COLOR_BACKGROUND;
            txtScale.Opacity := 0;
            txtScale.HitTest := False;
          end;
        end;
      itRecipeLink:
        begin
          layout1 := TLayout.Create(layoutIngredientBody);
          layout1.Parent := layoutIngredientBody;
          layout1.Height := 40;          
          layout1.Align := TAlignLayout.Top;
          begin        
            imgLeft := TImage.Create(layout1);
            imgLeft.Parent := layout1;
            imgLeft.Width := 30;
            imgLeft.Align := TAlignLayout.Left;
            imgLeft.Bitmap := ImageList.Bitmap(TSizeF.Create(60,60), 5);
            imgLeft.Tag := Ord(itRecipeLink);
            imgLeft.OnMouseDown := Step.OnDeleteImageMouseDown;

            recNameBody := TRectangle.Create(layout1);
            recNameBody.Parent := layout1;
            recNameBody.Align := TAlignLayout.Client;
            recNameBody.Fill.Color := TAlphaColorRec.Whitesmoke;
            recNameBody.Stroke.Color := COLOR_BOX_ROUND;
//            recNameBody.Margins := TBounds.Create(TRectF.Create(5,0,45,0));
            recNameBody.Margins := TBounds.Create(TRectF.Create(5,0,5,0));
            recNameBody.Padding := TBounds.Create(TRectF.Create(3,0,3,0));
            begin
              edtName := TEdit.Create(recNameBody);
              edtName.Parent := recNameBody;
              edtName.StyleLookup := 'Edit2Style1';
              edtName.TextPrompt := 'RECIPE';
              edtName.Text := aRecipeTitle;
              edtName.Align := TAlignLayout.VertCenter;
              edtName.TextSettings.Font.Size := 14;
              edtName.MaxLength := 100;
              edtName.StyledSettings := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];

              if aIngredientTable <> nil then
                edtname.Text := aIngredientTable.FieldByName('Title').AsWideString;

              edtName.CanFocus := False;
              edtName.OnExit := OnEditExit;
              edtName.OnClick := OnEditClick;
            end;
          end;
          layout2 := TLayout.Create(layoutIngredientBody);
          layout2.Parent := layoutIngredientBody;
          layout2.Position.Y := layout1.Position.Y + 10;
          layout2.Height := 40;
          layout2.Align := TAlignLayout.Top;
          layout2.Margins := TBounds.Create(TRectF.Create(35,5,0,0));
          begin
            recQuantityBody := TRectangle.Create(layout2);
            recQuantityBody.Parent := layout2;
            recQuantityBody.Width := 65;
            recQuantityBody.align := TAlignLayout.Right;
            recQuantityBody.Fill.Color := TAlphaColorRec.Whitesmoke;
            recQuantityBody.Stroke.Color := COLOR_BOX_ROUND;
            recQuantityBody.Margins.Right := 10;
            recQuantityBody.Padding := TBounds.Create(TRectF.Create(3,0,3,0));
            begin
              edtQuantity := TEdit.Create(recQuantityBody);
              edtQuantity.Parent := recQuantityBody;
              edtQuantity.StyleLookup := 'Edit2Style1';
              edtQuantity.TextPrompt := '예)200';
              edtQuantity.TextSettings.Font.Size := 14;
              edtQuantity.Font.Size := 14;
              edtQuantity.Align := TAlignLayout.VertCenter;
              edtQuantity.KeyboardType := TVirtualKeyboardType.PhonePad;
              edtQuantity.StyledSettings := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];

              // 기존의 Quantity를 세팅한다
              if aIngredientTable <> nil then
                edtQuantity.Text := aIngredientTable.FieldByName('amount').AsWideString;

              edtQuantity.CanFocus := False;
              edtQuantity.OnExit := OnEditExit;
              edtQuantity.OnClick := OnEditClick;
            end;
            
            recUnitBody := TRectangle.Create(layout2);
            recUnitBody.Parent := layout2;
            recUnitBody.Width := 65;
            recUnitBody.Position.X := recQuantityBody.Position.X + 10; // 위치잡기
            recUnitBody.align := TAlignLayout.Right;
            recUnitBody.Fill.Color := TAlphaColorRec.Whitesmoke;
            recUnitBody.Stroke.Color := COLOR_BOX_ROUND;
            recUnitBody.Margins.Right := 5;
            recUnitBody.Padding := TBounds.Create(TRectF.Create(3,0,3,0));
            begin
              cboUnit := TComboBox.Create(recUnitBody);
              cboUnit.Parent := recUnitBody;
              cboUnit.CanFocus := False;
              cboUnit.Align := TAlignLayout.VertCenter;
              cboUnit.StyleLookup := 'cboUnitStyle1';
              CM.GetIngredientUnit(cboUnit);
              cboUnit.OnChange := OnUnitComboChange;
              cboUnit.OnClosePopup := OnUnitComboclosePopup;
              begin
                edtUnit := TEdit.Create(cboUnit);
                edtUnit.Parent := cboUnit;
                edtUnit.HitTest := False;
                edtUnit.StyleLookup := 'edtWhitesmokeStyle1';
                edtUnit.TextPrompt := '예)g';
                edtUnit.TextSettings.Font.Size := 14;
                edtUnit.Align := TAlignLayout.VertCenter;
                edtUnit.StyledSettings := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
                edtUnit.OnExit := OnUnitEditExit;

                // 기존의 Unit 값으로 세팅한다
                if aIngredientTable <> nil then
                  edtUnit.Text := aIngredientTable.FieldByName('Unit').AsWideString;
              end;
            end;
            
            imgScale := TImage.Create(layout2);
            imgScale.Parent := layout2;
            imgScale.Width := 40;
            imgScale.Position.X := recUnitBody.Position.X + 30; // 위치잡기
            imgScale.Align := TAlignLayout.Right;
            imgScale.Bitmap := ImageList.Bitmap(TSizeF.Create(80,80), 8);

            imgScale.Tag := Ord(itRecipeLink);
            imgScale.OnMouseDown := Step.OnScaleImageMouseDown; // 재료 수정을 위해
            imgScale.OnTap := Step.OnScaleImageTap; // 저울 연결을 위해
            begin
              txtScale := TText.Create(imgScale);
              txtScale.parent := imgScale;
              txtScale.Align := TAlignLayout.Client;
              txtScale.TextSettings.FontColor := COLOR_BACKGROUND;
              txtScale.Opacity := 0;
              txtScale.HitTest := False;
            end;

            // 저울무게값이 있으면, 세팅한다
            if (aIngredient.ScaleWeight > 0) then
            begin
              txtScale.Text := aIngredient.ScaleWeight.ToString;
              txtScale.Opacity := 1;
              imgScale.Bitmap.Assign(nil);
            end;
          end;
        end;
    end;
  end;

  step.Ingredients.AddObject('', aIngredient);
  scrollRecipe.ViewportPosition := TPointF.Create(0,scrollRecipe.ViewportPosition.Y + h);
end;

procedure TfrmRecipeEditor.AddStep(aParent: TLayout; Serial: LargeInt);
var
  aStep: TStepInfo;
begin
  aStep := TStepInfo.Create;
  aStep.Ingredients := TStringList.Create;
  aStep.DeletedIngredient := TStringList.Create;

  // Init Step
  aStep.Serial := Serial;
  aStep.State := TRecipeState.rsNew;
  aStep.FCanMovingIngredient := False;
  aStep.FGrab := False; // 현재 drag & drop 상태 표시

  with aStep do
  begin
    No := FRecipe.Steps.Count + 1; // Step Number 는 1 부터 시작한다

    layoutStep := TLayout.Create(aParent);
    layoutStep.Parent := aParent;
    layoutStep.Tag := No;

    if No > 1 then
      layoutStep.Position.Y := layoutStepBody.Height + 10
    else
      layoutStep.Position.Y := 0;

    layoutStep.Align := TAlignLayout.Top;
    layoutStep.Padding := TBounds.Create(TRectF.Create(15,0,15,10));
    layoutStep.Height := 237;
    begin
      // Step Description
      layoutStepHead := TLayout.Create(layoutStep);
      layoutStepHead.parent := layoutStep;
      layoutStepHead.Align := TAlignLayout.Top;
      layoutStepHead.Height := 147;
      begin
        txtStepNo := TText.Create(layoutStepHead);
        txtStepNo.Parent := layoutStepHead;
        txtStepNo.Align := TAlignLayout.Top;
        txtStepNo.TextSettings.Font.Size := 16;
        txtStepNo.Margins.Left := 5;
        txtStepNo.Text := 'STEP ' + No.ToString;
        txtStepNo.TextSettings.HorzAlign := TTextAlign.Leading;
        begin
          imgDeleteStep := TImage.Create(txtStepNo);
          imgDeleteStep.Parent := txtStepNo;
          imgDeleteStep.Anchors := [TAnchorKind.akTop, TAnchorKind.akRight];
          imgDeleteStep.Align := TAlignLayout.Right;
          imgDeleteStep.Width := 34;
          imgDeleteStep.Bitmap := ImageList.Bitmap(TSizeF.Create(68,68), 7);

          imgDeleteStep.OnClick := OnDeleteStepClick;
        end;

        memoDescription := TMemo.Create(layoutStepHead);
        memoDescription.Parent := layoutStepHead;
        memoDescription.Align := TAlignLayout.Client;
        memoDescription.StyleLookup := 'Memo1Style1';
        memoDescription.Margins.Right := 10;
        memoDescription.MaxLength := 1000;
        memoDescription.TextSettings.Font.Size := 16;
        memoDescription.StyledSettings :=  memoDescription.StyledSettings - [TStyledSetting.Size];

        memoDescription.CanFocus := False;
        memoDescription.OnExit := OnEditExit;
        memoDescription.OnClick := onEditClick;

        recStepImage := TRectangle.Create(layoutStepHead);
        recStepImage.Parent := layoutStepHead;
        recStepImage.Align := TAlignLayout.Right;
        recStepImage.Fill.Color := COLOR_BACKGROUND_IMAGE;
        recStepImage.Stroke.Color := COLOR_BOX_ROUND;
        recStepImage.Width := 100;
        begin
          imgStep := TImage.Create(recStepImage);
          imgStep.Parent := recStepImage;
          imgStep.Align := TAlignLayout.Client;
          imgStep.OnTap := OnStepPictureTap;
          imgStep.OnPaint := imgRecipePaint;
          begin
            imgStepCamera := TImage.Create(imgStep);
            imgStepCamera.Parent := imgStep;
            imgStepCamera.Align := TAlignLayout.Center;
            imgStepCamera.Width := 40;
            imgStepCamera.Height := 40;
            imgStepCamera.Bitmap := ImageList.Bitmap(TSizeF.Create(80,80), 6);
            imgStepCamera.HitTest := False;

            imgDeleteStepImage := TImage.Create(imgStep);
            imgDeleteStepImage.Parent := imgStep;
            imgDeleteStepImage.Bitmap := ImageList.Bitmap(TSizeF.Create(60,60), 0);
            imgDeleteStepImage.Width := 30;
            imgDeleteStepImage.Height := 30;
            imgDeleteStepImage.Position.X := 0;
            imgDeleteStepImage.Position.Y := 0;
            imgDeleteStepImage.Visible := False;
            imgDeleteStepImage.OnTap := OnDeleteStepImageTap;

            imgStepImageOrigin := TImage.Create(imgStep);
            imgStepImageOrigin.Parent := imgStep;
            imgStepImageOrigin.Width := 20;
            imgStepImageOrigin.Height := 20;
            imgStepImageOrigin.Visible := False;

            imgStepImageRectangle := TImage.Create(imgStep);
            imgStepImageRectangle.Parent := imgStep;
            imgStepImageRectangle.Width := 15;
            imgStepImageRectangle.Height := 15;
            imgStepImageRectangle.Visible := False;
          end;
        end;
      end;
      // Ingredient Title
      txtStepIngredientTitle := TText.Create(layoutStep);
      txtStepIngredientTitle.Parent := layoutStep;
      txtStepIngredientTitle.Height := 40;
      txtStepIngredientTitle.Align := TAlignLayout.Top;
      txtStepIngredientTitle.Margins.Left := 5;
      txtStepIngredientTitle.TextSettings.HorzAlign := TTextAlign.Leading;
      txtStepIngredientTitle.TextSettings.Font.Size := 16;
      txtStepIngredientTitle.Text := txtStepNo.Text + ' 재료/시간';
      begin
        txtStepIngredientTitleEdit := TText.Create(txtStepIngredientTitle);
        txtStepIngredientTitleEdit.Parent := txtStepIngredientTitle;
        txtStepIngredientTitleEdit.Width := 60;
        txtStepIngredientTitleEdit.Align := TAlignLayout.Right;
        txtStepIngredientTitleEdit.TextSettings.Font.Size := 16;
        txtStepIngredientTitleEdit.TextSettings.FontColor := COLOR_BACKGROUND;
        txtStepIngredientTitleEdit.TextSettings.HorzAlign := TTextAlign.Trailing;
        txtStepIngredientTitleEdit.Text := '수정';

        txtStepIngredienttitleEdit.OnTap := OnEditIngredientTap;
      end;
      layoutIngredient := TLayout.Create(layoutStep);
      layoutIngredient.Parent := layoutStep;
      layoutIngredient.Position.Y := txtStepIngredientTitle.Position.Y + 10; // 화면위치 맞추기
      layoutIngredient.Height := 50;
      layoutIngredient.Align := TAlignLayout.Top;

      layoutIngredient.OnMouseMove := OnBodyLayoutMouseMove;
      layoutIngredient.OnMouseUp := OnBodyLayoutMouseUp;

      // 신규일 경우
      if Serial = NEW_STEP_SERIAL then
        AddIngredient(aStep, itIngredient, nil) // 재료 한개는 기본으로 추가한다.
      else
        layoutIngredient.Height := 0;

      layoutAddIngredient := TLayout.Create(layoutStep);
      layoutAddIngredient.Parent := layoutStep;
      layoutAddIngredient.Height := 60;
      layoutAddIngredient.Position.Y := layoutIngredient.Position.Y + 100;
      layoutAddIngredient.Align := TAlignLayout.Top;
      begin
        imgAddIngredient := TImage.Create(layoutAddIngredient);
        imgAddIngredient.Parent := layoutAddIngredient;
        imgAddIngredient.Align := TAlignLayout.Right;
        imgAddIngredient.Width := 40;
        imgAddIngredient.Height := 40;
        imgAddIngredient.Bitmap := ImageList.Bitmap(TSizeF.Create(92,92), 9);

//        imgAddIngredient.OnMouseDown := OnAddIngredientMouseDown;
        imgAddIngredient.OnTap := OnAddIngredientTap;

        recDivider := TRectangle.Create(layoutAddIngredient);
        recDivider.Parent := layoutAddIngredient;
        recDivider.Height := 10;
        recDivider.Align := TAlignLayout.Bottom;
        recDivider.Margins := TBounds.Create(TRectF.Create(-15,0,-15,0));
        recDivider.Fill.Color := COLOR_RECIPE_BACKGROUND;
        recDivider.Stroke.Color := COLOR_RECIPE_BACKGROUND;
      end;
    end;
  end;

  // Resize High of the layoutStep
  aStep.layoutStep.Height := aStep.layoutStepHead.Height + aStep.txtStepIngredientTitle.Height +
                             aStep.layoutIngredient.Height + aStep.layoutAddIngredient.Height;

  FRecipe.Steps.AddObject('', aStep);

  ReAlignLayoutStepBody;

  scrollRecipe.ViewportPosition := TPointF.Create(0,scrollRecipe.ViewportPosition.Y + aStep.layoutStep.Height);

//  aStep.memoDescription.SetFocus;
end;

procedure TfrmRecipeEditor.btnAddStepClick(Sender: TObject);
begin
  AddStep(layoutStepBody, NEW_STEP_SERIAL);
end;

procedure TfrmRecipeEditor.btnTimerOKClick(Sender: TObject);
begin
  if Assigned(FSelectedTimerText) then
  begin
    FSelectedTimerText.Text := Format('%.2d:%.2d:%.2d', [round(numHour.Value), round(numMin.Value), round(numSec.Value)]);
    FSelectedTimerText := nil;
  end;

  ShowTimerInput(False);
end;

procedure TfrmRecipeEditor.SaveRecipe(isPublished: Boolean);
  procedure CopyRecipe;
  var
    picture, pictureSquare, pictureRectangle: string;
    RecipeSerial: LargeInt;
  begin
    RecipeSerial := CM.DSMyRecipe.FieldByName('Serial').AsLargeInt;

    CM.DSMyRecipe.FieldByName('Description').AsWideString := memDescription.Lines.Text.Trim;
    CM.DSMyRecipe.FieldByName('PictureType').AsString := inttostr(Ord(TPicturetype.ptPicture));

    // 이미지 이름을 만든다
    frmS3.GetImageName(RecipeSerial, picture, pictureSquare, pictureRectangle);

    // 현재 이미지가 새로운 입력되었으면
    if (not imgRecipe.Bitmap.IsEmpty) and (imgRecipe.TagString.Trim = NEW_PICTURE) then
    begin
      // 원래 레시피 레코드에 사진이름이 없으면
      if CM.DSMyRecipe.FieldByName('Picture').AsWideString = '' then
      begin
        // S3에 저장한다
        frmS3.SaveImageToS3(BUCKET_RECIPE, picture, imgRecipeOrigin);
        frmS3.SaveImageToS3(BUCKET_RECIPE, pictureSquare, imgRecipe);
        frmS3.SaveImageToS3(BUCKET_RECIPE, pictureRectangle, imgRecipeRectangle);

        // Add Que 에 저장한다. 실해하면 Rollback 하기 위해
        FRecipe.AddedImageQue.Add(picture);
        FRecipe.AddedImageQue.Add(pictureSquare);
        FRecipe.AddedImageQue.Add(pictureRectangle);
      end
      // 레시페 페코드에 사진이름이 있으면, 레시피에 저장된 Image name을 Delete Que 에 넣음
      else
      begin
        FRecipe.DeletedImageQue.Add(CM.DSMyRecipe.FieldByName('Picture').AsWideString);
        FRecipe.DeletedImageQue.Add(CM.DSMyRecipe.FieldByName('PictureSquare').AsWideString);
        FRecipe.DeletedImageQue.Add(CM.DSMyRecipe.FieldByName('PictureRectangle').AsWideString);
      end;

      // 레시피에 새로운 Image Name을 업데이트
      CM.DSMyRecipe.FieldByName('Picture').AsWideString := picture;
      CM.DSMyRecipe.FieldByName('PictureSquare').AsWideString := pictureSquare;
      CM.DSMyRecipe.FieldByName('PictureRectangle').AsWideString := pictureRectangle;
    end;

    CM.DSMyRecipe.FieldByName('Category').AsString := frmRecipeCategory.GetSelectedCategoryString;
    CM.DSMyRecipe.FieldByName('MakingLevel').AsInteger := CM.GetRecipeInfoCode('MakingLevel', cboDifficult.Selected.Text);
    CM.DSMyRecipe.FieldByName('MakingTime').AsInteger := CM.GetRecipeInfoCode('MakingTime', cboTime.Selected.Text);
    CM.DSMyRecipe.FieldByName('Servings').AsInteger := CM.GetRecipeInfoCode('Servings', cboPerson.Selected.Text);

    CM.DSMyRecipe.FieldByName('CreatedDate').AsDateTime := now;
    CM.DSMyRecipe.FieldByName('UpdatedDate').AsDateTime := now;
  end;

  procedure CopyStep(aStep: TStepInfo; aSeq: integer);
  var
    picture, pictureSquare, pictureRectangle: string;
    RecipeSerial, StepSerial: LargeInt;
  begin
    RecipeSerial := CM.DSMyRecipe.FieldByName('Serial').AsLargeInt;
    StepSerial := CM.DSMyMethod.FieldByName('Serial').AsLargeInt;

    CM.DSMyMethod.FieldByName('MethodType').AsInteger := 0; // 사용안함
    CM.DSMyMethod.FieldByName('PictureType').AsInteger := Ord(TPictureType.ptPicture);

    // 이미지 이름을 만든다
    frmS3.GetImageName(RecipeSerial, picture, pictureSquare, pictureRectangle);

    // 현재 이미지가 새로운 입력되었으면
    if (not aStep.imgStep.Bitmap.IsEmpty) and (aStep.imgStep.TagString.Trim = NEW_PICTURE) then
    begin
      // 원래 Method record에 사진이름이 없으면
      if CM.DSMyMethod.FieldByName('Picture').AsWideString = '' then
      begin
        // S3에 저장한다
        frmS3.SaveImageToS3(BUCKET_RECIPE, picture, aStep.imgStepImageOrigin);
        frmS3.SaveImageToS3(BUCKET_RECIPE, pictureSquare, aStep.imgStep);
        frmS3.SaveImageToS3(BUCKET_RECIPE, pictureRectangle, aStep.imgStepImageRectangle);

        // Add Que 에 저장한다. 실해하면 Rollback 하기 위해
        FRecipe.AddedImageQue.Add(picture);
        FRecipe.AddedImageQue.Add(pictureSquare);
        FRecipe.AddedImageQue.Add(pictureRectangle);
      end
      // Method record에 사진이름이 있으면, Method에 저장된 Image name을 Delete Que 에 넣음
      else
      begin
        FRecipe.DeletedImageQue.Add(CM.DSMyMethod.FieldByName('Picture').AsWideString);
        FRecipe.DeletedImageQue.Add(CM.DSMyMethod.FieldByName('PictureSquare').AsWideString);
        FRecipe.DeletedImageQue.Add(CM.DSMyMethod.FieldByName('PictureRectangle').AsWideString);
      end;

      // Method에 새로운 Image Name을 업데이트
      CM.DSMyMethod.FieldByName('Picture').AsWideString := picture;
      CM.DSMyMethod.FieldByName('PictureSquare').AsWideString := pictureSquare;
      CM.DSMyMethod.FieldByName('PictureRectangle').AsWideString := pictureRectangle;
    end;

    CM.DSMyMethod.FieldByName('Description').AsString := aStep.memoDescription.Lines.Text.Trim;
    CM.DSMyMethod.FieldByName('seq').AsInteger := aSeq;
    CM.DSMyMethod.FieldByName('StepSeq').AsInteger := aSeq + 1;
  end;

  procedure CopyIngredient(aIngredient: TIngredientInfo; aSeq: integer);
  var
    title, amount, aunit: string;
    upperUnit: string;
  begin
    CM.DSMyIngredient.FieldByName('ItemType').AsInteger := Ord(aIngredient.IngredientType); // 사용안함
    CM.DSMyIngredient.FieldByName('Seq').AsInteger := aSeq;

    if aIngredient.IngredientType = TIngredientType.itTime  then
      CM.DSMyIngredient.FieldByName('ItemTimeValue').AsWideString := aIngredient.txtTimer.Text
    else
    begin
      title := aIngredient.edtName.Text.Trim;
      amount := aIngredient.edtQuantity.Text.Trim;
      aUnit := aIngredient.edtUnit.Text.Trim;

      // 저울 입력값이 있으면 저장
      if aIngredient.txtScale.Text.Trim <> '' then
        CM.DSMyIngredient.FieldByName('ItemWeightValue').AsSingle := aIngredient.txtScale.Text.ToSingle
      else
        CM.DSMyIngredient.FieldByName('ItemWeightValue').AsSingle := 0;

      // 입력값이 있으면
      if not (title.IsEmpty or amount.IsEmpty or aUnit.IsEmpty) then
      begin
        CM.DSMyIngredient.FieldByName('Title').AsWideString := title;
        CM.DSMyIngredient.FieldByName('Amount').AsWideString := amount;
        CM.DSMyIngredient.FieldByName('Unit').AsWideString := aUnit;

        // Linked Recipe Serial 저장
        CM.DSMyIngredient.FieldByName('LinkedRecipe').AsLargeInt := aIngredient.LinkedRecipeSerial;

        // 저울 입력값이 없고, 수동 입력값의 Unit 이 g, kg, mg 일 때, g값으로 변환하여 저울값으로 복사한다
        CM.DSMyIngredient.FieldByName('ItemUnit').AsInteger:= Ord(TIngredientUnit.wuG);
        if aIngredient.txtScale.Text.Trim = '' then
        begin
          upperUnit := Uppercase(aUnit);
          if upperUnit = 'G' then
            CM.DSMyIngredient.FieldByName('ItemWeightValue').AsString := FormatFloat('0.#', amount.ToSingle)
          else if upperUnit = 'KG' then
            CM.DSMyIngredient.FieldByName('ItemWeightValue').AsString := FormatFloat('0.#', amount.ToSingle * 1000)
          else if upperUnit = 'MG' then
            CM.DSMyIngredient.FieldByName('ItemWeightValue').AsString := FormatFloat('0.#', amount.ToSingle / 1000);
        end;
      end;
    end;
  end;
var
  nRecipeSerial, nStepSerial, nIngredientSerial: LargeInt;
  nStepNo, nIngredientNo, i: integer;
  aStep: TStepInfo;
  aIngredient: TIngredientInfo;
  aTitle: string;
begin
  if FRecipe.Steps.Count = 0 then
  begin
    ShowMessage('레시피 STEP을 입력하세야 저장할 수 있습니다!');
    Exit;
  end;

  nRecipeSerial := NEW_RECIPE_SERIAL;
  nStepSerial := NEW_STEP_SERIAL;
  nIngredientSerial := NEW_INGREDIENT_SERIAL;

  FRecipe.DeletedImageQue.Clear;
  FRecipe.AddedImageQue.Clear;

  if not CM.SQLConnection.Connected then
    CM.SQLConnection.Open;

  CM.DSDeleteQue.Open;

  CM.SQLConnection.BeginTransaction;
  try
    // Recipe
    CM.DSMyRecipe.Close;
    CM.DSMyRecipe.ParamByName('UserSerial').Value := CM.memUserSerial.Value;
    CM.DSMyRecipe.Open;

    // 새로운 레시피 이면
    if FRecipe.Serial = NEW_RECIPE_SERIAL then
    begin
      CM.DSMyRecipe.Append;
      CM.DSMyRecipe.FieldByName('Users_Serial').AsLargeInt := CM.memUserSerial.AsLargeInt;
      CM.DSMyRecipe.FieldByName('Title').AsWideString := edtTitle.Text.Trim;
      // 임시저장인지 아닌지 세팅한다
      CM.DSMyRecipe.FieldByName('Published').AsBoolean := isPublished;
      CM.DSMyRecipe.Post;
      CM.DSMyRecipe.ApplyUpdates(0);
      CM.DSMyRecipe.Refresh;

      nRecipeSerial := CM.DSMyRecipe.FieldByName('Serial').AsLargeInt;
    end
    // 기존에 있는 레시피 이면
    else
    begin
      if CM.DSMyRecipe.Locate('Serial', FRecipe.Serial, []) then
        nRecipeSerial := CM.DSMyRecipe.FieldByName('Serial').AsLargeInt
      else
        nRecipeSerial := NEW_RECIPE_SERIAL;
    end;

    if nRecipeSerial = NEW_RECIPE_SERIAL then
      raise Exception.Create('레시피를 저장할 수 없습니다!');

    CM.DSMyRecipe.Edit;
    CopyRecipe;
    CM.DSMyRecipe.Post;
    CM.DSMyRecipe.ApplyUpdates(0);

    // Method
    CM.DSMyMethod.Close;
    CM.DSMyMethod.ParamByName('RecipeSerial').Value := nRecipeSerial;
    CM.DSMyMethod.Open;

    for nStepNo := 0 to FRecipe.Steps.Count-1 do
    begin
      aStep := FRecipe.GetStep(nStepNo);

      // 새로운 STEP 이면
      if aStep.Serial = NEW_STEP_SERIAL then
      begin
        CM.DSMyMethod.Insert;
        CM.DSMyMethod.FieldByName('Recipe_Serial').AsLargeInt := nRecipeSerial;
        CM.DSMyMethod.Post;
        CM.DSMyMethod.ApplyUpdates(0);
        CM.DSMyMethod.Refresh;

        nStepSerial := CM.DSMyMethod.FieldByName('Serial').AsLargeInt;
      end
      // 아니면
      else
      begin
        if CM.DSMyMethod.Locate('Serial', aStep.Serial, []) then
          nStepSerial := CM.DSMyMethod.FieldByName('Serial').AsLargeInt
        else
          nStepSerial := NEW_STEP_SERIAL;
      end;

      if nStepSerial = NEW_STEP_SERIAL then
        raise Exception.Create('STEP을 저장할 수 없습니다!');

      CM.DSMyMethod.Edit;
      CopyStep(aStep, nStepNo);
      CM.DSMyMethod.Post;
      CM.DSMyMethod.ApplyUpdates(0);

      // 삭제된 Step을 DB에서 삭제한다
      for i := 0 to FRecipe.DeletedSteps.Count-1 do
        if CM.DSMyMethod.Locate('Serial', TStepInfo(FRecipe.DeletedSteps.Objects[i]).Serial, []) then
        begin
          CM.DSMyMethod.Delete;
          CM.DSMyMethod.Post;
          CM.DSMyMethod.ApplyUpdates(0);
          CM.DSMyMethod.Refresh;
        end;

      // Ingredient
      CM.DSMyIngredient.Close;
      CM.DSMyIngredient.ParamByName('RecipeSerial').Value := nRecipeSerial;
      CM.DSMyIngredient.Open;

      for nIngredientNo := 0 to aStep.Ingredients.Count-1 do
      begin
        aIngredient := FRecipe.GetIngredient(nStepNo, nIngredientNo);

        aTitle := aIngredient.edtName.Text.Trim;

        showmessage('title=' + aTitle + ' / IngredientSerial=' + aIngredient.Serial.ToString);

        // 재료/시간이 입력되지 않으면 저장하지 않는다
        if (aTitle.Trim <> '') then // or ((aIngredient.IngredientType = itTime) and (aIngredient.txtTimer.Text.Trim <> INIT_TIME_STR)) then
        begin
          // 새로운 Ingredient 이면
          if aIngredient.Serial = NEW_INGREDIENT_SERIAL then
          begin
            CM.DSMyIngredient.Insert;
            CM.DSMyIngredient.FieldByName('Recipe_Serial').AsLargeInt := nRecipeSerial;
            CM.DSMyIngredient.FieldByName('RecipeMethod_Serial').AsLargeInt := nStepSerial;
            CM.DSMyIngredient.Post;

            nIngredientSerial := CM.DSMyIngredient.FieldByName('Serial').AsLargeInt;
          end
          // 아니면
          else
          begin
            if CM.DSMyIngredient.Locate('Serial', aIngredient.Serial, []) then
              nIngredientSerial := CM.DSMyIngredient.FieldByName('Serial').AsLargeInt
            else
              nIngredientSerial := NEW_INGREDIENT_SERIAL;
          end;

          if nIngredientSerial = NEW_INGREDIENT_SERIAL then
            raise Exception.Create('재료/시간을 저장할 수 없습니다!');

          CM.DSMyIngredient.Edit;
          CopyIngredient(aIngredient, nIngredientNo);
          CM.DSMyIngredient.Post;
          CM.DSMyIngredient.ApplyUpdates(0);
        end;
      end;

      // 삭제된 Ingredient를 DB에서 삭제한다
      for i := 0 to FRecipe.GetStep(nStepNo).DeletedIngredient.Count-1 do
        if CM.DSMyIngredient.Locate('Serial', TIngredientInfo(FRecipe.GetStep(nStepNo).Ingredients.Objects[i]).Serial, []) then
        begin
          CM.DSMyIngredient.Delete;
          CM.DSMyIngredient.Post;
          CM.DSMyIngredient.ApplyUpdates(0);
          CM.DSMyIngredient.Refresh;
        end;
    end;

    // DeleteQue 에 저장된 삭제된 Image를 DB에 저장한다
    for i := 0 to FRecipe.DeletedImageQue.Count-1 do
      CM.AddtoDeleteImageQue(BUCKET_RECIPE, FRecipe.DeletedImageQue[i]);

    CM.DSDeleteQue.ApplyUpdates(0);

    CM.SQLConnection.Commit;

    // memTable 에 새로운 레시피 정보를 가져온다
    CM.GetRecipeTablesToMem;

    CM.SQLConnection.Close;
    FRecipe.DeletedImageQue.Clear;
    FRecipe.AddedImageQue.Clear;

    ShowMessage('저장하였습니다!');

    Close;
  except
    on E:Exception do
    begin
      CM.DSMyRecipe.CancelUpdates;
      CM.DSMyMethod.CancelUpdates;
      CM.DSMyIngredient.CancelUpdates;
      CM.DSDeleteQue.CancelUpdates;

      CM.SQLConnection.Rollback;

      // S3에 추가한 이미지 Rollback
      for i := 0 to FRecipe.AddedImageQue.Count-1 do
        CM.AddtoDeleteImageQue(BUCKET_RECIPE, FRecipe.AddedImageQue[i]);

      CM.DSDeleteQue.ApplyUpdates(0);

      CM.SQLConnection.Close;
      FRecipe.DeletedImageQue.Clear;
      FRecipe.AddedImageQue.Clear;

      ShowMessage(E.Message);
      raise;
    end;
  end;
end;

procedure TfrmRecipeEditor.SetRecipeSerial(const Value: LargeInt);
begin
  if Assigned(FRecipe) then
    FRecipe.Serial := Value;
end;

procedure TfrmRecipeEditor.ShowAddIngredientMenu(aVisible: Boolean);
begin
  HideVirtualKeyboard;

  if aVisible then
  begin
//    if layoutMenu.Position.Y > (ClientHeight - layoutMenu.Height) then
//    begin
      TAnimator.Create.AnimateFloat(recBackground, 'Opacity', 0.3, 0.15);
      recBackground.HitTest := True;

      TAnimator.Create.AnimateFloat(layoutMenu, 'Position.Y', ClientHeight - layoutMenu.Height, 0.25, TAnimationType.Out, TInterpolationType.Exponential);
//    end;
  end
  else
  begin
//    if layoutMenu.Position.Y <> ClientHeight then
//    begin
      TAnimator.Create.AnimateFloat(recBackground, 'Opacity', 0, 0.15);
      recBackground.HitTest := False;

      TAnimator.Create.AnimateFloat(layoutMenu, 'Position.Y', ClientHeight, 0.25, TAnimationType.Out, TInterpolationType.Exponential);
//    end;
  end;
end;

procedure TfrmRecipeEditor.ShowPictureInput(aVisible: Boolean; R: TRectF);
begin
  HideVirtualKeyboard;

  recPicture.Position.Y := R.Top;
  recPicture.Position.X := R.Left - recPicture.Width - 2;

  if aVisible then
  begin
    TAnimator.Create.AnimateFloat(recBackground, 'Opacity', 0.3, 0.15);
    recBackground.HitTest := True;

    TAnimator.Create.AnimateFloat(recPicture, 'Opacity', 1, 0);
  end
  else
  begin
    TAnimator.Create.AnimateFloat(recBackground, 'Opacity', 0, 0.15);
    recBackground.HitTest := False;

    TAnimator.Create.AnimateFloat(recPicture, 'Opacity', 0, 0);
  end;

  recPicture.HitTest := aVisible;
  btnGetPictureFromCamera.HitTest := aVisible;
  btnGetPictureFromGallery.HitTest := aVisible;
end;

procedure TfrmRecipeEditor.TakePhotoFromCameraAction1DidCancelTaking;
begin
  ShowPictureInput(False, TRectF.Create(0,0,0,0));
end;

procedure TfrmRecipeEditor.TakePhotoFromCameraAction1DidFinishTaking(
  Image: TBitmap);
begin
  if FSelectedImage <> nil then
    GetPicture(Image);
end;

procedure TfrmRecipeEditor.TakePhotoFromLibraryAction1DidCancelTaking;
begin
  ShowPictureInput(False, TRectF.Create(0,0,0,0));
end;

procedure TfrmRecipeEditor.TakePhotoFromLibraryAction1DidFinishTaking(
  Image: TBitmap);
begin
  if FSelectedImage <> nil then
    GetPicture(Image);
end;

procedure TfrmRecipeEditor.txtDoneClick(Sender: TObject);
begin
  HideVirtualKeyboard;

  MessageDlg( '레시피를 저장하시겠습니까?',
             TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult = mrYES then
    begin
      if CheckInputValid then
        SaveRecipe(True);
    end;
  end);
end;

procedure TfrmRecipeEditor.txtTimer1Click(Sender: TObject);
begin
  FSelectedTimerText := txtTimer1;
  ShowTimerInput(True);
end;

procedure TfrmRecipeEditor.txtMenuAddIngredientClick(Sender: TObject);
var
  aStep: TStepInfo;
begin
  if FSelectedStepNo > 0 then
  begin
    aStep := TStepInfo(FRecipe.Steps.Objects[FSelectedStepNo-1]);

    if Sender = txtMenuAddIngredient then
    begin
      AddIngredient(aStep, itIngredient, nil);
      aStep.layoutStep.Height := aStep.layoutStepHead.Height + aStep.txtStepIngredientTitle.Height +
                                 aStep.layoutIngredient.Height + aStep.layoutAddIngredient.Height;
      ReAlignLayoutStepBody;

      ShowAddIngredientMenu(False);
    end
    else if Sender = txtMenuAddSeasoning then
    begin
      AddIngredient(aStep, itSeasoning, nil);
      aStep.layoutStep.Height := aStep.layoutStepHead.Height + aStep.txtStepIngredientTitle.Height +
                                 aStep.layoutIngredient.Height + aStep.layoutAddIngredient.Height;
      ReAlignLayoutStepBody;

      ShowAddIngredientMenu(False);
    end
    else if Sender = txtMenuAddTimer then
    begin
      AddIngredient(aStep, itTime, nil);
      aStep.layoutStep.Height := aStep.layoutStepHead.Height + aStep.txtStepIngredientTitle.Height +
                                 aStep.layoutIngredient.Height + aStep.layoutAddIngredient.Height;
      ReAlignLayoutStepBody;

      ShowAddIngredientMenu(False);
    end
    else if Sender = txtMenuAddRecipe then
    begin
      frmList.Init(ltMyRecipe, '레시피가져오기', CallbackMyRecipeListResult);
      frmList.Show;
    end;
  end;
end;

procedure TfrmRecipeEditor.UpdateCategory;
  procedure AddCategoryItem(str: string);
  var
    item: TListBoxItem;
    Layout: TLayout;
    RoundRect: TRoundRect;
    Text: TText;
  begin
    item := TListBoxItem.Create(lbCategory);
    item.Selectable := False;
    item.Width := 110;
    item.HitTest := False;
    Item.Margins.Left := 10;
    Item.Margins.Right := 5;

    Layout := TLayout.Create(item);
    Layout.Parent := item;
    Layout.HitTest := False;
    Layout.Align := TAlignLayout.Client;

    RoundRect := TRoundRect.Create(Layout);
    RoundRect.Parent := Layout;
    RoundRect.HitTest := False;
    RoundRect.Align :=  TAlignLayout.VertCenter;
    RoundRect.Width := 95;
    RoundRect.Height := 30;
    RoundRect.Fill.Color := COLOR_BACKGROUND;
    RoundRect.Fill.Kind := TBrushKind.Solid;
    RoundRect.Stroke.Color := COLOR_BACKGROUND;

    Text := TText.Create(Layout);
    Text.Parent := Layout;
    Text.HitTest := False;
    Text.Align := TAlignLayout.Client;
    Text.TextSettings.FontColor := TAlphaColorRec.White;
    Text.HorzTextAlign := TTextAlign.Center;
    Text.VertTextAlign := TTextAlign.Center;
    Text.Font.Size := 14;
    Text.Text := str;

    lbCategory.AddObject(item);
  end;
var
  i: integer;
begin
  lbCategory.Items.Clear;
  lbCategory.BeginUpdate;

  for i := 0 to frmRecipeCategory.CategoryList.Count-1 do
    if TCategoryItem(frmRecipeCategory.CategoryList.Objects[i]).Selected then
      AddCategoryItem(TCategoryItem(frmRecipeCategory.CategoryList.Objects[i]).CategoryName.Text);

  lbCategory.EndUpdate;
end;

function GetRectString(aRect: TRectF): string;
begin
  result := Format('%5d, %5d, %5d, %5d', [aRect.Round.Left, aRect.Round.Top, aRect.Round.Right, aRect.Round.Bottom]);
end;
function GetPointString(aPoint: TPointF): string;
begin
  result := Format('%5d, %5d', [aPoint.Round.X, aPoint.Round.Y]);
end;

procedure TfrmRecipeEditor.UpdateKBBounds;
var
  LFocused : TControl;
  nScrollY: Single;
  LFocusRect: TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    FNeedOffset := True;

//    FOldControl := TControl(Focused.GetObject);

    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect; // Forcused Control Absolute Rect
    LFocusRect.Offset(scrollRecipe.ViewportPosition);
//    LFocusRect.Offset(0, scrollRecipe.ViewportPosition.Y * -1);

//    if (LFocused.AbsoluteRect.IntersectsWith(TRectF.Create(FKBBounds))) and
//       (LFocusRect.Bottom > FKBBounds.Top) then

    nScrollY := LFocused.AbsoluteRect.Top - recBody.Position.Y;

    showmessage(
      'scrollRecipe.VewportPosition = ' + scrollRecipe.ViewportPosition.Y.ToString + CRLF +
      'Focused.AbsoluteRect Top/Bottom = ' + LFocused.AbsoluteRect.Top.ToString + ' / ' + LFocused.AbsoluteRect.Bottom.ToString + CRLF +
      'FocusedRect.Offset = ' + LFocusRect.Top.ToString + ' / ' + LFocusRect.Bottom.ToString + CRLF +
      'FKBBounds Top/Bottom = ' + FKBBounds.Top.ToString + ' / ' + FKBBounds.Bottom.ToString + CRLF +
      'Client Height = ' + ClientHeight.ToString);


//    showmessage('nScrollY = ' + nScrollY.ToString + ' , FKBBounds.Top = ' + FKBBounds.Top.ToString + ' , FoucedBottom = ' + LFocused.AbsoluteRect.Bottom.ToString + ' Y = ' + LFocused.Position.Y.ToString);
//    showmessage('nScrollY = ' + nScrollY.ToString + ' , FKBBounds.Top = ' + FKBBounds.Top.ToString + ' , FoucedBottom = ' + LFocusRect.Bottom.ToString + ' Y = ' + LFocused.Position.Y.ToString);

    if nSCrollY < 0 then
    begin
      scrollRecipe.ViewportPosition := PointF(0, scrollRecipe.ViewportPosition.Y - (nScrollY * -1) - 20);
    end
//    else if FKeyboardShown and (LFocused.AbsoluteRect.Bottom > FKBBounds.Top) then
    else if FKeyboardShown and (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FOldViewPosition := scrollRecipe.ViewportPosition;

      FNeedOffset := True;
      scrollRecipe.RealignContent;

      layoutScrollBottom.Height := FKBBounds.Bottom - FKBBounds.Top + 120;// - 120;
      scrollRecipe.ViewportPosition := PointF(0, scrollRecipe.ViewportPosition.Y + layoutScrollBottom.Height);

//      scrollRecipe.ViewportPosition := PointF(0, scrollRecipe.ViewportPosition.Y + LFocused.AbsoluteRect.Bottom - FKBBounds.Top);

//      scrollRecipe.ViewportPosition := PointF(0, scrollRecipe.ViewportPosition.Y + LFocusRect.Bottom - FKBBounds.Top);
    end
  end;

  if not FNeedOffset then
    RestorePosition;
end;

{ TRecipeInfo }

procedure TRecipeInfo.Clear;
var
  aStep: TStepInfo;
begin
  Serial := -1;
  State := TRecipeState.rsNew;

  // 삭제된 Steps 정리
  while DeletedSteps.Count > 0 do
  begin
    // 삭제된 Ingredients 정리
    while TStepInfo(DeletedSteps.Objects[0]).DeletedIngredient.Count > 0 do
    begin
      TIngredientInfo(TStepInfo(DeletedSteps.Objects[0]).DeletedIngredient.Objects[0]).layoutIngredientBody.DisposeOf;
      TStepInfo(DeletedSteps.Objects[0]).DeletedIngredient.Delete(0);
    end;
    TStepInfo(DeletedSteps.Objects[0]).DeletedIngredient.Clear;

    TStepInfo(DeletedSteps.Objects[0]).layoutStep.DisposeOf;
    DeletedSteps.Delete(0);
  end;
  DeletedSteps.Clear;

  DeletedImageQue.Clear;

  while Steps.Count > 0 do
  begin
    aStep := GetStep(0);
    Steps.Delete(0);
    aStep.layoutStep.DisposeOf;
    aStep.DisposeOf;
  end;
end;

function TRecipeInfo.GetIngredient(aStepNo,
  aIngredientNo: integer): TIngredientInfo;
begin
  if (aStepNo > -1) and(aIngredientNo > -1) and
     (aStepNo < self.Steps.Count) and
     (aIngredientNo < TStepInfo(self.Steps.Objects[aStepNo]).Ingredients.Count) then
    result := TIngredientInfo(GetStep(aStepNo).Ingredients.Objects[aIngredientNo])
  else
    result := nil;
end;

function TRecipeInfo.GetIngredientNo(IngredientBodyLayout: TLayout): integer;
var
  i, n: integer;
  AStep: TStepInfo;
begin
  result := -1;

  for i := 0 to Self.Steps.Count-1 do
  begin
    AStep := TStepInfo(Self.Steps.Objects[i]);
    for n := 0 to AStep.Ingredients.Count-1 do
      if TIngredientInfo(AStep.Ingredients.Objects[n]).layoutIngredientBody = IngredientBodyLayout then
      begin
        result := n;
        break;
      end;
  end;
end;

function TRecipeInfo.GetStep(aStepNo: integer): TStepInfo;
begin
  if aStepNo <= self.Steps.Count-1 then
    result := TStepInfo(self.Steps.Objects[aStepNo])
  else
    result := nil;
end;

function TRecipeInfo.GetStepNo(StepLayout: TLayout): integer;
var
  i: integer;
begin
  result := -1;

  for i := 0 to self.Steps.Count-1 do
    if TStepInfo(Self.Steps.Objects[i]).layoutStep = StepLayout then
    begin
      result := i;
      break;
    end;
end;

procedure TRecipeInfo.Sort;
var
  n, x,y: integer;
//  aStepTemp: TStepInfo;
//  aIngredientTemp: TIngredientInfo;
begin
  // step sorting
  for x := 0 to self.Steps.Count-1 do
    for y := x+1 to self.Steps.Count-1 do
      if TStepInfo(self.Steps.Objects[x]).layoutStep.Position.Y > TStepInfo(self.Steps.Objects[y]).layoutStep.Position.Y  then
      begin
        self.Steps.Exchange(x, y);
//        aStepTemp := TStepInfo(self.Steps.Objects[x]);
////        self.Steps.Exchange(x,y);
//        self.Steps.Objects[x] := self.Steps.Objects[y];
//        self.Steps.Objects[y] := aStepTemp;
      end;

  // Step 표시를 바뀐 순서에 따라 다시 표시한다
  for x := 0 to self.Steps.Count-1 do
    TStepInfo(self.Steps.Objects[x]).txtStepNo.Text := 'STEP ' + inttostr(x + 1);

  // Step 의 Ingredients Sorting
  for n := 0 to self.Steps.Count-1 do
    for x := 0 to TStepInfo(self.Steps.Objects[n]).Ingredients.Count-1 do
      for y := x+1 to TStepInfo(self.Steps.Objects[n]).Ingredients.Count-1 do
        if TIngredientInfo(TStepInfo(self.Steps.Objects[n]).Ingredients.Objects[x]).layoutIngredientBody.Position.Y >
           TIngredientInfo(TStepInfo(self.Steps.Objects[n]).Ingredients.Objects[y]).layoutIngredientBody.Position.Y then
        begin
          self.Steps.Exchange(x, y);
//          aIngredientTemp := TIngredientInfo(TStepInfo(self.Steps.Objects[n]).Ingredients.Objects[x]);
//          TStepInfo(self.Steps.Objects[n]).Ingredients.Objects[x] := TStepInfo(self.Steps.Objects[n]).Ingredients.Objects[y];
//          TStepInfo(self.Steps.Objects[n]).Ingredients.Objects[y] := aIngredientTemp;
        end;
end;

// Ingredient '수정'을 선택하면 작동한다
procedure TRecipeInfo.ChangeIngredientEditState(IngredientEditText: TText);
var
  StepNo: integer;
  StepLayout: TLayout;
begin
  StepLayout := TLayout(TText(IngredientEditText.Parent).Parent); // laoutStep;

  StepNo := GetStepNo(StepLayout);

  if StepNo > -1 then
    TStepInfo(self.Steps.Objects[StepNo]).CanMovingIngredient := not TStepInfo(self.Steps.Objects[StepNo]).CanMovingIngredient;
end;

{ TPictureInfo }

procedure TPictureInfo.Clear;
begin
  pictureType := TPictureType.ptPicture;
  pictureName := '';
  pictureSquareName := '';
  pictureRectangleName := '';

  State := TRecipeState.rsNew;
end;

{ TRecipeStep }

procedure TStepInfo.OnBodyLayoutMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
var
  curY: Single;
begin
  if FGrab and (ssleft in Shift) then
  begin
    curY := Y - FOffset.Y;
    if curY < -20 then
      curY := -20
    else if curY > (layoutIngredient.Height - 35) then
      curY := (layoutIngredient.Height - 35);

    frmRecipeEditor.imgGrab.Position.Y := curY;
  end;
end;

procedure TStepInfo.OnBodyLayoutMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  layoutIngredient.BeginUpdate;
  FMovingLayout.Position.Y := frmRecipeEditor.imgGrab.Position.Y;
  layoutIngredient.EndUpdate;

  frmRecipeEditor.recWhite.Parent := frmRecipeEditor;
  frmRecipeEditor.recWhite.Visible := False;

  frmRecipeEditor.imgGrab.Parent := frmRecipeEditor;
  frmRecipeEditor.imgGrab.Visible := False;

  FGrab := False;
  frmRecipeEditor.scrollRecipe.AniCalculations.TouchTracking := [ttVertical];
end;

// When Ingredient Delete Image Mouse down
procedure TStepInfo.OnDeleteImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  StepNo, IngredientNo: Integer;
  AStepLayout, AIngredientBodyLayout: TLayout;
begin
  if CanMovingIngredient then
  begin
    if TImage(Sender).Tag = Ord(itRecipeLink) then
      AIngredientBodyLayout := TLayout(TImage(Sender).Parent.Parent)
    else
      AIngredientBodyLayout := TLayout(TImage(Sender).Parent);

    AStepLayout := AIngredientBodyLayout.Parent.Parent as TLayout;

    StepNo := frmRecipeEditor.FRecipe.GetStepNo(AStepLayout);
    IngredientNo := frmRecipeEditor.FRecipe.GetIngredientNo(AIngredientBodyLayout);

    if (StepNo >= 0) and (IngredientNo >= 0) then
    begin
      MessageDlg( '재료/시간을삭제하시겠습니까?',
                 TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0,
      procedure(const AResult: TModalResult)
      var
        AStep: TStepInfo;
        AIngredient: TIngredientInfo;
        h: Single;
      begin
        if AResult = mrYES then
        begin
          AStep := frmRecipeEditor.FRecipe.GetStep(StepNo);
          AIngredient := frmRecipeEditor.FRecipe.GetIngredient(StepNo, IngredientNo);

          h := AIngredient.layoutIngredientBody.Height;

          // 신규-삭제, 기존-DeletedIngredient로 이동
          aStep.Ingredients.Delete(IngredientNo);

          if aIngredient.Serial = NEW_INGREDIENT_SERIAL then
          begin
            aIngredient.layoutIngredientBody.DisposeOf;
            AIngredient.DisposeOf;
          end
          else
          begin
            aIngredient.layoutIngredientBody.Parent := nil;
            aStep.DeletedIngredient.AddObject('', aIngredient)
          end;

          // layoutStep 정리
          aStep.layoutStep.BeginUpdate;
          aStep.layoutIngredient.Height := aStep.layoutIngredient.Height - h;

          aStep.layoutStep.Height := aStep.layoutStepHead.Height + aStep.txtStepIngredientTitle.Height +
                                     aStep.layoutIngredient.Height + aStep.layoutAddIngredient.Height;
          aStep.layoutStep.EndUpdate;

          frmRecipeEditor.ReAlignLayoutStepBody;

          // 남은 재료가 없으면 Moving 상태를 해제한다
          if AStep.Ingredients.Count = 0 then
            CanMovingIngredient := False;
        end;
      end);
    end;
  end;
end;

procedure TStepInfo.OnScaleImageTap(Sender: TObject; const Point: TPointF);
begin
  // 재료 수정중이 아니면
  if not CanMovingIngredient then
  begin
    frmScaleView.SetValue('', _info.login.scale.MaxWeight, smViewMeasure,
      _info.login.scale.UserWeightUnit,
      procedure (const aResult: TStringList)
      var
        aWeight: Single;
        aStepNo, aIngredientNo: LargeInt;
        aStepLayout, aIngredientBodyLayout: TLayout;
        aIngredient: TIngredientInfo;
      begin
        if TImage(Sender).Tag = Ord(itRecipeLink) then
          aIngredientBodyLayout := TLayout(TImage(Sender).Parent.Parent) // layoutIngredientBody
        else
          aIngredientBodyLayout := TLayout(TImage(Sender).Parent); // layoutIngredientBody

        aStepLayout := aIngredientBodyLayout.Parent.Parent as TLayout;

        aStepNo := frmRecipeEditor.FRecipe.GetStepNo(AStepLayout);
        aIngredientNo := frmRecipeEditor.FRecipe.GetIngredientNo(AIngredientBodyLayout);

        aIngredient := frmRecipeEditor.FRecipe.GetIngredient(aStepNo, aIngredientNo);

        if Assigned(aIngredient) and Assigned(aIngredient.txtScale) and Assigned(aResult) and (aResult.Count > 0) then
        begin
          aWeight := StrToFloatDef(aResult[0], 0);

          if aWeight > 0 then
          begin
            aIngredient.txtScale.Text := aWeight.ToString;
            aIngredient.txtScale.Opacity := 1;
            TImage(Sender).Bitmap.Assign(nil);
          end
          else
          begin
            aIngredient.txtScale.Text := '';
            aIngredient.txtScale.Opacity := 0;
            TImage(Sender).Bitmap := frmRecipeEditor.ImageList.Bitmap(TSizeF.Create(80,80), 8);
          end;
        end;
      end
    );
    frmScaleView.Show;
  end;
end;

procedure TStepInfo.OnScaleImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  // 재료 수정중이면
  if CanMovingIngredient then
  begin
    if TImage(Sender).Tag = Ord(itRecipeLink) then
    begin
      FMovingLayout := TLayout(TImage(Sender).Parent.Parent); // layoutIngredientBody

      FOffset.X := X;
      FOffset.Y := FMovingLayout.Padding.Top + TLayout(TImage(Sender).Parent).Height + TLayout(TImage(Sender).Parent).Margins.top + Y;
    end
    else
    begin
      FMovingLayout := TLayout(TImage(Sender).Parent); // layoutIngredientBody

      FOffset.X := X;
      FOffset.Y := FMovingLayout.Padding.Top + Y;
    end;

    FMovingLayout.BringToFront;

    frmRecipeEditor.imgGrab.Parent := layoutIngredient;
    frmRecipeEditor.imgGrab.Position.X := 0;
    frmRecipeEditor.imgGrab.Position.Y := FMovingLayout.Position.Y;
    frmRecipeEditor.imgGrab.Width := FMovingLayout.Width;
    frmRecipeEditor.imgGrab.Height := FMovingLayout.Height;
    frmRecipeEditor.imgGrab.Bitmap := FMovingLayout.MakeScreenshot;

    frmRecipeEditor.recWhite.Parent := FMovingLayout;
    frmRecipeEditor.recWhite.Position.X := 0;
    frmRecipeEditor.recWhite.Position.Y := 0;
    frmRecipeEditor.recWhite.Width := FMovingLayout.Width;
    frmRecipeEditor.recWhite.Height := FMovingLayout.Height;
    frmRecipeEditor.recWhite.Visible := True;
    frmRecipeEditor.recWhite.BringToFront;

    frmRecipeEditor.imgGrab.Visible := True;
    frmRecipeEditor.imgGrab.BringToFront;

    layoutIngredient.Root.Captured := layoutIngredient;

    FGrab := True;
    frmRecipeEditor.scrollRecipe.AniCalculations.TouchTracking := [];
  end;
end;

procedure TStepInfo.SetCanMovingIngredient(const Value: Boolean);
var
  i: integer;
  AIngredient: TIngredientInfo;
begin
  FCanMovingIngredient := Value;

  // 완료일 경우만 Ingredients의 개수가 0이어도 실행
  // 수정을 요청할 때는 Ingredients 가 1개 이상이 되어야 함
  if not FCanMovingIngredient then
  begin
    txtStepIngredientTitleEdit.Text := '수정';
    self.imgAddIngredient.Visible := True;
  end;

  for i := 0 to Ingredients.Count-1 do
  begin
    AIngredient := TIngredientInfo(Ingredients.Objects[i]);

    if FCanMovingIngredient then
    begin
      txtStepIngredientTitleEdit.Text := '완료';
      self.imgAddIngredient.Visible := False;

      AIngredient.imgLeft.Bitmap := frmRecipeEditor.ImageList.Bitmap(TSizeF.Create(60,60), 0);

      AIngredient.txtScale.Visible := False;
      AIngredient.imgScale.Bitmap := frmRecipeEditor.ImageList.Bitmap(TSizeF.Create(60,60), 1);
      AIngredient.imgScale.Visible := True;

      if AIngredient.IngredientType = TIngredientType.itTime then
        AIngredient.recTimerBody.Width := 140;
    end
    else
    begin
      // Ingredient Type 에 따라 해당 아이콘을 가져온다
      case AIngredient.IngredientType of
        itIngredient: AIngredient.imgLeft.Bitmap := frmRecipeEditor.ImageList.Bitmap(TSizeF.Create(60,60), 2);
        itSeasoning: AIngredient.imgLeft.Bitmap := frmRecipeEditor.ImageList.Bitmap(TSizeF.Create(60,60), 3);
        itTime: AIngredient.imgLeft.Bitmap := frmRecipeEditor.ImageList.Bitmap(TSizeF.Create(60,60), 4);
        itRecipeLink: AIngredient.imgLeft.Bitmap := frmRecipeEditor.ImageList.Bitmap(TSizeF.Create(60,60), 5);
      end;

      // 전자저울로 부터 무게값을 가져온 것이 있는지 확인하여, 있으면 숫자만 표시한다
      if AIngredient.IngredientType = itTime then
      begin
        AIngredient.txtScale.Visible := False;
        AIngredient.imgScale.Visible := False;

        AIngredient.recTimerBody.Width := 140 + 40;
      end
      else
      begin
        if AIngredient.txtScale.Text.IsEmpty then
        begin
          AIngredient.txtScale.Visible := False;
          AIngredient.imgScale.Bitmap := frmRecipeEditor.ImageList.Bitmap(TSizeF.Create(60,60), 8);
        end
        else
        begin
          AIngredient.txtScale.Visible := True;
          AIngredient.imgScale.Bitmap.Assign(nil);
        end;
      end;
    end;
  end;
end;

end.
