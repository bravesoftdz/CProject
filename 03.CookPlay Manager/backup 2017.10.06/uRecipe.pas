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
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
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
    cxchkDeleted: TcxCheckBox;
    cxchkPublished: TcxCheckBox;
    cxLabel7: TcxLabel;
    cxtxtHashcode: TcxTextEdit;
    Panel2: TPanel;
    btnIngredientInsert: TButton;
    btnIngredientUpdate: TButton;
    btnIngredientDelete: TButton;
    Panel3: TPanel;
    btnMethodUpdate: TButton;
    btnMethodDelete: TButton;
    cxGrid2: TcxGrid;
    cxgRecipeIngredient: TcxGridDBTableView;
    cxgRecipeIngredientSerial: TcxGridDBColumn;
    cxgRecipeIngredientRecipe_Serial: TcxGridDBColumn;
    cxgRecipeIngredientSeq: TcxGridDBColumn;
    cxgRecipeIngredientIngredientType: TcxGridDBColumn;
    cxgRecipeIngredientTitle: TcxGridDBColumn;
    cxgRecipeIngredientAmount: TcxGridDBColumn;
    cxgRecipeIngredientUnit: TcxGridDBColumn;
    cxgRecipeIngredientWeight: TcxGridDBColumn;
    cxgRecipeIngredientPictureType: TcxGridDBColumn;
    cxgRecipeIngredientPicture: TcxGridDBColumn;
    cxgRecipeIngredientContents: TcxGridDBColumn;
    cxGrid2DBTableView2: TcxGridDBTableView;
    cxGrid2DBTableView2Serial: TcxGridDBColumn;
    cxGrid2DBTableView2Recipe_Serial: TcxGridDBColumn;
    cxGrid2DBTableView2Seq: TcxGridDBColumn;
    cxGrid2DBTableView2Description: TcxGridDBColumn;
    cxGrid2DBTableView2PictureType: TcxGridDBColumn;
    cxGrid2DBTableView2Picture: TcxGridDBColumn;
    cxGrid2DBTableView3: TcxGridDBTableView;
    cxgRecipeMethod: TcxGridDBTableView;
    cxgRecipeMethodSerial: TcxGridDBColumn;
    cxgRecipeMethodRecipe_Serial: TcxGridDBColumn;
    cxgRecipeMethodSeq: TcxGridDBColumn;
    cxgRecipeMethodDescription: TcxGridDBColumn;
    cxgRecipeMethodPictureType: TcxGridDBColumn;
    cxgRecipeMethodPicture: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    SpeedButton1: TSpeedButton;
    cxGrid1: TcxGrid;
    cxGMethod: TcxGridDBTableView;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridDBColumn20: TcxGridDBColumn;
    cxGridDBColumn21: TcxGridDBColumn;
    cxGridDBColumn22: TcxGridDBColumn;
    cxGridDBColumn23: TcxGridDBColumn;
    cxGridDBColumn24: TcxGridDBColumn;
    cxGridDBColumn25: TcxGridDBColumn;
    cxGridDBColumn26: TcxGridDBColumn;
    cxGridDBColumn27: TcxGridDBColumn;
    cxGridDBColumn28: TcxGridDBColumn;
    cxGridDBColumn29: TcxGridDBColumn;
    cxGridDBColumn30: TcxGridDBColumn;
    cxGridDBTableView3: TcxGridDBTableView;
    cxGridDBColumn31: TcxGridDBColumn;
    cxGridDBColumn32: TcxGridDBColumn;
    cxGridDBColumn33: TcxGridDBColumn;
    cxGridDBColumn34: TcxGridDBColumn;
    cxGridDBColumn35: TcxGridDBColumn;
    cxGridDBColumn36: TcxGridDBColumn;
    cxGridDBTableView4: TcxGridDBTableView;
    cxGridDBTableView5: TcxGridDBTableView;
    cxGridDBColumn37: TcxGridDBColumn;
    cxGridDBColumn38: TcxGridDBColumn;
    cxGridDBColumn39: TcxGridDBColumn;
    cxGridDBColumn40: TcxGridDBColumn;
    cxGridDBColumn41: TcxGridDBColumn;
    cxGridDBColumn42: TcxGridDBColumn;
    cxGridDBTableView6: TcxGridDBTableView;
    cxGridDBColumn43: TcxGridDBColumn;
    cxGridDBColumn44: TcxGridDBColumn;
    cxGridDBColumn45: TcxGridDBColumn;
    cxGridDBColumn46: TcxGridDBColumn;
    cxGridDBColumn47: TcxGridDBColumn;
    cxGridDBColumn48: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    cxGMethodRecId: TcxGridDBColumn;
    cxGMethodSerial: TcxGridDBColumn;
    cxGMethodRecipe_Serial: TcxGridDBColumn;
    cxGMethodSeq: TcxGridDBColumn;
    cxGMethodDescription: TcxGridDBColumn;
    cxGMethodPictureType: TcxGridDBColumn;
    cxGMethodPicture: TcxGridDBColumn;
    cxGMethodPictureRectangle: TcxGridDBColumn;
    cxGMethodPictureSquare: TcxGridDBColumn;
    cxGMethodNewPicture: TcxGridDBColumn;
    cxGMethodPictureState: TcxGridDBColumn;
    cxGMethodStateCur: TcxGridDBColumn;
    cxGMethodRecipeIngredient_Serial: TcxGridDBColumn;
    cxGMethodMethodType: TcxGridDBColumn;
    cxGMethodWeightType: TcxGridDBColumn;
    cxGMethodWeightValue: TcxGridDBColumn;
    cxGMethodTimeType: TcxGridDBColumn;
    cxGMethodTimeValue: TcxGridDBColumn;
    cxGMethodTemperatureType: TcxGridDBColumn;
    cxGMethodTemperatureValue: TcxGridDBColumn;
    cxGMethodLinkedRecipe: TcxGridDBColumn;
    btnAddExplain: TButton;
    btnSelectIngredient: TButton;
    btnAddTime: TButton;
    btnAddTemperature: TButton;
    btnSelectRecipe: TButton;
    btnAddIngredient: TButton;
    cxGMethodExplainSeq: TcxGridDBColumn;
    cxGMethodStateBefore: TcxGridDBColumn;
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
    memRecipeUsed: TBooleanField;
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
    memMethodExplainSeq: TSmallintField;
    memMethodNewPicture: TStringField;
    memMethodPictureState: TStringField;
    memMethodStateCur: TStringField;
    memMethodStateBefore: TStringField;
    memMethodUsed: TBooleanField;
    memIngredientSerial: TLargeintField;
    memIngredientRecipe_Serial: TLargeintField;
    memIngredientRecipeMethod_Serial: TLargeintField;
    memIngredientLinkedRecipe: TLargeintField;
    memIngredientSeq: TIntegerField;
    memIngredientItemType: TSmallintField;
    memIngredientItemValue: TBCDField;
    memIngredientItemUnit: TSmallintField;
    memIngredientIngredientType: TSmallintField;
    memIngredientTitle: TWideStringField;
    memIngredientAmount: TWideStringField;
    memIngredientUnit: TWideStringField;
    memIngredientNewPicture: TStringField;
    memIngredientPictureState: TStringField;
    memIngredientStateCur: TStringField;
    memIngredientStateBefore: TStringField;
    memIngredientUsed: TBooleanField;
    cxGrid1Level1: TcxGridLevel;
    cxGIngredient: TcxGridDBTableView;
    cxGIngredientRecId: TcxGridDBColumn;
    cxGIngredientSerial: TcxGridDBColumn;
    cxGIngredientRecipe_Serial: TcxGridDBColumn;
    cxGIngredientRecipeMethod_Serial: TcxGridDBColumn;
    cxGIngredientLinkedRecipe: TcxGridDBColumn;
    cxGIngredientSeq: TcxGridDBColumn;
    cxGIngredientItemType: TcxGridDBColumn;
    cxGIngredientItemValue: TcxGridDBColumn;
    cxGIngredientItemUnit: TcxGridDBColumn;
    cxGIngredientIngredientType: TcxGridDBColumn;
    cxGIngredientTitle: TcxGridDBColumn;
    cxGIngredientAmount: TcxGridDBColumn;
    cxGIngredientUnit: TcxGridDBColumn;
    cxGIngredientNewPicture: TcxGridDBColumn;
    cxGIngredientPictureState: TcxGridDBColumn;
    cxGIngredientStateCur: TcxGridDBColumn;
    cxGIngredientStateBefore: TcxGridDBColumn;
    cxGIngredientUsed: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnLoadImageClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearImageClick(Sender: TObject);
    procedure btnIngredientInsertClick(Sender: TObject);
    procedure btnIngredientUpdateClick(Sender: TObject);
    procedure btnIngredientDeleteClick(Sender: TObject);
    procedure btnMethodUpdateClick(Sender: TObject);
    procedure btnAddExplainClick(Sender: TObject);
    procedure btnMethodDeleteClick(Sender: TObject);
    procedure cxgIngredientCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGMethodCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxcbo0PropertiesClickCheck(Sender: TObject; ItemIndex: Integer;
      var AllowToggle: Boolean);
    procedure cxcbo0PropertiesChange(Sender: TObject);
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
    procedure SetMemRecipe;
    procedure SaveImages(ATable: TFDTable; fname: string);
    procedure DeleteImages(ATable: TFDTable);
    procedure CancelTables;
    procedure ApplyIngredient;
    procedure ApplyMethod;
    function GetMaxSeq(aTable: TdxMemData): Integer;
    procedure SetUsed2Ingredient;
    procedure SetCategoryCombobox;
    function GetCheckedCount: integer;
    procedure DisplayCategory;
  public
    { Public declarations }
    procedure Init(AEditingMode: TEditingMode);
  end;

