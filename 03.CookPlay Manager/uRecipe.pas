unit uRecipe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxContainer, cxEdit,
  dxLayoutcxEditAdapters, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxMemo, cxDBEdit, dxLayoutContainer,
  cxTextEdit, cxClasses, dxLayoutControl, cxLabel, Vcl.StdCtrls, cxImage,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin, dxmdaset, CookPlay.Global,
  dxBarBuiltInMenu, cxPC, FireDAC.Stan.Async, FireDAC.DApt, Vcl.ExtCtrls,
  cxSpinEdit, cxCalendar, FireDAC.Phys.SQLiteVDataSet, dxGDIPlusClasses,
  Vcl.DBCtrls, System.DateUtils, cxCheckBox, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  cxCheckComboBox;

type
  TfrmRecipe = class(TForm)
    dsRecipe: TDataSource;
    dsIngredient: TDataSource;
    dsMethod: TDataSource;
    memRecipe: TdxMemData;
    memIngredient: TdxMemData;
    memMethod: TdxMemData;
    sqlTemp: TFDQuery;
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    btnLoadImage: TButton;
    cxLabel5: TcxLabel;
    imgRecipeSquare: TImage;
    btnClearImage: TButton;
    btnSave: TButton;
    btnCancel: TButton;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel6: TcxLabel;
    cxTxtTitle: TcxTextEdit;
    cxMemoDescription: TcxMemo;
    cxSpinServings: TcxSpinEdit;
    cxcboMakingLevel: TcxLookupComboBox;
    cxcboMakingTime: TcxLookupComboBox;
    cxchkPublished: TcxCheckBox;
    cxLabel7: TcxLabel;
    cxtxtHashcode: TcxTextEdit;
    memRecipeSerial: TLargeintField;
    memRecipeUsers_Serial: TLargeintField;
    memRecipeTitle: TWideStringField;
    memRecipeDescription: TWideStringField;
    memRecipePictureType: TWideStringField;
    memRecipePicture: TWideStringField;
    memRecipePictureSquare: TWideStringField;
    memRecipePictureRectangle: TWideStringField;
    memRecipeCategory: TWideStringField;
    memRecipeMakingLevel: TSmallintField;
    memRecipeMakingTime: TSmallintField;
    memRecipeServings: TSmallintField;
    memRecipeHashcode: TWideStringField;
    memRecipeCreatedDate: TDateTimeField;
    memRecipeUpdatedDate: TDateTimeField;
    memRecipePublished: TBooleanField;
    memRecipeDeleted: TBooleanField;
    memRecipeNewPicture: TStringField;
    memRecipePictureState: TStringField;
    memRecipeStateCur: TStringField;
    memRecipeStateBefore: TStringField;
    cxcbo0: TcxCheckComboBox;
    cxcbo1: TcxCheckComboBox;
    cxcbo2: TcxCheckComboBox;
    cxcbo3: TcxCheckComboBox;
    cxtxtCategory: TcxTextEdit;
    cxtxtCategoryTag: TcxTextEdit;
    memMethodSerial: TLargeintField;
    memMethodRecipe_Serial: TLargeintField;
    memMethodPictureType: TSmallintField;
    memMethodPicture: TWideStringField;
    memMethodPictureRectangle: TWideStringField;
    memMethodPictureSquare: TWideStringField;
    memMethodDescription: TWideStringField;
    memMethodSeq: TSmallintField;
    memMethodStepSeq: TSmallintField;
    memMethodNewPicture: TStringField;
    memMethodPictureState: TStringField;
    memMethodStateCur: TStringField;
    memMethodStateBefore: TStringField;
    memIngredientSerial: TLargeintField;
    memIngredientRecipe_Serial: TLargeintField;
    memIngredientRecipeMethod_Serial: TLargeintField;
    memIngredientLinkedRecipe: TLargeintField;
    memIngredientSeq: TIntegerField;
    memIngredientItemType: TSmallintField;
    memIngredientItemWeightValue: TIntegerField;
    memIngredientItemTimeValue: TWideStringField;
    memIngredientItemTemperatureValue: TBCDField;
    memIngredientItemUnit: TSmallintField;
    memIngredientTitle: TWideStringField;
    memIngredientAmount: TWideStringField;
    memIngredientUnit: TWideStringField;
    memIngredientNewPicture: TStringField;
    memIngredientPictureState: TStringField;
    memIngredientStateCur: TStringField;
    memIngredientStateBefore: TStringField;
    pnlBody: TPanel;
    cxGrid1: TcxGrid;
    cxGMethod: TcxGridDBTableView;
    cxGMethodRecId: TcxGridDBColumn;
    cxGMethodSerial: TcxGridDBColumn;
    cxGMethodRecipe_Serial: TcxGridDBColumn;
    cxGMethodSeq: TcxGridDBColumn;
    cxGMethodStepSeq: TcxGridDBColumn;
    cxGMethodDescription: TcxGridDBColumn;
    cxGMethodPictureType: TcxGridDBColumn;
    cxGMethodPicture: TcxGridDBColumn;
    cxGMethodPictureRectangle: TcxGridDBColumn;
    cxGMethodPictureSquare: TcxGridDBColumn;
    cxGMethodNewPicture: TcxGridDBColumn;
    cxGMethodPictureState: TcxGridDBColumn;
    cxGMethodStateCur: TcxGridDBColumn;
    cxGMethodStateBefore: TcxGridDBColumn;
    cxGIngredient: TcxGridDBTableView;
    cxGIngredientRecId: TcxGridDBColumn;
    cxGIngredientSerial: TcxGridDBColumn;
    cxGIngredientRecipe_Serial: TcxGridDBColumn;
    cxGIngredientRecipeMethod_Serial: TcxGridDBColumn;
    cxGIngredientLinkedRecipe: TcxGridDBColumn;
    cxGIngredientSeq: TcxGridDBColumn;
    cxGIngredientItemType: TcxGridDBColumn;
    cxGIngredientItemWeightValue: TcxGridDBColumn;
    cxGIngredientItemTimeValue: TcxGridDBColumn;
    cxGIngredientItemTemperatureValue: TcxGridDBColumn;
    cxGIngredientItemUnit: TcxGridDBColumn;
    cxGIngredientTitle: TcxGridDBColumn;
    cxGIngredientAmount: TcxGridDBColumn;
    cxGIngredientUnit: TcxGridDBColumn;
    cxGIngredientNewPicture: TcxGridDBColumn;
    cxGIngredientPictureState: TcxGridDBColumn;
    cxGIngredientStateCur: TcxGridDBColumn;
    cxGIngredientStateBefore: TcxGridDBColumn;
    cxGIngredientUsed: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    cxGrid1Level1: TcxGridLevel;
    Panel3: TPanel;
    btnEditStep: TButton;
    btnDeleteStep: TButton;
    btnAddStep: TButton;
    btnAddIngredient: TButton;
    btnAddTime: TButton;
    btnAddTemperature: TButton;
    btnEditIngredient: TButton;
    btnDeleteIngredient: TButton;
    memMethodMethodType: TSmallintField;
    cxGMethodMethodType: TcxGridDBColumn;
    btnAddPicture: TButton;
    Bevel1: TBevel;
    deleteRecipe: TButton;
    cxchkDeleted: TcxCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnLoadImageClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearImageClick(Sender: TObject);
    procedure btnEditStepClick(Sender: TObject);
    procedure btnDeleteStepClick(Sender: TObject);
    procedure cxgIngredientCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGMethodCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxcbo0PropertiesClickCheck(Sender: TObject; ItemIndex: Integer;
      var AllowToggle: Boolean);
    procedure cxcbo0PropertiesChange(Sender: TObject);
    procedure btnAddStepClick(Sender: TObject);
    procedure btnAddIngredientClick(Sender: TObject);
    procedure btnEditIngredientClick(Sender: TObject);
    procedure btnDeleteIngredientClick(Sender: TObject);
    procedure deleteRecipeClick(Sender: TObject);
  private
    { Private declarations }
