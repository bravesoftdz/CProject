unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxLookAndFeels, dxSkinsForm, cxClasses, cxStyles,
  Vcl.ExtCtrls, dxSkinscxPCPainter, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeelPainters, cxPC, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid,
  cxCheckBox, cxDropDownEdit, cxDBExtLookupComboBox, cxDBLookupComboBox,
  cxContainer, cxTextEdit, cxMaskEdit, cxDBEdit, cxLookupEdit, cxDBLookupEdit,
  Vcl.ToolWin, Vcl.ComCtrls, dxLayoutContainer, dxLayoutControlAdapters,
  Vcl.DBCtrls, Vcl.Mask, dxLayoutControl, dxLayoutcxEditAdapters;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Setup1: TMenuItem;
    mDatabse: TMenuItem;
    dxSkinController1: TdxSkinController;
    Timer1: TTimer;
    cxPageMain: TcxPageControl;
    cxTabSheet4: TcxTabSheet;
    cxGrid2: TcxGrid;
    cxgRecipe: TcxGridDBTableView;
    cxgRecipeSerial: TcxGridDBColumn;
    cxgRecipeUsers_Serial: TcxGridDBColumn;
    cxgRecipeUserName: TcxGridDBColumn;
    cxgRecipeNickname: TcxGridDBColumn;
    cxgRecipeTitle: TcxGridDBColumn;
    cxgRecipeDescription: TcxGridDBColumn;
    cxgRecipePictureType: TcxGridDBColumn;
    cxgRecipePicture: TcxGridDBColumn;
    cxgRecipeCategory0: TcxGridDBColumn;
    cxgRecipeCategory1: TcxGridDBColumn;
    cxgRecipeCategory2: TcxGridDBColumn;
    cxgRecipeCategory3: TcxGridDBColumn;
    cxgRecipeItemName0: TcxGridDBColumn;
    cxgRecipeItemName1: TcxGridDBColumn;
    cxgRecipeItemName2: TcxGridDBColumn;
    cxgRecipeItemName3: TcxGridDBColumn;
    cxgRecipeMakingLevel: TcxGridDBColumn;
    cxgRecipeMakingTime: TcxGridDBColumn;
    cxgRecipeServings: TcxGridDBColumn;
    cxgRecipeHashcode: TcxGridDBColumn;
    cxgRecipeCreatedDate: TcxGridDBColumn;
    cxgRecipePublished: TcxGridDBColumn;
    cxgRecipeDeleted: TcxGridDBColumn;
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
    cxgRecipeMethodItem: TcxGridDBTableView;
    cxgRecipeMethodItemSerial: TcxGridDBColumn;
    cxgRecipeMethodItemRecipeMethod_Serial: TcxGridDBColumn;
    cxgRecipeMethodItemSeq: TcxGridDBColumn;
    cxgRecipeMethodItemMethodType: TcxGridDBColumn;
    cxgRecipeMethodItemItemCode: TcxGridDBColumn;
    cxgRecipeMethodItemItemValue: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2Level4: TcxGridLevel;
    cxGrid2Level2: TcxGridLevel;
    Panel4: TPanel;
    btnRecipeAdd: TButton;
    btnRecipeUpdate: TButton;
    cxTabSheet7: TcxTabSheet;
    cxGrid3: TcxGrid;
    cxgCategory: TcxGridDBTableView;
    cxgCategorySerial: TcxGridDBColumn;
    cxgCategoryCategoryType: TcxGridDBColumn;
    cxgCategoryCategoryCode: TcxGridDBColumn;
    cxgCategorySeq: TcxGridDBColumn;
    cxgCategoryItemCode: TcxGridDBColumn;
    cxgCategoryItemName: TcxGridDBColumn;
    cxgCategoryComment: TcxGridDBColumn;
    cxgCategoryDeleted: TcxGridDBColumn;
    cxgCategoryDetail: TcxGridDBTableView;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn10: TcxGridDBColumn;
    cxGridLevel3: TcxGridLevel;
    Panel1: TPanel;
    chkCategoryAllowInsert: TCheckBox;
    cxTabSheet1: TcxTabSheet;
    cxGrid1: TcxGrid;
    cxGUser: TcxGridDBTableView;
    cxGUserNickname: TcxGridDBColumn;
    cxGUserID: TcxGridDBColumn;
    cxGUserPwd: TcxGridDBColumn;
    cxGUserName: TcxGridDBColumn;
    cxGUserNational: TcxGridDBColumn;
    cxGUserBirthday: TcxGridDBColumn;
    cxGUserGender: TcxGridDBColumn;
    cxGUserIP: TcxGridDBColumn;
    cxGUserEmail: TcxGridDBColumn;
    cxGUserIntroduction: TcxGridDBColumn;
    cxGUserPicture: TcxGridDBColumn;
    cxGUserSSO: TcxGridDBColumn;
    cxGUserCreatedDate: TcxGridDBColumn;
    cxGUserLastUpdatedDate: TcxGridDBColumn;
    cxGUserWithdrawalDate: TcxGridDBColumn;
    cxGUserDeleted: TcxGridDBColumn;
    cxGUserLevel: TcxGridDBColumn;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridDBColumn16: TcxGridDBColumn;
    cxGridDBColumn17: TcxGridDBColumn;
    cxGridDBColumn18: TcxGridDBColumn;
    cxGridDBColumn19: TcxGridDBColumn;
    cxGridDBColumn20: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    Panel2: TPanel;
    btnUserAdd: TButton;
    btnUserUpdate: TButton;
    procedure mDatabseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure cxgCategoryDataControllerDetailExpanding(
      ADataController: TcxCustomDataController; ARecordIndex: Integer;
      var AAllow: Boolean);
    procedure chkCategoryAllowInsertClick(Sender: TObject);
    procedure btnUserAddClick(Sender: TObject);
    procedure btnUserUpdateClick(Sender: TObject);
    procedure btnRecipeAddClick(Sender: TObject);
    procedure btnRecipeUpdateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses CookPlay.Global, CookPlay.S3, uSetup, uDB, uUser, uRecipe;
{$R *.dfm}

