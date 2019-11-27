unit BCC.Campeonatos.View.AdicionaPartida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FormBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Samples.Spin, BCC.Model.Competidores, BCC.DAO.Competidores,
  System.Generics.Collections, Data.DB, Data.Win.ADODB, BCC.Conexao.DAO.Dados,
  BCC.Controller.Campeonatos;

type
  TFrmAdicionaPartida = class(TFrmBase)
    CmbCompetidor1: TComboBox;
    CmbCompetidor2: TComboBox;
    LblVs: TLabel;
    CmbVencedor: TComboBox;
    LblVencedor: TLabel;
    LblCompetidor1: TLabel;
    LblCompetidor2: TLabel;
    LblTitulo: TLabel;
    SedPonto2: TSpinEdit;
    SedPonto1: TSpinEdit;
    LblPontuacao1: TLabel;
    LblPontuacao2: TLabel;
    BtnRegistrarPartida: TButton;
    QryCompetidores: TADOQuery;
    QryCompetidoresCliente: TStringField;
    QryCompetidoresID_Comp: TAutoIncField;
    procedure CmbCompetidor1Change(Sender: TObject);
    procedure BtnRegistrarPartidaClick(Sender: TObject);
    procedure CmbCompetidor2Change(Sender: TObject);
    procedure CmbVencedorChange(Sender: TObject);
  private
    { Private declarations }
    CodCampeonato : Integer;
    
    procedure PreencherCombo1();
    procedure PreencherCombo2();
  public
    { Public declarations }
    constructor Create(AOwner : TComponent; ACodCampeonato : Integer); overload;
  end;

var
  FrmAdicionaPartida: TFrmAdicionaPartida;

implementation

{$R *.dfm}

{ TFrmAdicionaPartida }

procedure TFrmAdicionaPartida.BtnRegistrarPartidaClick(Sender: TObject);
var
  Resultado1, Resultado2 : EResultado;
begin
  inherited;  
  case Self.CmbVencedor.ItemIndex of
    0:
    begin  
      Resultado1 := CmpVitoria;
      Resultado2 := CmpDerrota;
    end;
    1:
    begin
      Resultado1 := CmpDerrota;
      Resultado2 := CmpVitoria;
    end;
    2:
    begin
      Resultado1 := CmpEmpate;
      Resultado2 := CmpEmpate;
    end;
  end;
  
  TControllerCampeonatos.AdicionarPartida(Integer(Self.CmbCompetidor1.Items.Objects[Self.CmbCompetidor1.ItemIndex]), Resultado1);
  TControllerCampeonatos.AumentarPontuacao(Integer(Self.CmbCompetidor1.Items.Objects[Self.CmbCompetidor1.ItemIndex]), Self.SedPonto1.Value);

  TControllerCampeonatos.AdicionarPartida(Integer(Self.CmbCompetidor2.Items.Objects[Self.CmbCompetidor2.ItemIndex]), Resultado2);
  TControllerCampeonatos.AumentarPontuacao(Integer(Self.CmbCompetidor2.Items.Objects[Self.CmbCompetidor2.ItemIndex]), Self.SedPonto2.Value);

  Self.Close();
end;

procedure TFrmAdicionaPartida.CmbCompetidor1Change(Sender: TObject);
begin
  inherited;
  if Self.CmbCompetidor1.ItemIndex >= 0 then
  begin
    Self.PreencherCombo2();

    Self.SedPonto1.Enabled := True;
    Self.CmbCompetidor2.Enabled := True;
  end
  else
  begin
    Self.SedPonto1.Enabled := False;
    Self.CmbCompetidor2.Enabled := False;
    Self.SedPonto2.Enabled := False;
    Self.BtnRegistrarPartida.Enabled := False;
    Self.CmbVencedor.Enabled := False;
  end;
end;

procedure TFrmAdicionaPartida.CmbCompetidor2Change(Sender: TObject);
begin
  inherited;
  if Self.CmbCompetidor2.ItemIndex >= 0 then
  begin
    Self.SedPonto2.Enabled := True;
    Self.CmbVencedor.Enabled := True;
  end
  else
  begin
    Self.SedPonto2.Enabled := False;
    Self.BtnRegistrarPartida.Enabled := False;
    Self.CmbVencedor.Enabled := False;
  end;
end;

procedure TFrmAdicionaPartida.CmbVencedorChange(Sender: TObject);
begin
  inherited;
  if Self.CmbVencedor.ItemIndex >= 0 then
  begin
    Self.BtnRegistrarPartida.Enabled := True;
  end
  else
  begin
    Self.BtnRegistrarPartida.Enabled := False;
  end;
end;

constructor TFrmAdicionaPartida.Create(AOwner: TComponent; ACodCampeonato: Integer);
begin
  inherited Create(AOwner);
  Self.CodCampeonato := ACodCampeonato;
  
  Self.QryCompetidores.Close();
  Self.QryCompetidores.SQL.Clear();
  Self.QryCompetidores.SQL.Text := 'SELECT' + #13 +
                                   '  cli.Nome AS Cliente,' + #13 +
                                   '  comp.ID_Comp' + #13 +
                                   'FROM Competidores_Campeonato comp' + #13 +
                                   '  LEFT JOIN Cliente cli ON cli.ID_Cliente = comp.ID_Cliente' + #13 +
                                   'WHERE comp.ID_Campeonato = 0' + ACodCampeonato.ToString();
  Self.QryCompetidores.Open();

  Self.PreencherCombo1();
end;

procedure TFrmAdicionaPartida.PreencherCombo1;
begin
  Self.CmbCompetidor1.Items.Clear();

  Self.QryCompetidores.First();
  for var I := 0 to Self.QryCompetidores.RecordCount - 1 do
  begin
    Self.CmbCompetidor1.Items.AddObject(Self.QryCompetidoresCliente.Value, TObject(Self.QryCompetidoresID_Comp.Value));
    Self.QryCompetidores.Next();
  end;
end;

procedure TFrmAdicionaPartida.PreencherCombo2;
begin
  Self.CmbCompetidor2.Items.Clear();
  
  Self.QryCompetidores.First();
  for var I := 0 to Self.QryCompetidores.RecordCount - 1 do
  begin
    if Integer(Self.CmbCompetidor1.Items.Objects[Self.CmbCompetidor1.ItemIndex]) <> Self.QryCompetidoresID_Comp.Value then
    begin
      Self.CmbCompetidor2.Items.AddObject(Self.QryCompetidoresCliente.Value, TObject(Self.QryCompetidoresID_Comp.Value));
    end;
    Self.QryCompetidores.Next();
  end;
end;

end.
