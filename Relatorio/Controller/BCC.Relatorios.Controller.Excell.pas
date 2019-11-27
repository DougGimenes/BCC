unit BCC.Relatorios.Controller.Excell;

interface

uses
  SysUtils,
  Variants,
  Classes,
  uni,
  ComObj,
  db,
  DBClient,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Windows,
  Data.Win.ADODB;

type
  TExcel = class
    private
      Query    : TADOQuery;
      Excel    : Variant;
      MtbQuery : TFDMemTable;
      DsQuery  : TClientDataSet;

      procedure inicializarExcel();
      procedure inicializarDefault();

      procedure printCabecalho();
      procedure printConteudo(Linha : Integer = 2);
      procedure printCabecalhoDataSet();
      procedure printConteudoDataSet();
      procedure printCabecalhoMT();
      procedure printConteudoMT();

      procedure printCabecalhoCompleto(Titulo, Subtitulo : String);

    protected
    public
      constructor Create();overload;
      constructor Create(qry : TClientDataSet);overload;
      destructor  Destroy();

      procedure ExcelVisivel(visivel : Boolean);
      procedure DadosParaExcel(excelVisivelNoFinal : Boolean = True; Titulo : String = ''; Subtitulo : String = ''); overload;
      procedure DadosParaExcel(qry : TClientDataSet; excelVisivelNoFinal : Boolean = True; Titulo : String = ''; Subtitulo : String = ''); overload;
      procedure DadosParaExcel(qry : TFDMemTable; excelVisivelNoFinal : Boolean = True; Titulo : String = ''; Subtitulo : String = ''); overload;
      procedure DadosParaExcel(AQuery : TADOQuery; AExcelVisivelNoFinal : Boolean = True; ATitulo : String = ''; ASubtitulo : String = ''); overload;
  end;


implementation

{$D+}

{ TExcel }

constructor TExcel.Create;
begin
  self.inicializarDefault();
end;

constructor TExcel.Create(qry: TClientDataSet);
begin
  self.inicializarDefault();
  self.DsQuery := qry;
end;

procedure TExcel.DadosParaExcel(excelVisivelNoFinal : Boolean = True; Titulo : String = ''; Subtitulo : String = '');
var
  i, Linha : Integer;
  gerouExcel : boolean;
begin
  if not ((Assigned(self.Query)) or (Assigned(self.DsQuery)) or (Assigned(self.MtbQuery))) then
  begin
    raise Exception.Create('Query e DataSet null');
  end;

  if (Assigned(self.Query)) then
  begin
    self.Query.First();
    if Titulo <> '' then
    begin
      Self.printCabecalhoCompleto(Titulo, Subtitulo);
      self.printConteudo(4);
    end
    else
    begin
      Self.printCabecalho();
      self.printConteudo();
    end;
  end
  else if Assigned(Self.DsQuery) then
  begin
    self.DsQuery.First();
    self.printCabecalhoDataSet();
    self.printConteudoDataSet();
  end
  else if Assigned(Self.MtbQuery) then
  begin
    Self.MtbQuery.First();
    Self.printCabecalhoMT();
    Self.printConteudoMT();
  end;

  Self.ExcelVisivel(excelVisivelNoFinal);
end;

procedure TExcel.DadosParaExcel(AQuery: TADOQuery; AExcelVisivelNoFinal: Boolean; ATitulo, ASubtitulo: String);
begin
  Self.Query := AQuery;
  Self.DadosParaExcel(AExcelVisivelNoFinal, ATitulo, ASubtitulo);
end;

procedure TExcel.DadosParaExcel(qry: TFDMemTable; excelVisivelNoFinal: Boolean = True; Titulo : String = ''; Subtitulo : String = '');
begin
  Self.MtbQuery := qry;
  Self.DadosParaExcel(excelVisivelNoFinal, Titulo, Subtitulo);
end;

