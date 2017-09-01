unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Cloud.CloudAPI,
  Data.Cloud.AmazonAPI;

type
  TfrmMian = class(TForm)
    Memo: TMemo;
    Layout1: TLayout;
    Timer1: TTimer;
    Button1: TButton;
    FDConnection: TFDConnection;
    tblDeleteImageQue: TFDTable;
    AmazonConnectionInfo: TAmazonConnectionInfo;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure DeletingImages;
  public
    { Public declarations }
  end;

var
  frmMian: TfrmMian;

implementation

{$R *.fmx}

procedure TfrmMian.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMian.DeletingImages;
var
  s3: TAmazonStorageService;
  bucketname, objectname: string;
begin
  try
    s3 := TAmazonStorageService.Create(AmazonConnectionInfo);

    tblDeleteImageQue.Open;
    while not tblDeleteImageQue.Eof do
    begin
      bucketname := tblDeleteImageQue['BucketName'];
      objectname := tblDeleteImageQue['ImageName'];
      if s3.DeleteObject(bucketname, objectname) then
      begin
        if memo.Lines.Count > 500 then
          memo.Lines.Clear;

        try
          tblDeleteImageQue.Delete;
          memo.Lines.insert(0, tblDeleteImageQue['BucketName'] + ' : ' + tblDeleteImageQue['ImageName'] + '  ==> success');
        except
          tblDeleteImageQue.Cancel;
          memo.Lines.insert(0, tblDeleteImageQue['BucketName'] + ' : ' + tblDeleteImageQue['ImageName'] + '  ==> error');
        end;
      end
      else
      begin
        memo.Lines.insert(0, tblDeleteImageQue['BucketName'] + ' : ' + tblDeleteImageQue['ImageName'] + '  == fail');
        tblDeleteImageQue.Next;
      end;
    end;
  finally
    tblDeleteImageQue.Close;
    s3.Free;
  end;
end;

procedure TfrmMian.FormShow(Sender: TObject);
begin
  AmazonConnectionInfo.StorageEndpoint := 's3.ap-northeast-2.amazonaws.com';
  memo.Lines.Clear;
  Timer1.Enabled := True;
end;

procedure TfrmMian.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  try
    FDConnection.Open;

    DeletingImages;
  except
    on E:Exception do
      ShowMessage(E.Message);
  end;

  Timer1.Interval := 1000;// * 60 * 5; //5Ка
  Timer1.Enabled := True;
end;

end.