const
  strIngredient = 'SELECT * FROM RecipeIngredient WHERE Recipe_Serial = :RecipeSerial ORDER BY Seq';
  strMethod = 'SELECT * FROM RecipeMethod WHERE Recipe_Serial = :RecipeSerial ORDER BY Seq';

var
  frmRecipe: TfrmRecipe;

implementation
uses uDB, CookPlay.S3, uIngredient, uExplain, uSelectIngredient, uAddTime,
      uAddTemperature, uSelectRecipe;
{$R *.dfm}

procedure TfrmRecipe.ApplyIngredient;
var
  i, seq: integer;
  nOldLastID, nNewLastID: LargeInt;
begin
  // Ingredient Table �� Update �Ѵ�.
  seq := 0;
  memIngredient.First;
  while not memIngredient.Eof do
  begin
    nOldLastID := memIngredient.FieldByName('Serial').AsLargeInt;

    if memIngredientStateCur.AsString = DS_INSERT then
    begin
      // Ingredient Table�� Insert �Ѵ�
      dmDB.tblRecipeIngredient.Insert;

      for i := 1 to dmDB.tblRecipeIngredient.FieldCount-1 do
        dmDB.tblRecipeIngredient.Fields[i].Value := memIngredient.Fields[i+1].Value;

      dmDB.tblRecipeIngredient.FieldByName('seq').AsInteger := seq;
      seq := seq + 1;

      dmDB.tblRecipeIngredient.Post;

      nNewLastID := dmDB.GetLastID;
      if nNewLastID = -1 then
        raise Exception.Create('Ingredient �ø����� �о�� �� �����ϴ�');

      // Method Table �� ��ũ�� Ingredient serial �� Update �Ѵ�
      SetSerial(memMethod, 'RecipeIngredient_Serial', nOldLastID, nNewLastID);

      if memIngredientPictureState.AsString = DS_INSERT then
      begin
        dmDB.tblRecipeIngredient.Edit;
        SaveImages(dmDB.tblRecipeIngredient, memIngredientNewPicture.AsString);
        dmDB.tblRecipeIngredient.Post;
      end;
    end
    else if memIngredientStateCur.AsString = DS_EDIT then
    begin
      // Ingredient Table�� Update �Ѵ�
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
        ShowMessage('��Ḧ ������Ʈ ���� ���Ͽ����ϴ�!');
    end
    else if memIngredientStateCur.AsString = DS_DELETE then
    begin
      // Ingredient Table �� ���� �����ϴ� ���̸� ���� �����ϰ�, �ƴϸ� �׳� Skip
      if dmDB.tblRecipeIngredient.Locate('Serial', memIngredientSerial.AsLargeInt, [loCaseInsensitive]) then
      begin
        if trim(memIngredientPicture.AsString) <> '' then
        begin
          dmDB.tblRecipeIngredient.Edit;
          DeleteImages(dmDB.tblRecipeIngredient);
          dmDB.tblRecipeIngredient.Post;
        end;

        dmDB.tblRecipeIngredient.Delete;
      end
      else
        Showmessage('��Ḧ �������� ���Ͽ����ϴ�!');
    end
    else if memIngredientStateCur.AsString = DS_NONE then
    begin
      // Ingredient Table�� seq �� Update �Ѵ�
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
  i, seq, explainSeq: integer;
  nOldLastID, nNewLastID: LargeInt;
