{
 /***************************************************************************
                                     unit1.pas
                                   ------------


 ***************************************************************************/

 *****************************************************************************
  This file is part of the Lazarus packages by Andreas Jakobsche

  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************
}
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynEdit, Forms, Controls, Graphics, Dialogs,
  Menus, ComCtrls, StdCtrls{, PathView};

type

  { TForm1 }

  TForm1 = class(TForm)
    FindDialog: TFindDialog;
    FontDialog: TFontDialog;
    Flags: TImageList;
    MainMenu: TMainMenu;
    TextEdit: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    LangMenu: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    WordWrapItem: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItemSave: TMenuItem;
    MenuItemSaveAs: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    StatusBar1: TStatusBar;
    procedure FindDialogFind(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure TextEditChange(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure WordWrapItemClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItemSaveClick(Sender: TObject);
    procedure MenuItemSaveAsClick(Sender: TObject);
  private
    { private declarations }
    procedure Translate(Language: string; MenuItem: TMenuItem);
  public
    { public declarations }
    Start: Integer;
    FileName: string;
    HasChanged: Boolean;
    procedure LoadFile;
  end;

var
  Form1: TForm1;

implementation

uses About, FormEx, Config;

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  if HasChanged then
    case MessageDlg('Der Text wurde geändert. Soll er gespeichert werden?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: MenuItemSave.Click;
      mrNo:;
      else Exit;
    end;
  if OpenDialog.Execute then begin
    FileName := OpenDialog.FileName;
    TextEdit.Lines.LoadFromFile(FileName);
    Caption := Format('%s - Karina', [FileName]);
    HasChanged := False
  end;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  Close
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if HasChanged then
    case MessageDlg('Der Text wurde geändert. Soll er gespeichert werden?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: MenuItemSave.Click;
      mrNo:;
      else Exit;
    end;
  TextEdit.Lines.Clear;
  FileName := '';
  Caption := 'Karina';
end;

procedure TForm1.TextEditChange(Sender: TObject);
begin
  HasChanged := True
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if HasChanged then
    case MessageDlg('Der Text wurde geändert. Soll er gespeichert werden?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: begin
          MenuItemSave.Click;
          CanClose := True
        end;
      mrNo: CanClose := True
      else CanClose := False;
    end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin

end;

procedure TForm1.FindDialogFind(Sender: TObject);
var
  P: Integer;
begin
  if Start = 0 then begin
    P := Pos(FindDialog.FindText, TextEdit.Text) - 1;
    if P = -1 then begin
      ShowMessage('Kein Fund');
    end
    else begin
      TextEdit.SelStart := P;
      TextEdit.SelLength := Length(FindDialog.FindText);
      Start := P + Length(FindDialog.FindText) + 1;
    end;
  end
  else begin
    P := Start + Pos(FindDialog.FindText, Copy(TextEdit.Text, Start + 1, Length(TextEdit.Text))) - 2;
    if P <= Start then begin
      ShowMessage('Kein weiterer Fund');
      Start := 0
    end
    else begin
      TextEdit.SelStart := P;
      TextEdit.SelLength := Length(FindDialog.FindText);
      Start := Start + P + Length(FindDialog.FindText);
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
  FormAdjust(Self);
  LoadFile;
  WordWrapItem.Checked := TextEdit.WordWrap;
  with KarinaConfig do begin
    if (Language = '') or (Language = 'de') then LangMenu.ImageIndex:=0
    else if Language = 'en' then LangMenu.ImageIndex := 1
    else if Language = 'fr' then LangMenu.ImageIndex := 2
    else if Language = 'es' then LangMenu.ImageIndex := 3
    else if Language = 'ru' then LangMenu.ImageIndex := 4;
  end;
{ Nicht verwendete Menübefehle deaktivieren }
  with MainMenu.Items do
    for i := 0 to Count - 1 do
      for j := 0 to Items[i].Count - 1 do
        Items[i].Items[j].Enabled := (Items[i].Items[j].Caption = '-') or (Items[i].Items[j].OnClick <> nil);
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  Close
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
  FindDialog.Execute;
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem23Click(Sender: TObject);
begin
  AboutBox.Show
end;

procedure TForm1.MenuItem25Click(Sender: TObject);
begin
  if FontDialog.Execute then TextEdit.Font := FontDialog.Font;
end;

procedure TForm1.MenuItem27Click(Sender: TObject);
begin
  Translate('', Sender as TMenuItem);
end;

procedure TForm1.MenuItem28Click(Sender: TObject);
begin
  Translate('en', Sender as TMenuItem);
end;

procedure TForm1.MenuItem29Click(Sender: TObject);
begin
  if HasChanged then
    case MessageDlg('Der Text wurde geändert. Soll er gespeichert werden?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes: MenuItemSave.Click;
      mrNo:;
      else Exit;
    end;
  FileName := KarinaConfig.ConfigFileName;
  TextEdit.Lines.LoadFromFile(FileName);
  Caption := Format('%s - Karina', [FileName]);
  HasChanged := False
end;

procedure TForm1.MenuItem30Click(Sender: TObject);
begin
  Translate('fr', Sender as TMenuItem);
end;

procedure TForm1.MenuItem31Click(Sender: TObject);
begin
  Translate('es', Sender as TMenuItem);
end;

procedure TForm1.MenuItem32Click(Sender: TObject);
begin
  Translate('ru', Sender as TMenuItem);
end;

procedure TForm1.WordWrapItemClick(Sender: TObject);
begin
  TextEdit.WordWrap := not TextEdit.WordWrap;
  (Sender as TMenuItem).Checked := TextEdit.WordWrap;
end;

procedure TForm1.MenuItemSaveClick(Sender: TObject);
begin
  if FileName <> '' then begin
    TextEdit.Lines.SaveToFile(FileName);
    HasChanged := False
  end
  else MenuItemSaveAs.Click
end;

procedure TForm1.MenuItemSaveAsClick(Sender: TObject);
begin
  if SaveDialog.Execute then begin
    FileName := SaveDialog.FileName;
    TextEdit.Lines.SaveToFile(FileName);
    HasChanged := False;
    Caption := Format('%s - Karina', [FileName])
  end;
end;

procedure TForm1.Translate(Language: string; MenuItem: TMenuItem);
begin
  KarinaConfig.Language := Language;
  LangMenu.ImageIndex := MenuItem.ImageIndex
end;

procedure TForm1.LoadFile;
var
  i: Integer;
begin
  if Application.ParamCount > 0 then begin
    i := 1;
    with Application do
      while (i <= ParamCount) do begin
      { Optionen mit je 1 Parameter überspringen }
        if (Params[i] = '-l') or (Params[i] = '--lang') then begin
          Inc(i, 2) {wird von Unit LCLTranslator ausgewertet}
        end
      { Optionen ohne Parameter überspringen }
        else if Params[i][1] = '-' then Inc(i)
        else Break {Dateiname als Parameter an Position i vermutet}
      end;
    if Application.Params[i] <> '' then begin
      TextEdit.Lines.LoadFromFile(Application.Params[i]);
      Caption := Format('%s - Karina', [Application.Params[i]]);
      FileName := Application.Params[i]
    end
  end;
end;

end.

