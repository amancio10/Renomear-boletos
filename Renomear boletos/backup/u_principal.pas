unit U_Principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus,
  StdCtrls, ComCtrls, Buttons, ShellAPI;

type

  { TFrm_Principal }

  TFrm_Principal = class(TForm)
    Edit_Pasta_Raiz: TEdit;
    Edit_Nome_Padrao: TEdit;
    Edit_Intervalo: TEdit;
    Edit_N_Primeiro_Boleto: TEdit;
    Edit_N_Ultimo_Boleto: TEdit;
    Edit_Quant_Arquivos: TEdit;
    Edit_Nome: TEdit;
    Edit_CPF: TEdit;
    Edit_Vencimento: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ImagemFundo: TImage;
    Label1: TLabel;
    Lb_Link_GitHub: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    Menu_Arquivo: TMenuItem;
    Menu_Converter: TMenuItem;
    Menu_Dividir: TMenuItem;
    Menu_Principal: TMainMenu;
    Menu_Sair: TMenuItem;
    ProgressBar1: TProgressBar;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Separador: TMenuItem;
    Bt_Dividir: TSpeedButton;
    Bt_Apagar_Capas: TSpeedButton;
    Bt_Converter: TSpeedButton;
    Bt_Renomear: TSpeedButton;
    SpeedButton1: TSpeedButton;
    procedure Bt_ConverterClick(Sender: TObject);
    procedure Bt_RenomearClick(Sender: TObject);
    procedure Lb_Link_GitHubClick(Sender: TObject);
    procedure Menu_SairClick(Sender: TObject);
    procedure Bt_DividirClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private

  public

  end;

var
  Frm_Principal: TFrm_Principal;

  StlArquivo : TStringList;
  QuantBoletos, Intervalo, UltimoReg, I : Integer;
  PastaRaiz, NomePadrao, Posicao, N_DOC, Arquivo_original, Novo_arquivo, S, Texto : string;

implementation

{$R *.lfm}

{ TFrm_Principal }

Function RemoverPalavras(Frase,Palavra_Remover:String): String;
Var
  Aux: String;
begin
  Aux := ' ' + Frase + '';
  Aux := StringReplace(Aux,''+Palavra_Remover+'','',[rfReplaceAll]);
  Result := Copy(Aux,2,Length(Aux)-1);
end;


procedure TFrm_Principal.Bt_DividirClick(Sender: TObject);
begin
   ShellExecute(Handle, 'open', 'https://www.ilovepdf.com/pt/dividir_pdf', '', '', 1);
end;

procedure TFrm_Principal.SpeedButton1Click(Sender: TObject);
begin
 if SelectDirectoryDialog1.Execute then
  Edit_Pasta_Raiz.Text := SelectDirectoryDialog1.FileName;
end;

procedure TFrm_Principal.Menu_SairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrm_Principal.Bt_ConverterClick(Sender: TObject);
begin
   ShowMessage('Para converter os PDFs use o Format Factory  ;)');
end;

procedure TFrm_Principal.Bt_RenomearClick(Sender: TObject);
begin

 if (Edit_Pasta_Raiz.Text <> '')      and (Edit_Quant_Arquivos.Text <> '')    and
    (Edit_Nome_Padrao.Text <> '')     and (Edit_Intervalo.Text <> '')         and
    (Edit_N_Ultimo_Boleto.Text <> '') and (Edit_N_Primeiro_Boleto.Text <> '') then
 begin // <-- Início do (if) validar campos vazios

//-----------------------------------------------------
  PastaRaiz    := Edit_Pasta_Raiz.Text;
  NomePadrao   := Edit_Nome_Padrao.Text;
  QuantBoletos := StrToInt(Edit_N_Ultimo_Boleto.Text);
  Intervalo    := StrToInt(Edit_Intervalo.Text);

//-----------------------------------------------------
  ProgressBar1.Max := StrToInt(Edit_Quant_Arquivos.Text);
  ProgressBar1.Position := 0;

//-------------------------------------------------------------------------------------
  UltimoReg := (StrToInt(Edit_N_Primeiro_Boleto.Text) - StrToInt(Edit_Intervalo.Text));

//---------------------------------------------------------------
 While QuantBoletos > UltimoReg do  // Parar no primeiro registro
  begin // <-- Início do (while)
   // --> Encontra o arquivo e colhe os dados
    Posicao    := IntToStr(QuantBoletos);
    StlArquivo := nil;

  //------------------------
   try // <-- Início do (try)
    StlArquivo := TStringList.Create;
    StlArquivo.LoadFromFile(PastaRaiz + '\' + NomePadrao + '-' + Posicao + '.txt');

   //---------------------------------------------------------
    Edit_Nome.Text       := stlArquivo[57]; // NOME CLIENTE
    Edit_CPF.Text        := stlArquivo[67]; // CPF
    Edit_Vencimento.Text := stlArquivo[43]; // DATA VENCIMENTO *
    N_DOC                := stlArquivo[25]; //  Nº DOCUMENTO

  // -------------------> Trata os caracteres dos campos <--------------------------
   Edit_Nome.Text := StringReplace(Edit_Nome.Text, ':', ' ',[rfReplaceAll]);
   Edit_Nome.Text := StringReplace(Edit_Nome.Text, ' ', '_',[rfReplaceAll]);
   Edit_Nome.Text := StringReplace(Edit_Nome.Text, '/', '_',[rfReplaceAll]);
   Edit_CPF.Text  := RemoverPalavras(Edit_CPF.Text, 'CPF ');
   Edit_CPF.Text  := StringReplace(Edit_CPF.Text, 'â€“', '-',[rfReplaceAll]);
   N_DOC := RemoverPalavras(N_DOC, ' '); // Nº DOCUMENTO
   N_DOC := RemoverPalavras(N_DOC, '000'); // Nº DOCUMENTO

 //---------------------> Renomeia o PDF na pasta raiz <----------------------
  Arquivo_original := (PastaRaiz + '\' + NomePadrao     + '-' + posicao + '.pdf');
  Novo_arquivo     := (PastaRaiz + '\' + Edit_Nome.Text + '-' + Edit_CPF.Text + '-' + N_DOC   + '.pdf');
  RenameFile(arquivo_original, novo_arquivo);

  //-----------------------> Deletar TXT <----------------------------
   if posicao <> '0' then
    DeleteFile(PastaRaiz + '\' + NomePadrao + '-' + posicao + '.txt');

    //--------------------------------------------------
     QuantBoletos := QuantBoletos - Intervalo;
     ProgressBar1.Position := ProgressBar1.Position + 1;

       finally // <-- Fim do (while)
        If Assigned(stlArquivo) then
         FreeAndNil(stlArquivo);
        end;

   end; // <-- Fim do (while)
   ShowMessage('Fim :D');
   ProgressBar1.Position := StrToInt(Edit_Quant_Arquivos.Text);

 end // <-- Fim do (if) validar campos vazios
  else
   ShowMessage('Favor preencha os campos pedidos! *');

end;

procedure TFrm_Principal.Lb_Link_GitHubClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'https://github.com/amancio10', '', '', 1);
end;

end.