procedure TExcel.DadosParaExcel(qry: TClientDataSet;
  excelVisivelNoFinal: Boolean = True; Titulo : String = ''; Subtitulo : String = '');
begin
  self.DsQuery := qry;
  self.DadosParaExcel(excelVisivelNoFinal, Titulo, Subtitulo);
end;

destructor TExcel.Destroy;
begin
  self.Query.Free();
  self.Excel.Free();
end;

procedure TExcel.ExcelVisivel(visivel: Boolean);
begin
  self.Excel.Visible := visivel;
end;

procedure TExcel.inicializarDefault;
begin
  self.Query := nil;
  self.DsQuery := nil;
  self.inicializarExcel();
end;

procedure TExcel.inicializarExcel;
begin
  self.Excel := CreateOleObject('Excel.Application');
  self.ExcelVisivel(False);
  self.Excel.Workbooks.Add;
end;

procedure TExcel.printCabecalho;
var
  i : Integer;
begin
  for i := 0 to self.Query.FieldCount - 1 do
  begin
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1] := self.Query.Fields[i].DisplayName;
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].font.size := 13;
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].font.bold := true;
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].font.color := RGB(255, 255, 255);
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].Interior.Color := RGB(35, 92, 145);
  end;
end;

procedure TExcel.printCabecalhoCompleto(Titulo, Subtitulo : String);
var
  i : Integer;
begin
  self.Excel.Range['A1:' + Char(self.Query.FieldCount + 64) + '1'].MergeCells := True;
  self.Excel.WorkBooks[1].Sheets[1].Cells[1,1] := Titulo;
  self.Excel.WorkBooks[1].Sheets[1].Cells[1,1].font.size := 15;
  self.Excel.WorkBooks[1].Sheets[1].Cells[1,1].font.bold := true;
  self.Excel.WorkBooks[1].Sheets[1].Cells[1,1].font.color := RGB(255, 255, 255);
  self.Excel.WorkBooks[1].Sheets[1].Cells[1,1].Interior.Color := RGB(35, 92, 145);
  self.Excel.WorkBooks[1].Sheets[1].Cells[1,1].HorizontalAlignment := 3;

  self.Excel.Range['A2:' + Char((self.Query.FieldCount - 1) + 64) + '2'].MergeCells := True;
  self.Excel.WorkBooks[1].Sheets[1].Cells[2,1] := Subtitulo;
  self.Excel.WorkBooks[1].Sheets[1].Cells[2,1].font.size := 13;
  self.Excel.WorkBooks[1].Sheets[1].Cells[2,1].font.bold := true;
  self.Excel.WorkBooks[1].Sheets[1].Cells[2,1].HorizontalAlignment := 3;

  self.Excel.WorkBooks[1].Sheets[1].Cells[2, self.Query.FieldCount] := 'Emissão: ' + FormatDateTime('dd/mm/yyyy', Now);
  self.Excel.WorkBooks[1].Sheets[1].Cells[2, self.Query.FieldCount].font.size := 10;
  self.Excel.WorkBooks[1].Sheets[1].Cells[2, self.Query.FieldCount].font.bold := true;
  self.Excel.WorkBooks[1].Sheets[1].Cells[2, self.Query.FieldCount].HorizontalAlignment := 3;

  for i := 0 to self.Query.FieldCount - 1 do
  begin
    self.Excel.WorkBooks[1].Sheets[1].Cells[3,i+1] := self.Query.Fields[i].DisplayName;
    self.Excel.WorkBooks[1].Sheets[1].Cells[3,i+1].font.size := 13;
    self.Excel.WorkBooks[1].Sheets[1].Cells[3,i+1].font.bold := true;
    self.Excel.WorkBooks[1].Sheets[1].Cells[3,i+1].font.color := RGB(255, 255, 255);
    self.Excel.WorkBooks[1].Sheets[1].Cells[3,i+1].Interior.Color := RGB(35, 92, 145);
  end;
