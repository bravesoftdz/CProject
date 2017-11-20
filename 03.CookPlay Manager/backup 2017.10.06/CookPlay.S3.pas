unit CookPlay.S3;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI,
  jpeg, Vcl.Graphics, Vcl.ExtCtrls, Vcl.Imaging.GIFimg, Vcl.Imaging.PNGimage,
  vcl.Dialogs, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.Types, Vcl.ExtDlgs, Data.DB;

type
  TImageType = (itNone, itBMP, itJPEG, itGIF, itPNG);

  TdmS3 = class(TDataModule)
    AmazonConnectionInfo: TAmazonConnectionInfo;
    NetHTTPClient: TNetHTTPClient;
    OpenPictureDialog: TOpenPictureDialog;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure init;
    function GetImageType(const strStream: TStringStream): TImageType;
    function SaveImageToS3(BucketName, fname: string; const sorImage: TImage): Boolean;
    function IsValidImage(fname: string): Boolean; overload;
    function IsValidImage(strStream: TStringStream): Boolean; overload;
    function LoadImageFromStream(image: TImage; const strStream: TStringStream): Boolean;
    function LoadImageFromS3(BucketName, ObjectName: string; image: TImage): Boolean;
    function CalCutSize(w, h: integer; size:TPoint): TPoint;
    function CropImageToJPEG(sorImage, tarImage: TImage; Size: TPoint): Boolean;
    function DeleteImage(bucketname, fname: string): Boolean;
    function GetImageName(Serial: LargeInt; ext: string; var picture: string; var pictureSquare: string; var pictureRectangle: string): Boolean;
  end;

const
  IH_BMP = 'BM';
  IH_JPEG = #$FF#$D8;
  IH_GIF = 'GIF';
  IH_PNG = #137'PNG'#13#10#26#10;

  SizeSequre: TPoint = (X:340; Y:340);
  SizeRectangle: TPoint = (X:320; Y:240);
  SizeUserPicture: TPoint = (X:280; Y:280);

//  CompressionQuality = 70;

var
  dmS3: TdmS3;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmS3 }

function TdmS3.GetImageName(Serial: LargeInt; ext: string; var picture, pictureSquare,
  pictureRectangle: string): Boolean;
var
  sDateTime: string;
begin
  try
    sDateTime := FormatDateTime('YYYYMMDD_HHNNSS_ZZZ', now);

    picture := Serial.ToString + '_' + sDateTime + ext;
    pictureRectangle := Serial.ToString + '_' + sDateTime + 'R.jpg';
    pictureSquare := Serial.ToString + '_' + sDatetime + 'S.jpg';

    result := True;
  except
    result := False;
  end;
end;

function TdmS3.GetImageType(const strStream: TStringStream): TImageType;
var
  tempFirstBytes : AnsiString;
begin
  SetLength(tempFirstBytes, 8);
  strStream.Read(tempFirstBytes[1], 8);
  strStream.Seek(0, 0);

  if copy(tempFirstBytes, 1, 2) = IH_JPEG then
    result := itJPEG
  else if copy(tempFirstbytes, 1, 3) = IH_GIF then
    result := itGIF
  else if copy(tempFirstBytes, 1, 2) = IH_BMP then
    result := itBMP
  else if tempFirstBytes = IH_PNG then
    result := itPNG
  else
    result := itNone;
end;

procedure TdmS3.init;
begin
  AmazonConnectionInfo.StorageEndpoint := 's3.ap-northeast-2.amazonaws.com';
end;

function TdmS3.IsValidImage(fname: string): Boolean;
var
  tempFileStream : TFileStream;
  tempFirstBytes : AnsiString;
begin
  tempFileStream := TFileStream.Create(fname, fmOpenRead);

  SetLength(tempFirstBytes, 8);
  tempFileStream.Read(tempFirstBytes[1], 8);
  tempFileStream.Free;

  result := (copy(tempFirstBytes, 1, 2) = IH_JPEG) OR
            (copy(tempFirstbytes, 1, 3) = IH_GIF) OR
            (copy(tempFirstBytes, 1, 2) = IH_BMP) OR
            (tempFirstBytes = IH_PNG);
end;

function TdmS3.IsValidImage(strStream: TStringStream): Boolean;
var
  tempFirstBytes : AnsiString;
begin
  SetLength(tempFirstBytes, 8);
  strStream.Read(tempFirstBytes[1], 8);
  strStream.Seek(0, 0);

  result := (copy(tempFirstBytes, 1, 2) = IH_JPEG) OR
            (copy(tempFirstbytes, 1, 3) = IH_GIF) OR
            (copy(tempFirstBytes, 1, 2) = IH_BMP) OR
            (tempFirstBytes = IH_PNG);
end;

function TdmS3.LoadImageFromS3(BucketName, ObjectName: string; image: TImage): Boolean;
var
  strStream: TStringStream;
begin
  result := False;
  try
    try
      strStream := TStringStream.Create;
      NetHTTPClient.Get('https://s3.ap-northeast-2.amazonaws.com/' + Bucketname + '/' + ObjectName, strStream);

      LoadImageFromStream(image, strStream);

      result := True;
    except
      On E: Exception do
        Showmessage(E.Message);
    end;
  finally
    strStream.Free;
  end;
