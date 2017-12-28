unit cookplay.S3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI, FMX.Objects, FMX.Surfaces, Data.DB,
  uGlobal;

type
  TImageType = (itNone, itBMP, itJPEG, itGIF, itPNG);

  TfrmS3 = class(TForm)
    AmazonConnectionInfo: TAmazonConnectionInfo;
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
//    function LoadImageFromS3(BucketName, ObjectName: string; image: TImage): Boolean; overload;
    function LoadImageFromS3(BucketName, ObjectName: string; bitmap: TBitmap): Boolean; overload;
    function LoadImageFromS3Ref(BucketName, ObjectName: string; bitmap: TBitmap; aCallBack: TCallbackRefNotify ): Boolean; overload;
    function CalCutSize(w, h: integer; size:TPoint): TPoint;
    function CropImageToJPEG(sorImage, tarImage: TImage; Size: TPoint): Boolean;
    function DeleteImage(bucketname, fname: string): Boolean;
    function GetImageName(Serial: LargeInt; var picture: string; var pictureSquare: string; var pictureRectangle: string): Boolean;
  end;

const
  IH_BMP = 'BM';
  IH_JPEG = #$FF#$D8;
  IH_GIF = 'GIF';
  IH_PNG = #137'PNG'#13#10#26#10;

  BUCKET_USER = 'cookplay-users';
  BUCKET_RECIPE = 'cookplay-recipe';
  BUCKET_STORY = 'cookplay-story';

  URL_S3 = 'https://s3.ap-northeast-2.amazonaws.com/';

  SizeSequre: TPoint = (X:340; Y:340);
  SizeRectangle: TPoint = (X:320; Y:240);
  SizeUserPicture: TPoint = (X:280; Y:280);

var
  frmS3: TfrmS3;

implementation
uses AnonThread;

{$R *.fmx}
function TfrmS3.GetImageName(Serial: LargeInt; var picture, pictureSquare,
  pictureRectangle: string): Boolean;
var
  sDateTime: string;
begin
  try
    sDateTime := FormatDateTime('YYYYMMDD_HHNNSS_ZZZ', now);

    picture := Serial.ToString + '_' + sDateTime + '.jpg';
    pictureRectangle := Serial.ToString + '_' + sDateTime + 'R.jpg';
    pictureSquare := Serial.ToString + '_' + sDatetime + 'S.jpg';

    result := True;
  except
    result := False;
  end;
end;

function TfrmS3.GetImageType(const strStream: TStringStream): TImageType;
var
  tempFirstBytes : UnicodeString;
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

procedure TfrmS3.init;
begin
  AmazonConnectionInfo.StorageEndpoint := 's3.ap-northeast-2.amazonaws.com';
end;

function TfrmS3.IsValidImage(fname: string): Boolean;
var
  tempFileStream : TFileStream;
  tempFirstBytes : UnicodeString;
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

function TfrmS3.IsValidImage(strStream: TStringStream): Boolean;
var
  tempFirstBytes : UnicodeString;
begin
  SetLength(tempFirstBytes, 8);
  strStream.Read(tempFirstBytes[1], 8);
  strStream.Seek(0, 0);

  result := (copy(tempFirstBytes, 1, 2) = IH_JPEG) OR
            (copy(tempFirstbytes, 1, 3) = IH_GIF) OR
            (copy(tempFirstBytes, 1, 2) = IH_BMP) OR
            (tempFirstBytes = IH_PNG);
end;

//function TfrmS3.LoadImageFromS3(BucketName, ObjectName: string; image: TImage): Boolean;
//var
//  oThread: TAnonymousThread<TMemoryStream>;
////  strStream: TStringStream;
//begin
//  result := False;
//
//  try
//    oThread := TAnonymousThread<TMemoryStream>.Create(
//      function: TMemoryStream
//      begin
//        result := TMemoryStream.Create;
//        NetHTTPClient.Get(URL_S3 + Bucketname + '/' + ObjectName, result);
//      end,
//      procedure(AResult: TMemoryStream)
//      begin
//        if aResult.Size > 0 then
//          image.Bitmap.LoadFromStream(aResult);
//
//        aResult.Free;
//      end,
//      procedure(aException: Exception)
//      begin
//      end
//    );
//    result := True;
//  except
//  end;
//
//
////  try
////    try
////      strStream := TStringStream.Create;
////      NetHTTPClient.Get(URL_S3 + Bucketname + '/' + ObjectName, strStream);
////
////      image.Bitmap.LoadFromStream(strStream);
//////      LoadImageFromStream(image, strStream);
////
////      result := True;
////    except
////      On E: Exception do
////        Showmessage(E.Message);
////    end;
////  finally
////    strStream.Free;
////  end;
//end;

function TfrmS3.LoadImageFromS3(BucketName, ObjectName: string;
  bitmap: TBitmap): Boolean;
var
  oThread: TAnonymousThread<TMemoryStream>;
//  strStream: TStringStream;
begin
  result := False;

  try
    oThread := TAnonymousThread<TMemoryStream>.Create(
      function: TMemoryStream
      var
        s3: TAmazonStorageService;
      begin
        s3 := TAmazonStorageService.Create(frmS3.AmazonConnectionInfo);

        result := TMemoryStream.Create;

        if not s3.GetObject(BucketName, ObjectName, result) then
          result.DisposeOf;

        s3.Free;
      end,
      procedure(aResult: TMemoryStream)
      begin
        if Assigned(aResult) and (aResult.Size > 0) then
          Bitmap.LoadFromStream(aResult);

        aResult.Free;
      end,
      procedure(aException: Exception)
      begin
      end
    );
    result := True;
  except
  end;
end;

