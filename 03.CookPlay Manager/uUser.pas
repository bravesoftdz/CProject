unit uUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CookPlay.Global, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls, cxGraphics, cxControls, cxLookAndFeels,
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
  dxSkinXmas2008Blue, cxLabel, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxMemo, cxDBEdit, cxTextEdit, cxMaskEdit, cxCalendar,
  cxCheckBox, dxGDIPlusClasses, cxImage, jpeg, Vcl.ExtDlgs, Data.Cloud.CloudAPI,
  Data.Cloud.AmazonAPI, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent;

type
  TfrmUser = class(TForm)
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxDBCheckBox1: TcxDBCheckBox;
    cxLabel11: TcxLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    cxdbNickName: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
    cxDBTextEdit4: TcxDBTextEdit;
    cxDBTextEdit5: TcxDBTextEdit;
    cxDBTextEdit7: TcxDBTextEdit;
    cxDBTextEdit8: TcxDBTextEdit;
    cxDBTextEdit9: TcxDBTextEdit;
    cxDBMemo1: TcxDBMemo;
    cxLabel12: TcxLabel;
    cxDBDateEdit2: TcxDBDateEdit;
    cxDBDateEdit3: TcxDBDateEdit;
    cxLabel13: TcxLabel;
    cxDBCheckBox2: TcxDBCheckBox;
    cxLabel14: TcxLabel;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    cxDBCheckBox3: TcxDBCheckBox;
    btnSave: TButton;
    Button2: TButton;
    cxDBDateEdit4: TcxDBDateEdit;
    btnLoadUserPicture: TButton;
    imgUserPicture: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    btnClearUserPicture: TButton;
    Timer1: TTimer;
    NetHTTPClient1: TNetHTTPClient;
    procedure btnSaveClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnLoadUserPictureClick(Sender: TObject);
    procedure btnClearUserPictureClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure DrawEllipseFromCenter(Canvas: TCanvas; CenterOfEllipse: TPoint; RadiusOfCircle: Integer);
    procedure DrawEllipticRegion(wnd : HWND; rect : TRect);
    function MakingUserPicturename: string;
    procedure DeleteUserPicture;
  public
    { Public declarations }
    EditingMode: TEditingMode;
    UserPictureName: string;
    LoadedFilename: string;
  end;

var
  frmUser: TfrmUser;

implementation
uses uDB, Cookplay.S3;
{$R *.dfm}

procedure TfrmUser.btnSaveClick(Sender: TObject);
var
  fname: string;
begin
  try
    if imgUserPicture.Tag = 1 then
    begin
      if imgUserPicture.Picture.Graphic = nil then
      begin
        // Delete Old Image
        dmDB.tblUsers.FieldByName('Picture').AsString := '';
        DeleteUserPicture;
      end
      else
      begin
        if UserPictureName = '' then        
        begin
          // Add New Image
          fname := MakingUserPictureName;
          dmDB.tblUsers.FieldByName('Picture').AsString := fname;

          if not dmS3.SaveImageToS3(BUCKET_USER_NAME, fname, imgUserPicture) then
            ShowMessage('이미지를 저장하지 못했습니다!');
        end
        else
          // Update New Image
          if not dmS3.SaveImageToS3(BUCKET_USER_NAME, UserPictureName, imgUserPicture) then
            ShowMessage('이미지를 저장하지 못했습니다!');
      end;
    end;
  
    dmDB.tblUsers.Post;  
    dmDB.FDConnection.Commit;
    Close;
  except
    on E:Exception do
    begin
//      dmDB.tblUsers.Cancel;
      dmDB.FDConnection.Rollback;
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TfrmUser.Button2Click(Sender: TObject);
begin
  dmDB.tblUsers.Cancel;
  dmDB.FDConnection.Rollback;
  Close;
end;

procedure TfrmUser.btnLoadUserPictureClick(Sender: TObject);
var
  image: TImage;
begin
  image := TImage.Create(self);

  if OpenPictureDialog1.Execute then
  begin
    LoadedFilename := OpenPictureDialog1.FileName;
    if FileExists(LoadedFilename) then
    begin
      if dmS3.IsValidImage(LoadedFilename) then
      begin
        image.Picture.LoadFromFile(LoadedFilename);

        if not dmS3.CropImageToJPEG(image, imgUserPicture, SizeUserPicture) then
          ShowMessage('이미지를 불러올 수 없습니다!')
        else
          imgUserPicture.Tag := 1
      end
      else
        ShowMessage('지원하는 이미지 타입이 아닙니다!');
    end
    else
      ShowMessage('파일을 찾을 수 없습니다!');
  end;
end;

procedure TfrmUser.btnClearUserPictureClick(Sender: TObject);
begin
  imgUserPicture.Picture.Assign(nil);
  
  if UserPictureName = '' then
    imgUserPicture.Tag := 0
  else
    imgUserPicture.Tag := 1;
end;

procedure TfrmUser.DeleteUserPicture;
var
  s3: TAmazonStorageService;
begin
  s3 := TAmazonStorageService.Create(dmS3.AmazonConnectionInfo);

  if not s3.DeleteObject(BUCKET_USER_NAME, UserPictureName) then
    ShowMessage('사진 삭제에 실패하였습니다!');

  s3.Free;
end;

procedure TfrmUser.DrawEllipseFromCenter(Canvas: TCanvas;
  CenterOfEllipse: TPoint; RadiusOfCircle: Integer);
var
  R: TRect;
begin
  with Canvas do begin
    R.Top := CenterOfEllipse.Y - RadiusOfCircle;
    R.Left := CenterOfEllipse.X - RadiusOfCircle;
    R.Bottom := CenterOfEllipse.Y + RadiusOfCircle;
    R.Right := CenterOfEllipse.X + RadiusOfCircle;
    Ellipse(R);
    MoveTo(CenterOfEllipse.X, CenterOfEllipse.Y);
    LineTo(CenterOfEllipse.X, CenterOfEllipse.Y);
  end;
end;

procedure TfrmUser.DrawEllipticRegion(wnd: HWND; rect: TRect);
var
  rgn: HRGN;
begin
  rgn := CreateEllipticRgn(rect.left, rect.top, rect.right, rect.bottom);
  SetWindowRgn(wnd, rgn, TRUE);
end;

procedure TfrmUser.FormShow(Sender: TObject);
begin
  imgUserPicture.Picture.Assign(nil);
  LoadedFilename := '';

  Timer1.Enabled := True;
end;

function TfrmUser.MakingUserPicturename: string;
begin
  result := cxdbNickname.EditingText + '_Picture.jpg';// + ExtractFileExt(LoadedFilename);

end;

procedure TfrmUser.Timer1Timer(Sender: TObject);
var
  strStream: TStringStream;
  jpg: TJPEGImage;
  bmp: TBitmap;
  graphic: TGraphic;
begin
  Timer1.Enabled := False;

  try
    if UserPictureName <> '' then
    begin
      jpg := TJPEGImage.Create;

      bmp := TBitmap.Create;

      graphic := TJPEGImage.Create;

      strStream := TStringStream.Create;
      NetHTTPClient1.Get('https://s3.ap-northeast-2.amazonaws.com/' + BUCKET_USER_NAME + '/' + UserPictureName, strStream);

      dmS3.LoadImageFromStream(imgUserPicture, strStream);
    end
  except
    On E: Exception do
      Showmessage(E.Message);
  end;
end;

end.
