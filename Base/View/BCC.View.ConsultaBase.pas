unit BCC.View.ConsultaBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FormBase, Vcl.ExtCtrls,
  Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, BCC.Conexao.DAO.Dados;

type
  TFrmConsultaBase = class(TFrmBase)
    DbgConsulta: TDBGrid;
    EdtConsulta: TEdit;
    QryConsulta: TADOQuery;
    DsConsulta: TDataSource;
    TimConsulta: TTimer;
    QryAutoComplete: TADOQuery;
    procedure DbgConsultaDblClick(Sender: TObject);
    procedure DbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimConsultaTimer(Sender: TObject);
    procedure EdtConsultaChange(Sender: TObject);
    procedure EdtConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  protected
    { Private declarations }
    SomenteAtivo : Boolean;
    FObjetoConsultado : TObject;
    FConsultou : Boolean;
    Apagando : Boolean;

    procedure FinalizarConsulta(); virtual; abstract;
    function FormarFiltro() : String; virtual; abstract;
    function FormarSQLAutoComplete() : String; virtual; abstract;
    procedure Filtrar();
  public
    { Public declarations }
    property ObjetoConsultado : TObject read FObjetoConsultado;
    property Consultou : Boolean read FConsultou;

    constructor Create(AOwner : TComponent; AAtivo : Boolean = True); overload;
  end;

var
  FrmConsultaBase: TFrmConsultaBase;

implementation

{$R *.dfm}

{ TFrmConsultaBase }

constructor TFrmConsultaBase.Create(AOwner: TComponent; AAtivo: Boolean);
begin
  inherited Create(AOwner);
  Self.SomenteAtivo := AAtivo;
end;

procedure TFrmConsultaBase.DbgConsultaDblClick(Sender: TObject);
begin
  inherited;
  Self.FinalizarConsulta();
  Self.Close();
end;

procedure TFrmConsultaBase.DbgConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_Return then
  begin
    Self.FinalizarConsulta();
    Self.Close();
  end;
end;

procedure TFrmConsultaBase.EdtConsultaChange(Sender: TObject);
var
  Inicial : Integer;
begin
  inherited;
  if not Self.Apagando then
  begin
    Inicial := Length(Self.EdtConsulta.Text);
    Self.QryAutoComplete.Close();
    Self.QryAutoComplete.SQL.Text := Self.FormarSQLAutoComplete();
    Self.QryAutoComplete.Open();

    Self.EdtConsulta.Text := Self.EdtConsulta.Text + Self.QryAutoComplete.Fields[0].AsString.Substring(Inicial);
    Self.EdtConsulta.SelStart := Inicial;
    Self.EdtConsulta.SelLength := Length(Self.EdtConsulta.Text) - Inicial;
  end;

  Self.TimConsulta.Enabled := False;

  if Inicial >= 3 then
  begin
    Self.TimConsulta.Interval := 1000;
    Self.TimConsulta.Enabled  := True;
  end;
end;

procedure TFrmConsultaBase.EdtConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Self.Apagando := False;

  if (Key = VK_BACK) or (Key = VK_DELETE) then
  begin
    Self.Apagando := True;
  end
  else if Key = VK_Return then
  begin
    if Self.EdtConsulta.Text <> '' then
    begin
      Self.Filtrar();
    end;
  end;
end;

procedure TFrmConsultaBase.Filtrar;
begin
  if not Self.QryConsulta.Active then
  begin
    Self.QryConsulta.Open();
  end;

  Self.QryConsulta.DisableControls();
  Self.QryConsulta.Filtered := False;
  Self.QryConsulta.Filter := Self.FormarFiltro();
  Self.QryConsulta.Filtered := True;
  Self.QryConsulta.EnableControls();
end;

procedure TFrmConsultaBase.FormCreate(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Consulta';
end;

procedure TFrmConsultaBase.TimConsultaTimer(Sender: TObject);
begin
  inherited;
  if Self.EdtConsulta.Text <> '' then
  begin
    Self.TimConsulta.Enabled := False;
    Self.Filtrar();
  end;
end;

end.