//    FLoadedFileName: string;
    FAddQue: TStringList;
    procedure Copy_A_Record(desTable: TdxMemData; sorTable: TFDTable);
    procedure Copy_All_Record(desTable: TdxMemData; sorTable: TFDQuery);
    procedure ClearRecipeControl;
    procedure SetRecipeControl;
    function InsertTableToDB: Boolean;
    function UpdateTableToDB: Boolean;
    procedure SetSerial(memTable: TdxMemData; sFieldName: string; AOldValue, ANewValue: LargeInt);
    procedure DeleteIngredient(fieldname: string; serial: LargeInt);
    procedure SetMemRecipe;
    procedure SaveImages(ATable: TFDTable; fname: string);
    procedure DeleteImages(ATable: TFDTable);
    procedure CancelTables;
    procedure ApplyIngredient;
    procedure ApplyMethod;
    function GetMaxSeq(aTable: TdxMemData): Integer; overload;
    function GetMaxSeq(aTable: TdxMemData; fieldname: string; serial: LargeInt): Integer; overload;
    function GetMaxStepSeq(aTable: TdxMemData): integer;
    procedure SetCategoryCombobox;
    function GetCheckedCount: integer;
    procedure DisplayCategory;
  public
    { Public declarations }
    procedure Init(AEditingMode: TEditingMode);
  end;

const
  strIngredient = 'SELECT * FROM RecipeIngredient WHERE Recipe_Serial = :RecipeSerial ORDER BY RecipeMethod_Serial, Seq';
  strMethod = 'SELECT * FROM RecipeMethod WHERE Recipe_Serial = :RecipeSerial ORDER BY Seq';

var
  frmRecipe: TfrmRecipe;

implementation
uses uDB, CookPlay.S3, uIngredient, uExplain, uAddTime,
      uAddTemperature, uSelectRecipe, System.UITypes;
{$R *.dfm}

procedure TfrmRecipe.ApplyIngredient;
var
  i, seq: integer;
  beforeMethodSerial: LargeInt;
begin
  // Ingredient Table 을 Update 한다.
  seq := 0;
  beforeMethodSerial := -1;

  memIngredient.First;
  while not memIngredient.Eof do
  begin
    // Method Serial 이 바뀌면 seq 를 0으로 초기화 한다
    if beforeMethodSerial <> memIngredientRecipeMethod_Serial.AsLargeInt  then
    begin
      seq := 0;
      beforeMethodSerial := memIngredientRecipeMethod_Serial.AsLargeInt;
    end;

    if memIngredientStateCur.AsString = DS_INSERT then
    begin
      // Ingredient Table에 Insert 한다
      dmDB.tblRecipeIngredient.Insert;

      for i := 1 to dmDB.tblRecipeIngredient.FieldCount-1 do
        dmDB.tblRecipeIngredient.Fields[i].Value := memIngredient.Fields[i+1].Value;

      dmDB.tblRecipeIngredient.FieldByName('seq').AsInteger := seq;
      seq := seq + 1;

      dmDB.tblRecipeIngredient.Post;

      if memIngredientPictureState.AsString = DS_INSERT then
      begin
        dmDB.tblRecipeIngredient.Edit;
        SaveImages(dmDB.tblRecipeIngredient, memIngredientNewPicture.AsString);
        dmDB.tblRecipeIngredient.Post;
      end;
    end
    else if memIngredientStateCur.AsString = DS_EDIT then
    begin
      // Ingredient Table에 Update 한다
      if dmDB.tblRecipeIngredient.Locate('Serial', memIngredientSerial.AsLargeInt, [loCaseInsensitive]) then
      begin
        dmDB.tblRecipeIngredient.Edit;

        for i := 1 to dmDB.tblRecipeIngredient.FieldCount-1 do
          dmDB.tblRecipeIngredient.Fields[i].Value := memIngredient.Fields[i+1].Value;

        dmDB.tblRecipeIngredient.FieldByName('seq').AsInteger := seq;
        seq := seq + 1;

        if memIngredientPictureState.AsString = DS_INSERT then
          SaveImages(dmDB.tblRecipeIngredient, memIngredientNewPicture.AsString)
        else if memIngredientPictureState.AsString = DS_EDIT then
        begin
          DeleteImages(dmDB.tblRecipeIngredient);
          SaveImages(dmDB.tblRecipeIngredient, memIngredientNewPicture.AsString);
        end
        else if memIngredientPictureState.AsString = DS_DELETE then
          DeleteImages(dmDB.tblRecipeIngredient);

        dmDB.tblRecipeIngredient.Post;
      end
      else
        ShowMessage('재료를 업데이트 하지 못하였습니다!');
    end
    else if memIngredientStateCur.AsString = DS_DELETE then
    begin
      // Ingredient Table 에 원래 존재하는 것이면 삭제 적용하고, 아니면 그냥 Skip
      if dmDB.tblRecipeIngredient.Locate('Serial', memIngredientSerial.AsLargeInt, [loCaseInsensitive]) then
      begin
        dmDB.tblRecipeIngredient.Delete;
      end
      else
        Showmessage('재료를 삭제하지 못하였습니다!');
    end
    else if memIngredientStateCur.AsString = DS_NONE then
    begin
      // Ingredient Table의 seq 를 Update 한다
      if dmDB.tblRecipeIngredient.Locate('Serial', memIngredientSerial.AsLargeInt, [loCaseInsensitive]) then
      begin
        dmDB.tblRecipeIngredient.Edit;
        dmDB.tblRecipeIngredient.FieldByName('seq').AsInteger := seq;
        seq := seq + 1;
        dmDB.tblRecipeIngredient.Post;
      end;
    end;

    memIngredient.Next;
  end;
end;

procedure TfrmRecipe.ApplyMethod;
var
  i, seq, StepSeq: integer;
  nOldLastID, nNewLastID: LargeInt;
begin
  // Method Table 을 Update 한다.
  seq := 0;
  StepSeq := 1;
  memMethod.First;
  while not memMethod.Eof do
  begin
    if memMethodStateCur.AsString = DS_INSERT then
    begin
      nOldLastID := memMethodSerial.AsLargeInt;

      // Method Table에 Insert 한다
      dmDB.tblRecipeMethod.Insert;

      for i := 1 to dmDB.tblRecipeMethod.FieldCount-1 do
        dmDB.tblRecipeMethod.Fields[i].Value := memMethod.Fields[i+1].Value;

      dmDB.tblRecipeMethod.FieldByName('Seq').AsInteger := seq;
      seq := seq + 1;

      if memMethodMethodType.AsInteger = _type.methodStep then // not memMethodDescription.AsString.IsEmpty then
      begin
        dmDB.tblRecipeMethod.FieldByName('StepSeq').AsInteger := StepSeq;
        StepSeq := StepSeq + 1;
      end;

      dmDB.tblRecipeMethod.Post;

      nNewLastID := dmDB.tblRecipeMethod.FieldByName('Serial').AsLargeInt;

