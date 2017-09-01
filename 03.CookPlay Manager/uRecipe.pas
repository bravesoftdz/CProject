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
  cxSpinEdit, cxCalendar, FireDAC.Phys.SQLiteVDataSet, dxGDIPlusClasses;

type
  TfrmRecipe = class(TForm)
    dsRecipe: TDataSource;
    dsIngredient: TDataSource;
    dsMethod: TDataSource;
    DataSource1: TDataSource;
    memRecipe: TdxMemData;
    memIngredient: TdxMemData;
    memMethod: TdxMemData;
    memMethodItem: TdxMemData;
    memIngredientSerial: TLargeintField;
    memIngredientRecipe_Serial: TLargeintField;
    memIngredientSeq: TIntegerField;
    memIngredientIngredientType: TShortintField;
    memIngredientTitle: TWideStringField;
    memIngredientAmount: TWideStringField;
    memIngredientPictureType: TShortintField;
    memIngredientPicture: TWideStringField;
    memIngredientContents: TWideStringField;
    memMethodSerial: TLargeintField;
    memMethodRecipe_Serial: TLargeintField;
    memMethodSeq: TIntegerField;
    memMethodDescription: TWideStringField;
    memMethodPictureType: TShortintField;
    memMethodPicture: TWideStringField;
    memMethodItemSerial: TLargeintField;
    memMethodItemRecipeMethod_Serial: TLargeintField;
    memMethodItemSeq: TIntegerField;
    memMethodItemMethodType: TShortintField;
    memMethodItemItemCode: TShortintField;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    sqlTemp: TFDQuery;
    Panel1: TPanel;
    cxDBTextEdit1: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxDBMemo1: TcxDBMemo;
    Button1: TButton;
    cxDBLookupComboBox2: TcxDBLookupComboBox;
    cxLabel5: TcxLabel;
    cxDBLookupComboBox3: TcxDBLookupComboBox;
    cxDBLookupComboBox4: TcxDBLookupComboBox;
    cxDBLookupComboBox5: TcxDBLookupComboBox;
    imgRecipeSquare: TImage;
    Button2: TButton;
    btnSave: TButton;
    btnCancel: TButton;
    cxLabel3: TcxLabel;
    cxDBSpinEdit1: TcxDBSpinEdit;
    imgRecipeOrigin: TImage;
    imgRecipeRectangle: TImage;
    memRecipeSerial: TLargeintField;
    memRecipeUsers_Nickname: TWideStringField;
    memRecipeTitle: TWideStringField;
    memRecipeDescription: TWideStringField;
    memRecipePictureType: TWideStringField;
    memRecipePicture: TWideStringField;
    memRecipePictureSquare: TWideStringField;
    memRecipePictureRectangle: TWideStringField;
    memRecipeItemCode0: TWideStringField;
    memRecipeItemCode1: TWideStringField;
    memRecipeItemCode2: TWideStringField;
    memRecipeItemCode3: TWideStringField;
    memRecipeMakingLevel: TShortintField;
    memRecipeMakingTime: TShortintField;
    memRecipeServings: TShortintField;
    memRecipeHashcode: TWideStringField;
    memRecipeCreatedDate: TDateTimeField;
    memRecipePublished: TBooleanField;
    memRecipeDeleted: TBooleanField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsMethodDataChange(Sender: TObject; Field: TField);
    procedure btnCancelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FLoadedFileName: string;
    procedure Copy_A_Record(desTable: TdxMemData; sorTable: TFDTable);
    procedure Copy_All_Record(desTable: TdxMemData; sorTable: TFDQuery);
  public
    { Public declarations }
    procedure Init(AEditingMode: TEditingMode);
  end;

const
  strIngredient = 'SELECT * FROM RecipeIngredient WHERE Recipe_Serial = :RecipeSerial ORDER BY Seq';
  strMethod = 'SELECT * FROM RecipeIngredient WHERE Recipe_Serial = :RecipeSerial ORDER BY Seq';
  strMethodItem = 'SELECT * FROM RecipeIngredient WHERE RecipeMethod_Serial = :RecipeSerial ORDER BY Seq';

var
  frmRecipe: TfrmRecipe;

implementation
uses uDB, CookPlay.S3;
{$R *.dfm}

procedure TfrmRecipe.btnCancelClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRecipe.btnSaveClick(Sender: TObject);
var
  fname: string;
