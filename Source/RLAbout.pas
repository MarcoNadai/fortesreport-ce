{$I RLReport.inc}

unit RLAbout;

interface

uses
  SysUtils, Classes,
{$ifdef MSWINDOWS}
  ShellAPI,
{$endif}
{$ifdef VCL}
  Windows, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
{$endif}
{$ifdef CLX}
  Types,
  Qt, QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QButtons,
{$endif}
  RLConsts, RLUtils, RLComponentFactory;

type
  TFormRLAbout = class(TForm)
    ImageLogo: TImage;
    LabelTitle: TLabel;
    LabelVersion: TLabel;
    LabelHome: TLabel;
    LabelCopyright: TLabel;
    BitBtnOk: TBitBtn;
    procedure LabelHomeClick(Sender: TObject);
  private
    TypedAuthorKey: string;
    procedure Init;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TFormRLAbout }

constructor TFormRLAbout.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  TypedAuthorKey := '';
  Init;
end;

procedure TFormRLAbout.KeyDown(var Key: Word; Shift: TShiftState);
const
  TheAuthorKey = 'TEAM';
begin
  inherited;
  if (ssCtrl in Shift) and (Key >= 65) and (Key <= 90) then
  begin
    TypedAuthorKey := TypedAuthorKey + Char(Key);
    if Length(TypedAuthorKey) > Length(TheAuthorKey) then
      Delete(TypedAuthorKey, 1, 1);
    if SameText(TypedAuthorKey, TheAuthorKey) then
      Caption := 'Autor: ' + CS_AuthorNameStr;
  end;
{$ifdef CLX}
  if Key = key_escape then
    BitBtnOk.Click;
{$endif}
{$ifdef VCL}
  if Key = vk_escape then
    BitBtnOk.Click;
{$endif}
end;

procedure TFormRLAbout.LabelHomeClick(Sender: TObject);
begin
{$ifdef MSWINDOWS}
  ShellExecute(0, nil, PChar(TLabel(Sender).Hint), nil, nil, SW_SHOWNORMAL);
{$endif}
end;

