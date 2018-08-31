{
 /***************************************************************************
                                    config.pas
                                   ------------


 ***************************************************************************/

 *****************************************************************************
  This file is part of the Lazarus packages by Andreas Jakobsche

  See the file COPYING.modifiedLGPL.txt, included in this distribution,
  for details about the license.
 *****************************************************************************
}
unit Config;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  TTranslateEvent = procedure (Sender: TObject; Lang: string) of object;

  TSetPropertyEvent = procedure(Sender: TObject; PropName, PropValue: string) of object;

  { TKarinaConfiguration }

  TKarinaConfiguration = class(TComponent)
  private
    FList: TStringList;
    FOnSetProperty: TSetPropertyEvent;
    FOnTranslate: TTranslateEvent;
    function GetConfigFileName: string;
    function GetList: TStringList;
  private
    HasChanged: Boolean;
    function GetLanguage: string;
    procedure SetLanguage(AValue: string);
    procedure Translate(Lang: string);
    property List: TStringList read GetList;
  protected
    procedure SetProperty(PropName, AValue: string);
    procedure GetProperty(PropName: string; var AValue: string);
  public
    constructor Create(AnOwner: TComponent); override;
    destructor Destroy; override;
    property ConfigFileName: string read GetConfigFileName;
  published
    property Language: string read GetLanguage write SetLanguage;
    property OnSetProperty: TSetPropertyEvent read FOnSetProperty write FOnSetProperty;
    property OnTranslate: TTranslateEvent read FOnTranslate write FOnTranslate;
  end;

var
  KarinaConfig: TKarinaConfiguration;

implementation

uses Forms, LCLTranslator;

{ TKarinaConfiguration }

function TKarinaConfiguration.GetConfigFileName: string;
begin
  Result := GetAppConfigFile(False)
end;

function TKarinaConfiguration.GetList: TStringList;
begin
  if not Assigned(FList) then begin
    FList := TStringList.Create;
    try
      FList.LoadFromFile(ConfigFileName);
    except
      on Exception do;
    end;
  end;
  Result := FList
end;

function TKarinaConfiguration.GetLanguage: string;
begin
  GetProperty('language', Result);
end;

procedure TKarinaConfiguration.SetLanguage(AValue: string);
begin
  if AValue <> Language then begin
    SetProperty('language', AValue);
    Translate(AValue)
  end;
end;

procedure TKarinaConfiguration.Translate(Lang: string);
begin
  SetDefaultLang(Lang, '', True);
  if Assigned(FOnTranslate) then FOnTranslate(Self, Lang)
end;

procedure TKarinaConfiguration.SetProperty(PropName, AValue: string);
begin
  if List.Values[PropName] <> AValue then begin
    List.Values[PropName] := AValue;
    HasChanged := True;
    if Assigned(FOnSetProperty) then FOnSetProperty(Self, PropName, AValue)
  end;
end;

procedure TKarinaConfiguration.GetProperty(PropName: string; var AValue: string
  );
begin
  AValue := List.Values[PropName];
end;

constructor TKarinaConfiguration.Create(AnOwner: TComponent);
var
  i: Integer;
  Translated: Boolean;
begin
  inherited Create(AnOwner);
{ Spracheinstellung in der Befehlszeile finden }
  i := 1; Translated := False;
  while i <= Application.ParamCount do
    if (Application.Params[i] = '-l') or (Application.Params[i] = '--lang') then begin
      Language := Application.Params[i + 1];
      Translated := True;
      Break;
    end;
{ Übersetzung in die Sprache aus der Konfigurationsdatei durchführen }
  if not Translated then Translate(Language)
end;

destructor TKarinaConfiguration.Destroy;
begin
  if HasChanged then begin
    ForceDirectories(ExtractFilePath(ConfigFileName));
    List.SaveToFile(ConfigFileName);
  end;
  FList.Free;
  inherited Destroy;
end;

initialization

KarinaConfig := TKarinaConfiguration.Create(Application);

end.