begin
  // Method Table �� Update �Ѵ�.
  seq := 0;
  explainSeq := 1;
  memMethod.First;
  while not memMethod.Eof do
  begin
    nOldLastID := memMethod.FieldByName('Serial').AsLargeInt;

    if memMethodStateCur.AsString = DS_INSERT then
    begin
      // Method Table�� Insert �Ѵ�
      dmDB.tblRecipeMethod.Insert;

      for i := 1 to dmDB.tblRecipeMethod.FieldCount-1 do
        dmDB.tblRecipeMethod.Fields[i].Value := memMethod.Fields[i+1].Value;

      dmDB.tblRecipeMethod.FieldByName('Seq').AsInteger := seq;
      seq := seq + 1;

      if memMethodMethodType.AsInteger = _type.methodExplain then
      begin
        dmDB.tblRecipeMethod.FieldByName('ExplainSeq').AsInteger := explainSeq;
        explainSeq := explainSeq + 1;
      end;

      dmDB.tblRecipeMethod.Post;

      nNewLastID := dmDB.GetLastID;
      if nNewLastID = -1 then
        raise Exception.Create('Method �ø����� �о�� �� �����ϴ�');

      if memMethodPictureState.AsString = DS_INSERT then
      begin
        dmDB.tblRecipeMethod.Edit;
        SaveImages(dmDB.tblRecipeMethod, memMethodNewPicture.AsString);
        dmDB.tblRecipeMethod.Post;
      end;
    end
    else if memMethodStateCur.AsString = DS_EDIT then
    begin
      // Method Table�� Update �Ѵ�
      if dmDB.tblRecipeMethod.Locate('Serial', memMethodSerial.AsLargeInt, [loCaseInsensitive]) then
      begin
        dmDB.tblRecipeMethod.Edit;

        for i := 1 to dmDB.tblRecipeMethod.FieldCount-1 do
          dmDB.tblRecipeMethod.Fields[i].Value := memMethod.Fields[i+1].Value;

        dmDB.tblRecipeMethod.FieldByName('Seq').AsInteger := seq;
        seq := seq + 1;

        if memMethodMethodType.AsInteger = _type.methodExplain then
        begin
          dmDB.tblRecipeMethod.FieldByName('ExplainSeq').AsInteger := explainSeq;
          explainSeq := explainSeq + 1;
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
        if trim(memMethodPicture.AsString) <> '' then
        begin
          dmDB.tblRecipeMethod.Edit;
          DeleteImages(dmDB.tblRecipeMethod);
          dmDB.tblRecipeMethod.Post;
        end;

        dmDB.tblRecipeMethod.Delete;
      end
      else
        Showmessage('����� �������� ���Ͽ����ϴ�!');
    end
    else if memMethodStateCur.AsString = DS_NONE then
    begin
      if dmDB.tblRecipeMethod.Locate('Serial', memMethodSerial.AsLargeInt, [loCaseInsensitive]) then
      begin
        dmDB.tblRecipeMethod.Edit;

        dmDB.tblRecipeMethod.FieldByName('Seq').AsInteger := seq;
        seq := seq + 1;

        if memMethodMethodType.AsInteger = _type.methodExplain then
        begin
          dmDB.tblRecipeMethod.FieldByName('ExplainSeq').AsInteger := explainSeq;
          explainSeq := explainSeq + 1;
        end;

        dmDB.tblRecipeMethod.Post;
      end;
    end;

    memMethod.Next;
  end;
