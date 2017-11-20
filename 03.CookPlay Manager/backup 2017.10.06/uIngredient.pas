unit uIngredient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
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
  dxSkinXmas2008Blue, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxDBEdit, cxMemo,
  Vcl.ExtCtrls, cxSpinEdit, Cookplay.Global, Data.DB;

type
  TfrmIngredient = class(TForm)
    btnSave: TButton;
    btnCancel: TButton;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    cxLabel7: TcxLabel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxTitle: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
    cxDBSpinEdit1: TcxDBSpinEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    imgSquare: TImage;
    btnLoadImage: TButton;
    btnClearImage: TButton;
    cxLabel6: TcxLabel;
    cxDBMemo1: TcxDBMemo;
    cxDBSpinEdit2: TcxDBSpinEdit;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    btnClearLink: TButton;
    cxcboLinkedRecipe: TcxDBLookupComboBox;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnLoadImageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearImageClick(Sender: TObject);
    procedure btnClearLinkClick(Sender: TObject);
    procedure cxcboLinkedRecipePropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIngredient: TfrmIngredient;

implementation
uses uRecipe, uDB, CookPlay.S3;
{$R *.dfm}

procedure TfrmIngredient.btnCancelClick(Sender: TObject);
begin
  frmRecipe.memIngredient.Cancel;
  Close;
end;

procedure TfrmIngredient.btnClearImageClick(Sender: TObject);
begin
  imgSquare.Picture.Assign(nil);

  if frmRecipe.memIngredientPicture.AsString.IsEmpty then
    frmRecipe.memIngredientPictureState.AsString := DS_NONE
  else
    frmRecipe.memIngredientPictureState.AsString := DS_DELETE;

  frmRecipe.memIngredientNewPicture.AsString := '';
end;

procedure TfrmIngredient.btnClearLinkClick(Sender: TObject);
begin
  frmRecipe.memIngredientLinkedRecipe.AsLargeInt := -1;
end;

procedure TfrmIngredient.btnLoadImageClick(Sender: TObject);
var
  imgOrigin: TImage;
  oldNewPicture, oldPictureState: string;
  fname: string;
begin
  oldNewPicture := frmRecipe.memIngredientNewPicture.AsString;
  oldPictureState := frmRecipe.memIngredientPictureState.AsString;

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
          dmS3.CropImageToJPEG(imgOrigin, imgSquare, SizeSequre);

          if frmRecipe.memIngredientPicture.AsString.IsEmpty then
            frmRecipe.memIngredientPictureState.AsString := DS_INSERT
          else
            frmRecipe.memIngredientPictureState.AsString := DS_EDIT;

          frmRecipe.memIngredientNewPicture.AsString := fname;
        end
        else
          ShowMessage('지원하는 이미지 타입이 아닙니다!');
      end
      else
        ShowMessage('파일을 찾을 수 없습니다!');
    end;
  except
    frmRecipe.memIngredientNewPicture.AsString := oldNewPicture;
    frmRecipe.memIngredientPictureState.AsString := oldPictureState;
  end;

  imgOrigin.Free;
end;

procedure TfrmIngredient.btnSaveClick(Sender: TObject);
begin
  if trim(frmRecipe.memIngredientTitle.AsString) = '' then
  begin
    ShowMessage('Title을 입력하십시오!');
    Exit;
  end;

  ModalResult := mrOK;
end;

procedure TfrmIngredient.cxcboLinkedRecipePropertiesChange(Sender: TObject);
var
  fname: string;
begin
  if frmRecipe.memIngredient.State in [dsInsert, dsEdit] then
  begin
    if cxcboLinkedRecipe.Text <> '' then
    begin
      frmRecipe.memIngredientTitle.AsString := cxcboLinkedRecipe.Text;
      fname := dmDB.GetPicturenameSquare(cxcboLinkedRecipe.EditValue);
    end
    else
      fname := '';

    imgSquare.Picture.Assign(nil);
    if fname <> '' then
      dmS3.LoadImageFromS3(BUCKET_RECIPE, fname, imgSquare);
  end;
end;

procedure TfrmIngredient.FormShow(Sender: TObject);
var
  imgOrigin: TImage;
begin
  imgSquare.Picture.Assign(nil);

  imgOrigin := TImage.Create(self);

  // Ingredient 사진 가져오기
  if not frmRecipe.memIngredientNewPicture.AsString.IsEmpty then
  begin
    if FileExists(frmRecipe.memIngredientNewPicture.AsString) then
    begin
      imgOrigin.Picture.LoadFromFile(frmRecipe.memIngredientNewPicture.AsString);
      dmS3.CropImageToJPEG(imgOrigin, imgSquare, SizeSequre);
    end;
  end
  else if not frmRecipe.memIngredientPictureSquare.AsString.IsEmpty  then
    dmS3.LoadImageFromS3(BUCKET_RECIPE, frmRecipe.memIngredientPictureSquare.AsString, imgSquare);
end;

end.