//      nNewLastID := dmDB.GetLastID;
//      if nNewLastID = -1 then
//        raise Exception.Create('Method 시리얼을 읽어올 수 없습니다');

      // Ingredient 의 RecipeMethod_Serial 을 새로운 것으로 세팅한다
      SetSerial(memIngredient, 'RecipeMethod_Serial', nOldLastID, nNewLastID);

      if memMethodPictureState.AsString = DS_INSERT then
      begin
        dmDB.tblRecipeMethod.Edit;
        SaveImages(dmDB.tblRecipeMethod, memMethodNewPicture.AsString);
        dmDB.tblRecipeMethod.Post;
      end;
    end
    else if memMethodStateCur.AsString = DS_EDIT then
    begin
      // Method Table에 Update 한다
      if dmDB.tblRecipeMethod.Locate('Serial', memMethodSerial.AsLargeInt, [loCaseInsensitive]) then
      begin
        dmDB.tblRecipeMethod.Edit;

        for i := 1 to dmDB.tblRecipeMethod.FieldCount-1 do
          dmDB.tblRecipeMethod.Fields[i].Value := memMethod.Fields[i+1].Value;

        dmDB.tblRecipeMethod.FieldByName('Seq').AsInteger := seq;
        seq := seq + 1;

        if not memMethodDescription.AsString.IsEmpty then
        begin
          dmDB.tblRecipeMethod.FieldByName('StepSeq').AsInteger := StepSeq;
          StepSeq := StepSeq + 1;
        end;

        if memMethodPictureState.AsString = DS_INSERT then
          SaveImages(dmDB.tblRecipeMethod, memMethodNewPicture.AsString)
        else if memMethodPictureState.AsString = DS_EDIT then
        begin
          DeleteImages(dmDB.tblRecipeMethod);
          SaveImages(dmDB.tblRecipeMethod, memMethodNewPicture.AsString);
        end
        else if memMethodPictureState.AsString = DS_DELETE then
          DeleteImages(dmDB.tblRecipeMethod);

        dmDB.tblRecipeMethod.Post;
      end;
    end
    else if memMethodStateCur.AsString = DS_DELETE then
    begin
      if dmDB.tblRecipeMethod.Locate('Serial', memMethodSerial.AsLargeInt, [loCaseInsensitive]) then
      begin
        if trim(dmDB.tblRecipeMethod.FieldByName('Picture').AsString) <> '' then
        begin
          dmDB.tblRecipeMethod.Edit;
          DeleteImages(dmDB.tblRecipeMethod);
          dmDB.tblRecipeMethod.Post;
        end;

        DeleteIngredient('RecipeMethod_Serial', memMethodSerial.AsLargeInt);

        dmDB.tblRecipeMethod.Delete;
      end
      else
        Showmessage('STEP을 삭제하지 못하였습니다!');
    end
    else if memMethodStateCur.AsString = DS_NONE then
    begin
      if dmDB.tblRecipeMethod.Locate('Serial', memMethodSerial.AsLargeInt, [loCaseInsensitive]) then
      begin
        dmDB.tblRecipeMethod.Edit;

        dmDB.tblRecipeMethod.FieldByName('Seq').AsInteger := seq;
        seq := seq + 1;

        if not memMethodDescription.AsString.IsEmpty then
        begin
          dmDB.tblRecipeMethod.FieldByName('StepSeq').AsInteger := StepSeq;
          StepSeq := StepSeq + 1;
        end;

        dmDB.tblRecipeMethod.Post;
      end;
    end;

    memMethod.Next;
  end;
end;

procedure TfrmRecipe.btnAddStepClick(Sender: TObject);
var
  maxseq: integer;
begin
  maxseq := GetMaxSeq(memMethod);

  memMethod.Insert;

  memMethodSerial.AsLargeInt := DateTimetoUnix(now);
  memMethodRecipe_Serial.AsLargeInt := memRecipeSerial.AsLargeInt;
  memMethodStepSeq.AsInteger := _type.firstSeq;
  memMethodSeq.AsInteger := maxseq;

  memMethodPictureType.AsInteger := _type.Picture.still;

  memMethodStateBefore.AsString := DS_INSERT;
  memMethodStateCur.AsString := DS_INSERT;

  if Sender = btnAddStep then
    memMethodMethodType.AsInteger := _type.methodStep
  else
    memMethodMethodType.AsInteger := _type.methodPicture;

  if frmExplain.ShowModal = mrOK then
    memMethod.Post
  else
    memMethod.Cancel;

  memMethod.EnableControls;
end;

procedure TfrmRecipe.btnAddIngredientClick(Sender: TObject);
var
  beforeSerial, nMethodSerial: LargeInt;
  maxseq: integer;
begin
  if memMethod.RecordCount = 0 then
  begin
    ShowMessage('STEP이 없습니다');
    Exit;
  end;

  if memMethodMethodType.AsInteger <> _type.methodStep then
  begin
    ShowMessage('STEP 에만 추가할 수 있습니다!');
    Exit;
  end;


  beforeSerial := memIngredientSerial.AsLargeInt;
  nMethodSerial := memMethodSerial.AsLargeInt;

  maxseq := GetMaxSeq(memIngredient, 'RecipeMethod_Serial', memMethodSerial.AsLargeInt);

//  memIngredient.Locate('Serial', beforeSerial, [loCaseInsensitive]);

  memIngredient.Insert;

  memIngredientSerial.AsLargeInt := DateTimetoUnix(now);
  memIngredientRecipe_Serial.AsLargeInt := memRecipeSerial.AsLargeInt;
  memIngredientRecipeMethod_Serial.AsLargeInt := nMethodSerial;

  memIngredientLinkedRecipe.AsLargeInt := _type.notLinked;
  memIngredientSeq.AsInteger := maxseq;

  memIngredientStateBefore.AsString := DS_INSERT;
  memIngredientStateCur.AsString := DS_INSERT;

    try
      if Sender = btnAddIngredient then
      begin
        memIngredientItemtype.AsInteger := _type.ingredient;
        memIngredientItemUnit.AsInteger := _type.weight_g;

        if frmIngredient.ShowModal = mrOK then
          memIngredient.Post
        else
          memIngredient.Cancel;
      end
      else if Sender = btnAddTime then
      begin
        memIngredientItemtype.AsInteger := _type.ingredient_time;
        memIngredientItemTimeValue.AsString := '00:00:00';

        if frmAddTime.ShowModal = mrOK then
          memIngredient.Post
        else
          memIngredient.Cancel;
      end
      else if Sender = btnAddTemperature then
      begin
        memIngredientItemtype.AsInteger := _type.ingredient_temperature;
        memIngredientItemTemperatureValue.AsFloat := 0;

        if frmAddTemperature.ShowModal = mrOK then
          memIngredient.Post
        else
          memIngredient.Cancel;
      end;
    except
      on E: Exception do
      begin
        memIngredient.Cancel;
        ShowMessage(E.Message);
      end;
    end;