end;

function TdmS3.LoadImageFromStream(image: TImage;
  const strStream: TStringStream): Boolean;
var
  graphic: TGraphic;
begin
  graphic := nil;
  case GetImageType(strStream) of
    itJPEG: graphic := TJPEGImage.Create;
    itBMP: graphic := TBitmap.Create;
    itGIF: graphic := TGIFImage.Create;
    itPNG: graphic := TPngImage.Create;
  end;

  if Assigned(graphic) then
  begin
    graphic.LoadFromStream(strStream);
    image.Picture.Assign(graphic);
    graphic.Free;
    result := true
  end
  else
    result := false;
end;

function TdmS3.CalCutSize(w, h: integer; size: TPoint): TPoint;
var
  nWidth, nHeight: integer;
begin
  if (w=0) or (h=0) or (size.X=0) or (size.Y=0) then
  begin
    result := Point(0,0);
    Exit;
  end;

  // 높이를 기준으로 계산 : size.Y 를 h와 같다고 했을 때, 필요한 w' 값을 계산한다
  nWidth := Trunc(h * size.X / size.Y);

  // 현재의 w 값이 계산된 w' 값보다 작을 경우에는 넓이를 기준으로 다시 계산한다
  if (w < nWidth) then
  begin
    nHeight := Trunc(w * Size.Y / size.X);

    result := Point(w, nHeight);
  end
  else
    result := Point(nWidth, h);
end;

function TdmS3.CropImageToJPEG(sorImage, tarImage: TImage; Size: TPoint): Boolean;
var
  bmp1, bmp2, bmp3: TBitmap;
  jpg: TJPEGImage;
  dxMargin, dyMargin: integer;
  cutSize: TPoint;
begin
  try
    try
      bmp1 := TBitmap.Create;
      bmp2 := TBitmap.Create;
      bmp3 := TBitmap.Create;
      jpg := TJPEGImage.Create;

      bmp1.Assign(sorImage.Picture.Graphic);

      // 필요한 width 와 height 를 구해온다
      cutSize := CalCutSize(bmp1.Width, bmp1.Height, Size);

      dxMargin := (bmp1.Width - cutSize.X) div 2;
      dyMargin := (bmp1.Height - cutSize.Y) div 2;

      bmp2.SetSize(cutSize.X, cutSize.Y);
      bmp2.Canvas.CopyRect(Rect(0,0,cutSize.X, cutSize.Y), bmp1.Canvas, Rect(dxMargin, dyMargin, dxMargin + cutSize.X, dyMargin + cutSize.Y));

      bmp3.SetSize(size.X, size.Y);
      SetStretchBltMode(bmp3.Canvas.Handle, HALFTONE);
      StretchBlt(bmp3.Canvas.Handle, 0, 0, size.X, size.Y, bmp2.Canvas.Handle, 0, 0, cutSize.X, cutSize.Y, SRCCOPY);

      jpg.Assign(bmp3);

      tarImage.Picture.Assign(jpg);

      result := True;
    except
      result := False;
    end;
  finally
    bmp1.Free;
    bmp2.Free;
    bmp3.Free;
    jpg.Free;
  end;
end;

function TdmS3.DeleteImage(bucketname, fname: string): Boolean;
var
  s3: TAmazonStorageService;
begin
  try
    try
      s3 := TAmazonStorageService.Create(dmS3.AmazonConnectionInfo);

      result := s3.DeleteObject(bucketname, fname);
    except
      on E: Exception do
      begin
        ShowMessage('사진 삭제에 실패하였습니다!');
        result := False;
      end;
    end;
  finally
    s3.Free;
  end;
end;

function TdmS3.SaveImageToS3(BucketName, fname: string; const sorImage: TImage): Boolean;
var
  s3: TAmazonStorageService;
  strStream: TStringStream;
//  graphic: TGraphic;
begin
  try
    try
      s3 := TAmazonStorageService.Create(dmS3.AmazonConnectionInfo);
      strstream := TStringStream.Create;

      sorImage.Picture.Graphic.SaveToStream(strStream);

      result := s3.UploadObject(BucketName, fname, strstream.Bytes, false, nil, nil, TAmazonACLType.amzbaPublicRead, nil);

  //    if (sorImage.Picture.Graphic is TJPEGImage) then
  //    begin
  //      graphic := TJPEGImage.Create;
  ////      TJPEGImage(graphic).CompressionQuality := CompressionQuality;
  //    end
  //    else if (sorImage.Picture.Graphic is TBitmap) then
  //      graphic := TBitmap.Create
  //    else if (sorImage.Picture.Graphic is TGIFImage) then
  //      graphic := TGIFImage.Create
  //    else if (sorImage.Picture.Graphic is TPNGImage) then
  //      graphic := TGIFImage.Create
  //    else
  //      graphic := nil;
  //
  //    if Assigned(graphic) then
  //    begin
  //      graphic.Assign(sorImage.Picture.Graphic);
  //      graphic.SaveToStream(strStream);
  //
  //      result := s3.UploadObject(BucketName, fname, strstream.Bytes, false, nil, nil, TAmazonACLType.amzbaPublicRead, nil);
  //    end
    except
      result := False;
    end;
  finally
    strstream.Free;
    s3.Free;
  end;
end;

end.
