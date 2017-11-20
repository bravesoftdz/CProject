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
    cxdbID: TcxDBTextEdit;
    cxdbPassword: TcxDBTextEdit;
    cxdbName: TcxDBTextEdit;
    cxdbNational: TcxDBTextEdit;
    cxdbGender: TcxDBTextEdit;
    cxdbIP: TcxDBTextEdit;
    cxdbEmail: TcxDBTextEdit;
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
    cxdbBirthday: TcxDBDateEdit;
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
    FOldID, FOldNickname: string;
    procedure DrawEllipseFromCenter(Canvas: TCanvas; CenterOfEllipse: TPoint; RadiusOfCircle: Integer);
    procedure DrawEllipticRegion(wnd : HWND; rect : TRect);
    function MakingUserPicturename: string;
    procedure DeleteUserPicture;
    function isValidate: Boolean;
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
    if not isValidate then
      raise Exception.Create('필수값을 입력하십시오!');

    if (FOldID <> dmDB.tblUsers.FieldByName('ID').AsString) and dmDB.FindID(dmDB.tblUsers.FieldByName('ID').AsString) then
      raise Exception.Create('같은 Nickname 이 존재합니다!');

    if (FOldNickname <> dmDB.tblUsers.FieldByName('Nickname').AsString) and dmDB.FindNickname(dmDB.tblUsers.FieldByName('Nickname').AsString) then
      raise Exception.Create('같은 Nickname 이 존재합니다!');

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

          if not dmS3.SaveImageToS3(BUCKET_USER, fname, imgUserPicture) then
            ShowMessage('이미지를 저장하지 못했습니다!');
        end
        else
          // Update New Image
          if not dmS3.SaveImageToS3(BUCKET_USER, UserPictureName, imgUserPicture) then
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

  if not s3.DeleteObject(BUCKET_USER, UserPictureName) then
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

function TfrmUser.isValidate: Boolean;
begin
  if trim(cxdbNickName.Text) = '' then
    cxdbNickname.SetFocus
  else if trim(cxdbID.Text) = '' then
    cxdbID.SetFocus
  else if trim(cxdbPassword.Text) = '' then
    cxdbPassword.SetFocus
  else if trim(cxdbName.Text) = '' then
    cxdbName.SetFocus
  else if trim(cxdbNational.Text) = '' then
    cxdbNational.SetFocus
  else if trim(cxdbBirthday.Text) = '' then
    cxdbBirthday.SetFocus
  else if trim(cxdbGender.Text) = '' then
    cxdbGender.SetFocus
  else if trim(cxdbEmail.Text) = '' then
    cxdbEmail.SetFocus
  else if trim(cxdbIP.Text) = '' then
    cxdbIP.SetFocus;


  result := (trim(cxdbNickname.Text) <> '') and (trim(cxdbID.Text) <> '') and
            (trim(cxdbPassword.Text) <> '') and (trim(cxdbName.Text) <> '') and
            (trim(cxdbNational.Text) <> '') and (trim(cxdbBirthday.Text) <> '') and
            (trim(cxdbGender.Text) <> '') and (trim(cxdbEmail.Text) <> '') and
            (trim(cxdbIP.Text) <> '');
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
    FOldID := dmdB.tblUsers.FieldByName('ID').AsString;
    FOldNickname := dmDB.tblUsers.FieldByName('Nickname').AsString;

    if UserPictureName <> '' then
    begin
      jpg := TJPEGImage.Create;

      bmp := TBitmap.Create;

      graphic := TJPEGImage.Create;

      strStream := TStringStream.Create;
      NetHTTPClient1.Get('https://s3.ap-northeast-2.amazonaws.com/' + BUCKET_USER + '/' + UserPictureName, strStream);

      dmS3.LoadImageFromStream(imgUserPicture, strStream);
    end
  except
    On E: Exception do
      Showmessage(E.Message);
  end;
end;

end.
