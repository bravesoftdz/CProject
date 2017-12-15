unit uWebNew;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.WebBrowser,
  FMX.Objects, FMX.Layouts;

type
  TfrmWebNew = class(TForm)
    Rectangle1: TRectangle;
    layoutBackButton: TLayout;
    Image1: TImage;
    WebBrowser: TWebBrowser;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWebNew: TfrmWebNew;

implementation

{$R *.fmx}

end.