begin
//  try
//    if imgRecipeOrigin.Tag = 1 then
//    begin
//      if imgRecipeOrigin.Picture.Graphic = nil then
//      begin
//        // Delete Old Image
//        dmDB.tblUsers.FieldByName('Picture').AsString := '';
//        dmS3.DeleteImage(BUCKET_RECIPE_NAME, )
//        DeleteUserPicture;
//      end
//      else
//      begin
//        if UserPictureName = '' then
//        begin
//          // Add New Image
//          fname := MakingUserPictureName;
//          dmDB.tblUsers.FieldByName('Picture').AsString := fname;
//
//          if not dmS3.SaveImageToS3(BUCKET_USER_NAME, fname, imgUserPicture) then
//            ShowMessage('이미지를 저장하지 못했습니다!');
//        end
//        else
//          // Update New Image
//          if not dmS3.SaveImageToS3(BUCKET_USER_NAME, UserPictureName, imgUserPicture) then
//            ShowMessage('이미지를 저장하지 못했습니다!');
//      end;
//    end;
//
//    dmDB.tblUsers.Post;
//    dmDB.FDConnection.Commit;
//    Close;
//  except
//    on E:Exception do
//    begin
////      dmDB.tblUsers.Cancel;
//      dmDB.FDConnection.Rollback;
//      ShowMessage(E.Message);
//    end;
//  end;
end;

procedure TfrmRecipe.Button1Click(Sender: TObject);
begin
  try
    if dmS3.OpenPictureDialog.Execute then
    begin
      FLoadedFileName := dmS3.OpenPictureDialog.FileName;
      if FileExists(FLoadedFileName) then
      begin
        if dmS3.IsValidImage(FLoadedFileName) then
        begin
          imgRecipeOrigin.Picture.LoadFromFile(FLoadedFileName);
          dmS3.CropImageToJPEG(imgRecipeOrigin, imgRecipeSquare, SizeSequre);
          dmS3.CropImageToJPEG(imgRecipeOrigin, imgRecipeRectangle, SizeRectangle);
          imgRecipeOrigin.Tag := 1;
        end
        else
          ShowMessage('지원하는 이미지 타입이 아닙니다!');
      end
      else
        ShowMessage('파일을 찾을 수 없습니다!');
    end;
  except
    imgRecipeOrigin.Tag := 0;
  end;
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
      desTable.Fields[i].Value := sorTable.Fields[i].Value;

    desTable.Post;

    sorTable.Next;
  end;

  desTable.EnableControls;
end;

procedure TfrmRecipe.Copy_A_Record(desTable: TdxMemData; sorTable: TFDTable);
var
  i: integer;
begin
  if not sorTable.eof then
  begin
    desTable.Append;

    for i := 0 to sorTable.FieldCount-1 do
      desTable.Fields[i].Value := sorTable.Fields[i].Value;

    desTable.Post;
  end;
end;

// 방법 Item 가져오기
procedure TfrmRecipe.dsMethodDataChange(Sender: TObject; Field: TField);
begin
  memMethodItem.Close;

  if not memMethod.Eof then
  begin
    sqlTemp.SQL.Text := strMethodItem;
    sqlTemp.ParamByName('RecipeSerial').Value := memMethod.FieldByName('Serial').Value; // 파라미터 세팅
    sqlTemp.Open;

    Copy_All_Record(memMethodItem, sqlTemp);

    sqlTemp.Close;
  end;
end;

procedure TfrmRecipe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  memRecipe.Close;
  memIngredient.Close;
  memMethod.Close;
  memMethodItem.Close;
  sqlTemp.Close;
end;

procedure TfrmRecipe.FormShow(Sender: TObject);
begin
  FLoadedFileName := '';
  imgRecipeOrigin.Tag := 0;
end;

procedure TfrmRecipe.Init(AEditingMode: TEditingMode);
var
  i: integer;
  sRecipePicture: string;
begin
  memRecipe.Open;

  if AEditingMode = edInsert then
  begin
    memRecipe.Append;
    memIngredient.Open;
    memMethod.Open;
    memMethodItem.Open;

    memRecipe['PictureType'] := 1;
    memRecipe['ItemCode0'] := 'RECIPEA99';
    memRecipe['ItemCode1'] := 'RECIPEB99';
    memRecipe['ItemCode2'] := 'RECIPEC99';
    memRecipe['ItemCode3'] := 'RECIPED99';
    memRecipe['MakingLevel'] := 0;
    memRecipe['MakingTime'] := 0;
    memRecipe['Servings'] := 1;
    memRecipe['Published'] := 0;
    memRecipe['Deleted'] := 0;
    memRecipe['CreatedDate'] := now;
  end
  else if AEditingMode = edUpdate then
  begin
    // 레시피 데이터 가져오기
    Copy_A_Record(memRecipe, dmDB.tblRecipe);

    memRecipe.Edit;

    // 레시피 데이터가 있으면
    if not dmDB.tblRecipe.Eof then
    begin
      // 레시피 사진 가져오기
      sRecipePicture := trim(dmDB.tblRecipe.FieldByName('Picture').AsString);
      if sRecipePicture <> '' then
        dmS3.LoadImageFromS3(BUCKET_RECIPE_NAME, sRecipePicture, imgRecipeSquare);

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
  end;
end;

end.