function TfrmS3.LoadImageFromS3Ref(BucketName, ObjectName: string;
  bitmap: TBitmap; aCallBack: TCallbackRefNotify): Boolean;
var
  oThread: TAnonymousThread<TMemoryStream>;
//  strStream: TStringStream;
begin
  result := False;

  try
    oThread := TAnonymousThread<TMemoryStream>.Create(
      function: TMemoryStream
      var
        s3: TAmazonStorageService;
      begin
        s3 := TAmazonStorageService.Create(frmS3.AmazonConnectionInfo);

        result := TMemoryStream.Create;

        if not s3.GetObject(BucketName, ObjectName, result) then
          result.DisposeOf;

        s3.Free;
      end,
      procedure(aResult: TMemoryStream)
      begin
        if Assigned(aResult) and (aResult.Size > 0) then
          Bitmap.LoadFromStream(aResult);

        aResult.Free;
        aCallBack;
      end,
      procedure(aException: Exception)
      begin
      end
    );
    result := True;
  except
  end;
end;

function TfrmS3.LoadImageFromStream(image: TImage;
  const strStream: TStringStream): Boolean;
var
  iType: TImagetype;
//  graphic: TGraphic;
begin
//  graphic := nil;
//  case GetImageType(strStream) of
//    itJPEG: graphic := TJPEGImage.Create;
//    itBMP: graphic := TBitmap.Create;
//    itGIF: graphic := TGIFImage.Create;
//    itPNG: graphic := TPngImage.Create;
//  end;

  itype := GetImageType(strStream);

  result := itype in [itJPEG, itBMP, itGIF, itPNG];

  if result then
    image.Bitmap.LoadFromStream(strStream);

//  if Assigned(graphic) then
//  begin
//    graphic.LoadFromStream(strStream);
//    image.Picture.Assign(graphic);
//    graphic.Free;
//    result := true
//  end
//  else
//    result := false;
end;

function TfrmS3.CalCutSize(w, h: integer; size: TPoint): TPoint;
var
  nWidth, nHeight: integer;
begin
  if (w=0) or (h=0) or (size.X=0) or (size.Y=0) then
  begin
    result := Point(0,0);
    Exit;
  end;

  if ((w=size.X) and (h=size.Y)) then
  begin
    result := size;
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

function TfrmS3.CropImageToJPEG(sorImage, tarImage: TImage; Size: TPoint): Boolean;
var
  bmp1: TBitmap;
  dxMargin, dyMargin: integer;
  cutSize: TPoint;
  Stream: TmemoryStream;
  Surf: TBitmapSurface;
begin
  try
    try
      // 필요한 width 와 height 를 구해온다
      cutSize := CalCutSize(sorImage.Bitmap.Width, sorImage.Bitmap.Height, Size);// bmp1.Width, bmp1.Height, Size);

      dxMargin := (sorImage.Bitmap.Width - cutSize.X) div 2;
      dyMargin := (sorImage.Bitmap.Height - cutSize.Y) div 2;

      bmp1 := TBitmap.Create(cutSize.X, cutSize.Y);
      bmp1.Canvas.BeginScene;
      bmp1.Canvas.DrawBitmap(sorImage.Bitmap, Rect(dxMargin, dyMargin, dxMargin + cutSize.X, dyMargin + cutSize.Y), Rect(0,0,cutSize.X, cutSize.Y), 1);
      bmp1.Canvas.EndScene;

      bmp1.Resize(size.X, size.Y);

      // JPEG 형태로 바꾸어 준다
      Stream := TMemoryStream.Create;
      Surf := TBitmapSurface.Create;

      Stream.Position := 0;
      Surf.Assign(bmp1);
      TBitmapcodecManager.SaveToStream(Stream, Surf, '.jpg');

      Stream.Position := 0;
      tarImage.Bitmap.LoadFromStream(Stream);

//      tarImage.Bitmap.Assign(bmp1);

      result := True;
    except
      result := False;
    end;
  finally
    bmp1.Free;
  end;
end;

function TfrmS3.DeleteImage(bucketname, fname: string): Boolean;
var
  s3: TAmazonStorageService;
begin
  try
    try
      s3 := TAmazonStorageService.Create(frmS3.AmazonConnectionInfo);

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

function TfrmS3.SaveImageToS3(BucketName, fname: string; const sorImage: TImage): Boolean;
var
//  s3: TAmazonStorageService;
//  strStream: TStringStream;
  oThread: TAnonymousThread<TAmazonStorageService>;
begin
//  s3 := TAmazonStorageService.Create(frmS3.AmazonConnectionInfo);

  try
    oThread := TAnonymousThread<TAmazonStorageService>.Create(
      function: TAmazonStorageService
      var
        strStream: TSTringStream;
      begin
        result := TAmazonStorageService.Create(frmS3.AmazonConnectionInfo);
        strStream := TStringStream.Create;

        sorImage.Bitmap.SaveToStream(strStream);

        result.UploadObject(BucketName, fname, strStream.Bytes, false, nil, nil, TAmazonACLType.amzbaPublicRead, nil);

        strStream.Free;
      end,
      procedure(AResult: TAmazonStorageService)
      begin
        aResult.Free;
      end,
      procedure(aException: Exception)
      begin
      end
    );
    result := True;
  except
  end;


//  try
//    try
//      s3 := TAmazonStorageService.Create(frmS3.AmazonConnectionInfo);
//      strstream := TStringStream.Create;
//
//      sorImage.Bitmap.SaveToStream(strStream);
//
//      result := s3.UploadObject(BucketName, fname, strstream.Bytes, false, nil, nil, TAmazonACLType.amzbaPublicRead, nil);
//    except
//      result := False;
//    end;
//  finally
//    strstream.Free;
//    s3.Free;
//  end;
end;

end.
