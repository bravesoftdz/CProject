unit uScaleView;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uScaleFrame,
  FMX.Objects, uGlobal, cookplay.scale;

type
  TfrmScaleView = class(TForm)
    frameScale1: TframeScale;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frameScale1layoutCloseClick(Sender: TObject);
    procedure frameScale1txtViewActionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FScaleMeasureType: TScaleMeasureType;
    FIngredientExplain: string;
    FIngredientWeight: Single;
    FIngredientUnit: TingredientUnit;

    FCallbackRefFunc: TCallbackRefFunc;

    procedure ClearControls;
  public
    { Public declarations }
    procedure SetValue(aExplain: string='';
      aWeight: Single = WEIGHT_DEFAULT_MAX;
      aScaleMeasureType: TScaleMeasureType=smViewSetup;
      aIngredientUnit: TIngredientUnit=wuG;
      aCallbackRefFunc: TCallbackRefFunc=nil);
  end;

var
  frmScaleView: TfrmScaleView;

implementation
uses cookplay.StatusBar;
{$R *.fmx}

procedure TfrmScaleView.ClearControls;
begin
  FScaleMeasureType := TScaleMeasureType.smViewSetup;
  FIngredientExplain := '';
  FIngredientWeight := WEIGHT_DEFAULT_MAX;
  FIngredientUnit := TIngredientUnit.wuG;

  FCallbackRefFunc := nil;
end;

procedure TfrmScaleView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frameScale1.CloseScale;

  if Assigned(FCallbackRefFunc) then
    FCallbackRefFunc := nil;

  ClearControls;
end;

procedure TfrmScaleView.FormCreate(Sender: TObject);
begin
  ClearControls;
end;

procedure TfrmScaleView.FormShow(Sender: TObject);
begin
  // Status Bar »öÀ» ¹Ù²Û´Ù
  Fill.Color := $FFFFDF77;
  StatusBarSetColor(Fill.Color);

  frameScale1.Resize(FScaleMeasureType);
  frameScale1.ScaleOpen(FScaleMeasureType, FIngredientExplain, FIngredientWeight, FIngredientUnit, nil);
end;

procedure TfrmScaleView.frameScale1layoutCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmScaleView.frameScale1txtViewActionClick(Sender: TObject);
var
  aList: TStringList;
begin
  frameScale1.txtViewActionClick(Sender);

  if Assigned(FCallbackRefFunc) then
  begin
    aList := TStringList.Create;
    aList.Add(frameScale1.Weight.ToString);
    FCallbackRefFunc(aList);
    Close;
  end;
end;

procedure TfrmScaleView.SetValue(aExplain: string; aWeight: Single;
      aScaleMeasureType: TScaleMeasureType; aIngredientUnit: TIngredientUnit;
      aCallbackRefFunc: TCallbackRefFunc);
begin
  FScaleMeasureType := aScaleMeasureType;

  FIngredientExplain := aExplain;
  FIngredientWeight := aWeight;
  FIngredientUnit := aIngredientUnit;

  FCallbackRefFunc := aCallbackRefFunc;
end;

end.