end;

procedure TfrmRecipe.btnAddExplainClick(Sender: TObject);
var
  maxseq, cnt: integer;
begin
//  if memIngredient.RecordCount <= 0 then
//  begin
//    ShowMessage('������ ��ᰡ �����ϴ�!');
//    Exit;
//  end;

//  cnt := 0;
//  memIngredient.First;
//  while not memIngredient.Eof do
//  begin
//    if not memIngredientUsed.AsBoolean then
//      cnt := cnt + 1;
//
//    memIngredient.Next;
//  end;
//
//  if cnt = 0 then
//  begin
//    ShowMessage('��ᰡ ��� ���Ǿ����ϴ�');
//    Exit;
//  end;

  maxseq := GetMaxSeq(memMethod);

  memMethod.Insert;

  memMethodSerial.AsLargeInt := DateTimetoUnix(now);
  memMethodRecipe_Serial.AsLargeInt := memRecipeSerial.AsLargeInt;
  memMethodSeq.AsInteger := maxseq;
  memMethodLinkedRecipe.AsLargeInt := _type.notLinked;
  memMethodRecipeIngredient_Serial.AsLargeInt := _type.notLinked;

  memMethodPictureType.AsInteger := _type.Picture.still;
  memMethodMethodType.AsInteger := _type.methodExplain;
  memMethodWeightType.AsInteger := _type.weight_g;
  memMethodTemperatureType.AsInteger := _type.temperature_C;
  memMethodTimeType.AsInteger := _type.time_sec;

  memMethodStateBefore.AsString := DS_INSERT;
  memMethodStateCur.AsString := DS_INSERT;

  if Sender = btnAddExplain then
  begin
    if frmExplain.ShowModal = mrOK then
      memMethod.Post
    else
      memMethod.Cancel;
  end
  else if Sender = btnAddIngredient then
  begin
    memMethodMethodType.AsInteger := _type.methodIngredient;

    maxseq := GetMaxSeq(memIngredient);

    memIngredient.Insert;
    memIngredientSerial.AsLargeInt := DateTimetoUnix(now);
    memIngredientRecipe_Serial.AsLargeInt := memRecipeSerial.AsLargeInt;
    memIngredientPictureType.AsInteger := _type.Picture.still;
    memIngredientIngredientType.AsInteger := _type.ingredient;
    memIngredientWeightType.AsInteger := _type.weight_g;
    memIngredientLinkedRecipe.AsLargeInt := _type.notLinked;
    memIngredientUsed.AsBoolean := False;

    memIngredientSeq.AsInteger := maxseq;

    memIngredientStateBefore.AsString := DS_INSERT;
    memIngredientStateCur.AsString := DS_INSERT;

    try
      if frmIngredient.ShowModal = mrOK then
      begin
        memIngredientUsed.AsBoolean := True;
        memIngredient.Post;

        memMethodRecipeIngredient_Serial.AsLargeInt := memIngredientSerial.AsLargeInt;

        memMethod.Post;
      end
      else
      begin
        memIngredient.Cancel;
        memMethod.Cancel;
      end;
    except
      on E: Exception do
      begin
        memIngredient.Cancel;
        memMethod.Cancel;
        ShowMessage(E.Message);
      end;
    end;
  end
  else if Sender = btnSelectIngredient then
  begin
    memMethodMethodType.AsInteger := _type.methodIngredient;

    if frmMethodSelectIngredient.ShowModal = mrOK then
      memMethod.Post
    else
      memMethod.Cancel;
  end
  else if Sender = btnAddTime then
  begin
    memMethodMethodType.AsInteger := _type.methodTime;
    memMethodTimeValue.Text := '00:00:00';

    if frmAddTime.ShowModal = mrOK then
      memMethod.Post
    else
      memMethod.Cancel;
  end
  else if Sender = btnAddTemperature then
  begin
    memMethodMethodType.AsInteger := _type.methodTemperature;
    memMethodTemperatureValue.AsFloat := 0;

    if frmAddTemperature.ShowModal = mrOK then
      MemMethod.Post
    else
      MemMethod.Cancel;
  end
  else if Sender = btnSelectRecipe then
  begin
    memMethodMethodType.AsInteger := _type.methodLinked;

    if frmSelectRecipe.ShowModal = mrOK then
      memMethod.Post
    else
      memMethod.Cancel;
  end
  else
    memMethod.Cancel;
