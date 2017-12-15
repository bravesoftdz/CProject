program CookPlay;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  cookplay.StatusBar in '..\..\00.Library\cookplay.StatusBar.pas',
  uGlobal in 'uGlobal.pas',
  cookplay.Scale in '..\..\00.Library\cookplay.Scale.pas',
  ClientModuleUnit in 'ClientModuleUnit.pas' {CM: TDataModule},
  uRecipeEditor in 'uRecipeEditor.pas' {frmRecipeEditor},
  uSetup in 'uSetup.pas' {frmSetup},
  uRecipeCategory in 'uRecipeCategory.pas' {frmRecipeCategory},
  uList in 'uList.pas' {frmList},
  cookplay.S3 in '..\..\00.Library\cookplay.S3.pas' {frmS3},
  uWeb in 'uWeb.pas' {frmWeb},
  uListDragNDrop in 'uListDragNDrop.pas' {frmListDragNDrop},
  AnonThread in 'AnonThread.pas',
  uListScroll in 'uListScroll.pas',
  ClientClassesUnit in 'ClientClassesUnit.pas',
  uChangeWeight in 'uChangeWeight.pas' {frmChangeWeight},
  uComment in 'uComment.pas' {frmComment},
  uScaleFrame in 'uScaleFrame.pas' {frameScale: TFrame},
  uScaleView in 'uScaleView.pas' {frmScaleView},
  uRecipePlay in 'uRecipePlay.pas' {frmRecipePlay},
  uTemp in 'uTemp.pas' {Form3},
  uTimerFrame in 'uTimerFrame.pas' {frameTimer: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmRecipeEditor, frmRecipeEditor);
  Application.CreateForm(TfrmSetup, frmSetup);
  Application.CreateForm(TfrmRecipeCategory, frmRecipeCategory);
  Application.CreateForm(TfrmList, frmList);
  Application.CreateForm(TfrmS3, frmS3);
  Application.CreateForm(TfrmListDragNDrop, frmListDragNDrop);
  Application.CreateForm(TfrmChangeWeight, frmChangeWeight);
  Application.CreateForm(TfrmComment, frmComment);
  Application.CreateForm(TfrmScaleView, frmScaleView);
  Application.CreateForm(TfrmRecipePlay, frmRecipePlay);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TCM, CM);
  Application.Run;
end.