procedure TFormRLAbout.Init;
begin
  Left := 250;
  Top := 223;
  ActiveControl := BitBtnOk;
{$ifdef VCL}
  BorderStyle := bsDialog;
{$else}
  BorderStyle := fbsDialog;
{$endif};
  Caption := LocaleStrings.LS_AboutTheStr + ' ' + CS_ProductTitleStr;
  ClientHeight := 155;
  ClientWidth := 373;
  Color := clWhite;
  Position := poScreenCenter;
  {$ifndef FPC}
  Scaled := False;
  {$endif}
  PixelsPerInch := 96;
  KeyPreview := True;
  AutoScroll := False;

  ImageLogo := TImage.Create(Self);
  with ImageLogo do
  begin
    Name := 'ImageLogo';
    Parent := Self;
    Left := 12;
    Top := 12;
    Width := 32;
    Height := 32;
    AutoSize := True;
    Picture.Graphic := HexToGraphic(
      '07544269746D617076020000424D760200000000000076000000280000002000' +
      '000020000000010004000000000000020000120B0000120B0000100000001000' +
      '000000000000000080000080000000808000800000008000800080800000C0C0' +
      'C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF' +
      'FF00FFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFF' +
      'FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF99FFFFFFFFF' +
      'FFFFFFFFFFFFFFFFFFFF99FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF99FFFFFFFFFF' +
      'FFFFFFFFFFFFFFFFFFF99FFFFFFFFFFFFFFFFFFFFFFFFFFFFF999FFFFFFFFFFF' +
      'FFFFFFFFFFFFFFFFFF99FFFFFFFFFFFFFFFFFFFFFFFFFFFFF999FFFFFFFFFFFF' +
      'FFFFFFFFFFFF99FFF999FFFFFFFFFFFFFFFFFFFFFF99FFFF999FFFFFFFFFFFFF' +
      'FFFFFFFF999FFFFF999FFFFFFFFFFFFFFFFFFFF9999FFFF9999FFFFFFFFFFFFF' +
      'FFFFFF9999FFFFF9999FFFFFFFFFFFFFFFFFF99999FFFFF9999FFFFFFFFFFFFF' +
      'FFFFF99999FFFF99999FFFFFFFFFFFFFFFFFF99999FFFF99999FFFFFFFFFFFFF' +
      'FFFFF999999FFF99999FFFFFFFFFFFFFFFFFFF999999FF99999FFFFFFFFFFFFF' +
      'FFFFFFF999999F99999FFFFFFFFFFFFFFFFFFFFFF9999999999FFFFFFFFFFFFF' +
      'FFFFFFFFFFF999999999FFFFFFFFFFFFFFFFFFFFFFFFF9999999FFFFFFFFFFFF' +
      'FFFFFFFFFFFFFF9999999FFFFFFFFF999FFFFF9999FFFFF999999999999999FF' +
      'FFFFF999999FFFFF99999999999FFFFFFFFFF999999FFFFFF999999FFFFFFFFF' +
      'FFFFF999999FFFFFFF9999999FFFFFFFFFFFF999999FFFFFFFFF99999999FFFF' +
      '999FFF9999FFFFFFFFFFFF99999999999FFFFFFFFFFFFFFFFFFFFFFFF9999FFF' +
      'FFFF');
  end;

  TRLComponentFactory.CreateComponent(TLabel, Self, LabelTitle);
  with LabelTitle do
  begin
    Name := 'LabelTitle';
    Parent := Self;
    Left := 52;
    Top := 12;
    Width := 101;
    Height := 19;
    Caption := CS_ProductTitleStr;
    Font.Name := 'helvetica';
    Font.Color := clBlack;
    Font.Height := 19;
    Font.Pitch := fpVariable;
    Font.Style := [fsBold];
    ParentFont := False;
  end;

  TRLComponentFactory.CreateComponent(TLabel, Self, LabelVersion);
  with LabelVersion do
  begin
    Name := 'LabelVersion';
    Parent := Self;
    Left := 52;
    Top := 32;
    Width := 65;
    Height := 13;
{$ifdef VCL}
    Caption := CS_Version + ' VCL';
{$endif}
{$ifdef CLX}
    Caption := CS_Version + ' CLX';
{$endif}
    Font.Name := 'helvetica';
    Font.Color := clBlack;
    Font.Height := 13;
    Font.Pitch := fpVariable;
    Font.Style := [];
    ParentFont := False;
  end;

  TRLComponentFactory.CreateComponent(TLabel, Self, LabelCopyright);
  with LabelCopyright do
  begin
    Name := 'LabelCopyright';
    Parent := Self;
    Left := 52;
    Top := 56;
    Width := 211;
    Height := 14;
    Caption := CS_CopyrightStr + #13 + CS_AuthorNameStr;
    Font.Name := 'helvetica';
    Font.Color := clBlack;
    Font.Height := -11;
    Font.Pitch := fpVariable;
    Font.Style := [];
    ParentFont := False;
  end;

  TRLComponentFactory.CreateComponent(TLabel, Self, LabelHome);
  with LabelHome do
  begin
    Name := 'LabelHome';
    Parent := Self;
    Left := 52;
    Top := 92;
    Hint := CS_URLStr;
    Caption := CS_URLStr;
    Font.Name := 'helvetica';
    Font.Color := clBlue;
    Font.Height := -11;
    Font.Pitch := fpVariable;
    Font.Style := [fsUnderline];
    ParentFont := False;
    Cursor := crHandPoint;
    OnClick := LabelHomeClick;
  end;

  TRLComponentFactory.CreateComponent(TBitBtn, Self, BitBtnOk);
  with BitBtnOk do
  begin
    Name := 'BitBtnOk';
    Parent := Self;
    Left := 286;
    Top := 112;
    Width := 69;
    Height := 26;
    Caption := '&Ok';
    TabOrder := 0;
    Kind := bkOK;
  end;
end;

end.

