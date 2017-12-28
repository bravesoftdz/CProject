unit uRecipeEditorFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.Edit;

type
  TframeRecipeEditor = class(TFrame)
    recTitle: TRectangle;
    layoutBackButton: TLayout;
    Image1: TImage;
    Text2: TText;
    Rectangle2: TRectangle;
    Text1: TText;
    Rectangle4: TRectangle;
    Edit2: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
