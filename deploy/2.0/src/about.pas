{
 /***************************************************************************
                                    about.pas
                                   ------------


 ***************************************************************************/

 *****************************************************************************
  This file is part of the Lazarus packages by Andreas Jakobsche

  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************
}
unit About;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TAboutBox }

  TAboutBox = class(TForm)
    Label1: TLabel;
    ScrollBox1: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ScrollBox1Resize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses FormEx;

{$R *.lfm}

{ TAboutBox }

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  FormAdjust(Self);
end;

procedure TAboutBox.FormResize(Sender: TObject);
begin
  Label1.Width := Label1.Parent.ClientWidth;
end;

procedure TAboutBox.ScrollBox1Resize(Sender: TObject);
begin

end;

end.