end;

procedure TfrmRecipe.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRecipe.btnSaveClick(Sender: TObject);
begin

  try
    memMethod.DisableControls;
    memIngredient.DisableControls;

    if (memRecipeStateCur.AsString = DS_INSERT) and InsertTableToDB then
      Close
    else if (memRecipeStateCur.AsString = DS_EDIT) and UpdateTableToDB then
      Close;

  finally
    memIngredient.EnableControls;
    memMethod.EnableControls;
  end;
end;

procedure TfrmRecipe.btnEditIngredientClick(Sender: TObject);
begin
  if memIngredient.RecordCount <= 0 then
  begin
    ShowMessage('수정할 데이터가 없습니다!');
    Exit;
  end;

  if memIngredientStateCur.AsString = DS_DELETE then
  begin
    ShowMessage('삭제된 대이터입니다!');
    Exit;
  end;

  memIngredient.Edit;
  // DS_INSERT 와 DS_EDIT 의 상태에서는 state 변화를 주지 않는다
  // DS_NONE -> DS_EDIT
  // DS_EDIT -> DS_EDIT
  // DS_INSERT -> DS_INSERT
  if memIngredientStateCur.AsString = DS_NONE then
  begin
    memIngredientStateBefore.AsString := DS_NONE;
    memIngredientStateCur.AsString := DS_EDIT;
  end;

  if memIngredientItemType.AsInteger = _type.ingredient then
  begin
    if frmIngredient.ShowModal = mrOK then
      memIngredient.Post
    else
      memIngredient.Cancel;
  end
  else if memIngredientItemType.AsInteger = _type.ingredient_temperature then
  begin
    if frmAddTemperature.ShowModal = mrOK then
      memIngredient.Post
    else
      memIngredient.Cancel;
  end
  else if memIngredientItemType.AsInteger = _type.ingredient_time then
  begin
    if frmAddTime.ShowModal = mrOK then
      memIngredient.Post
    else
      memIngredient.Cancel;
  end;
end;

