{
 /***************************************************************************
                                    karina.pas
                                   ------------


 ***************************************************************************/

 *****************************************************************************
  This file is part of the Lazarus packages by Andreas Jakobsche

  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************
}
program karina;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  clocale,
  {$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, about
  { you can add units after this };

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.

