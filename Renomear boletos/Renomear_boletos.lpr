program Renomear_boletos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, U_Principal
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Renomear Boletos';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFrm_Principal, Frm_Principal);
  Application.Run;
end.