end;

procedure TExcel.printCabecalhoMT;
var
  i : Integer;
begin
  for i := 0 to self.MtbQuery.FieldCount - 1 do
  begin
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1] := self.MtbQuery.Fields[i].DisplayName;
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].font.size := 13;
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].font.bold := true;
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].font.color := RGB(255, 255, 255);
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].Interior.Color := RGB(35, 92, 145);
  end;


end;

procedure TExcel.printCabecalhoDataSet;
var
  i : Integer;
begin
  for i := 0 to self.DsQuery.FieldCount - 1 do
  begin
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1] := self.DsQuery.Fields[i].DisplayName;
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].font.size := 13;  // Tamanho da fonte
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].font.bold := true; //Fonte Negrito
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].font.color := RGB(255, 255, 255);
    self.Excel.WorkBooks[1].Sheets[1].Cells[1,i+1].Interior.Color := RGB(35, 92, 145);
  end;

end;

procedure TExcel.printConteudo(Linha : Integer = 2);
var
  i : Integer;
begin

  //Linha := 2; // começa pelo 2 pois o 1 está o cabeçalho

  while not Self.Query.Eof do
  begin

    for i := 0 to self.Query.FieldCount - 1 do
    begin
      if(self.Query.Fields[i].DataType = ftInteger) then
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := self.Query.Fields[i].AsInteger
      else if (self.Query.Fields[i].DataType = ftFloat) then
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := self.Query.Fields[i].AsFloat
      else if (self.Query.Fields[i].DataType = ftDateTime) then
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := 'Data: ' + FormatDateTime('dd/mm/yyyy', self.Query.Fields[i].AsDateTime)
      else
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := self.Query.Fields[i].AsString
    end;

    self.Query.Next();
    Linha := Linha + 1;

  end;
  self.Excel.Columns.AutoFit;

end;

procedure TExcel.printConteudoMT;
var
  i, Linha : Integer;
begin

  Linha := 2; // começa pelo 2 pois o 1 está o cabeçalho

  while not Self.MtbQuery.Eof do
  begin

    for i := 0 to self.MtbQuery.FieldCount - 1 do
    begin
      if(self.MtbQuery.Fields[i].DataType = ftInteger) then
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := self.MtbQuery.Fields[i].AsInteger
      else if (self.MtbQuery.Fields[i].DataType = ftFloat) then
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := self.MtbQuery.Fields[i].AsFloat
      else if (self.MtbQuery.Fields[i].DataType = ftDateTime) then
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := 'Data: ' + FormatDateTime('dd/mm/yyyy', self.MtbQuery.Fields[i].AsDateTime)
      else
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := self.MtbQuery.Fields[i].AsString



    end;

    self.MtbQuery.Next();
    Linha := Linha + 1;
  end;
  self.Excel.Columns.AutoFit;

end;

procedure TExcel.printConteudoDataSet;
var
  i, Linha : Integer;
begin

  Linha := 2; // começa pelo 2 pois o 1 está o cabeçalho

  while not Self.DsQuery.Eof do
  begin

    for i := 0 to self.DsQuery.FieldCount - 1 do
    begin
      if(self.DsQuery.Fields[i].DataType = ftInteger) then
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := self.DsQuery.Fields[i].AsInteger
      else if (self.DsQuery.Fields[i].DataType = ftFloat) then
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := self.DsQuery.Fields[i].AsFloat
      else if (self.DsQuery.Fields[i].DataType = ftDateTime) then
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := 'Data: ' + FormatDateTime('dd/mm/yyyy', self.DsQuery.Fields[i].AsDateTime)
      else
        self.Excel.WorkBooks[1].Sheets[1].Cells[Linha,i+1] := self.DsQuery.Fields[i].AsString

    end;

    self.DsQuery.Next();
    Linha := Linha + 1;

  end;
end;

end.
