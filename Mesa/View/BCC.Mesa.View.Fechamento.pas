unit BCC.Mesa.View.Fechamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FormBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, BCC.Model.Mesa, FireDAC.Stan.Intf, FireDAC.Stan.Option, Vcl.Grids,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, Vcl.DBGrids,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Generics.Collections;

type
  TFrmFechaMesa = class(TFrmBase)
    CmbPagamento: TComboBox;
    BtnFecharMesa: TButton;
    MtbTitulos: TFDMemTable;
    DsTitulos: TDataSource;
    DbgTitulos: TDBGrid;
    MtbTitulosValor: TFloatField;
    MtbTitulosPago: TFloatField;
    MtbTitulosTroco: TFloatField;
    MtbTitulosFormaPagto: TIntegerField;
    LedValor: TLabeledEdit;
    LblFormaPagto: TLabel;
    LedPago: TLabeledEdit;
    LedTroco: TLabeledEdit;
    BtnAddForma: TButton;
    MtbTitulosFormaString: TStringField;
    procedure BtnFecharMesaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAddFormaClick(Sender: TObject);
    procedure LedValorExit(Sender: TObject);
    procedure LedPagoChange(Sender: TObject);
    procedure CmbPagamentoChange(Sender: TObject);
  private
    FFinalizou: Boolean;
    FTitulosGerados: TObjectList<TTitulo>;
    ValorTotal : Double;

    function ValorFaltante() : Double;
    { Private declarations }
  public
    { Public declarations }
    property TitulosGerados: TObjectList<TTitulo> read FTitulosGerados;
    property Finalizou: Boolean read FFinalizou;

    procedure TratarTela();

    constructor Create(AOwner : TComponent; AValorTotal : Double); overload;
  end;

var
  FrmFechaMesa: TFrmFechaMesa;

implementation

{$R *.dfm}

procedure TFrmFechaMesa.BtnAddFormaClick(Sender: TObject);
begin
  inherited;
  if StrToFloat(Self.LedValor.Text) <= Self.ValorFaltante() then
  begin
    Self.MtbTitulos.Append();

    Self.MtbTitulosValor.Value      := StrToFloat(Self.LedValor.Text);
    Self.MtbTitulosPago.Value       := StrToFloat(Self.LedPago.Text);
    Self.MtbTitulosTroco.Value      := StrToFloat(Self.LedTroco.Text);
    Self.MtbTitulosFormaPagto.Value := Self.CmbPagamento.ItemIndex;

    case Self.CmbPagamento.ItemIndex of
      0 :
      begin
        Self.MtbTitulosFormaString.Value := 'Dinheiro';
      end;
      1 :
      begin
        Self.MtbTitulosFormaString.Value := 'Débito';
      end;
      2 :
      begin
        Self.MtbTitulosFormaString.Value := 'Crédito';
      end;
    end;

    Self.MtbTitulos.Post();
  end
  else
  begin
    Application.MessageBox('O pagamento não pode ser inserido, o valor é maior do que o valor faltante!', 'ATENÇÂO!');
  end;
  Self.TratarTela();
end;

procedure TFrmFechaMesa.BtnFecharMesaClick(Sender: TObject);
var
  I: Integer;
  Titulo : TTitulo;
begin
  inherited;

  if Application.MessageBox('Deseja fechar a mesa?', 'Board Café Control', MB_YESNO) = id_yes then
  begin
    Self.FTitulosGerados := TObjectList<TTitulo>.Create(True);

    Self.MtbTitulos.First();
    for I := 0 to Self.MtbTitulos.RecordCount - 1 do
    begin
      Titulo := TTitulo.Create();
      Titulo.Valor := Self.MtbTitulosValor.Value;
      Titulo.Pago  := Self.MtbTitulosPago.Value;
      Titulo.Troco := Self.MtbTitulosTroco.Value;
      Titulo.FormaPagto := EFormaPagamento(Self.MtbTitulosFormaPagto.Value);
      Self.FTitulosGerados.Add(Titulo);

      Self.MtbTitulos.Next();
    end;

    Self.FFinalizou := True;
    Self.Close();
  end;
end;

procedure TFrmFechaMesa.CmbPagamentoChange(Sender: TObject);
begin
  inherited;
  if Self.CmbPagamento.ItemIndex = 0 then
  begin
    Self.LedPago.ReadOnly := False;
  end
  else
  begin
    Self.LedPago.ReadOnly := True;
  end;
end;

constructor TFrmFechaMesa.Create(AOwner: TComponent; AValorTotal: Double);
begin
  inherited Create(AOwner);
  Self.ValorTotal := AValorTotal;
end;

procedure TFrmFechaMesa.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FFinalizou := False;
  Self.MtbTitulos.Open();
end;

procedure TFrmFechaMesa.LedPagoChange(Sender: TObject);
begin
  inherited;
  Self.LedTroco.Text := FormatFloat('#,##0.00', StrToFloat(Self.LedPago.Text) - StrToFloat(Self.LedValor.Text));
end;

procedure TFrmFechaMesa.LedValorExit(Sender: TObject);
begin
  inherited;
  Self.LedPago.Text := Self.LedValor.Text;
end;

procedure TFrmFechaMesa.TratarTela;
begin
  Self.LedValor.Text := FormatFloat('#,##0.00', Self.ValorFaltante());
  Self.LedPago.Text  := Self.LedValor.Text;
  Self.LedTroco.Text := '0';
  Self.CmbPagamento.ItemIndex := -1;

  if Self.ValorFaltante() = 0 then
  begin
    Self.BtnFecharMesa.Enabled := True;
  end
  else
  begin
    Self.BtnFecharMesa.Enabled := False;
  end;
end;

function TFrmFechaMesa.ValorFaltante: Double;
var
  Valor : Double;
  I: Integer;
begin
  Valor := Self.ValorTotal;

  Self.MtbTitulos.First();
  for I := 0 to Self.MtbTitulos.RecordCount - 1 do
  begin
    Valor := Valor - Self.MtbTitulosValor.Value;
    Self.MtbTitulos.Next();
  end;

  Result := Valor;
end;

end.