procedure TfrmRecipe.btnDeleteIngredientClick(Sender: TObject);
begin
  if memIngredient.RecordCount <= 0 then
  begin
    ShowMessage('삭제할 데이터가 없습니다!');
    Exit;
  end;

  if memIngredientStateCur.AsString = DS_DELETE then
  begin
    ShowMessage('삭제된 대이터입니다!');
    Exit;
  end;

  if MessageDlg('삭제하시겠습니까?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    if memIngredientStateBefore.AsString = DS_INSERT then
      memIngredient.Delete
    else
    begin
      try
        memIngredient.Edit;
        memIngredientStateBefore.AsString := memIngredientStateCur.AsString;
        memIngredientStateCur.AsString := DS_DELETE;
        memIngredient.Post;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
    end;
  end;
end;

procedure TfrmRecipe.btnLoadImageClick(Sender: TObject);
var
  imgOrigin: TImage;
  oldNewPicture, oldPictureState: string;
  fname: string;
begin
  oldNewPicture := memRecipeNewPicture.AsString;
  oldPictureState := memRecipePictureState.AsString;

  imgOrigin := TImage.Create(self);

  try
    if dmS3.OpenPictureDialog.Execute then
    begin
      fname := dmS3.OpenPictureDialog.FileName;
      if FileExists(fname) then
      begin
        if dmS3.IsValidImage(fname) then
        begin
          imgOrigin.Picture.LoadFromFile(fname);
          dmS3.CropImageToJPEG(imgOrigin, imgRecipeSquare, SizeSequre);

          memRecipe.Edit;
          if memRecipePicture.AsString.IsEmpty then
            memRecipePictureState.AsString := DS_INSERT
          else
            memRecipePictureState.AsString := DS_EDIT;

          memRecipeNewPicture.AsString := fname;
          memRecipe.Post;
        end
        else
          ShowMessage('지원하는 이미지 타입이 아닙니다!');
      end
      else
        ShowMessage('파일을 찾을 수 없습니다!');
    end;
  except
    memRecipe.Edit;
    memRecipe['NewPicture'] := oldNewPicture;
    memRecipe['PictureState'] := oldPictureState;
    memRecipe.Post;
  end;

  imgOrigin.Free;
end;

procedure TfrmRecipe.btnDeleteStepClick(Sender: TObject);
var
  nMethodSerial: LargeInt;
  recno: LargeInt;
begin
  if memMethod.RecordCount = 0 then
  begin
    ShowMessage('삭제할 STEP이 없습니다!');
    Exit;
  end;

  if memMethodStateCur.AsString = DS_DELETE then
  begin
    ShowMessage('이미 삭제된 STEP입니다!');
    Exit;
  end;

  if MessageDlg('삭제하시겠습니까?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    recno := memMethod.RecNo;

    memMethod.DisableControls;
    memIngredient.DisableControls;

    // Insert 된 method 이면 바로 삭제한다. Ingredient 도...
    if memMethodStateBefore.AsString = DS_INSERT then
    begin
      memIngredient.First;
      while not memIngredient.eof do
      begin
        if memIngredientRecipeMethod_Serial.AsLargeInt = memMethodSerial.AsLargeInt then
          memIngredient.Delete;

        memIngredient.Next;
      end;

      memMethod.Delete;
    end
    else
    begin
      try
        nMethodSerial := memMethodSerial.AsLargeInt;
        memIngredient.First;
        while not memIngredient.eof do
        begin
          if memIngredientRecipeMethod_Serial.AsLargeInt = nMethodSerial then
          begin
            // 재료를 삭제한다
            if memIngredientStateBefore.AsString = DS_INSERT then
              memIngredient.Delete
            else if memIngredientStateCur.AsString <> DS_DELETE then
            begin
              memIngredient.Edit;
              memIngredientStateBefore.AsString := memIngredientStateCur.AsString;
              memIngredientStateCur.AsString := DS_DELETE;
              memIngredient.Post;
            end;
          end;
          memIngredient.Next;
        end;

        memMethod.Edit;
        memMethodStateBefore.AsString := memMethodStateCur.AsString;
        memMethodStateCur.AsString := DS_DELETE;
        memMethod.Post;
     except
        on E: Exception do
          ShowMessage(E.Message);
      end;
    end;

    memIngredient.EnableControls;
    memMethod.EnableControls;

    memMethod.RecNo := recno;
  end;
end;

procedure TfrmRecipe.btnEditStepClick(Sender: TObject);
begin
  if memMethod.Eof then
  begin
    ShowMessage('수정할 STEP이 없습니다!');
    Exit;
  end;

  if memMethodStateCur.AsString = DS_DELETE then
  begin
    ShowMessage('삭제된 STEP입니다!');
    Exit;
  end;

  memMethod.Edit;
  // DS_INSERT 와 DS_EDIT 의 상태에서는 state 변화를 주지 않는다
  // DS_NONE -> DS_EDIT
  // DS_EDIT -> DS_EDIT
  // DS_INSERT -> DS_INSERT
  if memMethodStateCur.AsString = DS_NONE then
  begin
    memMethodStateBefore.AsString := DS_NONE;
    memMethodStateCur.AsString := DS_EDIT;
  end;

  if frmExplain.ShowModal = mrOK then
    memMethod.Post
  else
    memMethod.Cancel;
end;

procedure TfrmRecipe.btnClearImageClick(Sender: TObject);
begin
  imgRecipeSquare.Picture.Assign(nil);

  memRecipe.Edit;

  if memRecipePicture.AsString.IsEmpty then
    memRecipePictureState.AsString := DS_NONE
  else
    memRecipePictureState.AsString := DS_DELETE;

  memRecipeNewPicture.AsString := '';

  memRecipe.Post;
end;

procedure TfrmRecipe.CancelTables;
begin
  if dmDB.tblRecipe.State in [dsInsert, dsEdit] then
    dmDB.tblRecipe.Cancel;

  if dmDB.tblRecipeIngredient.State in [dsInsert, dsEdit] then
    dmDB.tblRecipeIngredient.Cancel;

  if dmDB.tblRecipeMethod.State in [dsInsert, dsEdit] then
    dmDB.tblRecipeMethod.Cancel;
end;

procedure TfrmRecipe.ClearRecipeControl;
begin
  cxtxtTitle.Clear;
  cxMemoDescription.Clear;
  imgRecipeSquare.Picture.Assign(nil);

  cxcbo0.Properties.items.Clear;
  cxcbo1.Properties.items.Clear;
  cxcbo2.Properties.items.Clear;
  cxcbo3.Properties.items.Clear;

  cxSpinServings.Value := 1;
  cxcboMakingLevel.Clear;
  cxcboMakingTime.Clear;
  cxchkDeleted.Clear;
end;

procedure TfrmRecipe.Copy_All_Record(desTable: TdxMemData; sorTable: TFDQuery);
var
  i: integer;
begin
  desTable.Open;
  desTable.DisableControls;

  sorTable.First;

  while not sorTable.Eof do
  begin
    desTable.Append;

    for i := 0 to sorTable.FieldCount-1 do
      desTable.Fields[i+1].Value := sorTable.Fields[i].Value;

    desTable['NewPicture'] := '';
    desTable['PictureState'] := DS_NONE;
    desTable['StateBefore'] := DS_NONE;
    desTable['StateCur'] := DS_NONE;

    desTable.Post;

    sorTable.Next;
  end;

  desTable.First;

  desTable.EnableControls;
end;

procedure TfrmRecipe.Copy_A_Record(desTable: TdxMemData; sorTable: TFDTable);
var
  i: integer;
begin
  if not sorTable.eof then
  begin
    desTable.Append;

    //TdxMemData 는 첫번째 필드가 'RecId'로 자동 세팅되므로 1개 Skip 한다
    for i := 0 to sorTable.FieldCount-1 do
      desTable.Fields[i+1].Value := sorTable.Fields[i].Value;

    desTable['UpdatedDate'] := now;
    desTable['NewPicture'] := '';
    desTable['PictureState'] := DS_NONE;
    desTable['StateBefore'] := DS_NONE;
    desTable['StateCur'] := DS_EDIT;

    desTable.Post;
  end;
end;

procedure TfrmRecipe.cxcbo0PropertiesChange(Sender: TObject);
begin
  DisplayCategory;
end;

procedure TfrmRecipe.cxcbo0PropertiesClickCheck(Sender: TObject;
  ItemIndex: Integer; var AllowToggle: Boolean);
begin
  if GetCheckedCount >= 10 then
  begin
    ShowMessage('최대 10개까지 선택이 가능합니다');
    AllowToggle := False;
  end;
end;

procedure TfrmRecipe.cxgIngredientCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
var
  iIndex: integer;
begin
  iIndex := AViewInfo.RecordViewInfo.GridRecord.Index;

  if Sender.DataController.GetValue(iIndex, cxgIngredientStateCur.Index) = DS_DELETE then
  begin
    ACanvas.Font.Color := clSilver;
    ACanvas.Font.Style := [fsStrikeOut];
  end
  else if Sender.DataController.GetValue(iIndex, cxgIngredientUsed.Index) = True then
    ACanvas.Font.Style := [fsBold];
end;

procedure TfrmRecipe.cxGMethodCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
var
  iIndex: integer;
begin
  iIndex := AViewInfo.RecordViewInfo.GridRecord.Index;

  if Sender.DataController.GetValue(iIndex, cxgMethodStateCur.Index) = DS_DELETE then
  begin
    ACanvas.Font.Color := clSilver;
    ACanvas.Font.Style := [fsStrikeOut];
  end;
end;

procedure TfrmRecipe.DeleteImages(ATable: TFDTable);
begin
  if ATable.State <> dsEdit then
    raise Exception.Create('이미지 삭제정보를 테이블에 저장할 수 없습니다');

  if trim(ATable.FieldByName('Picture').AsString) <> '' then
    dmDB.AddtoDeleteImageQue(BUCKET_RECIPE, ATable.FieldByName('Picture').AsString);

  if trim(ATable.FieldByName('PictureSquare').AsString) <> '' then
    dmDB.AddtoDeleteImageQue(BUCKET_RECIPE, ATable.FieldByName('PictureSquare').AsString);

  if trim(ATable.FieldByName('PictureRectangle').AsString) <> '' then
    dmDB.AddtoDeleteImageQue(BUCKET_RECIPE, ATable.FieldByName('PictureRectangle').AsString);

  ATable.FieldByName('Picture').AsString := '';
  ATable.FieldByName('PictureSquare').AsString := '';
  ATable.FieldByName('PictureRectangle').AsString := '';
end;

procedure TfrmRecipe.DeleteIngredient(fieldname: string; serial: LargeInt);
begin
  memIngredient.First;
  while not memIngredient.eof do
  begin
    if memIngredientRecipeMethod_Serial.AsLargeInt = serial then
    begin
      if dmDB.tblRecipeIngredient.Locate('Serial', memIngredientSerial.AsLargeInt, [loCaseInsensitive]) then
      begin
        if trim(dmDB.tblRecipeIngredient.FieldByName('Picture').AsString) <> '' then
        begin
          dmDB.tblRecipeIngredient.Edit;
          DeleteImages(dmDB.tblRecipeIngredient);
          dmDB.tblRecipeIngredient.Post;
        end;

        dmDB.tblRecipeIngredient.Delete
      end
      else
        ShowMessage('Step에 해당하는 재료들을 삭제하지 못했습니다!');

      memIngredient.Delete;
    end
    else
      memIngredient.Next;
  end;
end;

procedure TfrmRecipe.deleteRecipeClick(Sender: TObject);
begin
  if MessageDlg('레시피를 실제로 삭제하시겠습니까?'+#13#10+'쿡북에 연결된 레시피도 삭제됩니다!', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    if memRecipeStateBefore.AsString = DS_INSERT then
      Close
    else
    begin
      try
        dmDB.FDConnection.StartTransaction;

        memIngredient.First;
        while not memIngredient.eof do
        begin
          if memIngredientStateBefore.AsString <> DS_INSERT then
          begin
            if dmDB.tblRecipeIngredient.Locate('Serial', memIngredientSerial.AsLargeInt, [loCaseInsensitive]) then
            begin
              if dmDB.tblRecipe.FieldByName('Picture').AsString.Trim <> '' then
              begin
                dmDB.tblRecipe.Edit;
                DeleteImages(dmDB.tblRecipe);
                dmDB.tblRecipe.Post;
              end;

              dmDB.tblRecipeIngredient.Delete
            end
            else
              memIngredient.Next;
          end
          else
            memIngredient.Next;
        end;

        memMethod.First;
        while not memMethod.eof do
        begin
          if memMethodStateBefore.AsString <> DS_INSERT then
          begin
            if dmDB.tblRecipeMethod.Locate('Serial', memMethodSerial.AsLargeInt, [loCaseInsensitive]) then
            begin
              if dmDB.tblRecipeMethod.FieldByName('Picture').AsString.Trim <> '' then
              begin
                dmDB.tblRecipeMethod.Edit;
                DeleteImages(dmDB.tblRecipeMethod);
                dmDB.tblRecipeMethod.Post;
              end;
              dmDB.tblRecipeMethod.Delete
            end
            else
              memMethod.Next;
          end
          else
            memMethod.Next;
        end;

        dmDB.DeleteRecipeRecommendation(memRecipeSerial.AsLargeInt);
        dmDB.DeleteRecipeComment(memRecipeSerial.AsLargeInt);
        dmDB.DeleteCookbookRecipe(memRecipeSerial.AsLargeInt);
        dmDB.DeleteFeed(_type.feedRecipe, memRecipeSerial.AsLargeInt);

        if dmDB.tblRecipe.Locate('Serial', memRecipeSerial.AsLargeInt, [loCaseInsensitive]) then
        begin
          if dmDB.tblRecipe.FieldByName('Picture').AsString.Trim <> '' then
          begin
            dmDB.tblRecipe.Edit;
            DeleteImages(dmDB.tblRecipe);
            dmDB.tblRecipe.Post;
          end;

          dmDB.tblRecipe.Delete;
        end;

        dmDB.FDConnection.Commit;

        Close;
      except
        On E:Exception Do
        begin
          CancelTables;
          dmDB.FDConnection.Rollback;
          ShowMessage(E.Message);
        end;
      end;
    end;
  end;
end;

procedure TfrmRecipe.DisplayCategory;
var
  List, tagList: TStringList;
  i: integer;
begin
  List := TStringList.Create;
  tagList := TStringList.Create;

  for i := 0 to cxcbo0.Properties.Items.Count-1 do
    if cxcbo0.States[i] = cbsChecked then
    begin
      List.Add(cxcbo0.Properties.Items[i].Description);
      tagList.Add(cxcbo0.Properties.Items[i].Tag.ToString);
    end;

  for i := 0 to cxcbo1.Properties.Items.Count-1 do
    if cxcbo1.States[i] = cbsChecked then
    begin
      List.Add(cxcbo1.Properties.Items[i].Description);
      tagList.Add(cxcbo1.Properties.Items[i].Tag.ToString);
    end;

  for i := 0 to cxcbo2.Properties.Items.Count-1 do
    if cxcbo2.States[i] = cbsChecked then
    begin
      List.Add(cxcbo2.Properties.Items[i].Description);
      tagList.Add(cxcbo2.Properties.Items[i].Tag.ToString);
    end;

  for i := 0 to cxcbo3.Properties.Items.Count-1 do
    if cxcbo3.States[i] = cbsChecked then
    begin
      List.Add(cxcbo3.Properties.Items[i].Description);
      tagList.Add(cxcbo3.Properties.Items[i].Tag.ToString);
    end;

  cxtxtCategory.Clear;
  cxtxtCategoryTag.Clear;
  for i := 0 to List.Count-1 do
    if i=0 then
    begin
      cxtxtCategory.Text := List.Strings[i];
      cxtxtCategoryTag.Text := tagList.Strings[i];
    end
    else
    begin
      cxtxtCategory.Text := cxtxtCategory.text + ';' + List.Strings[i];
      cxtxtCategoryTag.Text := cxtxtCategoryTag.Text + ';' + tagList.Strings[i];
    end;

  tagList.Free;
  List.Free;
end;

procedure TfrmRecipe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FAddQue.Free;
  memRecipe.Close;
  memIngredient.Close;
  memMethod.Close;
  sqlTemp.Close;
end;

procedure TfrmRecipe.FormShow(Sender: TObject);
begin
  FAddQue := TStringList.Create;
end;

function TfrmRecipe.GetCheckedCount: integer;
var
  i: integer;
begin
  result := 0;

  for i := 0 to cxcbo0.Properties.Items.Count-1 do
    if cxcbo0.States[i] = cbsChecked then
      result := result + 1;

  for i := 0 to cxcbo1.Properties.Items.Count-1 do
    if cxcbo1.States[i] = cbsChecked then
      result := result + 1;

  for i := 0 to cxcbo2.Properties.Items.Count-1 do
    if cxcbo2.States[i] = cbsChecked then
      result := result + 1;

  for i := 0 to cxcbo3.Properties.Items.Count-1 do
    if cxcbo3.States[i] = cbsChecked then
      result := result + 1;
end;

function TfrmRecipe.GetMaxSeq(aTable: TdxMemData; fieldname: string;
  serial: LargeInt): Integer;
begin
  result := _type.firstSeq;

  aTable.First;
  while not aTable.Eof do
  begin
    if (aTable.FieldByName(fieldname).AsLargeInt = serial) and (aTable.FieldByName('seq').AsInteger >= result) then
      result := aTable.FieldByName('seq').AsInteger + 1;

    aTable.Next;
  end;
end;

function TfrmRecipe.GetMaxStepSeq(aTable: TdxMemData): integer;
begin
  result := _type.firstSeq;

  aTable.First;
  while not aTable.Eof do
  begin
    if aTable.FieldByName('StepSeq').AsInteger >= result then
      result := aTable.FieldByName('StepSeq').AsInteger + 1;

    aTable.Next;
  end;
end;

function TfrmRecipe.GetMaxSeq(aTable: TdxMemData): Integer;
begin
  result := _type.firstSeq;

  aTable.First;
  while not aTable.Eof do
  begin
    if aTable.FieldByName('seq').AsInteger >= result then
      result := aTable.FieldByName('seq').AsInteger + 1;

    aTable.Next;
  end;
end;

procedure TfrmRecipe.Init(AEditingMode: TEditingMode);
begin
  ClearRecipeControl;

  SetCategoryCombobox;
  cxtxtCategory.Clear;
  cxtxtCategoryTag.Clear;

  memMethod.DisableControls;
  memIngredient.DisableControls;

  memRecipe.Open;

  if AEditingMode = edInsert then
  begin
    memRecipe.Insert;

    memRecipe['Serial'] := DateTimetoUnix(now);
    memRecipe['Users_Serial'] := dmDB.sqlUser.FieldByName('Serial').AsLargeInt;
    memRecipe['PictureType'] := _type.picture.still;
    memRecipe['Category'] := '';
    memRecipe['MakingLevel'] := _type.MakingLevel.level0;
    memRecipe['MakingTime'] := _type.MakingTime.level0;
    memRecipe['Servings'] := 1;
    memRecipe['Published'] := _type.publish;
    memRecipe['Deleted'] := _type.unDeleted;
    memRecipe['CreatedDate'] := now;
    memRecipe['UpdatedDate'] := now;

    memRecipe['NewPicture'] := '';
    memRecipe['PictureState'] := DS_NONE;
    memRecipe['StateBefore'] := DS_INSERT;
    memRecipe['StateCur'] := DS_INSERT;

    memRecipe.Post;

    SetRecipeControl;

    memIngredient.Open;
    memMethod.Open;
  end
  else if AEditingMode = edUpdate then
  begin
    // 레시피 데이터 가져오기
    Copy_A_Record(memRecipe, dmDB.tblRecipe);

    SetRecipeControl;

    // 재료가져오기
    sqlTemp.SQL.Text := strIngredient;
    sqlTemp.ParamByName('RecipeSerial').Value := dmDB.tblRecipe.FieldByName('Serial').Value;
    sqlTemp.Open;
    Copy_All_Record(memIngredient, sqlTemp);

    // 방법가져오기
    sqlTemp.SQL.Text := strMethod;
    sqlTemp.ParamByName('RecipeSerial').Value := dmDB.tblRecipe.FieldByName('Serial').Value;
    sqlTemp.Open;
    Copy_All_Record(memMethod, sqlTemp);

    sqlTemp.Close;
  end;

  memIngredient.EnableControls;
  memMethod.EnableControls;
end;

function TfrmRecipe.InsertTableToDB: Boolean;
var
  i: integer;
  nOldLastID, nNewLastID: LargeInt;
begin
  result := False;

  if memRecipe.RecordCount = 0 then
  begin
    ShowMessage('추가할 레시피가 없습니다!');
    Exit;
  end;

  FAddQue.Clear;
  dmDB.tblRecipe.DisableControls;

  try
    dmDB.FDConnection.StartTransaction;

    // memRecipe 에 Control 에 입력된 값을 세팅한다
    SetMemRecipe;

    // 현재의 Recipe Serial을 가져온다
    nOldLastID := memRecipe.FieldByName('Serial').AsLargeInt;

    // 데이터를 Recipe Table에 복사할 때 memory Field 에서
    // 0번째 Field 인 Serial 과
    // 마지막에서 3개의 필드 NewPicture, PictureState, State 는 제외한다
    dmDB.tblRecipe.insert;
    for i := 1 to dmDB.tblRecipe.FieldCount-1 do
      dmDB.tblRecipe.Fields[i].Value := memRecipe.Fields[i+1].Value;
    dmDB.tblRecipe.Post;

    // Recipe Image 처리
    if memRecipePictureState.AsString = DS_INSERT then
    begin
      dmDB.tblRecipe.Edit;
      SaveImages(dmDB.tblRecipe, memRecipeNewPicture.AsString);
      dmDB.tblRecipe.Post;
    end;

    // 추가된 Recipe Serial을 읽어옴
    nNewLastID := dmDB.tblRecipe.FieldByName('Serial').AsLargeInt;
//    nNewLastID := dmDB.GetLastID;
//    // Serial 을 읽어오지 못하면 Error 발생 후 종료
//    if nNewLastID = -1 then
//      raise Exception.Create('시리얼 번호를 읽어올 수 없습니다');

    // Ingredient 와 Method 의 Recipe_Serial 을 새로운 것으로 세팅한다
    SetSerial(memIngredient, 'Recipe_Serial', nOldLastID, nNewLastID);
    SetSerial(memMethod, 'Recipe_Serial', nOldLastID, nNewLastID);

    // Method Table 에 추가한다
    ApplyMethod; // Ingredient 도 같이 삭제 혹은 serial 을 update

    // Ingredient Table 에 추가한다
    ApplyIngredient;

    // Feed를 추가한다
    dmDB.WriteLinkToFeed(dmDB.sqlUser.FieldByName('Serial').AsLargeInt
                         , _type.feedRecipe
                         , nNewLastID);

    dmDB.FDConnection.Commit;

    result := True;
  except
    On E:Exception Do
    begin
      CancelTables;
      dmDB.FDConnection.Rollback;
      ShowMessage(E.Message);

      for i := 0 to FAddQue.Count-1 do
        dmDB.AddtoDeleteImageQue(BUCKET_RECIPE, FAddQue.ValueFromIndex[i]);
    end;
  end;
  dmDB.tblRecipe.Refresh;
  dmDB.tblRecipeIngredient.Refresh;
  dmDB.tblRecipeMethod.Refresh;

  dmDB.tblRecipe.EnableControls;

  FAddQue.Clear;
end;

procedure TfrmRecipe.SaveImages(ATable: TFDTable; fname: string);
var
  imgOrigin, imgSquare, imgRectangle: TImage;
  picture, pictureRectangle, pictureSquare: string;
begin
  if not FileExists(fname) then
    raise Exception.Create('이미지 파일을 찾을 수 없습니다');

  // Image 초기화
  imgOrigin := TImage.Create(self);
  imgSquare := TImage.Create(self);
  imgRectangle := TImage.Create(self);
  try
    try
      if not dmS3.IsValidImage(fname) then
        raise Exception.Create('지원하는 이미지 형식이 아닙니다');

      // 원본 이미지 가져오기
      imgOrigin.Picture.LoadFromFile(fname);
      dmS3.CropImageToJPEG(imgOrigin, imgSquare, SizeSequre);
      dmS3.CropImageToJPEG(imgOrigin, imgRectangle, SizeRectangle);

      if not dmS3.GetImageName(memRecipeSerial.AsLargeInt, ExtractFileExt(fname), picture, pictureSquare, pictureRectangle) then
        raise Exception.Create('Image 이름을 가져올 수 없습니다');

      if dmS3.SaveImageToS3(BUCKET_RECIPE, picture, imgOrigin) then
        FAddQue.Add(picture)
      else
        raise Exception.Create('이미지를 저장할 수 없습니다');

      if dmS3.SaveImageToS3(BUCKET_RECIPE, pictureRectangle, imgRectangle) then
        FAddQue.Add(pictureRectangle)
      else
        raise Exception.Create('이미지를 저장할 수 없습니다');

      if dmS3.SaveImageToS3(BUCKET_RECIPE, pictureSquare, imgSquare) then
        FAddQue.Add(pictureSquare)
      else
        raise Exception.Create('이미지를 저장할 수 없습니다');

      ATable.FieldByName('Picture').AsString := picture;
      ATable.FieldByName('PictureSquare').AsString := pictureSquare;
      ATable.FieldByName('PictureRectangle').AsString := pictureRectangle;
    except
      Raise;
    end;
  finally
    imgOrigin.Free;
    imgRectangle.Free;
    imgSquare.Free;
  end;
end;

procedure TfrmRecipe.SetCategoryCombobox;
begin
  dmDB.sqlCategoryRecipe0.First;
  while not dmDB.sqlCategoryRecipe0.eof do
  begin
    cxcbo0.Properties.Items.AddCheckItem(dmDB.sqlCategoryRecipe0.FieldByName('CategoryName').AsString);
    cxcbo0.Properties.Items[cxcbo0.Properties.Items.Count-1].Tag := dmDB.sqlCategoryRecipe0.FieldByName('CategoryCode').AsInteger;
    dmDB.sqlCategoryRecipe0.Next;
  end;

  dmDB.sqlCategoryRecipe1.First;
  while not dmDB.sqlCategoryRecipe1.eof do
  begin
    cxcbo1.Properties.Items.AddCheckItem(dmDB.sqlCategoryRecipe1.FieldByName('CategoryName').AsString);
    cxcbo1.Properties.Items[cxcbo1.Properties.Items.Count-1].Tag := dmDB.sqlCategoryRecipe1.FieldByName('CategoryCode').AsInteger;
    dmDB.sqlCategoryRecipe1.Next;
  end;

  dmDB.sqlCategoryRecipe2.First;
  while not dmDB.sqlCategoryRecipe2.eof do
  begin
    cxcbo2.Properties.Items.AddCheckItem(dmDB.sqlCategoryRecipe2.FieldByName('CategoryName').AsString);
    cxcbo2.Properties.Items[cxcbo2.Properties.Items.Count-1].Tag := dmDB.sqlCategoryRecipe2.FieldByName('CategoryCode').AsInteger;
    dmDB.sqlCategoryRecipe2.Next;
  end;

  dmDB.sqlCategoryRecipe3.First;
  while not dmDB.sqlCategoryRecipe3.eof do
  begin
    cxcbo3.Properties.Items.AddCheckItem(dmDB.sqlCategoryRecipe3.FieldByName('CategoryName').AsString);
    cxcbo3.Properties.Items[cxcbo3.Properties.Items.Count-1].Tag := dmDB.sqlCategoryRecipe3.FieldByName('CategoryCode').AsInteger;
    dmDB.sqlCategoryRecipe3.Next;
  end;
end;

procedure TfrmRecipe.SetMemRecipe;
begin
  if trim(cxtxtTitle.Text) = '' then
    raise Exception.Create('Title을 입력하여야 합니다');

  memRecipe.Edit;
  memRecipeTitle.AsString := trim(cxtxtTitle.Text);
  memRecipeDescription.AsString := trim(cxmemoDescription.Lines.Text);

  memRecipeCategory.AsString := cxtxtCategoryTag.Text;

  memRecipeMakingLevel.AsString := cxcboMakingLevel.EditValue;
  memRecipeMakingTime.AsString := cxcboMakingTime.EditValue;
  memRecipeServings.AsInteger := cxspinServings.EditValue;
  memRecipeHashcode.AsString := trim(cxtxtHashcode.Text);
  memRecipePublished.AsBoolean := cxchkPublished.Checked;
  memRecipeDeleted.AsBoolean := cxchkDeleted.Checked;
  memRecipe.Post;
end;

procedure TfrmRecipe.SetRecipeControl;
var
  sRecipePicture: string;
  List: TStringList;
  i, k: integer;
  nCode: integer;
begin
  cxtxtTitle.Text := memRecipeTitle.AsString;
  cxMemoDescription.Lines.Text := memRecipeDescription.AsString;

  // 레시피 사진 가져오기
  sRecipePicture := trim(memRecipePictureSquare.AsString);
  if sRecipePicture <> '' then
    dmS3.LoadImageFromS3(BUCKET_RECIPE, sRecipePicture, imgRecipeSquare);

  List := TStringList.Create;
  List.Delimiter := ';';
  List.DelimitedText := memRecipeCategory.AsString;

  for i := 0 to List.Count-1 do
  begin
    nCode := List.Strings[i].ToInteger;

    for k := 0 to cxcbo0.Properties.Items.Count-1 do
      if cxcbo0.Properties.Items[k].Tag = nCode then
        cxcbo0.States[k] := cbsChecked;

    for k := 0 to cxcbo1.Properties.Items.Count-1 do
      if cxcbo1.Properties.Items[k].Tag = nCode then
        cxcbo1.States[k] := cbsChecked;

    for k := 0 to cxcbo2.Properties.Items.Count-1 do
      if cxcbo2.Properties.Items[k].Tag = nCode then
        cxcbo2.States[k] := cbsChecked;

    for k := 0 to cxcbo3.Properties.Items.Count-1 do
      if cxcbo3.Properties.Items[k].Tag = nCode then
        cxcbo3.States[k] := cbsChecked;
  end;

  DisplayCategory;

  List.Free;

  cxSpinServings.Value := memRecipeServings.AsInteger;
  cxcboMakingLevel.EditValue := memRecipe['MakingLevel'];
  cxcboMakingTime.EditValue := memRecipe['MakingTime'];

  cxtxtHashcode.Text := memRecipeHashcode.AsString;
  cxchkPublished.Checked := memRecipePublished.AsBoolean;
  cxchkDeleted.Checked := memRecipeDeleted.AsBoolean;
end;

procedure TfrmRecipe.SetSerial(memTable: TdxMemData; sFieldName: string;
  AOldValue, ANewValue: LargeInt);
begin
  memTable.First;
  while not memTable.Eof do
  begin
    if memTable.FieldByName(sFieldName).AsLargeInt = AOldValue then
    begin
      memTable.Edit;
      memTable.FieldByName(sFieldName).AsLargeInt := ANewValue;
      memTable.Post;
    end;

    memTable.Next;
  end;
end;

function TfrmRecipe.UpdateTableToDB: Boolean;
var
  i: integer;
begin
  result := False;

  if memRecipe.RecordCount = 0 then
  begin
    ShowMessage('편집할 레시피가 없습니다!');
    Exit;
  end;

  FAddQue.Clear;

  dmDB.tblRecipe.DisableControls;

  try
    dmDB.FDConnection.StartTransaction;

    SetMemRecipe;

    // 데이터를 Recipe Table에 복사할 때 memory Field 에서
    // 0번째 Field 인 Serial 과
    // 마지막에서 3개의 필드 NewPicture, PictureState, State 는 제외한다
    dmDB.tblRecipe.Edit;
    for i := 1 to dmDB.tblRecipe.FieldCount-1 do
      dmDB.tblRecipe.Fields[i].Value := memRecipe.Fields[i+1].Value;
    dmDB.tblRecipe.Post;

    // Recipe Image 처리
    dmDB.tblRecipe.Edit;

    if memRecipePictureState.AsString = DS_INSERT then
      SaveImages(dmDB.tblRecipe, memRecipeNewPicture.AsString)
    else if memRecipePictureState.AsString = DS_EDIT then
    begin
      DeleteImages(dmDB.tblRecipe);
      SaveImages(dmDB.tblRecipe, memRecipeNewPicture.AsString);
    end
    else if memRecipePictureState.AsString = DS_DELETE then
      DeleteImages(dmDB.tblRecipe);

   dmDB.tblRecipe.Post;

    // Method Table 을 적용한다
    ApplyMethod;

    // Ingredient Table 을 적용한다
    ApplyIngredient;

    dmDB.FDConnection.Commit;

    result := True;
  except
    On E:Exception Do
    begin
      CancelTables;
      dmDB.FDConnection.Rollback;
      ShowMessage(E.Message);

      for i := 0 to FAddQue.Count-1 do
        dmDB.AddtoDeleteImageQue(BUCKET_RECIPE, FAddQue.ValueFromIndex[i]);
    end;
  end;
  dmDB.tblRecipe.Refresh;
  dmDB.tblRecipeIngredient.Refresh;
  dmDB.tblRecipeMethod.Refresh;

  dmDB.tblRecipe.EnableControls;

  FAddQue.Clear;
end;

end.