procedure TfrmMain.btnRecipeAddClick(Sender: TObject);
begin
  frmRecipe.Init(edInsert);
  frmRecipe.ShowModal;
end;

procedure TfrmMain.btnRecipeUpdateClick(Sender: TObject);
begin
  if dmDB.tblRecipe.Eof then
    ShowMessage('수정할 레시피가 없습니다!')
  else
  begin
    frmRecipe.Init(edUpdate);
    frmRecipe.ShowModal;
  end;
end;

procedure TfrmMain.btnUserAddClick(Sender: TObject);
begin
//  frmUser.EditingMode := edInsert;
  dmDB.FDConnection.StartTransaction;
  dmDB.tblUsers.Append;
  dmDB.tblUsers.FieldByName('National').AsString := 'KOR';
  dmDB.tblUsers.FieldByName('Gender').AsString := 'M';
  dmDB.tblUsers.FieldByName('National').AsString := 'KOR';
  dmDB.tblUsers.FieldByName('CreatedDate').AsDateTime := now;
  dmDB.tblUsers.FieldByName('LastUpdatedDate').AsDateTime := now;

  frmuser.imgUserPicture.Tag := 0;
  frmUser.UserPictureName := '';
  frmUser.ShowModal;
end;

procedure TfrmMain.btnUserUpdateClick(Sender: TObject);
begin
  dmDB.FDConnection.StartTransaction;
  dmDB.tblUsers.Edit;
  dmDB.tblUsers.FieldByName('LastUpdatedDate').AsDateTime := now;

  frmUser.imgUserPicture.Tag := 0;
  frmUser.UserPictureName := dmDB.tblUsers.FieldByName('Picture').AsString.Trim;
  frmUser.ShowModal;
end;

procedure TfrmMain.chkCategoryAllowInsertClick(Sender: TObject);
begin
  cxgCategory.NewItemRow.Visible := chkCategoryAllowInsert.Checked;
  cxgCategoryDetail.NewItemRow.Visible := chkCategoryAllowInsert.Checked;
end;

procedure TfrmMain.cxgCategoryDataControllerDetailExpanding(
  ADataController: TcxCustomDataController; ARecordIndex: Integer;
  var AAllow: Boolean);
begin
  cxgCategory.ViewData.Collapse(True);

  AdataController.FocusedRecordIndex := ARecordIndex;

  AAllow := True;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Timer1.Enabled := True;
end;

procedure TfrmMain.mDatabseClick(Sender: TObject);
begin
  frmSetup.ShowModal;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  try
    oSysInfo := TSysInfo.Create;
    cxPageMain.Visible := True;

    dmS3.init;
    dmDB.Init;

  except
    on E: Exception do
    begin
      ShowMessage('시스템 시작시 에러가 발생하였습니다!'+#13+#10+E.Message);
    end;
  end;
end;

end.
