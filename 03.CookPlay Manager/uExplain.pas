unit uExplain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinXmas2008Blue, cxCheckBox, cxSpinEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, cxMemo,
  Vcl.StdCtrls, cxLabel, Vcl.ExtCtrls, cxDBEdit, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, CookPlay.Global, dxmdaset,
  dxBarBuiltInMenu, cxPC, cxCurrencyEdit, cxTimeEdit;

type
  TfrmExplain = class(TForm)
    cxLabel8: TcxLabel;
    cxDBSpinEdit2: TcxDBSpinEdit;
    cxLabel2: TcxLabel;
    cxmemoDescription: TcxDBMemo;
    imgSquare: TImage;
    btnLoadImage: TButton;
    btnClearImage: TButton;
    btnSave: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadImageClick(Sender: TObject);
    procedure btnClearImageClick(Sender: TObject);
  private
    { Private declarations }
    procedure ClearControls;
  public
    { Public declarations }
  end;

var
  frmExplain: TfrmExplain;

implementation
uses uDB, uRecipe, CookPlay.S3;
{$R *.dfm}

{ TfrmMethod }

procedure TfrmExplain.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmExplain.btnClearImageClick(Sender: TObject);
begin
  imgSquare.Picture.Assign(nil);

  if frmRecipe.memMethodPicture.AsString.IsEmpty then
    frmRecipe.memMethodPictureState.AsString := DS_NONE
  else
    frmRecipe.memMethodPictureState.AsString := DS_DELETE;

  frmRecipe.memMethodNewPicture.AsString := '';
end;

procedure TfrmExplain.btnLoadImageClick(Sender: TObject);
var
  imgOrigin: TImage;
  oldNewPicture, oldPictureState: string;
  fname: string;
begin
  oldNewPicture := frmRecipe.memMethodNewPicture.AsString;
  oldPictureState := frmRecipe.memMethodPictureState.AsString;

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

          if frmRecipe.memMethodPicture.AsString.IsEmpty then
            frmRecipe.memMethodPictureState.AsString := DS_INSERT
          else
            frmRecipe.memMethodPictureState.AsString := DS_EDIT;

          frmRecipe.memMethodNewPicture.AsString := fname;
        end
        else
          ShowMessage('지원하는 이미지 타입이 아닙니다!');
      end
      else
        ShowMessage('파일을 찾을 수 없습니다!');
    end;
  except
    frmRecipe.memMethodNewPicture.AsString := oldNewPicture;
    frmRecipe.memMethodPictureState.AsString := oldPictureState;
  end;

  imgOrigin.Free;
end;

procedure TfrmExplain.btnSaveClick(Sender: TObject);
begin
  // MethodType 이  Step 이면 설명이 반드시 있어야 하고,
  //                Picutre 이면 사진이 반드시 있어야 한다.
  if cxmemoDescription.Visible and frmRecipe.memMethodDescription.AsString.IsEmpty then
  begin
    ShowMessage('설명을 입력하십시오!');
    Exit;
  end;

  if (not cxmemoDescription.Visible) and (imgSquare.Picture.Graphic = nil) then
  begin
    ShowMessage('사진을 선택하여 주십시오!');
    Exit;
  end;

  ModalResult := mrOK;
end;

procedure TfrmExplain.ClearControls;
begin
  imgSquare.Picture.Assign(nil);
end;

procedure TfrmExplain.FormShow(Sender: TObject);
var
  imgOrigin: TImage;
  sPicture: string;
  i: integer;
begin
  ClearControls;

  cxmemoDescription.Visible := frmRecipe.memMethodMethodType.AsInteger = _type.methodStep;

  imgOrigin := TImage.Create(self);

  // Method 사진 가져오기
  if not frmRecipe.memMethodNewPicture.AsString.IsEmpty then
  begin
    if FileExists(frmRecipe.memMethodNewPicture.AsString) then
    begin
      imgOrigin.Picture.LoadFromFile(frmRecipe.memMethodNewPicture.AsString);
      dmS3.CropImageToJPEG(imgOrigin, imgSquare, SizeSequre);
    end;
  end
  else if not frmRecipe.memMethodPictureSquare.AsString.IsEmpty  then
    dmS3.LoadImageFromS3(BUCKET_RECIPE, frmRecipe.memMethodPictureSquare.AsString, imgSquare);
end;

end.