end;

procedure TfrmRecipe.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRecipe.btnSaveClick(Sender: TObject);
var
  fname: string;
begin
  if (memRecipeStateCur.AsString = DS_INSERT) and InsertTableToDB then
    Close
  else if (memRecipeStateCur.AsString = DS_EDIT) and UpdateTableToDB then
    Close;
end;

procedure TfrmRecipe.btnIngredientDeleteClick(Sender: TObject);
begin
  if memIngredient.RecordCount < 1 then
  begin
    ShowMessage('������ ��ᰡ �����ϴ�!');
    Exit;
  end;

  if memIngredientStateCur.AsString = DS_DELETE then
  begin
    ShowMessage('�̹� ������ ��� �Դϴ�!');
    Exit;
  end;

  if dmDB.FindSerial('RecipeIngredient_Serial', memIngredientSerial.AsLargeInt, memMethod) then
  begin
    ShowMessage('�ش���ᰡ ����� ���Ǿ ������ �� �����ϴ�!');
    Exit;
  end;

  if MessageDlg('�����Ͻðڼ��ϱ�?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    try
      memIngredient.Edit;

      memIngredientStateBefore.AsString := memIngredientStateCur.AsString;
      memIngredientStateCur.AsString := DS_DELETE;

      memIngredient.Post;
    except
      on E:Exception do
        ShowMessage(E.Message);
    end;
  end;

end;

procedure TfrmRecipe.btnIngredientInsertClick(Sender: TObject);
var
  maxseq: integer;
begin
  maxseq := GetMaxSeq(memIngredient);

  memIngredient.Insert;
  memIngredientSerial.AsLargeInt := DateTimetoUnix(now);
  memIngredientRecipe_Serial.AsLargeInt := memRecipeSerial.AsLargeInt;
  memIngredientPictureType.AsInteger := _type.Picture.still;
  memIngredientIngredientType.AsInteger := _type.ingredient;
  memIngredientWeightType.AsInteger := _type.weight_g;
  memIngredientLinkedRecipe.AsLargeInt := _type.notLinked;
  memIngredientUsed.AsBoolean := False;

  memIngredientSeq.AsInteger := maxseq;

  memIngredientStateBefore.AsString := DS_INSERT;
  memIngredientStateCur.AsString := DS_INSERT;

  try
    if frmIngredient.ShowModal = mrOK then
      memIngredient.Post
    else
      memIngredient.Cancel;
  except
    on E: Exception do
    begin
      memIngredient.Cancel;
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TfrmRecipe.btnIngredientUpdateClick(Sender: TObject);
begin
  if memIngredient.RecordCount <= 0 then
  begin
    ShowMessage('������ ��ᰡ �����ϴ�!');
    Exit;
  end;

  if memIngredientStateCur.AsString = DS_DELETE then
  begin
    ShowMessage('������ ����Դϴ�!');
    Exit;
  end;

  memIngredient.Edit;
  // DS_INSERT �� DS_EDIT �� ���¿����� state ��ȭ�� ���� �ʴ´�
  // DS_NONE -> DS_EDIT
  // DS_EDIT -> DS_EDIT
  // DS_INSERT -> DS_INSERT
  if memIngredientStateCur.AsString = DS_NONE then
  begin
    memIngredientStateBefore.AsString := DS_NONE;
    memIngredientStateCur.AsString := DS_EDIT;
  end;

  if frmIngredient.ShowModal = mrOK then
    memIngredient.Post
  else
    memIngredient.Cancel;
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
          ShowMessage('�����ϴ� �̹��� Ÿ���� �ƴմϴ�!');
      end
      else
        ShowMessage('������ ã�� �� �����ϴ�!');
    end;
  except
    memRecipe.Edit;
    memRecipe['NewPicture'] := oldNewPicture;
    memRecipe['PictureState'] := oldPictureState;
    memRecipe.Post;
  end;

  imgOrigin.Free;
end;

procedure TfrmRecipe.btnMethodDeleteClick(Sender: TObject);
begin
  if memMethod.RecordCount = 0 then
  begin
    ShowMessage('������ �ڷᰡ �����ϴ�!');
    Exit;
  end;

  if memMethodStateCur.AsString = DS_DELETE then
  begin
    ShowMessage('�̹� ������ �ڷ��Դϴ�!');
    Exit;
  end;

  if MessageDlg('�����Ͻðڽ��ϱ�?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    try
      if memMethodMethodType.AsInteger =_type.methodIngredient then
      begin
        if memIngredient.Locate('serial', memMethodRecipeIngredient_Serial.AsLargeInt, [loCaseInsensitive]) then
        begin
          memIngredient.Edit;
          memIngredientUsed.AsBoolean := False;
          memIngredient.Post;
        end;
      end;

      memMethod.Edit;

      memMethodRecipeIngredient_Serial.AsLargeInt := _type.notLinked;
      memMethodStateBefore.AsString := memMethodStateCur.AsString;
      memMethodStateCur.AsString := DS_DELETE;

      memMethod.Post;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;
end;

procedure TfrmRecipe.btnMethodUpdateClick(Sender: TObject);
var
  maxseq: integer;
begin
  if memMethod.Eof then
  begin
    ShowMessage('������ �����Ͱ� �����ϴ�!');
    Exit;
  end;

  if memMethodStateCur.AsString = DS_DELETE then
  begin
    ShowMessage('������ ����Դϴ�!');
    Exit;
  end;

  memMethod.Edit;
  // DS_INSERT �� DS_EDIT �� ���¿����� state ��ȭ�� ���� �ʴ´�
  // DS_NONE -> DS_EDIT
  // DS_EDIT -> DS_EDIT
  // DS_INSERT -> DS_INSERT
  if memMethodStateCur.AsString = DS_NONE then
  begin
    memMethodStateBefore.AsString := DS_NONE;
    memMethodStateCur.AsString := DS_EDIT;
  end;

  if memMethodMethodType.AsInteger = _type.methodExplain then
  begin
    if frmExplain.ShowModal = mrOK then
      memMethod.Post
    else
      memMethod.Cancel;
  end
  else if memMethodMethodType.AsInteger = _type.methodIngredient then
  begin
    if frmMethodSelectIngredient.ShowModal = mrOK then
      memMethod.Post
    else
      memMethod.Cancel;
  end
  else if memMethodMethodType.AsInteger = _type.methodTime then
  begin
    if frmAddTime.ShowModal = mrOK then
      memMethod.Post
    else
      memMethod.Cancel;
  end
  else if memMethodMethodType.AsInteger = _type.methodTemperature then
  begin
    if frmAddTemperature.ShowModal = mrOK then
      MemMethod.Post
    else
      MemMethod.Cancel;
  end
  else if memMethodMethodType.AsInteger = _type.methodLinked then
  begin
    if frmSelectRecipe.ShowModal = mrOK then
      memMethod.Post
    else
      memMethod.Cancel;
  end
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

    //TdxMemData �� ù��° �ʵ尡 'RecId'�� �ڵ� ���õǹǷ� 1�� Skip �Ѵ�
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
    ShowMessage('�ִ� 10������ ������ �����մϴ�');
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
    raise Exception.Create('�̹��� ���������� ���̺��� ������ �� �����ϴ�');

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
var
  i: integer;
  sRecipePicture: string;
  item: TcxCheckComboBoxItem;
begin
  ClearRecipeControl;

  SetCategoryCombobox;
  cxtxtCategory.Clear;
  cxtxtCategoryTag.Clear;

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
    // ������ ������ ��������
    Copy_A_Record(memRecipe, dmDB.tblRecipe);

    SetRecipeControl;

    // ��ᰡ������
    sqlTemp.SQL.Text := strIngredient;
    sqlTemp.ParamByName('RecipeSerial').Value := dmDB.tblRecipe.FieldByName('Serial').Value;
    sqlTemp.Open;
    Copy_All_Record(memIngredient, sqlTemp);

    // �����������
    sqlTemp.SQL.Text := strMethod;
    sqlTemp.ParamByName('RecipeSerial').Value := dmDB.tblRecipe.FieldByName('Serial').Value;
    sqlTemp.Open;
    Copy_All_Record(memMethod, sqlTemp);

    SetUsed2Ingredient;

    sqlTemp.Close;
  end;
end;

function TfrmRecipe.InsertTableToDB: Boolean;
var
  i: integer;
  nOldLastID, nNewLastID: LargeInt;
  picture, pictureSquare, pictureRectangle: string;
begin
  result := False;

  if memRecipe.RecordCount = 0 then
  begin
    ShowMessage('�߰��� �����ǰ� �����ϴ�!');
    Exit;
  end;

  dmDB.tblRecipe.DisableControls;

  try
    dmDB.FDConnection.StartTransaction;

    // memRecipe �� Control �� �Էµ� ���� �����Ѵ�
    SetMemRecipe;

    // ������ Recipe Serial�� �����´�
    nOldLastID := memRecipe.FieldByName('Serial').AsLargeInt;

    // �����͸� Recipe Table�� ������ �� memory Field ����
    // 0��° Field �� Serial ��
    // ���������� 3���� �ʵ� NewPicture, PictureState, State �� �����Ѵ�
    dmDB.tblRecipe.insert;
    for i := 1 to dmDB.tblRecipe.FieldCount-1 do
      dmDB.tblRecipe.Fields[i].Value := memRecipe.Fields[i+1].Value;
    dmDB.tblRecipe.Post;

    // Recipe Image ó��
    if memRecipePictureState.AsString = DS_INSERT then
    begin
      dmDB.tblRecipe.Edit;
      SaveImages(dmDB.tblRecipe, memRecipeNewPicture.AsString);
      dmDB.tblRecipe.Post;
    end;

    // �߰��� Recipe Serial�� �о��
    nNewLastID := dmDB.GetLastID;
    // Serial �� �о���� ���ϸ� Error �߻� �� ����
    if nNewLastID = -1 then
      raise Exception.Create('�ø��� ��ȣ�� �о�� �� �����ϴ�');

    // Ingredient �� Method �� Recipe_Serial �� ���ο� ������ �����Ѵ�
    SetSerial(memIngredient, 'Recipe_Serial', nOldLastID, nNewLastID);
    SetSerial(memMethod, 'Recipe_Serial', nOldLastID, nNewLastID);

    // Ingredient Table �� �߰��Ѵ�
    ApplyIngredient;

    // Method Table �� �߰��Ѵ�
    ApplyMethod;

    // Story�� Feed�� �߰��Ѵ�
    dmDB.WriteLinkToFeed(dmDB.sqlUser.FieldByName('Serial').AsLargeInt
                         , cxtxtTitle.Text
                         , _type.storyLinkRecipe
                         , nNewLastID);

    dmDB.FDConnection.Commit;

    result := True;
  except
    On E:Exception Do
    begin
      for i := 0 to FAddQue.Count-1 do
        dmDB.AddtoDeleteImageQue(BUCKET_RECIPE, FAddQue.ValueFromIndex[i]);

      CancelTables;
      dmDB.FDConnection.Rollback;
      ShowMessage(E.Message);
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
    raise Exception.Create('�̹��� ������ ã�� �� �����ϴ�');

  try
    // Image �ʱ�ȭ
    imgOrigin := TImage.Create(self);
    imgSquare := TImage.Create(self);
    imgRectangle := TImage.Create(self);


    if not dmS3.IsValidImage(fname) then
      raise Exception.Create('�����ϴ� �̹��� ������ �ƴմϴ�');

    // ���� �̹��� ��������
    imgOrigin.Picture.LoadFromFile(fname);
    dmS3.CropImageToJPEG(imgOrigin, imgSquare, SizeSequre);
    dmS3.CropImageToJPEG(imgOrigin, imgRectangle, SizeRectangle);

    if not dmS3.GetImageName(memRecipeSerial.AsLargeInt, ExtractFileExt(fname), picture, pictureSquare, pictureRectangle) then
      raise Exception.Create('Image �̸��� ������ �� �����ϴ�');

    if dmS3.SaveImageToS3(BUCKET_RECIPE, picture, imgOrigin) then
      FAddQue.Add(picture)
    else
      raise Exception.Create('�̹����� ������ �� �����ϴ�');

    if dmS3.SaveImageToS3(BUCKET_RECIPE, pictureRectangle, imgRectangle) then
      FAddQue.Add(pictureRectangle)
    else
      raise Exception.Create('�̹����� ������ �� �����ϴ�');

    if dmS3.SaveImageToS3(BUCKET_RECIPE, pictureSquare, imgSquare) then
      FAddQue.Add(pictureSquare)
    else
      raise Exception.Create('�̹����� ������ �� �����ϴ�');

    ATable.FieldByName('Picture').AsString := picture;
    ATable.FieldByName('PictureSquare').AsString := pictureSquare;
    ATable.FieldByName('PictureRectangle').AsString := pictureRectangle;
  except
    imgOrigin.Free;
    imgRectangle.Free;
    imgSquare.Free;

    Raise;
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
    raise Exception.Create('Title�� �Է��Ͽ��� �մϴ�');

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

  // ������ ���� ��������
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
      memIngredient.Next;
    end;

    memTable.Next;
  end;  
end;

procedure TfrmRecipe.SetUsed2Ingredient;
begin
  memIngredient.First;
  while not memIngredient.Eof do
  begin
    // ����� ���� ���� ���ǥ�ø� �Ѵ�
    memIngredient.Edit;
    memIngredientUsed.AsBoolean := memMethod.Locate('RecipeIngredient_Serial', memIngredientSerial.AsLargeInt, [loCaseInsensitive]);
    memIngredient.Post;

    memIngredient.Next;
  end;
end;

function TfrmRecipe.UpdateTableToDB: Boolean;
var
  i: integer;
begin
  result := False;

  if memRecipe.RecordCount = 0 then
  begin
    ShowMessage('������ �����ǰ� �����ϴ�!');
    Exit;
  end;

  dmDB.tblRecipe.DisableControls;

  try
    dmDB.FDConnection.StartTransaction;

    SetMemRecipe;

    // �����͸� Recipe Table�� ������ �� memory Field ����
    // 0��° Field �� Serial ��
    // ���������� 3���� �ʵ� NewPicture, PictureState, State �� �����Ѵ�
    dmDB.tblRecipe.Edit;
    for i := 1 to dmDB.tblRecipe.FieldCount-1 do
      dmDB.tblRecipe.Fields[i].Value := memRecipe.Fields[i+1].Value;
    dmDB.tblRecipe.Post;

    // Recipe Image ó��
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

    // Ingredient Table �� �����Ѵ�
    ApplyIngredient;

    // Method Table �� �����Ѵ�
    ApplyMethod;

    dmDB.FDConnection.Commit;

    result := True;
  except
    On E:Exception Do
    begin
      for i := 0 to FAddQue.Count-1 do
        dmDB.AddtoDeleteImageQue(BUCKET_RECIPE, FAddQue.ValueFromIndex[i]);

      CancelTables;
      dmDB.FDConnection.Rollback;
      ShowMessage(E.Message);
    end;
  end;
  dmDB.tblRecipe.Refresh;
  dmDB.tblRecipeIngredient.Refresh;
  dmDB.tblRecipeMethod.Refresh;

  dmDB.tblRecipe.EnableControls;

  FAddQue.Clear;
end;

end.