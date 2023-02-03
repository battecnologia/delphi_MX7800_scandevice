unit HeaderFooterTemplate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  batBroadcastReceiver, batMX7800ScanDevice, FMX.Controls.Presentation,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  THeaderFooterForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    MX7800ScanDevice1: TMX7800ScanDevice;
    btActive: TButton;
    Memo1: TMemo;
    Button1: TButton;
    procedure btActiveClick(Sender: TObject);
    procedure MX7800ScanDevice1BarcodeRead(barcode: string);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HeaderFooterForm: THeaderFooterForm;

implementation

{$R *.fmx}

procedure THeaderFooterForm.btActiveClick(Sender: TObject);
var
  ok: Boolean;
begin
  ok:= MX7800ScanDevice1.InitReader;
  if MX7800ScanDevice1.Active then
  begin
    ShowMessage('Scanner Activated');
    Memo1.Lines.Clear;
  end
  else
    ShowMessage('Scanner not activated');
end;

procedure THeaderFooterForm.Button1Click(Sender: TObject);
begin
  if MX7800ScanDevice1.Active then
  begin
    MX7800ScanDevice1.Active:= False;
    ShowMessage('Scanner Closed');
  end;
end;

procedure THeaderFooterForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  MX7800ScanDevice1.Active:= False;
end;

procedure THeaderFooterForm.MX7800ScanDevice1BarcodeRead(barcode: string);
begin
  Memo1.Lines.Add(barcode);
end;

end.
