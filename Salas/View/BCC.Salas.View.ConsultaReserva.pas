unit BCC.Salas.View.ConsultaReserva;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.ConsultaBase, Data.DB,
  Data.Win.ADODB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  BCC.Sala.Model.Reserva, BCC.Sala.DAO.Reserva;

type
  TFrmConsultaReserva = class(TFrmConsultaBase)
    QryConsultaID_Reserva: TAutoIncField;
    QryConsultaID_Sala: TIntegerField;
    QryConsultaID_Cliente: TIntegerField;
    QryConsultaDataHora: TDateTimeField;
    QryConsultaCliente: TStringField;
    QryConsultaSala: TStringField;
    procedure FormCreate(Sender: TObject);
  private
    FObjetoConsultado: TReserva;
    { Private declarations }
    procedure FinalizarConsulta(); override;
    function  FormarFiltro() : String; override;
  public
    { Public declarations }
    property ObjetoConsultado: TReserva read FObjetoConsultado;
    constructor Create(AOwner : TComponent); override;
  end;

var
  FrmConsultaReserva: TFrmConsultaReserva;

implementation

{$R *.dfm}

{ TFrmConsultaBase1 }

constructor TFrmConsultaReserva.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TFrmConsultaReserva.FinalizarConsulta;
begin
  inherited;
  Self.FConsultou := True;
  Self.FObjetoConsultado := TDmReserva.Create(Self).Selecionar(Self.QryConsultaID_Reserva.Value);
end;

function TFrmConsultaReserva.FormarFiltro: String;
begin
  Result := '(Sala LIKE ''%' + Self.EdtConsulta.Text + '%''' +  #13 +
            'OR Cliente LIKE ''%' + Self.EdtConsulta.Text + '%'')';
end;

procedure TFrmConsultaReserva.FormCreate(Sender: TObject);
begin
  inherited;
  Self.QryConsulta.Open();
end;

end.
